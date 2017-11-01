<?php

namespace frontend\modules\plane\controllers;

use yii\web\Controller;
use common\models\City;

class IndexController extends Controller
{
    public function actionIndex()
    {
        if(\Yii::$app->request->isPost){
            $acty = \Yii::$app->request->post('acty');
            $dcty = \Yii::$app->request->post('dcty');
            if(!$acty){
                $aa = \Yii::$app->getSession()->setFlash('error', '出发地不能为空');
                return $this->redirect(['/plane/index/index']);
            }
            
            $where = [['<>','xiecheng',''], ['<>','id',$acty], 'status'=>0];
            if(!empty($dcty)){
               $where[] = ['in','id',$dcty];
            }
            
            $citylist = (new City())->getList($where, 'arr');
            $onCity = City::find()->where(['id'=>$acty])->one()->toArray();
            
            $data = [];
            $data['citys'] = json_encode($citylist);
			$data['oncity'] = json_encode($onCity);
			
            return $this->renderPartial('list', $data);
        }else{
            $where = [['<>', 'xiecheng', ''], 'status'=>0];
            $citys = City::getPairs($where);
            
            $data = [];
            $data['citys'] = $citys;
            return $this->renderPartial('index', $data);
        }
    }
    
    public function actionTest() {
        //flush all the schema cache
        $a = file_get_contents('../../test.html');
//         $b = preg_match_all('/<a([^>]*)>(.*)<\/a>/i', $a, $match);
        $b = preg_match_all('/data="([^"]*)"/i', $a, $match);
        foreach ($match[1] as $val) {
            $c = explode('|', $val);
            $nameArr = explode('(', $c[1]);
            
            $data = new City();
            $data->city = $nameArr[0];
            $data->pinyin = $c[0];
            $data->xiecheng = $c[3];
            $data->xiechengnum = $c[2];
            
            $data->save();
        }
    }
}

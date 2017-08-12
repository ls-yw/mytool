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
                \Yii::$app->getSession()->setFlash('error', '出发地不能为空');
                return $this->redirect(['/plane/index/index']);
            }
        }else{
            $where = ['<>', 'suoxie', ''];
            $citys = City::getPairs($where);
            
            $data = [];
            $data['citys'] = $citys;
            
            return $this->renderPartial('index', $data);
        }
    }
}

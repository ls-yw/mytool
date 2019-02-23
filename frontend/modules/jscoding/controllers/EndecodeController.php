<?php
namespace frontend\modules\jscoding\controllers;

use frontend\basic\BasicController;

class EndecodeController extends BasicController
{
    public function actionGotime() 
    {
        return $this->render('gotime');
    }
    
    public function actionCreatePwd()
    {
        if(\Yii::$app->request->isAjax){
            $tj1 = \Yii::$app->request->post('tj1');
            $tj2 = \Yii::$app->request->post('tj2');
            $tj3 = \Yii::$app->request->post('tj3');
            $tj4 = \Yii::$app->request->post('tj4');
            $pwdLength = (int)\Yii::$app->request->post('pwdLength', 0);
            if(empty($pwdLength))return $this->ajaxReturn(1, '密码长度错误');
            
            $z = [];
            if($tj1 == 1)$z[] = str_shuffle('ABCDEFGHIJKLMNOPQISTUVWXYZ');
            if($tj2 == 1)$z[] = str_shuffle('abcdefghijklmnopqistuvwxyz');
            if($tj3 == 1)$z[] = str_shuffle('0123456789');
            if($tj4 == 1)$z[] = str_shuffle('!@#$%^&*');
            if(empty($z))return $this->ajaxReturn(1, '必须有加密条件');
            
            do {
                $pwd = '';
                $a = [];
                for ($i = 0;$i < $pwdLength; $i++) {
                    $n = mt_rand(0,count($z)-1);
                    $a[$n] = $n;
                    $pwd .= substr($z[$n], mt_rand(0, strlen($z[$n])-1), 1);
                }
                
            } while (count($a) != count($z));
            
            return $this->ajaxReturn(0, '成功', $pwd);
        }
        return $this->render('create-pwd');
    }
}
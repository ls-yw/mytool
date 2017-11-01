<?php
namespace frontend\modules\jscoding\controllers;

use yii\web\Controller;

class EndecodeController extends Controller
{
    public function actionGotime() 
    {
        return $this->render('gotime');
    }
}
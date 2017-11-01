<?php
namespace common\models;

use yii\db\ActiveRecord;

class BaseModel extends ActiveRecord
{
    /**
     * 处理where条件
     * @param Object $obj
     * @param string|array $where
     */
    protected static function _dealWhere($obj, $where)
    {
        if(!empty($where)){
            $i = 0;
            foreach ($where as $key => $value) {
                if(is_array($value) && is_numeric($key)){
                    ($i == 0) ? $obj->where($value) : $obj->andWhere($value);
                }else{
                    ($i == 0) ? $obj->where([$key=>$value]) : $obj->andWhere([$key=>$value]);
                }
                $i++;
            }
        }
    }
    
}
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
            if(is_array($where) && isset($where[0]) && is_array($where[0])){
                foreach ($where as $key => $value) {
                    ($key == 0) ? $obj->where($value) : $obj->andWhere($value);
                }
            }else{
                $obj->where($where);
            }
        }
    }
    
}
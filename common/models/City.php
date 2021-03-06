<?php
namespace common\models;

class City extends BaseModel
{
    
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%city}}';
    }
    
    public static function getList($where, $format='obj') {
        $citys = self::find();
        self::_dealWhere($citys, $where);
        if($format == 'arr' || $format == 'array')$citys->asArray();
        $lists = $citys->all();
        return $lists;
    }
    
    public static function getPairs($where) {
        $arr = [];
        $lists = self::getList($where);
        if(count($lists) > 0){
            foreach ($lists as $list) {
                $arr[$list->id] = $list->city;
            }
        }
        return $arr;
    }
}
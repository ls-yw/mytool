<?php
namespace app\plane\controller;

use think\Controller;
use app\plane\model\City;
use think\View;

class Index extends Controller
{
	public $days = 15;
	
	public function index(){
		
		$citys = new City();
		$citylist = $citys->where('suoxie','<>','')->where('city','<>','杭州')->select();
		$onCity = $citys->where('city','杭州')->find();
		
		$data = array();
		$data['citys'] = json_encode($citylist);
		$data['oncity'] = json_encode($onCity);
		
// 		print_r($citys->city);
		
		$view = new View();
		return $view->fetch('list',$data);
		
	}
	
	public function getPricePlane($acty,$dcty){
		if($acty == $dcty)return fasle;
		
		$url = config('get_price_url');
		$data['acty'] = $acty;
		$data['dcty'] = $dcty;
		$data['stype']= 1;
		
		$prices = $this->fetchPost($url, $data);
		$prices = $this->fillter($prices);
		print_r($prices);
	}
	
	public function fetchPost($url,$data){
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url );
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
		curl_setopt($ch, CURLOPT_POST, 1 );
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
		$result = curl_exec( $ch );
		
		if ($error = curl_error($ch) ) {
			die($error);
		}
		curl_close($ch);
		$result = json_decode($result,true);
		return $result;
	}
	
	private function fillter($lists){
		if(empty($lists))return $lists;
		
		$datelist = array();
		$today = date('Y-m-d').' 00:00:00';
		$today = strtotime($today);
		$diffday = 60*60*24;
		for($i=1;$i<=$this->days;$i++){
			$datelist[] = date('Y-m-d H:i:s',$today);
			$today += $diffday;
		}
		
		$data = array();
		foreach ($lists['prices'] as $list){
			if(in_array($list['dDate'], $datelist)){
				$data[] = $list;
			}
		}
		return $data;
	}
	
	
}
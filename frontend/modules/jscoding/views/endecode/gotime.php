<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>时间转换</title>
<link href="/assets/plugs/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<style type="text/css">
.zhuan{margin:0 30px;}
</style>
</head>
<body>

<div class="container">
	<div class="panel panel-default" style="margin-top:50px;">
	  <div class="panel-heading text-center">
	  	现在的时间戳是：<input type="text" class="now_timestamp" readonly style="width:100px;"> 
	  	<a href="javascript:" class="btn btn-default btn-sm" id="start">开始</a>
	  	<a href="javascript:" class="btn btn-default btn-sm" id="stop">停止</a>
	  	<a href="javascript:" class="btn btn-default btn-sm" id="refresh">刷新</a>
	  </div>
	  <div class="panel-body">
	    <div class="row text-center bj-ts">
	    	<div class="col-md-3">时间戳 → 北京时间</div>
	    	<div class="col-md-9"><input type="text" class="time_timestamp" style="width:200px;" value=""> <a href="javascript:" class="btn btn-info btn-sm zhuan">转换</a> <input type="text" class="time_bj" style="width:200px;" value="" autocomplete="off"></div>
	    </div>
	    <hr>
	    <div class="row text-center ts-bj">
	    	<div class="col-md-3">北京时间 ← 时间戳</div>
	    	<div class="col-md-9"><input type="text" class="time_bj" style="width:200px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});" value="" autocomplete="off"> <a href="javascript:" class="btn btn-info btn-sm zhuan">转换</a> <input type="text" class="time_timestamp" style="width:200px;" value="" autocomplete="off"></div>
	    </div>
	  </div>
	</div>
</div>
<script type="text/javascript" src="/assets/plugs/jquery/jquery.min.js"></script>
<script type="text/javascript" src="/assets/plugs/wdatepicker/WdatePicker.js"></script>
<script type="text/javascript">
$(function(){
	var inter = setInterval('getTimestamp()',1000);
	$('#start').click(function(){getTimestamp();inter = setInterval('getTimestamp()',1000)});
	$('#stop').click(function(){window.clearInterval(inter)});
	$('#refresh').click(function(){getTimestamp()});
	
	$('.bj-ts .time_timestamp').val(parseInt((new Date().getTime())/1000));
	$('.ts-bj .time_bj').val(formatDate(new Date()));
	$('.zhuan').click(function(){
		var ppobj = $(this).parent().parent();
		if(ppobj.hasClass('bj-ts')){
			if($(this).siblings('.time_timestamp').val() != ''){
				var now_time = $(this).siblings('.time_timestamp').val();
				if(now_time.length != 13 && now_time.length != 10){
					alert('时间戳格式错误');
					return false;
				}
				if(now_time.length == 10){
					now_time = parseInt(now_time) * 1000;
				}
				$(this).siblings('.time_bj').val(formatDate(new Date(parseInt(now_time))));
			}
		}
		if(ppobj.hasClass('ts-bj')){
			if($(this).siblings('.time_bj').val() != ''){
				var now_time = $(this).siblings('.time_bj').val();
				$(this).siblings('.time_timestamp').val(Date.parse(new Date(now_time))/1000);
			}
		}
	});
});
function getTimestamp(){
	$('.now_timestamp').val(parseInt((new Date().getTime())/1000));
}
function   formatDate(now)   {     
    var   year=now.getFullYear();     
    var   month=now.getMonth()+1;     
    var   date=now.getDate();     
    var   hour=now.getHours();   
    if(hour < 10)hour = '0'+hour;
    var   minute=now.getMinutes();     
    if(minute < 10)minute = '0'+minute;
    var   second=now.getSeconds();     
    if(second < 10)second = '0'+second;
    return   year+"-"+month+"-"+date+" "+hour+":"+minute+":"+second;     
}     
</script>
</body>
</html>
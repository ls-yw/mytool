<?php 
use yii\helpers\Url;
?>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>我的工具</title>
<link href="/assets/plugs/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="container">

  <div class="content" style="margin-top:50px;">
  		
  	  <div class="row">
	  	<div class="col-md-2 list-title">编码转化：</div>
	  	<div class="col-md-10">
	  		<ul class="list-inline">
			  <li><a href="<?php echo Url::to(['jscoding/endecode/gotime'])?>">时间戳转换</a></li>
			</ul>
			<hr/>
	  	</div>
	  </div>
	  
	  <div class="row">
	  	<div class="col-md-2 list-title">加密解密：</div>
	  	<div class="col-md-10">
	  		<ul class="list-inline">
			  <li><a href="<?php echo Url::to(['jscoding/endecode/create-pwd'])?>">生成密码</a></li>
			</ul>
			<hr/>
	  	</div>
	  </div>
  		
	  <div class="row">
	  	<div class="col-md-2 list-title">交通查询：</div>
	  	<div class="col-md-10">
	  		<ul class="list-inline">
			  <li><a href="<?php echo Url::to(['plane/index/index'])?>">机票查询</a></li>
			</ul>
			<hr/>
	  	</div>
	  </div>
  </div>
</div>
<script type="text/javascript" src="/assets/plugs/jquery/jquery.min.js"></script>
<script type="text/javascript" src="/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
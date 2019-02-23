<?php
use yii\helpers\Url;
?>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>生成密码</title>
<meta name="keywords" content="生成密码" />
<meta name="description" content="生成密码"/>
<link href="/assets/plugs/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<style type="text/css">
.zhuan{margin:0 30px;}
</style>
</head>
<body>

<div class="container">
	<div class="panel panel-default" style="margin-top:50px;">
	  <div class="panel-heading text-center">
	  	生成随机字符串密码
	  </div>
	  <div class="panel-body">
	    <div class="row text-center bj-ts">
	    	<div class="col-md-3">加密条件</div>
	    	<div class="col-md-9 form-inline">
	    		<label class="checkbox-inline">
                  <input type="checkbox" id="tj1" value="1" checked> 包含A-Z
                </label>
                <label class="checkbox-inline">
                  <input type="checkbox" id="tj2" value="1" checked> 包含a-z
                </label>
                <label class="checkbox-inline">
                  <input type="checkbox" id="tj3" value="1" checked> 包含0-9
                </label>
                <label class="checkbox-inline">
                  <input type="checkbox" id="tj4" value="1"> 包含!@#$%^&*
                </label>
                <div class="form-group">
                    <label for="exampleInputName2">密码长度</label>
                    <input type="text" class="form-control" id="pwd-length" value="16" size="4">
                </div>
	    	</div>
	    </div>
	    <hr>
	    <div class="row text-center ts-bj">
	    	<div class="col-md-3"><a href="javascript:" class="btn btn-info btn-sm zhuan" style="margin: 5px 100px;">生成密码</a></div>
	    	<div class="col-md-9"><input type="text" class="form-control" id="pwd"></div>
	    </div>
	  </div>
	</div>
</div>
<script type="text/javascript" src="/assets/plugs/jquery/jquery.min.js"></script>
<script type="text/javascript" src="/assets/plugs/wdatepicker/WdatePicker.js"></script>
<script type="text/javascript">
$(function(){
	$('.zhuan').click(function(){
		var tj1 = $('#tj1:checked').val();
		var tj2 = $('#tj2:checked').val();
		var tj3 = $('#tj3:checked').val();
		var tj4 = $('#tj4:checked').val();
		var pwdLength = $('#pwd-length').val();
		$.post("<?=Url::to(['/jscoding/endecode/create-pwd'])?>",{'tj1':tj1,'tj2':tj2,'tj3':tj3,'tj4':tj4,'pwdLength':pwdLength,'_csrf':'<?=Yii::$app->request->csrfToken?>'}, function(res){
			if(res.code != 0){
				alert(res.msg);
				return false;
			}
			$('#pwd').val(res.data);
		},'json');
	});

});
  
</script>
</body>
</html>
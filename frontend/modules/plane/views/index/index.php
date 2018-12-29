<?php 
use yii\bootstrap\Alert;
?>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>Insert title here</title>
<link href="/assets/plugs/chosen/chosen.css" rel="stylesheet">
<link href="/assets/plugs/toastr/toastr.css" rel="stylesheet">
<link href="/assets/plugs/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<style>
.content{margin:20% auto 0;padding:5px;max-width:500px;vertical-align: middle;line-height:24px;}
</style>
</head>
<body>
<form method="post" action="" id="form1" class="form-horizontal">
<div class="content">
	<div class="form-group">
		<label class="col-sm-3 control-label">出发地：</label>
		<div class="col-sm-9">
		<select name="acty" id="acty" class="chosen form-control">
    		<option value="0">请选择城市</option>
    		<?php if(!empty($citys)):foreach ($citys as $key => $city) :?>
    		<option value="<?php echo $key?>"><?php echo $city?></option>
    		<?php endforeach;endif;?>
		</select>
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-3 control-label">目的地：</label>
    	<div class="col-sm-9">
        	<select name="dcty[]" id="dcty" class="chosen form-control" multiple="multiple">
        		<?php if(!empty($citys)):foreach ($citys as $key => $city) :?>
        		<option value="<?php echo $key?>"><?php echo $city?></option>
        		<?php endforeach;endif;?>
        	</select>
        </div>
    </div>
    <div class="form-group">
    <div class="col-sm-offset-3 col-sm-9">
          <input name="<?= Yii::$app->request->csrfParam;?>" type="hidden" value="<?= Yii::$app->request->csrfToken ?>">
	<button type="submit">查询</button>
        </div>
	
	</div>
	
</div>
</form>
<?php 

$a = Yii::$app->getSession()->hasFlash('error');
?>
<script type="text/javascript" src="/assets/plugs/jquery/jquery.min.js"></script>
<script type="text/javascript" src="/assets/plugs/chosen/chosen.jquery.js"></script>
<script type="text/javascript" src="/assets/plugs/toastr/toastr.min.js"></script>
<script type="text/javascript">
if($.isFunction($('select.chosen').chosen)){
	initChosen();
}

$(function () {  
	<?php 
		if( Yii::$app->getSession()->hasFlash('success') ) {
		    echo "toastr.error('".Yii::$app->getSession()->getFlash('success')."')";
		}
		if( Yii::$app->getSession()->hasFlash('error') ) {
		    echo "toastr.error('".Yii::$app->getSession()->getFlash('error')."')";
		}
	?>
})  

function initChosen(){
	$('select.chosen').each(function(){
		var options = {};
		options.placeholder_text_multiple = '请选择城市';
		options.no_results_text = '查找不到结果为';
		options.width = '100%';
		
		if(typeof($(this).attr('max')) !== 'undefined'){
			options.max_selected_options = $(this).attr('max');
		}
		
		$(this).chosen(options);
	});
}
</script>
</body>
</html>
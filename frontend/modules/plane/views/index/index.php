<?php 
use yii\bootstrap\Alert;
?>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/assets/plugs/chosen/chosen.css" rel="stylesheet">
<link href="/assets/plugs/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<style>
.content{margin:0 auto;width:500px;margin-top:300px;}
</style>
</head>
<body>
<?php 
if( Yii::$app->getSession()->hasFlash('success') ) {
    echo Alert::widget([
        'options' => [
            'class' => 'alert-success', //这里是提示框的class
        ],
        'body' => Yii::$app->getSession()->getFlash('success'), //消息体
    ]);
}
if( Yii::$app->getSession()->hasFlash('error') ) {
    echo Alert::widget([
        'options' => [
            'class' => 'alert-error',
        ],
        'body' => Yii::$app->getSession()->getFlash('error'),
    ]);
}
?>
<form method="post" action="" id="form1">
<div class="content">
	<span>出发地：</span>
	<select name="acty" id="acty" class="chosen">
		<option value="0">请选择城市</option>
		<?php if(!empty($citys)):foreach ($citys as $key => $city) :?>
		<option value="<?php echo $key?>"><?php echo $city?></option>
		<?php endforeach;endif;?>
	</select>
	<br/>
	<span>目的地：</span>
	<select name="dcty[]" id="dcty" class="chosen" multiple="multiple">
		<?php if(!empty($citys)):foreach ($citys as $key => $city) :?>
		<option value="<?php echo $key?>"><?php echo $city?></option>
		<?php endforeach;endif;?>
	</select>
	<input name="<?= Yii::$app->request->csrfParam;?>" type="hidden" value="<?= Yii::$app->request->csrfToken ?>">
	<button type="submit">查询</button>
</div>
</form>

<script type="text/javascript" src="/assets/plugs/jquery/jquery.min.js"></script>
<script type="text/javascript" src="/assets/plugs/chosen/chosen.jquery.js"></script>
<script type="text/javascript">
if($.isFunction($('select.chosen').chosen)){
	initChosen();
}
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
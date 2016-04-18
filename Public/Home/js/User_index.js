$(function(){
	var tab_child=$("#tab").children();
	tab_child.click(function() {
		var num=$(this).index();
		$('#tab>li[class=active]').removeClass('active');
		$('#contents>div:visible').css("display", "none");
		$('#tab>li:eq('+num+')').addClass('active');
		$('#contents>div:eq('+num+')').css("display", "block");
	});
});

$('button').click(function(){
	$('#contents>div:first>table,button').css('display', 'none');
	$("#list").css('display', 'block');

});

$('#tab>li:first').click(function(event) {
	$('#contents>div:first>table,button').css('display', 'block');
	$(':input[value!=修改]').val('');
	$("#list").css('display', 'none');
});
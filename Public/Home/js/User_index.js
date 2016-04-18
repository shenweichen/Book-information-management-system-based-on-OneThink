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
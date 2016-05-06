$(function() {
	var tab_child = $("#tab").children();
	tab_child.click(function() {
		var num = $(this).index();
		$('#tab>li[class=active]').removeClass('active');
		$('#contents>div:visible').css("display", "none");
		$('#tab>li:eq(' + num + ')').addClass('active');
		$('#contents>div:eq(' + num + ')').css("display", "block");
		if (num==0) {
			 location.href ="index.php?s=/Home/Admin/index"
			 //点击首页重新刷新页面
		} 
	});
	var booklist_child = $("#bookitem").find('button');
	booklist_child.click(function(event) {

		var book_id = $(this).parent().attr('id');
			alert("删除");
	location.href ="index.php?s=/Home/Admin/deletecopy/book_id/"+book_id;
			 //点击删除重新刷新页面
	});

});

$('#button2').click(function() {
	//$('#contents>div:first>table,button').css('display', 'none');
		var isbn = $("#BOOKISBN").html();
		$('#tempisbn').val(isbn);
	$("#list").css('display', 'block');

});

$('#tab>li:first').click(function(event) {
	$('#contents>div:first>table,button').css('display', 'block');
	$(':input[value!=修改]').val('');
	$("#list").css('display', 'none');
});
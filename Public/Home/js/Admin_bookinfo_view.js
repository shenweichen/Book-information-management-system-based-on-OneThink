$(function() {
	var tab_child = $("#tab").children();
	tab_child.click(function() {
		var num = $(this).index();
		$('#tab>li[class=active]').removeClass('active');
		$('#contents>div:visible').css("display", "none");
		$('#tab>li:eq(' + num + ')').addClass('active');
		$('#contents>div:eq(' + num + ')').css("display", "block");
	});
	var booklist_child = $("#bookitem").find('button');
	booklist_child.click(function(event) {
		
		
	if($(this).parent().parent().find('font:first').text()=="在馆"){
var book_id = $(this).parent().attr('id');
		location.href ="index.php?s=/Home/Admin/deletecopy/book_id/"+book_id;
			 //点击删除重新刷新页面
	}else{
		alert("该书尚未归还不可删除!");
	}

	});

});

$('#button2').click(function() {
	//$('#contents>div:first>table,button').css('display', 'none');
		var isbn = $("#BOOKISBN").html();
		$('#tempisbn').val(isbn);
		$(this).css('display','none');
	$("#list").css('display', 'block');

});

$('#tab>li:first').click(function(event) {
	$('#contents>div:first>table,button').css('display', 'block');
	$(':input[value!=修改]').val('');
	$("#list").css('display', 'none');
});


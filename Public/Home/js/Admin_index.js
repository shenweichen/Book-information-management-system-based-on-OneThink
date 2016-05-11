$(function() {
	var tab_child = $("#tab").children();
	tab_child.click(function() {
		var num = $(this).index();
		$('#tab>li[class=active]').removeClass('active');
		$('#contents>div:visible').css("display", "none");
		$('#tab>li:eq(' + num + ')').addClass('active');
		$('#contents>div:eq(' + num + ')').css("display", "block");
	});

	var booklist_child = $("#booklist").find('button');
	booklist_child.click(function(event) {
		var isbn = $(this).parent().attr('id');
	location.href ="index.php?s=/Home/Admin/bookinfo_view/ISBN/"+isbn;
			 
	});
});

$('#button1').click(function() {
	$('#contents>table,span').css('display', 'none');
	$('#searchlist').css('display','none');
	$("#list1").css('display', 'block');
});


$('#tab>li:first').click(function(event) {
	$('#contents>div:first>table,button').css('display', 'block');
	$(':input[value!=修改]').val('');
	$("#list").css('display', 'none');
});

//提交按钮,所有验证通过方可提交
$('#submit').click(function(){
     var book_name = $('#addlist input:eq(0)').val();
     var author = $('#addlist input:eq(1)').val();
     var pub = $('#addlist input:eq(2)').val();
      var ISBN = $('#addlist input:eq(3)').val();
    if(book_name==""||author==""||pub==""||ISBN==""){
        alert("图书信息缺失!");
        return false;
        
    }else{
        $('form').submit();
    }
});

$('#searchbook').click(function(){

     var book_name = $('#searchlist input:eq(0)').val();

    if(book_name==""){
        alert("请输入查询条件");
        return false;
        
    }else{
        $('form').submit();
    }
});
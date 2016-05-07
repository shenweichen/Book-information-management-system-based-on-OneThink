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
		var p = $(this).parent().parent();
		var user_id = p.children('td:eq(11)').attr('id');
		var name = p.children('td:eq(2)').html();
		var mobile=p.children('td:eq(5)').html();
		var college=p.children('td:eq(7)').html();
		var major = p.children('td:eq(8)').html();
		$('#contents>table,button').css('display', 'none');

		$("#list1 :input:eq(0)").val(user_id);
		$("#list1 :input:eq(1)").val(name);
		$("#list1 :input:eq(2)").val(mobile);
		$("#list1 :input:eq(3)").val(college);
		$("#list1 :input:eq(4)").val(major);


	$("#list1").css('display', 'block');
	});
});



// $('#tab>li:first').click(function(event) {
// 	$('#contents>div:first>table,button').css('display', 'block');
// 	$(':input[value!=修改]').val('');
// 	$("#list").css('display', 'none');
// });
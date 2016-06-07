//提交按钮,所有验证通过方可提交
$('#submit').click(function(){
     var keyword = $('#word').val();
    if(keyword!=""){
        
        $('form').submit();
    }else{
        alert("请输入查询条件!");
        return false;
    }
});

$(function(){/*动态加载轮播*/
    var num=eval($("#count").html());
    var str="";
     for (var i = 0; i <num; i++) {
         str+=' <li data-target="#carousel-book" data-slide-to="'+i+'"></li>';
     }
     $(".carousel-indicators").append(str);
    $(".carousel-inner>div:first").addClass('active');
    $(".carousel-indicators>li:first").addClass('active');

});


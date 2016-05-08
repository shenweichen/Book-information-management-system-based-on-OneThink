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

$('#null').click(function(){
 var keyword = $('#word').val();
        if (keyword!="") {
            var sid=$('#field_select').get(0).selectedIndex;
            var query_field;
            switch(sid){/*判断搜索字段*/
                case 0:query_field="book_name";break;
                case 1:query_field="author";break;
                case 2:query_field="ISBN";break;
            }
            $.ajax({/*ajax异步刷新*/
                type: "GET",
                url: "index.php?s=/Home/Index/search",
                data: {
                    keyword:keyword,
                    query_field:query_field
                },
                dataType: "json",
                success: function(data){/*将搜索结果返回*/
                  //  alert("callback"); 
                  $('#answer').empty();   
                    var title='<th>书名</th><th>作者名</th><th>出版社</th><th>出版时间</th>';
                    $('#answer').append(title);
                    for (var i = data.length - 1; i >= 0; i--) {
                      var ISBN=data[i]['ISBN'];
                      var book_name=data[i]['book_name'];
                      var author=data[i]['author'];
                      var pub=data[i]['pub'];
                      var pub_date=data[i]['pub_date'];
                        var str="";
                        str+='<tr>';
                        str+='<td><a href="index.php?s=/home/index/bookinfo/ISBN/'+ISBN+'">'+book_name+'</a></td>';/*将id作为参数拼接*/
                        str+='<td align="center">'+author+'</td>';
                        str+='<td align="center">'+pub+'</td>';
                        str+='<td align="center">'+pub_date+'</td>';
                        str+='<br/></tr>'
                        $('#answer').append(str);
                    }
                    }
                });
            }

        else{

            alert("请输入书籍名称！");
        }
});

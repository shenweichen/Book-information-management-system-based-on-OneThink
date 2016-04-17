//提交按钮,所有验证通过方可提交
$('#submit').click(function(){
     var keyword = $('#word').val();
    if(keyword!=""){
        
        $('form').submit();
    }else{
        alert("字段不能为空!");
        return false;
    }
});
function datetime_to_unix(datetime){

    var tmp_datetime = datetime.replace(/:/g,'-');

    tmp_datetime = tmp_datetime.replace(/ /g,'-');

    var arr = tmp_datetime.split("-");

    var now = new Date(Date.UTC(arr[0],arr[1]-1,arr[2],arr[3]-8,arr[4],arr[5]));

    return parseInt(now.getTime()/1000);

}

function unix_to_datetime(unix) {

    var now = new Date(parseInt(unix) * 1000);

    return now.toLocaleString().replace(/年|月/g, "-").replace(/日/g, " ");

}

 

/*var datetime = '2012-11-16 10:36:50';
var unix = datetime_to_unix(datetime);*/


$('#search_list>p>a').mouseover(function() {
    var isbn=$(this).attr('ISBN');
         $.ajax({/*ajax异步刷新*/
                type: "POST",
                url: "index.php?s=/Home/List/bookinfo_view",
                data: {
                    ISBN:isbn,
                },
                dataType: "json",
                success: function(data){/*将搜索结果返回*/
                    $("div[id="+isbn+"] tbody tr:gt(0)").remove();//删除数据
                    for (var i = data.length - 1; i >= 0; i--) {
                      var call=data[i]['call'];
                      var book_id=data[i]['book_id'];
                      var collection=data[i]['collection'];
                      var state=data[i]['state'];
                      var borrow_time=data[i]['borrow_time'];
                      var back_time=data[i]['back_time'];
                var str = ' <tr align="left" class="whitetext">' +
                    '<td width="10%">'+call+'</td>' +
                    '<td align="center"width="15%">'+book_id+'</td>' +
                    '<td width="15%">&nbsp;-</td>' +
                    '<td width="25%" title="'+collection+'">' +
                    '<span class="glyphicon glyphicon-book"></span>'+collection+'</td>' +
                    '<td width="%25">';
                    if(state=="1"){
                       str+='<font color="green">可借</font>';
                    }else{
                        var datetime = unix_to_datetime(back_time);
                     str+='借出-应还日期：'+datetime;
                    }
                    str+='</td></tr>';
                        $("div[id="+isbn+"] tbody").append(str);

                    }
    $("div[id="+isbn+"]").css("display","block");
                    }
                });
});

$('#search_list>p>a').mouseout(function() {
     var isbn=$(this).attr('ISBN');
    $("div[id="+isbn+"]").css("display","none");

});






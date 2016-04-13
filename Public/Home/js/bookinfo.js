var ISBN = $('#ISBN').html();
var remainnum=$('#remainnum').html();
var totalnum=$('#totalnum').html();
var userid=$('#userid').html();
var book_id=$('#state').html();
$('#borrow').click(function(){
    if(userid==0){
        alert("该用户还未登录");
    }
    else{
        if (remainnum>0) {
            $.ajax({/*ajax异步刷新*/
                type: "POST",
                url: "index.php?s=/Home/Index/borrow",
                data: {
                    ISBN:ISBN,
                },
                dataType: "json",
                success: function(data){
                $('#remainnum').html(data.remainnum);
                remainnum=$('#remainnum').html();
                $('#state').html(data.book_id);
                    }
                });
            }
        else{
            alert("该书没有余量");
        }
    }
});

$('#return').click(function(){
    if(userid==0){
          alert("该用户还未登录");
      }else{
        if (eval(remainnum)<eval(totalnum)) {
        	/*不能直接比较大写，因为是字符串，先转换成数字*/
            $.ajax({/*ajax异步刷新*/
                type: "POST",
                url: "index.php?s=/Home/Index/returnbook",
                data: {
                    ISBN:ISBN,
                    book_id:book_id,
                },
                dataType: "json",
                success: function(data){
                $('#remainnum').html(data);
                remainnum=$('#remainnum').html();
                $('#state').html(0);
                    }
                });
            }
        else{

            alert("该书不可还");
        }
    }
});
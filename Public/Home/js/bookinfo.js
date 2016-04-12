var bookid = $('#bookid').html();
var remainnum=$('#remainnum').html();
var totalnum=$('#totalnum').html();
var userid=$('#userid').html();
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
                    book_id:bookid,
                    user_id:userid,
                },
                dataType: "json",
                success: function(data){
                $('#remainnum').html(data);
                remainnum=$('#remainnum').html();
                $('#state').html(1);
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
                    book_id:bookid,
                    user_id:userid,
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
var ISBN = $('#ISBN').html();
var remainnum=$('#remainnum').html();
var totalnum=$('#totalnum').html();
var userid=$('#userid').html();
$('#borrow').click(function(){
    var  book_id=$('#state').html();
    if(userid==0){
        alert("该用户还未登录");
    }else if(book_id!=0){
    alert("您当前正在借阅这本书!不可重复借阅")
    }
    else{
        if (remainnum>0) {
            $.ajax({/*ajax异步刷新*/
                type: "POST",
                url: "index.php?s=/Home/List/borrow",
                data: {
                    ISBN:ISBN,
                },
                dataType: "json",
                success: function(data){
                    alert("借阅成功!");
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
         var  book_id=$('#state').html();
        if (eval(book_id)!=0) {
        	/*不能直接比较大小，因为是字符串，先转换成数字*/
          var  book_id=$('#state').html();
            $.ajax({/*ajax异步刷新*/
                type: "POST",
                url: "index.php?s=/Home/List/returnbook",
                data: {
                    ISBN:ISBN,
                    book_id:book_id,
                },
                dataType: "json",
                success: function(data){
                    alert("还书成功");
                $('#remainnum').html(data);
                remainnum=$('#remainnum').html();
                $('#state').html(0);
                    }
                });
            }
        else{

            alert("该书不可还，您尚未借阅此书");
        }
    }
});
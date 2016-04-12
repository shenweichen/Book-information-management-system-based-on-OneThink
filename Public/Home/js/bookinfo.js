var bookid = $('#bookid').html();
var remainnum=$('#remainnum').html();
var totalnum=$('#totalnum').html();
$('#borrow').click(function(){
        if (remainnum>0) {
            $.ajax({/*ajax异步刷新*/
                type: "POST",
                url: "index.php?s=/Home/Index/borrow",
                data: {
                    id:bookid,
                },
                dataType: "json",
                success: function(data){
                $('#remainnum').html(data);
                remainnum=$('#remainnum').html();
                    }
                });
            }
        else{
            alert("该书没有余量");
        }
});

$('#return').click(function(){
        if (eval(remainnum)<eval(totalnum)) {
        	/*不能直接比较大写，因为是字符串，先转换成数字*/
            $.ajax({/*ajax异步刷新*/
                type: "POST",
                url: "index.php?s=/Home/Index/returnbook",
                data: {
                    id:bookid,
                },
                dataType: "json",
                success: function(data){
                $('#remainnum').html(data);
                remainnum=$('#remainnum').html();
                    }
                });
            }
        else{

            alert("该书不可还");
        }
});
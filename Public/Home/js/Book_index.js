var ISBN = $('#ISBN').html();
var remainnum = $('#remainnum').html();
var totalnum = $('#totalnum').html();
var userid = $('#userid').html();
var score = 0;
function unix_to_datetime(unix) {

    var now = new Date(parseInt(unix) * 1000);

    return now.toLocaleString().replace(/年|月/g, "-").replace(/日/g, " ");

}


$('#borrow').click(function() {
    var book_id = $('#state').html();
    if (userid == 0) {
        alert("该用户还未登录");
    } else if (book_id != 0) {
        alert("您当前正在借阅这本书!不可重复借阅")
    } else {
        if (remainnum > 0) {
            $.ajax({ /*ajax异步刷新*/
                type: "POST",
                url: "index.php?s=/Home/Book/borrow",
                data: {
                    ISBN: ISBN,
                },
                dataType: "json",
                success: function(data) {

                    var book_id = data.book_id;
                    var back_time = unix_to_datetime(data.back_time);
                    $('#remainnum').html(data.remainnum);
                    remainnum = $('#remainnum').html();
                    $('#state').html(book_id);
          /*          $('#borrow').attr('disabled', 'disabled');
                    $('#return').removeAttr('disabled');*/
                    $('#' + book_id + '>td:last').html('借出-应还日期' + back_time);
                    $("#bookstate").html(' <font color="red">借阅中</font>');

                    $('#borrow').css('display','none');
                    $('#return').css('display','block');

                    var temp = $("#borrow").clone(); 
                    $("#borrow").remove(); 
                    $("#return").after(temp);


                    alert("借阅成功!");
                }
            });
        } else {
            alert("该书没有余量");
        }
    }
});

$('#return').click(function() {
    if (eval(score) == 0) {
        alert("请给出您的评分");
    } else {
        var book_id = $('#state').html();
        if (eval(book_id) != 0) {
            /*不能直接比较大小，因为是字符串，先转换成数字*/
            $.ajax({ /*ajax异步刷新*/
                type: "POST",
                url: "index.php?s=/Home/Book/returnbook",
                data: {
                    ISBN: ISBN,
                    book_id: book_id,
                    score:score
                },
                dataType: "json",
                success: function(data) {
                    $('#remainnum').html(data);
                    remainnum = $('#remainnum').html();
                    $('#state').html(0);
                   /* $('#borrow').removeAttr('disabled');
                    $('#return').attr('disabled', 'disabled');*/
                    var str = '<font color="green">可借</font>';
                    $('#' + book_id + '>td:last').empty();
                    $('#' + book_id + '>td:last').append(str);
                    $("#bookstate").empty();
                    $("#bookstate").append(str);

                    $('#return').css('display', 'none');   
                  $('#borrow').css('display','block');
                   var temp = $("#return").clone(); 
                    $("#return").remove(); 
                    $("#borrow").after(temp);


              
                    alert("还书成功");
                }
            });
        } else {
            alert("该书不可还，您尚未借阅此书");
        }
    }
});

$('#collect').click(function() {
    var book_id = $('#collection').html();
    if(book_id=="0"){
            $.ajax({ /*ajax异步刷新*/
                type: "POST",
                url: "index.php?s=/Home/Book/collect",
                data: {
                    ISBN: ISBN,
                    type:1,
                },
                dataType: "json",
                success: function(data) {
                    alert("收藏成功");
                    $('#collection').html("1");
                    $('#collect').removeClass('btn-info');
                    $('#collect').addClass('btn-danger');
                 $('#collect').html("取消收藏");
                }
            });
        }else{

$.ajax({ /*ajax异步刷新*/
                type: "POST",
                url: "index.php?s=/Home/Book/collect",
                data: {
                    ISBN: ISBN,
                    type:0,
                },
                dataType: "json",
                success: function(data) {
                    alert("取消收藏成功");
                    $('#collection').html("0");
                       $('#collect').removeClass('btn-danger');
                      $('#collect').addClass('btn-info');
                   $('#collect').html("收藏");
                }
            });

        }
});

$(function(){
    $("#input-id").rating();
    $('#input-id').on('rating.change', function(event, value, caption) {
    score=value;
});

$('#input-id').on('rating.clear', function(event) {
    score=0;
});

    var tab_child=$("#tab").children();
    tab_child.click(function() {
        var num=$(this).index();
        $('#tab>li[class=active]').removeClass('active');
        $('#tabs>div:visible').css("display", "none");
        $('#tab>li:eq('+num+')').addClass('active');
        $('#tabs>div:eq('+num+')').css("display", "block");
    });
});



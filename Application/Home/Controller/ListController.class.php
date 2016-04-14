<?php 
namespace Home\Controller;

class ListController extends HomeController{
	public function index(){
		$book=M('book');
		$word=I('keyword');
        $query_field=I('query_field');

    	$map[$query_field]=array('LIKE','%'.$word.'%');
    	$count=$book->where($map)->count();
    	$Page=new \Think\Page($count,3);//设置分页
    	/*foreach ($map as $key => $val) {
    		$Page->parameter[$key]   =   urlencode($val);
    	}*/
    	//分页跳转的查询条件的字段不是数据表中的字段，而是提交的字段
    	$Page->parameter['keyword']   = urlencode($word);
    	$Page->parameter['query_field']   = urlencode($query_field);

    	$list=$book->where($map)->limit($Page->firstRow.','.$Page->listRows)->select();
    	$this->count=$count;
    	$this->query_field=$query_field;
    	$this->word=$word;

 		$this->book=$list;
    	$this->page=$Page->show();
    	$this->display();
	}

    public function bookinfo(){
        $ISBN=I('ISBN');
        $user_id = session('user_id');
        $map['ISBN']=array('EQ',$ISBN);
        $this->info=M('book')->where($map)->find();//find返回一行数据
        $map['user_id']=intval($user_id);
        $book_id=M('borrow')->where($map)->getField('book_id');
  
        $this->state=$book_id?$book_id:0;//返回当前用户这本书的借阅状态：已借阅：book_id，未借阅为0

        $this->userid=$user_id;
        $this->display();
    }
/*    public function _before_borrow(){
        is_login() || $this->error('您还没有登录，请先登录！', U('User/login'));
    }
    public function _before_returnbook(){
        is_login() || $this->error('您还没有登录，请先登录！', U('User/login'));
    }
*/
    public function borrow(){
        $ISBN=I('ISBN');
        $user_id=session('user_id');
        $map['ISBN']=$ISBN;
    //找到一本在库的书借出并设置状态为借出
        $bookid_isbn=M('bookid_isbn');
        $book_id=$bookid_isbn->where($map)->where('state=1')->getField('book_id');
        $map['book_id']=$book_id;
        $bookid_isbn-> where($map)->setField('state',0);//数据库内部设置了触发器,当状态字段改变会自动修改库存数量

        $answer['remainnum']=M('book')->where($map)->getField('remainnum');
        $answer['book_id']=$book_id;
    //将借书记录插入至借阅表
        $map['user_id']=intval($user_id);//session里存的user_id为字符串型，这里需要转换成整型
       // 日期时间在数据库中设置了自动获取
        M('borrow')->add($map);
        $this->ajaxReturn($answer);
    }

     public function returnbook(){
         $ISBN=I('ISBN');
         $user_id=session('user_id');
         $book_id=I('book_id');

        $map['ISBN']=array('EQ',$ISBN);
        $map['book_id']=$book_id;
         M('bookid_isbn')->where($map)->setField('state',1);//将bookid表中的借阅状态设置为0，同时触发器自动更新库存数量
        $remainnum=M('book')->where($map)->getField('remainnum');//获取指定字段的值

        $map['user_id']=$user_id;
        $borrow=M('borrow');
        $record= $borrow->where($map)->find();//找到该条借阅记录

        M('borrow_history')->add($record);//插入到还书表
         $borrow->where($map)->delete();//删除该条借阅记录
     

        $this->ajaxReturn($remainnum);
    }



    
}



 ?>
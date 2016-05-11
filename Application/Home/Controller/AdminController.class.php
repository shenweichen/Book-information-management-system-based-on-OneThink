<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Home\Controller;


/**
 * 后台控制器
 * 包括图书管理，用户管理
 */
class AdminController extends HomeController {

	/* 用户中心首页 */
	public function index(){
		parent::login();
		$user_id=session('user_id');
		if($user_id!=1){//只有管理员可以登录后台管理
			$this->error('您无权进行后台管理操作');
		}
		$this->userid=$user_id;

		$this->bookall=M('book')->select();
	
		$this->display();
	}

	public function users(){
		$this->users=M('reader_view')->select();
		$this->display();
	}

	public function bookinfo_view(){
		//parent::login();
        $map['ISBN']=I('ISBN');
        $this->bookinfo=M('bookinfo_view')->where($map)->select();
        $this->book_isbn=$map['ISBN'];
        $this->img=M('book')->where($map)->getField('img');
        $this->book_name=M('book')->where($map)->getField('book_name');
        $this->display();
}
	public function addbook(){
		$user_id=session('user_id');

		$data['ISBN']=I('isbn');
		$data['book_name']=I('book_name');
		$data['author']=I('author');
		$data['pub']=I('pub');
		$data['call_num']=I('call_num');
		$data['img']=I('img');
		M('book')->add($data);
		$this->success('添加新书成功', U('bookinfo_view',array('ISBN'=>$data['ISBN'])));
	}


	public function addcopy(){
		$user_id=session('user_id');

		$number=I('number');
		$data['ISBN']=I('isbn');
		$data['collection']=I('collection');
		for ($i=0; $i <$number ; $i++) { 
			M('bookid_isbn')->add($data);
		}

		$map['ISBN']=I('isbn');

		$this->success('添加复本成功', U('bookinfo_view',array('ISBN'=>$map['ISBN'])));
	}
	public function deletecopy(){

		$user_id=session('user_id');

		$map['book_id']=I('book_id');
			$data['ISBN']=M('bookid_isbn')->where($map)->getField('ISBN');
		M('bookid_isbn')->where($map)->delete();
	

		$this->success('删除复本成功', U('bookinfo_view',array('ISBN'=>$data['ISBN'])));
	}

	public function updateuser(){
		$user_id=I('user_id');

		$map['name']=I('name');
		$map['mobile']=I('mobile');
		$map['college']=I('college');
		$map['major']=I('major');

		M('reader')->where('user_id=%d',$user_id)->save($map);
		$this->success('修改成功', 'index.php?s=/Home/Admin/users');

	}

	public function searchbook(){

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
        switch ($query_field) {
            case 'book_name':
                    $this->query_field="题名";
                break;
            case 'author':
                    $this->query_field="作者";
                break;
            case 'ISBN':
                $this->query_field="ISBN编号";
            break;
        }
    	$this->word=$word;

 		$this->bookall=$list;
    	$this->page=$Page->show();
    	$this->display('index');
	}



	public function searchuser(){

		$reader=M('reader_view');
		$word=I('keyword');
        $query_field=I('query_field');

    	$map[$query_field]=array('LIKE','%'.$word.'%');
    	$count=$reader->where($map)->count();
    	$Page=new \Think\Page($count,3);//设置分页
    	/*foreach ($map as $key => $val) {
    		$Page->parameter[$key]   =   urlencode($val);
    	}*/
    	//分页跳转的查询条件的字段不是数据表中的字段，而是提交的字段
    	$Page->parameter['keyword']   = urlencode($word);
    	$Page->parameter['query_field']   = urlencode($query_field);

    	$list=$reader->where($map)->limit($Page->firstRow.','.$Page->listRows)->select();
    	$this->count=$count;

 		$this->users=$list;
    	$this->page=$Page->show();
    	$this->display('users');
	}

	

}

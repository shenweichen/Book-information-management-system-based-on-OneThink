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
 * 包括用户中心，用户登录及注册
 */
class AdminController extends HomeController {

	/* 用户中心首页 */
	public function index(){
		//parent::login();
		$user_id=session('user_id');
		$this->userid=$user_id;

		$this->bookall=M('book')->select();
		$this->books=M('borrow')->where('user_id=%d',$user_id)->select();//分配当前正在借阅的图书给模板
		$this->history=M('borrow_history')->where('user_id=%d',$user_id)->select();
		//分配借阅历史
		$this->collection=M('collection_view')->where('user_id=%d',$user_id)->select();
		//分配收藏
		$this->display();
	}

	public function bookinfo_view(){
		//parent::login();
        $map['ISBN']=I('ISBN');
        $this->bookinfo=M('bookinfo_view')->where($map)->select();
        $this->book_isbn=$map['ISBN'];

        $this->display();
}
	public function addbook(){
		$user_id=session('user_id');

		$data['ISBN']=I('isbn');
		$data['book_name']=I('book_name');
		$data['author']=I('author');
		$data['pub']=I('pub');
		$data['call_num']=I('call_num');

		M('book')->add($data);
		$this->success('添加新书成功', 'index.php?s=/Home/Admin/index');
	}


	public function addcopy(){
		$user_id=session('user_id');

		$number=I('number');
		$data['ISBN']=I('isbn');
		$data['collection']=I('collection');
		for ($i=0; $i <$number ; $i++) { 
			M('bookid_isbn')->add($data);
		}
	
		$this->success('添加复本成功', 'index.php?s=/Home/Admin/index');
	}

	public function deletecopy(){

		$user_id=session('user_id');

		$map['book_id']=I('book_id');
		M('bookid_isbn')->where($map)->delete();

		$this->success('删除成功', 'index.php?s=/Home/Admin/index');
	}
	/*public function update(){
		$user_id=session('user_id');
		$mobile=I('mobile');
		$college=I('college');
		$major=I('major');

		$map['mobile']=$mobile;
		$map['college']=$college;
		$map['major']=$major;

		M('reader')->where('user_id=%d',$user_id)->save($map);
		$this->success('修改成功', 'index.php?s=/Home/User/index');

	}*/

	

}

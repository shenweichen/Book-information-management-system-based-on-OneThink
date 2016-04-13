<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Home\Controller;
use OT\DataDictionary;

/**
 * 前台首页控制器
 * 主要获取首页聚合数据
 */
class IndexController extends HomeController {

	//系统首页
    public function index(){
        session('user_id',is_login());
        //将当前用户ID存在session中
    	$this->books=M('book')->select();//select返回多行数据
    	$this->display();
        /*$category = D('Category')->getTree();
        $lists    = D('Document')->lists(null);

        $this->assign('category',$category);//栏目
        $this->assign('lists',$lists);//列表
        $this->assign('page',D('Document')->page);//分页

                 
        $this->display();*/
    }

    public function search(){

    	$word=I('keyword');
        $query_field=I('query_field');
    	$map[$query_field]=array('LIKE','%'.$word.'%');
    	$answer=M('book')->where($map)->select();
    	$this->ajaxReturn($answer);
    }
    public function bookinfo(){
        $ISBN=I('ISBN');
        $user_id = session('user_id');
        $map['ISBN']=array('EQ',$ISBN);
        $this->info=M('book')->where($map)->find();//find返回一行数据
        $map['user_id']=intval($user_id);
        $this->state=M('borrow')->where($map)->getField('book_id');//返回当前用户这本书的借阅状态
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
    //找到一本在库的书借出设置状态为借出
        $bookid_isbn=M('bookid_isbn');
        $book_id=$bookid_isbn->where($map)->where('state=0')->getField('book_id');
        $bookid_isbn-> where("book_id=%d",$book_id)->setField('state',1);

        M('book')->where($map)->setDec('remainnum');//统计字段更新
        $answer['remainnum']=M('book')->where($map)->getField('remainnum');
        $answer['book_id']=$book_id;
    //将借书记录插入至借阅表
        $map['user_id']=intval($user_id);//session里存的user_id为字符串型，这里需要转换成整型
        $map['book_id']=$book_id;
       // 日期时间在数据库中设置了自动获取
        M('borrow')->add($map);
        $this->ajaxReturn($answer);
    }

     public function returnbook(){
         $ISBN=I('ISBN');
         $user_id=session('user_id');
         $book_id=I('book_id');

        $map['ISBN']=array('EQ',$ISBN);
        M('book')->where($map)->setInc('remainnum');
        $remainnum=M('book')->where($map)->getField('remainnum');//获取指定字段的值

        $map['user_id']=$user_id;
        $map['book_id']=$book_id;

        $record=M('borrow')->where($map)->find();//找到该条借阅记录

        M('borrow_history')->add($record);//插入到还书表
        M('borrow')->where($map)->delete();//删除该条借阅记录

        $this->ajaxReturn($remainnum);
    }


}
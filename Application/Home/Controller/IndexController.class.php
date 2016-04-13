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
        session('uid',is_login());//将当前用户ID存在session中
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
    	$answer=M('book')->where($map)->order('id desc')->select();
    	$this->ajaxReturn($answer);
    }
    public function bookinfo(){
        $bookid=I('book_id');
        $userid = session('uid');
        $map['book_id']=array('EQ',$bookid);
        $this->info=M('book')->where($map)->find();//find返回一行数据
        $map['user_id']=$userid;
        $this->state=M('book_record')->where($map)->getField('type');//返回当前用户这本书的借阅状态
        $this->userid=$userid;
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
        $bookid=I('book_id');
        $userid=I('user_id');
        $map['book_id']=array('EQ',$bookid);
        M('book')->where($map)->setDec('remainnum');//统计字段更新
        $num=M('book')->where($map)->getField('remainnum');

        $record=M('book_record');
        if($record->create()){
            $record->add();
        }

        $this->ajaxReturn($num);
    }
     public function returnbook(){
        $bookid=I('book_id');
         $userid=I('user_id');
        $map['book_id']=array('EQ',$bookid);
        M('book')->where($map)->setInc('remainnum');
        $num=M('book')->where($map)->getField('remainnum');//获取指定字段的值

        $map['user_id']=$userid;
 
        M('book_record')->where($map)->setField('type',0);//更新指定字段

        $this->ajaxReturn($num);
    }


}
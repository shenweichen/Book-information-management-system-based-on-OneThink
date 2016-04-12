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
        foreach ($answer as $key => $value) {//实现关联查询

            $data['book_id'] = $value['id'];
            $result = M('Book_info')->where($data)->Field('publish,pub_date')->find();
            $answer[$key]['publish'] = $result['publish'];
            $answer[$key]['pub_date']=$result['pub_date'];
        }
    	$this->ajaxReturn($answer);
    }
    public function bookinfo(){
        $bookid=I('id');
        $userid=is_login();
        $map['book_id']=array('EQ',$bookid);
        $this->info=M('book_info')->where($map)->find();//find返回一行数据
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
        M('book_info')->where($map)->setDec('remainnum');//统计字段更新
        $num=M('book_info')->where($map)->getField('remainnum');

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
        M('book_info')->where($map)->setInc('remainnum');
        $num=M('book_info')->where($map)->getField('remainnum');//获取指定字段的值

        $map['user_id']=$userid;
 
        M('book_record')->where($map)->setField('type',0);//更新指定字段

        $this->ajaxReturn($num);
    }


}
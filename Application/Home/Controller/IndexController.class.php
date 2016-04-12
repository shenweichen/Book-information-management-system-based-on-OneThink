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

            $data['bid'] = $value['id'];
            $result = M('Book_info')->where($data)->Field('publish,pub_date')->find();
            $answer[$key]['publish'] = $result['publish'];
            $answer[$key]['pub_date']=$result['pub_date'];
        }
    	$this->ajaxReturn($answer);
    }
    public function bookinfo(){
        $bookid=I('id');
        $map['bid']=array('EQ',$bookid);
        $this->info=M('book_info')->where($map)->find();//find返回一行数据
        $this->display();
    }
    public function borrow(){
        $bookid=I('id');
        $map['bid']=array('EQ',$bookid);
        M('book_info')->where($map)->setDec('remainnum');//统计字段更新
        $num=M('book_info')->where($map)->getField('remainnum');
        $this->ajaxReturn($num);
    }
     public function returnbook(){
        $bookid=I('id');
        $map['bid']=array('EQ',$bookid);
        M('book_info')->where($map)->setInc('remainnum');
        $num=M('book_info')->where($map)->getField('remainnum');//获取指定字段的值
        $this->ajaxReturn($num);
    }


}
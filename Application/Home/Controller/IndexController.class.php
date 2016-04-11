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
    	$this->books=M('book')->select();
    	$this->display();
    	//die;
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
    	// echo json_encode($answer);
    	$this->ajaxReturn($answer);

    	// var_dump($answer);die;
    }

}
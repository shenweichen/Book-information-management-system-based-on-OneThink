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
        $user_id=session('user_id');
     
       //显示热门图书
    	$this->books=M('borrowrank_view')->order('rank desc')->limit(3)->select();
        $this->count=count($this->books);//热门图书数量
        $this->name=M('reader')->where('user_id=%d',$user_id)->getField('name');//分配用户名用于欢迎语
        //显示高分图书
        $this->highbooks=M('book')->order('avg_score desc')->limit(3)->select();
        //计算推荐图书
        system("python recommend.py",$out); 
        $this->recommend=M('recommend_view')->select();
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
    	$result=M('book')->where($map)->select();
    	$this->ajaxReturn($result);
    }
  


}
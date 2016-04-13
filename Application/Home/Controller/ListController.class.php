<?php 
namespace Home\Controller;

class ListController extends HomeController{
	public function index(){
		$book=M('book');
		$word=I('keyword');
        $query_field=I('query_field');

    	$map[$query_field]=array('LIKE','%'.$word.'%');
    	$count=$book->where($map)->count();
    	$Page=new \Think\Page($count,2);
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
}



 ?>
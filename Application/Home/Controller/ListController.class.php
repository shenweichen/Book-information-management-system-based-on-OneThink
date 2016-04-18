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

 		$this->book=$list;
    	$this->page=$Page->show();
    	$this->display();
	}


    public function bookinfo_view(){
        $ISBN=I('ISBN');
        $map['ISBN']=$ISBN;
        $answer=M('bookinfo_view')->where($map)->select();
        $this->ajaxReturn($answer);
    }


   



    
}



 ?>

<?php $ps_text = '
<!--
API
參數說明：start_date         => 起始日期(只接受 格式為：YYYYMMDD,共8碼)
　　　　　end_date           => 起始日期(只接受 格式為：YYYYMMDD,共8碼)
　　　　　limit              => 筆數 (數字)
　　　　　status             => 狀態(0=>全部 , 1=>OK ,2=>OK-SEQ 3=>OK-JOB 4 =>NG 5=>NS 6=> REVERSE)
	     operator           => 人員
         job                => (0=>列出所有的job)
         mode               =>(ng_rank(NG排行) ,)

-->';

header("Access-Control-Allow-Credentials: true ");
header("Access-Control-Allow-Methods: OPTIONS, GET, POST");
header("Access-Control-Allow-Headers: Content-Type, Depth, User-Agent, X-File-Size, X-Requested-With, If-Modified-Since, X-File-Name, Cache-Control");

echo $ps_text;
# 輸出結果
switch($type){

}
?>
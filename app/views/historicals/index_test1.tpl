<?php 
// 假設你的陣列名稱是 $array
$array = array(
    '20240422' => array('ng_count' => 0, 'ok_count' => 0, 'ok_all_count' => 0),
    '20240423' => array('ng_count' => 3, 'ok_count' => 0, 'ok_all_count' => 0),
    '20240424' => array('ng_count' => 0, 'ok_count' => 0, 'ok_all_count' => 0),
    '20240425' => array('ng_count' => 0, 'ok_count' => 0, 'ok_all_count' => 0),
    '20240426' => array('ng_count' => 0, 'ok_count' => 1, 'ok_all_count' => 6),
    '20240427' => array('ng_count' => 0, 'ok_count' => 0, 'ok_all_count' => 0),
    '20240428' => array('ng_count' => 0, 'ok_count' => 0, 'ok_all_count' => 0),
    '20240429' => array('ng_count' => 0, 'ok_count' => 0, 'ok_all_count' => 0)
);

// 提取 ng_count 的值
$ng_counts = array();
foreach ($array as $date => $data) {
    $ng_counts[$date] = $data['ng_count'];
}

// 將陣列轉換成 JSON 格式
$json_data = json_encode($ng_counts);

// 輸出 JSON 資料
echo $json_data;

?>
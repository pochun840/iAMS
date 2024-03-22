<?php


// App 根目錄，這是引入 app 資料夾裡的資源用的
define('APPROOT', dirname(dirname(__FILE__)) . '/');

// URL 根目錄，這是引入 public 資料夾裡的資源，或是頁面跳轉時用的
define('URLROOT', '../public/'); //local用

// 網站名稱
define('SITENAME', 'iDAS');

// iDAS連線模式 0:單機版 1:連線版
define('IDASMODE', '1');
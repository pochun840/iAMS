<?php

class Monitors_2{
    private $db;//cc db
    private $db_gtcs;//gtcs tcscon.db

    // 在建構子將 Database 物件實例化
    public function __construct()
    {
        $this->db = new Database;
        $this->db = $this->db->getDb_cc();

    }

  

 

}

<?php

class Calibration{
    private $db;//condb control box
    private $db_dev;//devdb tool
    private $db_iDas;//iDas db
    private $db_cc;//iDas db

    // 在建構子將 Database 物件實例化
    public function __construct()
    {
        $this->db = new Database;
        $this->db = $this->db->getDb_cc();
    }


    public function details($mode){

        $details = array();
        if($mode =="controller"){
            $details = array(
                0 => 'GTCS',
                1 => 'TCG',
            );
        }

        if($mode =="torquemeter"){
            $details = array(
                0 => 'KTM-150',
                1 => 'KTM-50',
                2 => 'KTM-100'
            );
        }


        return $details;
    }

   
  


}

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

        if($mode =="torque"){
            $details  = array(
                1 => 'N.m',
                0 => 'Kgf.m',
                2 => 'Kgf.cm',
                3 => 'In.lbs',
            );
    
        }

   

        return $details;
    }


    public function datainfo(){

        $sql =" SELECT * FROM calibrations ORDER BY id desc ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetchAll(PDO::FETCH_ASSOC);

        return $result;

    }


    public function echarts_data(){

        $sql =" SELECT * FROM calibrations ORDER BY id ASC ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        
        $result_charts = $statement->fetchAll(PDO::FETCH_ASSOC);


        return $result_charts;

        /*if(!empty($result)){
            $id_json = json_encode(array_column($result, 'id'));
            $torque_json = json_encode(array_column($torque, 'id'));
            echo $id_json;
        }*/

        




        
    }


    public function tidy_data($final){

        #從資料庫找出最大 最小 平均 扭力 high_percent low_percent
        $sql =" SELECT  MAX(torque) AS max_torque, MIN(torque) AS min_torque   FROM  calibrations ORDER BY id DESC LIMIT 1 ";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetchAll(PDO::FETCH_ASSOC);


        $sql_total ="SELECT COUNT(*) AS total_records  FROM calibrations";
        $statement = $this->db->prepare($sql_total);
        $statement->execute();
        $result_total = $statement->fetchAll(PDO::FETCH_ASSOC);


        $count = (int)$result_total[0]['total_records'] + 1;
        if(isset($result[0])){
            //新增資料 

            $max_torque = floatval($result[0]['max_torque']);
            $min_torque = floatval($result[0]['min_torque']);
           
            if($final > $max_torque){
                $max_torque = $final;

            }

            if($final < $min_torque){
                $min_torque = $final;
            }

            $avg_torque = $max_torque + $final / $count; 


            $high_percent = "(C42-C43)/C43)";
            $low_percent  = "(C42-C43)/C43)";

            
            $datatime = date("Ymd H:i:s");

            echo $max_torque;
            echo "<br>";
            echo $min_torque;
            echo "<br>";
            echo $avg_torque;




        }
    

    }


   
  


}

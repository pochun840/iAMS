<?php

class Operation{
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

    // 取得Nav列
    public function GetNav()
    {
        $sql = 'SELECT * FROM nav';
        $statement = $this->db->prepare($sql);
        $results = $statement->execute();

        return $statement->fetchall(PDO::FETCH_ASSOC);;
    }

    // 取得user id by account
    public function GetUserIdByAccount($account)
    {
        $sql = 'SELECT * FROM users WHERE account = :account';
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':account', $account);
        $statement->execute();
        $results = $statement->fetch(PDO::FETCH_ASSOC);

        return $results['id'];
    }

    //-----------------------------------------------

    // 取得config table的設定值
    public function GetConfigValue($config_name)
    {
        $sql = 'SELECT * FROM config WHERE config_name = :config_name ';
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':config_name', $config_name);
        $statement->execute();
        $results = $statement->fetch(PDO::FETCH_ASSOC);

        return $results;
    }

    // 設定config table的設定值
    public function SetConfigValue($config_name,$value)
    {
        $sql = 'UPDATE config SET value = :value WHERE config_name = :config_name ';
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':value', $value);
        $statement->bindValue(':config_name', $config_name);
        $statement->execute();
        $results = $statement->fetch(PDO::FETCH_ASSOC);

        return $results;
    }

    // 取得所有enable的Sequence
    public function getSequencesEnable($job_id)
    {
        $sql = "SELECT * FROM `sequence` WHERE job_id = :job_id AND sequence_enable = 1";
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':job_id', $job_id);
        $statement->execute();

        return $statement->fetchall(PDO::FETCH_ASSOC);
    }

    // 取得所有enable的Sequence
    public function SaveFastenData($data)
    {
        $sql = "INSERT INTO `fasten_data` ('cc_barcodesn','cc_station','cc_job_id','cc_seq_id','cc_task_id','cc_equipment','cc_operator','system_sn','data_time','device_type','device_id','device_sn','tool_type','tool_sn','tool_status','job_id','job_name','sequence_id','sequence_name','step_id','fasten_torque','torque_unit','fasten_time','fasten_angle','count_direction','last_screw_count','max_screw_count','fasten_status','error_message','step_targettype','step_tooldirection','step_rpm','step_targettorque','step_hightorque','step_lowtorque','step_targetangle','step_highangle','step_lowangle','step_delayttime','threshold_torque','step_threshold_angle','downshift_torque','downshift_speed','step_prr_rpm','step_prr_angle','barcode','total_angle')
        VALUES(:cc_barcodesn,:cc_station,:cc_job_id,:cc_seq_id,:cc_task_id,:cc_equipment,:cc_operator,:system_sn,:data_time,:device_type,:device_id,:device_sn,:tool_type,:tool_sn,:tool_status,:job_id,:job_name,:sequence_id,:sequence_name,:step_id,:fasten_torque,:torque_unit,:fasten_time,:fasten_angle,:count_direction,:last_screw_count,:max_screw_count,:fasten_status,:error_message,:step_targettype,:step_tooldirection,:step_rpm,:step_targettorque,:step_hightorque,:step_lowtorque,:step_targetangle,:step_highangle,:step_lowangle,:step_delayttime,:threshold_torque,:step_threshold_angle,:downshift_torque,:downshift_speed,:step_prr_rpm,:step_prr_angle,:barcode,:total_angle)
        ";
        $statement = $this->db->prepare($sql);
        $statement->bindValue(':cc_barcodesn', $data['cc_barcodesn']);
        $statement->bindValue(':cc_station', $data['cc_station']);
        $statement->bindValue(':cc_job_id', $data['cc_job_id']);
        $statement->bindValue(':cc_seq_id', $data['cc_seq_id']);
        $statement->bindValue(':cc_task_id', $data['cc_task_id']);
        $statement->bindValue(':cc_equipment', $data['cc_equipment']);
        $statement->bindValue(':cc_operator', $data['cc_operator']);
        $statement->bindValue(':system_sn', $data['system_sn']);
        $statement->bindValue(':data_time', $data['data_time']);
        $statement->bindValue(':device_type', $data['device_type']);
        $statement->bindValue(':device_id', $data['device_id']);
        $statement->bindValue(':device_sn', $data['device_sn']);
        $statement->bindValue(':tool_type', $data['tool_type']);
        $statement->bindValue(':tool_sn', $data['tool_sn']);
        $statement->bindValue(':tool_status', $data['tool_status']);
        $statement->bindValue(':job_id', $data['job_id']);
        $statement->bindValue(':job_name', $data['job_name']);
        $statement->bindValue(':sequence_id', $data['sequence_id']);
        $statement->bindValue(':sequence_name', $data['sequence_name']);
        $statement->bindValue(':step_id', $data['step_id']);
        $statement->bindValue(':fasten_torque', $data['fasten_torque']);
        $statement->bindValue(':torque_unit', $data['torque_unit']);
        $statement->bindValue(':fasten_time', $data['fasten_time']);
        $statement->bindValue(':fasten_angle', $data['fasten_angle']);
        $statement->bindValue(':count_direction', $data['count_direction']);
        $statement->bindValue(':last_screw_count', $data['last_screw_count']);
        $statement->bindValue(':max_screw_count', $data['max_screw_count']);
        $statement->bindValue(':fasten_status', $data['fasten_status']);
        $statement->bindValue(':error_message', $data['error_message']);
        $statement->bindValue(':step_targettype', $data['step_targettype']);
        $statement->bindValue(':step_tooldirection', $data['step_tooldirection']);
        $statement->bindValue(':step_rpm', $data['step_rpm']);
        $statement->bindValue(':step_targettorque', $data['step_targettorque']);
        $statement->bindValue(':step_hightorque', $data['step_hightorque']);
        $statement->bindValue(':step_lowtorque', $data['step_lowtorque']);
        $statement->bindValue(':step_targetangle', $data['step_targetangle']);
        $statement->bindValue(':step_highangle', $data['step_highangle']);
        $statement->bindValue(':step_lowangle', $data['step_lowangle']);
        $statement->bindValue(':step_delayttime', $data['step_delayttime']);
        $statement->bindValue(':threshold_torque', $data['threshold_torque']);
        $statement->bindValue(':step_threshold_angle', $data['step_threshold_angle']);
        $statement->bindValue(':downshift_torque', $data['downshift_torque']);
        $statement->bindValue(':downshift_speed', $data['downshift_speed']);
        $statement->bindValue(':step_prr_rpm', $data['step_prr_rpm']);
        $statement->bindValue(':step_prr_angle', $data['step_prr_angle']);
        $statement->bindValue(':barcode', $data['barcode']);
        $statement->bindValue(':total_angle', $data['total_angle']);

        $results = $statement->execute();

        return 0;
    }

}

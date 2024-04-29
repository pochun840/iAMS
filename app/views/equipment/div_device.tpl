<!-- Device GTCS Ediet Setting -->
    <div id="Device_Edit_Setting" style="display: none">
        <div class="topnav">
            <label type="text" style="font-size: 20px; margin: 4px; padding-left: 2%">GTCS - picking connection setting</label>
            <button class="btn" id="back-btn" type="button" onclick="cancelSetting()">
                <img id="img-back" src="./img/back.svg" alt="">back
            </button>
        </div>

        <div class="main-content">
            <div class="center-content">
                <div id="container">
                    <div class="wrapper" style=" top: 0">
                        <div class="navbutton active" onclick="handleButtonClick(this, 'connection')">
                            <span data-content="Connect setting" onclick="showContent('connection')"></span>Connect setting
                        </div>
                        <div class="navbutton" onclick="handleButtonClick(this, 'controller')">
                            <span data-content="Controller setting" onclick="showContent('controller')"></span>Controller setting
                        </div>
                        <div class="navbutton" onclick="handleButtonClick(this, 'information')">
                            <span data-content="Infomation" onclick="showContent('information')"></span>Infomation
                        </div>
                    </div>

                    <div id="connectionContent" class="content ">
                        <div style="padding-left: 7%; padding: 50px">
                            <div class="row t1">
                                <div class="col-1 t3">Name :</div>
                                <div class="col-2 t2">
                                    <input type="text" id="connect-name" class="t5 form-control input-ms" value="" maxlength="">
                                </div>
                            </div>

                            <div style="padding: 5px">
                                <label style="font-size: 18px">
                                    <img style="height: 25px; width: 25px" class="images" src="./img/connection-control.svg" alt="">&nbsp;
                                    <b>Connection control</b>
                                </label>
                            </div>
                            <div class="row t3">
                                <div class="col-2 t4 form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="connection-control" id="Device-RS232" value="1" style="zoom:1.2; vertical-align: middle">&nbsp;
                                    <label class="form-check-label" for="Device-RS232">Modbus RTU/RS232</label>
                                </div>
                            </div>

                            <div class="row t3">
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">com 3</option>
                                        <option value="2">com 5</option>
                                    </select>
                                </div>
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">115200</option>
                                        <option value="2">57600</option>
                                        <option value="3">38400</option>
                                        <option value="4">9600</option>
                                        <option value="5">4800</option>
                                        <option value="6">2400</option>
                                        <option value="7">1200</option>
                                    </select>
                                </div>
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">None</option>
                                        <option value="2">Odd</option>
                                        <option value="2">Even</option>
                                        <option value="2">Mark</option>
                                        <option value="2">Space</option>
                                    </select>
                                </div>
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">8</option>
                                        <option value="2">7</option>
                                        <option value="3">6</option>
                                        <option value="4">5</option>
                                        <option value="5">4</option>
                                        <option value="6">3</option>
                                        <option value="7">2</option>
                                        <option value="8">1</option>
                                    </select>
                                </div>
                                <div class="col-1 t3">
                                    <select id="unit" style="width: 110px">
                                        <option value="1">10</option>
                                        <option value="2">4</option>
                                        <option value="3">1</option>
                                        <option value="4">3</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row t3">
                                <div class="col-3 t4 form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="connection-control" id="Device-TCP-IP" value="1" onclick="EquipmentCheckbox('gtcs')" style="zoom:1.2; vertical-align: middle">&nbsp;
                                    <label class="form-check-label" for="Device-TCP-IP">TCP/IP</label>
                                </div>
                            </div>

                            <div class="row t3">
                                <div class="col-1 t3">
                                    <input type="text" class="t5 form-control input-ms" id="Network-IP" value="" maxlength="" style="opacity: 0.4">
                                </div>
                                <div class="col-2 t3">
                                    <input type="text" class="t5 form-control input-ms" id="Network-IP" value="192.168.0.184" maxlength="" required>
                                </div>
                                <div class="col-2 t3">
                                    <input type="text" class="t5 form-control input-ms" id="Network-IP" value="192.168.0.184" maxlength="" style="opacity: 0.4">
                                </div>
                                <div class="col-2 t3">
                                    <input type="text" class="t5 form-control input-ms" id="Network-IP" value="192.168.0.184" maxlength="" style="opacity: 0.4">
                                </div>
                                <div class="col-1 t3">
                                    <input type="text" class="t5 form-control input-ms" id="Communication-Port" value="502" maxlength="" required >
                                </div>
                            </div>

                            <hr style="color: #000;border: 0.5px solid #000;">

                            <div>
                                <label style="font-size: 18px">
                                    <img style="height: 25px; width: 25px" class="images" src="./img/test-adjust.png" alt="">&nbsp;
                                    <b>Test adjust</b>
                                </label>
                            </div>
                            <div class="row t4">
                                <div class="col-3 t3">Status:
                                    <label style="color: red; padding-left: 5%"> offline/online</label>
                                </div>
                                <div class="col">
                                    <button type="button" class="btn btn-Reconnect">Reconnect</button>
                                </div>
                            </div>
                            <div class="row t4">
                                <div class="col t3"><b>Communication log</b></div>
                            </div>
                            <div class="scrollbar-Communicationlog" id="style-Communicationlog">
                                <div class="force-overflow-Communicationlog">
                                    <div class="row t4">
                                        <div class="col t3">2024/02/26 14:00 P.M equipment connect successfully</div>
                                    </div>
                                    <div class="row t4">
                                        <div class="col t3">2024/02/26 2:15 P.M equipment connect failed</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="controllerContent" class="content"  style="display: none;">
                        <div style="padding-left: 7%; padding: 60px">
                            <div class="col t1" style="padding: 10px"><b>Contrller Setting</b></div>
                            <div class="row t1">
                                <div class="col-2 t1" >ID :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="controller-id" class="t2 form-control input-ms" value="1" maxlength="">
                                </div>

                                <div class="col-3 t1" style="padding-left: 10%;">Diskfull Warning(&#37;) :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="diskfull-warning" class="t2 form-control input-ms" value="80" maxlength="">
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Name :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="controller-name" class="t2 form-control input-ms" value="GTCS" maxlength="">
                                </div>

                                <div class="col-3 t1" style="padding-left: 10%;">Disk Storage Space :</div>
                                <div class="col progress t2" style="margin-top: 10px;padding-left:0;margin-right: 10px">
                                    <div id="disk_usage" class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="width: 25%">X%</div>
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Unit :</div>
                                <div class="col-3 t2">
                                    <select id="Torque-Unit" class="t2 Select-All" style="height: 35px; border: 1px solid  #BBBBBB; border-radius: 3px">
                                        <option value="2">N.m</option>
                                        <option value="1">Kgf.m</option>
                                        <option value="2">Kgf.cm</option>
                                        <option value="2">In.lbs</option>
                                    </select>
                                </div>

                                <div class="col-3 t1" style="padding-left: 10%">Export data :</div>
                                <div class="col t2">
                                    <button class="export-impost-data w3-button w3-border w3-round-large" style="float: right">Copy data</button>
                                    <button class="export-impost-data w3-button w3-border w3-round-large" style="float: right">Export</button>
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Language :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="language" class="t2 form-control input-ms" value="English" maxlength="" disabled="disabled">
                                </div>

                                <div class="col-3 t1" style="padding-left: 10%">Import data :</div>
                                <div class="col-3 t2">
                                    <input type="file" id="export-data-uploader" data-target="import-file-uploader" accept=".cfg" style="display: inline-block;" class="t2 form-control">
                                </div>
                                <div class="col t2">
                                    <button class="expost-impost-data w3-button w3-border w3-round-large" style="float: right">Import</button>
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Torque Filter :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="torque-filter" class="t2 form-control input-ms" value="0.0" maxlength="">
                                </div>

                                <div class="col-3 t1" style="padding-left: 10%">Firmware update :</div>
                                <div class="col-3 t2">
                                    <input type="file" id="firmware-uploader" data-target="import-file-uploader" accept=".cfg" style="display: inline-block;" class="t2 form-control">
                                </div>
                                <div class="col t2">
                                    <button class="expost-impost-data w3-button w3-border w3-round-large" style="float: right">Firmware Update</button>
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Batch Mode :</div>
                                <div class="switch menu col-3 t2">
                                    <input id="Batch-Mode" type="checkbox" checked>
                                    <label><i></i></label>
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Blackout Recovery :</div>
                                <div class="switch menu col-3 t2">
                                    <input id="Blackout-Recovery" type="checkbox" checked>
                                    <label><i></i></label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="informationContent" class="content"  style="display: none;">
                        <div style="padding-left: 5%; padding: 60px">
                            <div class="row t1">
                                <div class="col-5 t1" style="padding: 10px;"><b>Tool Information</b></div>
                                <div class="col t1" style="padding: 10px; padding-left: 5%"><b>Controller Information</b></div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1" >Tool Type :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="tool-type" class="form-control input-ms" value="SGT-CS" maxlength="" disabled="disabled">
                                </div>

                                <div class="col-3 t1" style="padding-left: 12%">Controller S/N :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="controller-sn" class="form-control input-ms" value="" maxlength="" disabled="disabled">
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Tool SN :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="tool-sn" class="form-control input-ms" value="PTS" maxlength="" disabled="disabled">
                                </div>

                                <div class="col-3 t1" style="padding-left: 12%">Controller Ver :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="controller-version" class="form-control input-ms" value="1.25-J7" maxlength="" disabled="disabled">
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">S/W Version :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="sw-version" class="form-control input-ms" value="1.09" maxlength="" disabled="disabled">
                                </div>

                               <div class="col-3 t1" style="padding-left: 12%">MCB Version :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="MCB-version" class="form-control input-ms" value="V02.91_T1_Svn369" maxlength="" disabled="disabled">
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Total Counts :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="total-counts" class="form-control input-ms" value="" maxlength="" disabled="disabled">
                                </div>

                                <div class="col-3 t1" style="padding-left: 12%">Image Version :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="image-version" class="form-control input-ms" value="V2.00" maxlength="" disabled="disabled">
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Max Torque :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="max-torque" class="form-control input-ms" value="3.0" maxlength="" disabled="disabled">
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Max Speed :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="max-speed" class="form-control input-ms" value="980" maxlength="" disabled="disabled">
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Calibration Value :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="calibration-value" class="form-control input-ms" value="1.839" maxlength="" disabled="disabled">
                                </div>
                            </div>

                            <div class="row t1">
                                <div class="col-2 t1">Maintain Counts :</div>
                                <div class="col-3 t2">
                                    <input type="text" id="maintain-counts" class="form-control input-ms" value="2289" maxlength="" disabled="disabled">
                                </div>

                                <div class="col t2">
                                    <button class="expost-impost-data w3-button w3-border w3-round-large">Refresh</button>
                                </div>
                            </div>

                        </div>
                    </div>
                    <button class="saveButton" id="saveButton">Save</button>
                </div>
            </div>
        </div>
    </div>
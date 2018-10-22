<?php
 include '../conf/conf.php';
   
?>

	
		<h4>RL1.2 - Indikator Pelayanan Rumah Sakit</h4></div>
	<?php
	switch($_GET[act]){
	default:
    echo"
    <div class='row'>
<div class='col-lg-12'>
    <div class='box dark'>
        <header>
            <div class='icons'><i class='fa fa-edit'></i></div>
            <h5>Input Text Fields</h5>
            <!-- .toolbar -->
            <div class='toolbar'>
              <nav style='padding: 8px;'>
                  <a href='javascript:;' class='btn btn-default btn-xs collapse-box'>
                      <i class='fa fa-minus'></i>
                  </a>
                  <a href='javascript:;' class='btn btn-default btn-xs full-box'>
                      <i class='fa fa-expand'></i>
                  </a>
                  <a href='javascript:;' class='btn btn-danger btn-xs close-box'>
                      <i class='fa fa-times'></i>
                  </a>
              </nav>
            </div>            <!-- /.toolbar -->
        </header>
        <div id='div-1' class='body'>
         <form action='?module=1.2&act=tampil' method='post' class='form-horizontal'>
        

                <div class='form-group'>
                    <label for='text1' class='control-label col-lg-4'>Bulan</label>

                    <div class='col-lg-8'>
                       <select name='bulan' class='form-control chzn-select'>
	<option value='1'>Januari</option>
	<option value='2'>Februari</option>
	<option value='3'>Maret</option>
	<option value='4'>April</option>
	<option value='5'>Mei</option>
	<option value='6'>Juni</option>
	<option value='7'>Juli</option>
	<option value='8'>Agustus</option>
	<option value='9'>September</option>
	<option value='10'>Oktober</option>
	<option value='11'>November</option>
	<option value='12'>Desember</option>
	</select>
                    </div>
                </div>
                <!-- /.form-group -->
<div class='form-group'>
                    <label for='text1' class='control-label col-lg-4'>Tahun</label>

                    <div class='col-lg-8'>
                      
                       <select name='tahun' class='form-control chzn-select'>
	<option value='2015'>2015</option>
	<option value='2016'>2016</option>
	<option value='2017'>2017</option>
	<option value='2018'>2018</option>	
	</select>
                    </div>
                </div>
                <!-- /.form-group -->
                <div class='form-group'>
                    <label for='text1' class='control-label col-lg-4'>BOR</label>

                    <div class='col-lg-8'>
                     <input type='text' name='bor' class='form-control'/>
                    </div>
                </div>
             
                <!-- /.form-group -->
                <div class='form-group'>
                    <label for='text1' class='control-label col-lg-4'>ALOS</label>

                    <div class='col-lg-8'>
                     <input type='text' name='los' class='form-control'/>
                    </div>
                </div>
                 <!-- /.form-group -->
                <div class='form-group'>
                    <label for='text1' class='control-label col-lg-4'>BTO</label>

                    <div class='col-lg-8'>
                     <input type='text' name='bto' class='form-control'/>
                    </div>
                </div>
               
                <!-- /.form-group -->
                <div class='form-group'>
                    <label for='text1' class='control-label col-lg-4'>TOI</label>

                    <div class='col-lg-8'>
                     <input type='text' name='toi' class='form-control'/>
                    </div>
                </div>
                 <!-- /.form-group -->
                <div class='form-group'>
                    <label for='text1' class='control-label col-lg-4'>NDR</label>

                    <div class='col-lg-8'>
                     <input type='text' name='ndr' class='form-control'/>
                    </div>
                </div>
                 <!-- /.form-group -->
                <div class='form-group'>
                    <label for='text1' class='control-label col-lg-4'>GDR</label>

                    <div class='col-lg-8'>
                     <input type='text' name='gdr' class='form-control'/>
                    </div>
                </div>
                 <!-- /.form-group -->
                <div class='form-group'>
                    <label for='text1' class='control-label col-lg-4'>Kunjungan Per Hari</label>

                    <div class='col-lg-8'>
                     <input type='text' name='kunjunganperhari' class='form-control'/>
                    </div>
                </div>
                <!-- /.form-group -->
<input type='submit' value='Kirm' class='btn btn-success'>
            </form>
        </div>
    </div>
</div>
</div>



	";
	break;
	
	case "tampil":
		$ppkkode="SELECT * FROM setting";
		$ppk_kode=bukaquery($ppkkode);
		$tahun      = $_POST['tahun'];
		$bulan      = $_POST['bulan'];  
		$bor      = $_POST['bor'];  
		$los      = $_POST['los'];  
		$bto      = $_POST['bto']; 
		$toi      = $_POST['toi'];  
		$ndr      = $_POST['ndr']; 
		$gdr      = $_POST['gdr']; 
		$kunjunganperhari      = $_POST['kunjunganperhari']; 

		 while($ppk = mysql_fetch_array($ppk_kode)) { 
			$k_ppk=$ppk['kode_ppk'];
			$n_ppk=$ppk['nama_ppk'];
		 }
	$datatime=date("Y-m-d H:i:s");
		echo"
		<input type='button' value='Back' onclick=self.history.go(-1)>";
$myvars="";
				$post[] = array(
	
					'koders'=>$k_ppk,
  					'tahun'=>$tahun,
  					'bulan'=>$bulan,
  					'bor'=>$bor,
  					'los'=>$los,
  					'bto'=>$bto,
  					'toi'=>$toi,
  					'ndr'=>$ndr,
  					'gdr'=>$gdr,
  					'kunjunganperhari'=>$kunjunganperhari
					);
				$myvars=json_encode($post);
		//echo $myvars;
$url= "http://eis.dinkes.jakarta.go.id/api/curl/ws-rl12.php";
require_once('../conf/curl-send.php');	
break;
}
  	?>

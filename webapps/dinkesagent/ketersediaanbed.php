
<?php
/*] CREATE BY   	: DIDIK ANANG NUGROHO
[*] DATE(DMY)   	: 23-05-2017 19:24:02
[*] COMPANY     	: RUMAH SAKIT UMUM DAERAH KOJA
[*] CITY        	: NORTH JAKARTA, INDONESIA
[*/
 require_once('../conf/conf.php');
/*
$query ="
				select 
						KodeRS as koders,
						Tanggal as tanggal,
						NamaInstalasi as namainstalasi,
						NamaRuangan as namaruangan,
						'' as kelas,
						JumlahPasien as jumlahpasien,
						UpdateDate as updatedate
				from  dbo.[dinkes_kunjunganpasienruangan_dayly]
			";

$data = array();
$zz = sqlsrv_query($conn, $query); 
while ($allRow = sqlsrv_fetch_array($zz, SQLSRV_FETCH_ASSOC)){ 
            $datas[] = $allRow;

        }

$host = "localhost";
$user = "root";
$pass = ""; 
$db = "db_rsukramatjati_devlp"; 
$koneksi = mysql_connect($host, $user, $pass); 
	if (!$koneksi){
	echo "Couldn't connect to host $host because <b> ".mysql_error()."</b>";
	}else{
	$select_db = mysql_select_db($db);
		if (!$select_db){
			echo "Couldn't select database $db because <b>".mysql_error()."</b>";
		}
	}
	*/
$query="select * from bangsal where publish='1' ";
$result = bukaquery($query);
$num_rows = mysql_num_rows($result);
$jumlah_kosong=0;
$jumlah_isi=0;
while($data1 = mysql_fetch_array($result)) {
$kd_bangsal=$data1['kd_bangsal'];
$query1="select * from kamar Where kd_bangsal='$kd_bangsal' and status='ISI'";
$result1 = bukaquery($query1);
$isi = mysql_num_rows($result1);
	$query2="select * from kamar Where kd_bangsal='$kd_bangsal' and status='KOSONG'";
$result2 = bukaquery($query2);
$kosong = mysql_num_rows($result2);
	$query3="select * from kamar Where kd_bangsal='$kd_bangsal'";
$result3 = bukaquery($query3);
$total = mysql_num_rows($result3);
$datatime=date("Y-m-d H:i:s");
$datas[] = array(

	
		'koders'=>'0113R072',
		'koderuangan'=>$kd_bangsal,
		'jumlahisi'=>$isi,
		'jumlahkosong'=>$kosong,
		'jumlahtotal'=>$total,
		'updatetime'=>$datatime,
		

	);
$jumlah_kosong=$jumlah_kosong+$kosong;
		$jumlah_isi=$jumlah_isi+$isi;
}
/*echo "Service Informasi Kunjungan Pasien Berdasarkan Ruangan";
echo '<br>';
echo '<br>';*/
$datatime=date("Y-m-d H:i:s");
$datas[] = array(

	
		'koders'=>'0113R072',
		'koderuangan'=>'KL3',
		'jumlahisi'=>$jumlah_isi,
		'jumlahkosong'=>$jumlah_kosong,
		'jumlahtotal'=>$jumlah_isi+$jumlah_kosong,
		'updatetime'=>$datatime,
		

	);
//echo json_encode($datas);
echo "Kamar Berhasil Disimpan";
$myvars=json_encode($datas);
 
?>
<input id = 'content' type='hidden' name='content' value='<?php echo $myvars; ?>'>
<div id="result"></div>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	    $.ajax({
	        url: "http://202.147.199.11/wsdashboarddinkes/wsketersediaanbed.php",
	        type: "POST",
	        data: {
				content: $("#content").val()
			},
	        dataType: "JSON",
	        success: function (jsonStr) {
	            $("#result").text(JSON.stringify(jsonStr));
	        }
	    });
	});
	
</script>

	
<!-- <button id="submit" name="submit" type="submit">Send</buttton> -->
	
	
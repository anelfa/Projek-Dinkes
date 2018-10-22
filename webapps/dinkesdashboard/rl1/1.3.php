<?php
 include '../conf/conf.php';
   /* header("Content-type: application/x-msdownload");
    header("Content-Disposition: attachment; filename=LaporanRekapKunjuangnJenisBayar.xls");
    header("Pragma: no-cache");
    header("Expires: 0");
    print "$header\n$data";*/
?>
<html>
    <body>
	<div class="panel-heading">
		<h4>RL 1.3 - Fasilitas Tempat Tidur Rawat Inap</h4></div>
			<div class="panel-body">
    <?php     		
		date_default_timezone_set("Asia/Jakarta");
		$datatime=date("Y-m-d H:i:s");
		$date1      = $_POST['tanggal1']; 
        $date2      = $_POST['tanggal2'];
		$date=$_POST['tanggal'];
		$tanggal1=date("y-m-d",strtotime($date1));
		$tanggal2=date("y-m-d",strtotime($date2));
		//tampilkan dalam tabel
		echo"
		<table class='table table-bordered table-hover table-striped'' data-toggle='table'>
		<tr>
		<thead>
		<td>Kode</td>
		<td>Nama Ruang Rawat</td>
		<td>Jenis Ruang Rawat</td>
		<td>Jumlah Tempat Tidur</td>";
        $_sql = "SELECT setting.kode_ppk, bangsal.nm_bangsal, aplicare_ketersediaan_kamar.kode_kelas_aplicare, Count(kamar.kd_kamar) AS jumlah
				 FROM kamar , bangsal , setting , aplicare_ketersediaan_kamar
				 WHERE kamar.kd_bangsal = bangsal.kd_bangsal AND kamar.kd_bangsal = aplicare_ketersediaan_kamar.kd_bangsal 
				 GROUP BY kamar.kd_bangsal ORDER BY bangsal.nm_bangsal ASC";            
        $hasil=bukaquery($_sql);
                 while($baris = mysql_fetch_array($hasil)) { 
				 $ppk=$baris['kode_ppk'];
				 $ruang=$baris['nm_bangsal'];
				 $jenis=$baris['kode_kelas_aplicare'];
				 $jml=$baris['jumlah'];
				//simpan data untuk kirim ke dinkes
				$myvars="";
				$post[] = array(
	
					'koders'=>$baris['kode_ppk'],
					'namaruangrawat'=>$baris['nm_bangsal'],
					'jenisruangrawat'=>'KL3',
					'jumlahtt'=>$baris['jumlah'],
					);
		echo"
		</tr>
		</thead>
		<td>$ppk</td>
		<td>$ruang</td>
		<td>$jenis</td>
		<td>$jml</td>
		</tr>";
                }  
		echo"
		</table>";
		//keep data dengan JSON
		$myvars=json_encode($post);
		$url = 'http://eis.dinkes.jakarta.go.id/api/curl/ws-rl13.php';

include "../curl-send.php";
?>

	
	
<!-- <button id="submit" name="submit" type="submit">Send</buttton> -->


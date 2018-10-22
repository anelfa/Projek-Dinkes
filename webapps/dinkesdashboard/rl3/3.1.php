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
		<h4>Laporan RL 3.1 & RL 5.2</h4></div>
			<div class="panel-body">
    <?php
	switch($_GET[act]){
	default:
    echo"<form action='?module=3.1&act=tampil' method='post'>
	<table>
	<tr>
	<td>Periode</td><td>:</td><td><input type='text' id='calender1' name='tanggal1' >-S/D-<input type='text' id='calender' name='tanggal2' ></td>
	<td align='right'><input type='submit' value='tampilkan' ></td>
	</tr>
	</table>
	</form>";
	break;
	
	case "tampil":
    reportsqlinjection();      
       date_default_timezone_set("Asia/Jakarta");
		$datatime=date("Y-m-d H:i:s");
		$date1      = $_POST['tanggal1']; 
        $date2      = $_POST['tanggal2'];
		$tanggal1=date("Y-m-d",strtotime($date1));
		$tanggal2=date("Y-m-d",strtotime($date2));
		$datatime=date("Y-m-d H:i:s");
        
		//echo $n_ppk;
		$_instalasi = Array('Instalasi Rawat Jalan','Instalasi Rawat Inap');
        $myvars="";
		echo"
		<input type='button' value='Back' onclick=self.history.go(-1)>
		<h3>Periode: $tanggal1 - $tanggal2</h3>
		<table class='table table-bordered table-hover table-striped' data-toggle='table'>
		<thead>
		<tr>
		<td>Kode</td>
		<td>Tanggal</td>
		<td>Nama Instalasi</td>
		<td>Nama Ruangan</td>
		<td>Kelas</td>
		<td>Jumlah Pasien</td>";
		
    foreach($_instalasi as $instansi) {
		if('Instalasi Rawat Jalan'==$instansi)
		{
			
		$_sql = "SELECT setting.kode_ppk, poliklinik.nm_poli, Count(poliklinik.kd_poli) AS jumlah_pasien
				 FROM reg_periksa , poliklinik , setting
				 WHERE reg_periksa.kd_poli = poliklinik.kd_poli AND reg_periksa.kd_poli != 'IGD' AND reg_periksa.tgl_registrasi BETWEEN '$tanggal1' AND '$tanggal2'
				 GROUP BY poliklinik.nm_poli";            
        $hasil=bukaquery($_sql);
                 while($baris = mysql_fetch_array($hasil)) { 
				//simpan data untuk kirim ke dinkes
				$myvars="";
				$post[] = array(
	
					'koders'=>$baris['kode_ppk'],
					'tanggal'=>$tanggal2,
					'namainstalasi'=>'Instalasi Rawat Jalan',
					'namaruangan'=>$baris['nm_poli'],
					'kelas'=>'',
					'jumlahpasien'=>$baris['jumlah_pasien'],
					'updatedate'=>$datatime,
					);
		echo"
		</tr>
		</thead>
		<td>$baris[kode_ppk]</td>
		<td>$tanggal2</td>
		<td>Instalasi Rawat Jalan</td>
		<td>$baris[nm_poli]</td>
		<td>-</td>
		<td>$baris[jumlah_pasien]</td>
		</tr>";
        } 
		}
		else if('Instalasi Rawat Inap'==$instansi)
		{
		
		$_sql = "SELECT setting.kode_ppk, bangsal.nm_bangsal, kamar.kelas,Count(poliklinik.kd_poli) AS jumlah_pasien
				 FROM reg_periksa , poliklinik , setting, kamar_inap, kamar, bangsal
				 WHERE reg_periksa.kd_poli = poliklinik.kd_poli AND reg_periksa.no_rawat=kamar_inap.no_rawat AND kamar_inap.kd_kamar = kamar.kd_kamar AND kamar.kd_bangsal=bangsal.kd_bangsal
				 AND reg_periksa.status_lanjut='Ranap' AND reg_periksa.tgl_registrasi BETWEEN '$tanggal1' AND '$tanggal2'
				 GROUP BY bangsal.nm_bangsal";            
        $hasil=bukaquery($_sql);
                 while($baris = mysql_fetch_array($hasil)) { 
				//simpan data untuk kirim ke dinkes
				$myvars="";
				$post[] = array(
	
					'koders'=>$baris['kode_ppk'],
					'tanggal'=>$tanggal2,
					'namainstalasi'=>'Instalasi Rawat Inap',
					'namaruangan'=>$baris['nm_bangsal'],
					'kelas'=>$baris['kelas'],
					'jumlahpasien'=>$baris['jumlah_pasien'],
					'updatedate'=>$datatime,
					);
		echo"
		</tr>
		</thead>
		<td>$baris[kode_ppk]</td>
		<td>$tanggal2</td>
		<td>Instalasi Rawat Inap</td>
		<td>$baris[nm_bangsal]</td>
		<td>$baris[kelas]</td>
		<td>$baris[jumlah_pasien]</td>
		</tr>";
		}
		}		}			
        echo"
		</tr>";
                 
		echo"
		</table>";   
		$myvars=json_encode($post);
		?>
		<form action='?module=3.1&act=kirim' method='post'>
		<input type='hidden' value='<?php echo $myvars; ?>' name='kirim'>
		<button id="submit" name="submit" type="submit">Send</button>
		</form>
		<?php
		break ; 
 
 case "kirim":
		$myvars=$_POST['kirim'];
		// URL untuk mengirimkan data ke server dinas kesehatan
		$url = 'http://eis.dinkes.jakarta.go.id/api/curl/ws-kunjunganpasienruangan.php';
		require_once('curl-send.php');	
		echo "<script>alert('Data Insya Allah Sudah Di Kirim Juragan :)'); window.location = 'javascript:history.go(-1)'</script>";
 break;
		
}
?>
    <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br>
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
		<h4>Laporan RL 3.3</h4></div>
			<div class="panel-body">
    <?php
	switch($_GET[act]){
	default:
    echo"<form action='?module=3.3&act=tampil' method='post'>
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
		$datatime=date("$tanggal2 H:i:s");
		$waktu=date("H:i:s");
		echo"
		<input type='button' value='Back' onclick=self.history.go(-1)>
		<h3>Periode: $tanggal1 - $tanggal2</h3>
		<table class='table table-bordered table-hover table-striped' data-toggle='table'>
		<thead>
		<tr>
		<td>Kode</td>
		<td>Tanggal</td>
		<td>Jenis Kegiatan</td>
		<td>Jumlah Pasien</td>";
		$poli = getOne("SELECT poliklinik.kd_poli FROM poliklinik
				WHERE poliklinik.nm_poli LIKE '%gigi%'");

        $_sql = "select jns_perawatan.nm_perawatan,count(jns_perawatan.nm_perawatan) as jumlah,setting.kode_ppk
				 from rawat_jl_dr, reg_periksa,jns_perawatan, setting
				 where rawat_jl_dr.no_rawat=reg_periksa.no_rawat and rawat_jl_dr.kd_jenis_prw=jns_perawatan.kd_jenis_prw AND
				 reg_periksa.kd_poli= '$poli' AND reg_periksa.tgl_registrasi between '$tanggal1' and '$tanggal2' 
				 group by jns_perawatan.nm_perawatan ";            
        $hasil=bukaquery($_sql);
                 while($baris = mysql_fetch_array($hasil)) { 
				//simpan data untuk kirim ke dinkes
				$myvars="";
				$post[] = array(
	
					'koders'=>$baris['kode_ppk'],
					'tanggal'=>$tanggal2,
					'jeniskegiatan'=>$baris['nm_perawatan'],
					'jumlahpasien'=>$baris['jumlah'],
					);
	    echo"
		</tr>
		</thead>
		<tr>
		<td>$baris[kode_ppk]</td>
		<td>$tanggal2</td>
		<td>$baris[nm_perawatan]</td>
		<td>$baris[jumlah]</td>
		</tr>";
                }  
		echo"
		</table>";
		//keep data dengan JSON
		$myvars=json_encode($post);
		?>
		<form action='?module=3.3&act=kirim' method='post'>
		<input type='hidden' value='<?php echo $myvars; ?>' name='kirim'>
		<button id="submit" name="submit" type="submit">Send</button>
		</form><br><br><br>
		<?php
		break ; 
 
 case "kirim":
		$myvars=$_POST['kirim'];
		// URL untuk mengirimkan data ke server dinas kesehatan
		$url = "http://eis.dinkes.jakarta.go.id/api/curl/ws-rl33.php";
		require_once('../conf/curl-send.php');	
		echo "<script>alert('Data Insya Allah Sudah Di Kirim Juragan :)'); window.location = 'javascript:history.go(-1)'</script>";
 break;
}
?>
    </body>
</html>

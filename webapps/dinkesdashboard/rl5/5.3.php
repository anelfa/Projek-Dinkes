<?php
 include '../conf/conf.php';
   /* header("Content-type: application/x-msdownload");
    header("Content-Disposition: attachment; filename=LaporanRekapKunjuangnJenisBayar.xls");
    header("Pragma: no-cache");
    header("Expires: 0");
    print "$header\n$data";*/
?>

     <div class="panel-heading">
		<h4>RL 5.3 & RL 5.4 - Daftar 10 Besar Penyakit Rawat jalan, Rawat Inap & IGD </h4></div>
			<div class="panel-body">
    <?php
	switch($_GET[act]){
	default:
    echo"<form action='?module=5.3&act=tampil' method='post'>
	<table>
	<tr>
	<td>Periode</td><td>:</td><td><input type='text' id='calender1' name='tanggal1' >-S/D-<input type='text' id='calender' name='tanggal2' ></td>
	<td align='right'><input type='submit' value='Tampilkan' class='btn btn-success'></td>
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

      
		//query poliklinik
		$_poli="SELECT * FROM poliklinik";
		$poli=bukaquery($_poli);
		
		
		//query setting
		$ppkkode="SELECT * FROM setting";
		$ppk_kode=bukaquery($ppkkode);
		
		 while($ppk = mysql_fetch_array($ppk_kode)) { 
			$k_ppk=$ppk['kode_ppk'];
			$n_ppk=$ppk['nama_ppk'];
		 }
        
		//echo $n_ppk;
		$_stts_daftar = Array('Ralan','Ranap');
		$_instalasi = Array('Instalasi Rawat Jalan','Instalasi Gawat Darurat','Instalasi Rawat Inap');
        $myvars="";
		echo"
		<input type='button' value='Back' class='btn btn-danger' onclick=self.history.go(-1)>
		<h3>Periode: $tanggal1 - $tanggal2</h3>
		<table class='table table-bordered table-hover table-striped' data-toggle='table'>
		<thead>
		<tr>
		<td>Kode</td>
		<td>Tanggal</td>
		<td>Nama Instalasi</td>
		<td>Kode Penyakit</td>
		<td>Nama Penyakit</td>
		<td>Jumlah Pasien</td>
		";
		
    foreach($_instalasi as $instansi) {
		
		
		if('Instalasi Gawat Darurat'==$instansi)
		{
		$no=1;	foreach($_stts_daftar as $status_pasien)
		{
			$_sql = "SELECT diagnosa_pasien.kd_penyakit,penyakit.nm_penyakit, Count(diagnosa_pasien.kd_penyakit) AS jumlah_pasien
				 FROM diagnosa_pasien ,penyakit ,reg_periksa WHERE diagnosa_pasien.kd_penyakit = penyakit.kd_penyakit AND diagnosa_pasien.no_rawat = reg_periksa.no_rawat AND reg_periksa.kd_poli = 'IGD' AND 
				 diagnosa_pasien.status = 'Ralan' AND reg_periksa.tgl_registrasi BETWEEN '$tanggal1' AND '$tanggal2'
				 GROUP BY diagnosa_pasien.kd_penyakit Order By Count(diagnosa_pasien.kd_penyakit) Desc limit 10" ;
		$hasil=bukaquery($_sql);
        while($baris = mysql_fetch_array($hasil)) {
				$kode_penyakit=$baris['kd_penyakit'];
				$nama_penyakit=$baris['nm_penyakit'];
				$jml_pasien=$baris['jumlah_pasien'];
		
		
		$post[] = array(
	
					'koders'=>$k_ppk,
					'tanggal'=>$tanggal2,
					'namainstalasi'=>$instansi,
					'kodediagnosa'=>$kode_penyakit,
					'namadiagnosa'=>$nama_penyakit,
					'jumlahpasien'=>$jml_pasien,
					'updatedate'=>$datatime,
		);
		echo"
		</tr>
		</thead>
		<td>$k_ppk</td>
		<td>$tanggal2</td>";

		echo"<td>$instansi</td>
			 <td>$no</td>
			 <td>$kode_penyakit</td>
			 <td>$nama_penyakit</td>
			 <td>$jml_pasien</td>";
			 echo"
		</tr>";
		$no++;
		}
		}}
		else if('Instalasi Rawat Jalan'==$instansi)
		{
		$no=1;	foreach($_stts_daftar as $status_pasien)
		{
			$_sql = "SELECT diagnosa_pasien.kd_penyakit,penyakit.nm_penyakit, Count(diagnosa_pasien.kd_penyakit) AS jumlah_pasien
				 FROM diagnosa_pasien ,penyakit ,reg_periksa WHERE diagnosa_pasien.kd_penyakit = penyakit.kd_penyakit AND 
				 diagnosa_pasien.no_rawat = reg_periksa.no_rawat AND reg_periksa.kd_poli != 'IGD' AND
				 diagnosa_pasien.status = 'Ralan' AND reg_periksa.tgl_registrasi BETWEEN '$tanggal1' AND '$tanggal2' 
				 GROUP BY diagnosa_pasien.kd_penyakit Order By Count(diagnosa_pasien.kd_penyakit) Desc limit 10";
		$hasil=bukaquery($_sql);
		while($baris = mysql_fetch_array($hasil)) {
				$kode_penyakit=$baris['kd_penyakit'];
				$nama_penyakit=$baris['nm_penyakit'];
				$jml_pasien=$baris['jumlah_pasien'];
		
		
			$post[] = array(
	
					'koders'=>$k_ppk,
					'tanggal'=>$tanggal2,
					'namainstalasi'=>$instansi,
					'kodediagnosa'=>$kode_penyakit,
					'namadiagnosa'=>$nama_penyakit,
					'jumlahpasien'=>$jml_pasien,
					'updatedate'=>$datatime,
				);
			echo"
		</tr>
		</thead>
		<td>$k_ppk</td>
		<td>$tanggal2</td>";
		echo"<td>$instansi</td>
		<td>$no</td>
			 <td>$kode_penyakit</td>
			 <td>$nama_penyakit</td>
			 <td>$jml_pasien</td>";
			 echo"
		</tr>";
		$no++;
		}
		}}
		else
		{
		$no=1;	foreach($_stts_daftar as $status_pasien)
		{
			$_sql = "SELECT diagnosa_pasien.kd_penyakit,penyakit.nm_penyakit, Count(diagnosa_pasien.kd_penyakit) AS jumlah_pasien
				 FROM diagnosa_pasien ,penyakit ,reg_periksa WHERE diagnosa_pasien.kd_penyakit = penyakit.kd_penyakit AND 
				 diagnosa_pasien.no_rawat = reg_periksa.no_rawat AND diagnosa_pasien.status = 'Ranap' AND 
				 reg_periksa.tgl_registrasi BETWEEN '$tanggal1' AND '$tanggal2' 
				 GROUP BY diagnosa_pasien.kd_penyakit Order By Count(diagnosa_pasien.kd_penyakit) Desc limit 10";
		$hasil=bukaquery($_sql);
		while($baris = mysql_fetch_array($hasil)) {
				$kode_penyakit=$baris['kd_penyakit'];
				$nama_penyakit=$baris['nm_penyakit'];
				$jml_pasien=$baris['jumlah_pasien'];
		
			$post[] = array(
	
					'koders'=>$k_ppk,
					'tanggal'=>$tanggal2,
					'namainstalasi'=>$instansi,
					'kodediagnosa'=>$kode_penyakit,
					'namadiagnosa'=>$nama_penyakit,
					'jumlahpasien'=>$jml_pasien,
					'updatedate'=>$datatime,
				);
			echo"
		</tr>
		</thead>
		<td>$k_ppk</td>
		<td>$tanggal2</td>";
		echo"<td>$instansi</td>
		<td>$no</td>
			 <td>$kode_penyakit</td>
			 <td>$nama_penyakit</td>
			 <td>$jml_pasien</td>";
			 echo"
		</tr>";
		$no++;
		}
		}}
				
        
                } 
		echo"
		</table>";   
		
		$myvars=json_encode($post);
		
		


?>
<form action='?module=5.3&act=kirim' method='post'>
		<input type='hidden' value='<?php echo $myvars; ?>' name='kirim'>
		<button id="submit" name="submit" class="btn btn-primary" type="submit">Send</button>
		</form>
		<?php break ; 
		case "kirim":
		$myvars=$_POST['kirim'];
		// URL untuk mengirimkan data ke server dinas kesehatan
		$url = "http://eis.dinkes.jakarta.go.id/api/curl/ws-kunjunganpasiendiagnosa.php";
		require_once('../conf/curl-send.php');	
		echo "<script>alert('Data Insya Allah Sudah Di Kirim'); window.location = 'javascript:history.go(-1)'</script>";
 break; 
}
?>	
   <br><br><br>
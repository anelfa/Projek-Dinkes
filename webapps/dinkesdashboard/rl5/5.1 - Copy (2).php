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
		<h4>RL 5.1 - Pengunjung Rumah Sakit</h4></div>
			<div class="panel-body">
    <?php
	switch($_GET[act]){
	default:
    echo"<form action='?module=5.1&act=tampil' method='post'>
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
		
		
		//query seting
		$ppkkode="SELECT * FROM setting";
		$ppk_kode=bukaquery($ppkkode);
		
		 while($ppk = mysql_fetch_array($ppk_kode)) { 
			$k_ppk=$ppk['kode_ppk'];
			$n_ppk=$ppk['nama_ppk'];
		 }
        
		//echo $n_ppk;
		$_stts_daftar = Array('Baru','Lama');
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
		<td>Status Pasien</td>
		<td>Jumlah Pasien</td>
		<td>Nama Instalasi</td>
		<td>Status Pasien</td>
		<td>Jumlah Pasien</td>";
		
    foreach($_instalasi as $instansi) {
		echo"
		</tr>
		</thead>
		<td>$k_ppk</td>
		<td>$tanggal2</td>";
		
		if('Instalasi Gawat Darurat'==$instansi)
		{
			foreach($_stts_daftar as $status_pasien)
		{
			switch($status_pasien){
				case "Baru":
				$jml_pasien="352";
				break;
				case "Lama":
				$jml_pasien="391";
				break;

			}
		
		$post[] = array(
	
					'koders'=>$k_ppk,
					'tanggal'=>$tanggal2,
					'namainstalasi'=>$instansi,
					'statusdaftar'=>$status_pasien,
					'jumlahpasien'=>$jml_pasien,
					'updatedate'=>$datatime,
				);
		echo"<td>$instansi</td>
			 <td>$status_pasien</td>
			 <td>$jml_pasien</td>";
		}}
		else if('Instalasi Rawat Jalan'==$instansi)
		{
			foreach($_stts_daftar as $status_pasien)
		{
			switch($status_pasien){
				case "Baru":
				$jml_pasien="887";
				break;
				case "Lama":
				$jml_pasien="1179";
				break;

			}
			$post[] = array(
	
					'koders'=>$k_ppk,
					'tanggal'=>$tanggal2,
					'namainstalasi'=>$instansi,
					'statusdaftar'=>$status_pasien,
					'jumlahpasien'=>$jml_pasien,
					'updatedate'=>$datatime,
				);
		echo"<td>$instansi</td>
			 <td>$status_pasien</td>
			 <td>$jml_pasien</td>";
		}}
		else
		{
			foreach($_stts_daftar as $status_pasien)
		{
		switch($status_pasien){
				case "Baru":
				$jml_pasien="20";
				break;
				case "Lama":
				$jml_pasien="120";
				break;

			}
			$post[] = array(
	
					'koders'=>$k_ppk,
					'tanggal'=>$tanggal2,
					'namainstalasi'=>$instansi,
					'statusdaftar'=>$status_pasien,
					'jumlahpasien'=>$jml_pasien,
					'updatedate'=>$datatime,
				);
		echo"<td>$instansi</td>
			 <td>$status_pasien</td>
			 <td>$jml_pasien</td>";
		}}
				
        echo"
		</tr>";
                } 
		echo"
		</table>";   
		$myvars=json_encode($post);
		echo $myvars;
		 
?>
<form action='?module=5.1&act=kirim' method='post'>
		<input type='hidden' value='<?php echo $myvars; ?>' name='kirim'>
		<button id="submit" name="submit" class="btn btn-primary" type="submit">Send</button>
		</form>
	<?php break ; 
	case "kirim":
		$myvars=$_POST['kirim'];
		// URL untuk mengirimkan data ke server dinas kesehatan
		$url= "http://eis.dinkes.jakarta.go.id/api/curl/ws-kunjunganpasienstatusdaftar.php";
		require_once('../conf/curl-send.php');	
		echo "<script>alert('Data Insya Allah Sudah Di Kirim'); window.location = 'javascript:history.go(-1)'</script>";
 break; 
}
?>	
    </body>
</html>

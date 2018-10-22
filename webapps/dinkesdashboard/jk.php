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
		<h4>Laporan Berdasarkan Jenis Kelamin</h4></div>
			<div class="panel-body">
    <?php
	switch($_GET[act]){
	default:
    echo"<form action='?module=jk&act=tampil' method='post'>
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
		$datatime=date("Y-m-d");

      
		
		$_poli="SELECT * FROM poliklinik";
		$poli=bukaquery($_poli);
		
		
		
		$ppkkode="SELECT * FROM setting";
		$ppk_kode=bukaquery($ppkkode);
		
		 while($ppk = mysql_fetch_array($ppk_kode)) { 
			$k_ppk=$ppk['kode_ppk'];
			$n_ppk=$ppk['nama_ppk'];
		 }
        echo"
		<input type='button' value='Back' onclick=self.history.go(-1)>
		<h3>Periode: $tanggal1 - $tanggal2</h3>
		<table class='table table-bordered table-hover table-striped' data-toggle='table'>
		<thead>
		<tr>
		<td>Kode</td>
		<td>Tanggal</td>
		<td>Nama Instalasi</td>
		<td>Jenis Kelamin</td>
		<td>Jumlah Pasien</td>
		<td>Nama Instalasi</td>
		<td>Jenis Kelamin</td>
		<td>Jumlah Pasien</td>";
		//echo $n_ppk;
		$_jenis = Array('L','P');
		$_instalasi = Array('Instalasi Rawat Jalan','Instalasi Gawat Darurat','Instalasi Rawat Inap');
        $myvars="";
		
    foreach($_instalasi as $instansi) {
		echo"
		</tr>
		</thead>
		<td>$k_ppk</td>
		<td>$tanggal2</td>";
		if('Instalasi Gawat Darurat'==$instansi)
		{
			foreach($_jenis as $jns_kelamin)
		{
			$_sql = "SELECT Count(pasien.jk) AS jumlah_pasien
				 FROM reg_periksa JOIN penjab ON reg_periksa.kd_pj = penjab.kd_pj JOIN pasien ON reg_periksa.no_rkm_medis = pasien.no_rkm_medis WHERE reg_periksa.kd_poli = 'IGDK' AND jk='$jns_kelamin' AND tgl_registrasi  BETWEEN '$tanggal1' AND '$tanggal2'";            
        $hasil=bukaquery($_sql);
        while($baris = mysql_fetch_array($hasil)) {
				$jml_pasien=$baris['jumlah_pasien'];
		}
		
		$post[] = array(
	
					'koders'=>$k_ppk,
					'tanggal'=>$tanggal2,
					'namainstalasi'=>$instansi,
					'jeniskelamin'=>$jns_kelamin,
					'jumlahpasien'=>$jml_pasien,
					'updatedate'=>$datatime
				);
		echo"<td>$instansi</td>
			 <td>$jns_kelamin</td>
			 <td>$jml_pasien</td>";
		}}
		else if('Instalasi Rawat Jalan'==$instansi)
		{
			foreach($_jenis as $jns_kelamin)
		{
			$_sql = "SELECT Count(pasien.jk) AS jumlah_pasien
				 FROM reg_periksa JOIN penjab ON reg_periksa.kd_pj = penjab.kd_pj JOIN pasien ON reg_periksa.no_rkm_medis = pasien.no_rkm_medis WHERE reg_periksa.kd_poli != 'IGDK' AND jk='$jns_kelamin' AND tgl_registrasi  BETWEEN '$tanggal1' AND '$tanggal2'";            
        $hasil=bukaquery($_sql);
		while($baris = mysql_fetch_array($hasil)) {
				$jml_pasien=$baris['jumlah_pasien'];
		}
		
			$post[] = array(
	
					'koders'=>$k_ppk,
					'tanggal'=>$tanggal2,
					'namainstalasi'=>$instansi,
					'jeniskelamin'=>$jns_kelamin,
					'jumlahpasien'=>$jml_pasien,
					'updatedate'=>$datatime
				);
		echo"<td>$instansi</td>
			 <td>$jns_kelamin</td>
			 <td>$jml_pasien</td>";
		}}
		else
		{
			foreach($_jenis as $jns_kelamin)
		{
			$_sql = "SELECT Count(pasien.jk) AS jumlah_pasien
				 FROM reg_periksa JOIN penjab ON reg_periksa.kd_pj = penjab.kd_pj  JOIN pasien ON reg_periksa.no_rkm_medis = pasien.no_rkm_medis  WHERE  jk='$jns_kelamin' AND status_lanjut='Ranap' AND tgl_registrasi  BETWEEN '$tanggal1' AND '$tanggal2' ";            
        $hasil=bukaquery($_sql);
		while($baris = mysql_fetch_array($hasil)) {
				$jml_pasien=$baris['jumlah_pasien'];
		}
			$post[] = array(
	
					'koders'=>$k_ppk,
					'tanggal'=>$tanggal2,
					'namainstalasi'=>$instansi,
					'jeniskelamin'=>$jns_kelamin,
					'jumlahpasien'=>$jml_pasien,
					'updatedate'=>$datatime
				);
		echo"<td>$instansi</td>
			 <td>$jns_kelamin</td>
			 <td>$jml_pasien</td>";
		}}
				
		echo"
		</tr>";
                } 
		echo"
		<table>";   
		echo json_encode($post);
		$myvars=json_encode($post);
			
		


?>

<input id = 'content' type='text' name='content' value='<?php echo $myvars; ?>'>
<div id="result"></div>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	    $.ajax({
	     url: "http://202.147.199.11/wsdashboarddinkes/wskunjunganpasienjeniskelamin.php",
	        type: "POST",
	        data: {
				data: $("#content").val()
			},
	        dataType: "JSON",
	        success: function (jsonStr) {
	            $("#result").text(JSON.stringify(jsonStr));
	        }
	    });
	});
</script>
	
<!-- <button id="submit" name="submit" type="submit">Send</buttton> -->
	<?php break ; 
}
?>	
    </body>
</html>

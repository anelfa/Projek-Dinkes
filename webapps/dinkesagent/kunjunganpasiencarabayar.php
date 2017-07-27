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

    <?php
    reportsqlinjection();      
       $tanggal1      = '2017-07-01'; 
        $tanggal2      = '2017-07-28'; 
		date_default_timezone_set("Asia/Jakarta");
		$datatime=date("Y-m-d H:i:s");

      
		
		$_poli="SELECT * FROM poliklinik";
		$poli=bukaquery($_poli);
		
		
		
		$ppkkode="SELECT * FROM setting";
		$ppk_kode=bukaquery($ppkkode);
		
		 while($ppk = mysql_fetch_array($ppk_kode)) { 
			$k_ppk=$ppk['kode_ppk'];
			$n_ppk=$ppk['nama_ppk'];
		 }
        
		//echo $n_ppk;
		$_jenis = Array('UMUM','BPJS');
		$_instalasi = Array('Instalasi Rawat Jalan','Instalasi Gawat Darurat','Instalasi Rawat Inap');
        $myvars="";
		
    foreach($_instalasi as $instansi) {
		
		if('Instalasi Gawat Darurat'==$instansi)
		{
			foreach($_jenis as $jns_byr)
		{
			$_sql = "SELECT Count(reg_periksa.kd_pj) AS jumlah_pasien
				 FROM reg_periksa JOIN penjab ON reg_periksa.kd_pj = penjab.kd_pj WHERE reg_periksa.kd_poli = 'IGD' AND png_jawab='$jns_byr' AND tgl_registrasi  BETWEEN '$tanggal1' AND '$tanggal2'";            
        $hasil=bukaquery($_sql);
        while($baris = mysql_fetch_array($hasil)) {
				$jml_pasien=$baris['jumlah_pasien'];
		}
		
		$post[] = array(
	
					'koders'=>$k_ppk,
					'tanggal'=>$tanggal2,
					'namainstalasi'=>$instansi,
					'carabayar'=>$jns_byr,
					'jumlahpasien'=>$jml_pasien,
					'updatedate'=>$datatime,
				);
		}}
		else if('Instalasi Rawat Jalan'==$instansi)
		{
			foreach($_jenis as $jns_byr)
		{
			$_sql = "SELECT Count(reg_periksa.kd_pj) AS jumlah_pasien
				 FROM reg_periksa JOIN penjab ON reg_periksa.kd_pj = penjab.kd_pj WHERE reg_periksa.kd_poli != 'IGD' AND png_jawab='$jns_byr' AND tgl_registrasi  BETWEEN '$tanggal1' AND '$tanggal2'";            
        $hasil=bukaquery($_sql);
		while($baris = mysql_fetch_array($hasil)) {
				$jml_pasien=$baris['jumlah_pasien'];
		}
		
			$post[] = array(
	
					'koders'=>$k_ppk,
					'tanggal'=>$tanggal2,
					'namainstalasi'=>$instansi,
					'carabayar'=>$jns_byr,
					'jumlahpasien'=>$jml_pasien,
					'updatedate'=>$datatime,
				);
		}}
		else
		{
			foreach($_jenis as $jns_byr)
		{
			$_sql = "SELECT Count(reg_periksa.kd_pj) AS jumlah_pasien
				 FROM reg_periksa JOIN penjab ON reg_periksa.kd_pj = penjab.kd_pj WHERE  png_jawab='$jns_byr' AND status_lanjut='Ranap' AND tgl_registrasi  BETWEEN '$tanggal1' AND '$tanggal2' ";            
        $hasil=bukaquery($_sql);
		while($baris = mysql_fetch_array($hasil)) {
				$jml_pasien=$baris['jumlah_pasien'];
		}
			$post[] = array(
	
					'koders'=>$k_ppk,
					'tanggal'=>$tanggal2,
					'namainstalasi'=>$instansi,
					'carabayar'=>$jns_byr,
					'jumlahpasien'=>$jml_pasien,
					'updatedate'=>$datatime,
				);
		}}
				
       
		}
		echo json_encode($post);
		$myvars=json_encode($post);
		
		
		


?>

<input id = 'content' type='text' name='content' value='<?php echo $myvars; ?>'>
<div id="result"></div>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	    $.ajax({
	        url: "http://202.147.199.11/wsdashboarddinkes/wskunjunganpasiencarabayar.php",
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
	
    </body>
</html>

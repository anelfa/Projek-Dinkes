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
		<h4>Laporan RL 3.15</h4></div>
			<div class="panel-body">
    <?php
	switch($_GET[act]){
	default:
    echo"<form action='?module=3.15&act=tampil' method='post'>
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
		$_jenis = Array('UMUM','BPJS','JAMINAN','UMUM-GRATIS');
		$_instalasi = Array('Instalasi Rawat Jalan','Instalasi Gawat Darurat','Instalasi Rawat Inap');
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
		<td>Jenis Bayar</td>
		<td>Jumlah Pasien</td>
		<td>Nama Instalasi</td>
		<td>Jenis Bayar</td>
		<td>Jumlah Pasien</td>";
		
    foreach($_instalasi as $instansi) {
		echo"
		</tr>
		</thead>
		<td>$k_ppk</td>
		<td>$tanggal2</td>
		";
		if('Instalasi Gawat Darurat'==$instansi)
		{
			foreach($_jenis as $jns_byr)
		{
			switch($jns_byr){
				case "UMUM":
				$jnsbyr="504";
				break;
				case "BPJS":
				$jnsbyr="1319";
				break;
				case "JAMINAN":
				$jnsbyr="0";
				break;
				case "UMUM-GRATIS":
				$jnsbyr="0";
				break;
				

			}
		
		$post[] = array(
	
					'koders'=>$k_ppk,
					'tanggal'=>$tanggal2,
					'namainstalasi'=>$instansi,
					'carabayar'=>$jns_byr,
					'jumlahpasien'=>$jnsbyr,
					'updatedate'=>$datatime
				);
		echo"<td>$instansi</td>
			 <td>$jns_byr</td>
			 <td>$jnsbyr</td>";	
		}}
		else if('Instalasi Rawat Jalan'==$instansi)
		{
			foreach($_jenis as $jns_byr)
		{
		
		switch($jns_byr){
				case "UMUM":
				$jnsbyr="662";
				break;
				case "BPJS":
				$jnsbyr="0";
				break;
				case "JAMINAN":
				$jnsbyr="0";
				break;
				case "UMUM-GRATIS":
				$jnsbyr="0";
				break;
				

			}
			$post[] = array(
	
					'koders'=>$k_ppk,
					'tanggal'=>$tanggal2,
					'namainstalasi'=>$instansi,
					'carabayar'=>$jns_byr,
					'jumlahpasien'=>$jnsbyr,
					'updatedate'=>$datatime
				);
		echo"<td>$instansi</td>
			 <td>$jns_byr</td>
			 <td>$jnsbyr</td>";
		}}
		else
		{
			foreach($_jenis as $jns_byr)
		{
			switch($jns_byr){
				case "UMUM":
				$jnsbyr="23";
				break;
				case "BPJS":
				$jnsbyr="88";
				break;
				case "JAMINAN":
				$jnsbyr="0";
				break;
				case "UMUM-GRATIS":
				$jnsbyr="0";
				break;
				

			}
			$post[] = array(
	
					'koders'=>$k_ppk,
					'tanggal'=>$tanggal2,
					'namainstalasi'=>$instansi,
					'carabayar'=>$jns_byr,
					'jumlahpasien'=>$jnsbyr,
					'updatedate'=>$datatime
				);
		echo"<td>$instansi</td>
			 <td>$jns_byr</td>
			 <td>$jnsbyr</td>";
		}}
				
        echo"
		</tr>";
                } 
		echo"
		</table>";   
		$myvars=json_encode($post);
		?>
		<form action='?module=3.15&act=kirim' method='post'>
		<input type='hidden' value='<?php echo $myvars; ?>' name='kirim'>
		<button id="submit" name="submit" type="submit">Send</button>
		</form>
		<br>
		<br>
		<?php
		break ; 
 
 case "kirim":
		$myvars=$_POST['kirim'];
		// URL untuk mengirimkan data ke server dinas kesehatan
		$url = 'http://eis.dinkes.jakarta.go.id/api/curl/ws-kunjunganpasiencarabayar.php';
		require_once('../conf/curl-send.php');	
		echo "<script>alert('Data Insya Allah Sudah Di Kirim'); window.location = 'javascript:history.go(-1)'</script>";
 break;
		 
}
?>	
    </body>
</html>

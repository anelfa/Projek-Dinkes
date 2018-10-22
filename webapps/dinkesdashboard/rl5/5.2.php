<?php
 include '../conf/conf.php';
   /* header("Content-type: application/x-msdownload");
    header("Content-Disposition: attachment; filename=LaporanRekapKunjuangnJenisBayar.xls");
    header("Pragma: no-cache");
    header("Expires: 0");
    print "$header\n$data";*/
?>
    <div class="panel-heading">
		<h4>Laporan RL 5.2 - Kunjungan Rawat Jalan</h4></div>
			<div class="panel-body">
    <?php
	switch($_GET[act]){
	default:
    echo"<form action='?module=5.2&act=tampil' method='post'>
	<table>
	<tr>
	<td>Periode</td><td>:</td><td><input type='text' id='calender1' name='tanggal1' >-S/D-<input type='text' id='calender' name='tanggal2' ></td>
	<td align='right'><input type='submit' value='tampilkan' class='btn btn-success' ></td>
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
		echo"
		<input type='button' class='btn btn-danger' value='Back' onclick=self.history.go(-1)>
		<h3>Periode: $tanggal1 - $tanggal2</h3>
		<table class='table table-bordered table-hover table-striped' data-toggle='table'>
		<thead>
		<tr>
		<td>Kode</td>
		<td>Tanggal</td>
		<td>Nama Instalasi</td>
		<td>Nama Ruangan</td>
		<td>Jumlah Pasien</td>";
		$ppkkode="SELECT * FROM setting";
		$ppk_kode=bukaquery($ppkkode);
		
		 while($ppk = mysql_fetch_array($ppk_kode)) { 
			$k_ppk=$ppk['kode_ppk'];
			$n_ppk=$ppk['nama_ppk'];
		 }
       $_namaPoli=array('Poli Umum','Poli Gigi','Poli KIA/KB','Poli Gizi','Poli Anak','Poli Penyakit Dalam','Poli KIR');
                 foreach($_namaPoli as $namaPoli ) {

                 switch($namaPoli){
				case "Poli Umum":
				$jml_pasien="406";
				break;
				case "Poli Gigi":
				$jml_pasien="161";
				break;
				case "Poli KIA/KB":
				$jml_pasien="143";
				break;
				case "Poli Gizi":
				$jml_pasien="5";
				break;
				case "Poli Anak":
				$jml_pasien="111";
				break;
				case "Poli Penyakit Dalam":
				$jml_pasien="93";
				break;
				case "Poli KIR":
				$jml_pasien="0";
				break;

			} 
				//simpan data untuk kirim ke dinkes
				$myvars="";
				$post[] = array(
	
					'koders'=>$k_ppk,
					'tanggal'=>$tanggal2,
					'namainstalasi'=>'Instalasi Rawat jalan',
					'namaruangan'=>$namaPoli,
					'kelas'=>'',
					'jumlahpasien'=>$jml_pasien,
					'updatedate'=>$datatime,
					);
		echo"
		</tr>
		</thead>
		<td>$k_ppk</td>
		<td>$tanggal2</td>
		<td>Instalasi Rawat Jalan</td>
		<td>$namaPoli</td>
		<td>$jml_pasien</td>
		</tr>";
                } 
		echo"
		</table>";   
		//keep data dengan JSON
		$myvars=json_encode($post);
 
?>
<form action='?module=5.2&act=kirim' method='post'>
		<input type='hidden' value='<?php echo $myvars; ?>' name='kirim'>
		<button id="submit" name="submit" class="btn btn-primary" type="submit">Send</button>
		</form>
		<?php break ;
		case "kirim":
		$myvars=$_POST['kirim'];
		// URL untuk mengirimkan data ke server dinas kesehatan
		$url = 'http://eis.dinkes.jakarta.go.id/api/curl/ws-kunjunganpasienruangan.php';
		require_once('../conf/curl-send.php');	
		echo "<script>alert('Data Insya Allah Sudah Di Kirim'); window.location = 'javascript:history.go(-1)'</script>";
 break; 
}
?>
  <br><br><br>  

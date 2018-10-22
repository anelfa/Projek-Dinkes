<?php
 include '../conf/conf.php';
   /* header("Content-type: application/x-msdownload");
    header("Content-Disposition: attachment; filename=LaporanRekapKunjuangnJenisBayar.xls");
    header("Pragma: no-cache");
    header("Expires: 0");
    print "$header\n$data";*/
?>

    <div class="panel-heading">
		<h4>RL 2 - Ketenagaan </h4></div>
			<div class="panel-body">
    <?php
	switch($_GET[act]){
	default:
    echo"
	 
	<code class='language-markup'>
<form action='?module=2&act=simpan' method='post' class='form-horizontal'>
	<div class='form-group'>
<label class='control-label col-lg-4'>Jabatan Fungsional</label>
	
	<div class='col-lg-8'>
	<select name='jabatanfungsional' class='form-control chzn-select'>
	
	<option >Dokter Umum</option>
	<option >Dokter Gigi</option>
	<option >Dokter Gigi Spesialis</option>
	<option >Dokter Spes Obgin</option>
	<option >Dokter Spes Penyakit Dalam</option>
	<option >Dokter Spes Kes. Anak</option>
	<option >Dokter Spes Radiologi</option>
	<option >Dokter Spes Paru</option>
	<option >Dokter Spes Anasthesi</option>
	<option >Dokter Spes Patologi Klinik</option>
	<option >Struktural</option>
	<option >Apoteker</option>
	<option >Perawat (S1)</option>
	<option >Perawat (D3)</option>
	<option >Perawat Lain (SPK)</option>
	<option >Perawat Gigi</option>
	<option >Bidan</option>
	<option >Teknisi Radiografer</option>
	<option >Analis Laboratorium</option>
	<option >Asisten Apoteker</option>
	<option >Nutrisionis</option>
	<option >Sanitarian</option>
	<option >Fisioterapis</option>
	<option >Rekam Medis</option>
	<option >Staf Administrasi</option>
	<option >Staf Keuangan</option>
	<option >Pengurus Barang</option>
	<option >Tenaga IT</option>
	<option >Pengemudi</option>
	<option >Juru Masak</option>
	<option >Laundry</option>
	

	</select>
	</div></div>
	
	<div class='form-group'>
<label class='control-label col-lg-4'>Jenis Tenaga Kerja</label>
	
	<div class='col-lg-8'>
	<select name='jenistenagakerja' class='form-control chzn-select'>
	<option value='tenaga_medis'>Tenaga Medis</option>
	<option value='tenaga_non_medis'>Tenaga Non Medis</option>
	
	</select>
	</div></div>
	<div class='form-group'>
<label class='control-label col-lg-4'>Jumlah</label>
	
	<div class='col-lg-8'>
	<td><input type='text' name='jumlahtenagakerja' class='form-control'/>
	</div></div>
	
<input type='submit' value='Simpan' class='btn btn-primary' ></td>
	
	</form>
	
	</code>
	
	<br>
<table class='table table-bordered table-hover table-striped' data-toggle='table'>
		<thead>
		<tr>
		<td>No</td>
		<td>Jabatan Fungsional</td>
		<td>Jenis Tenaga</td>
		<td>Jumlah</td>
		<td></td>
		</tr>
		</thead>";?>
<?php 
$ppkkode="SELECT * FROM setting";
		$ppk_kode=bukaquery($ppkkode);
 while($ppk = mysql_fetch_array($ppk_kode)) { 
			$k_ppk=$ppk['kode_ppk'];
			$n_ppk=$ppk['nama_ppk'];
		 }
$_sql = "SELECT * FROM ketenagaan";  
$hasil=bukaquery($_sql); $no=1;
                 while($baris = mysql_fetch_array($hasil)) { 
                 	
                 	$myvars="";
				$post[] = array(
	
					'koders'=>$k_ppk,
  					'jabatanfungsional'=>$baris['jabatanfungsional'],
  					'jenistenagakerja'=>$baris['jenistenagakerja'],
  					'jumlahtenagakerja'=>$baris['jumlahtenagakerja']
					);
$myvars=json_encode($post);
              switch($baris['jenistenagakerja'])
              {
              	case "tenaga_medis": $tenaga="Tenaga Medis";
              	break;
              	case "tenaga_non_medis": $tenaga="Tenaga Non Medis";
              	break;
              }
              $idf=$baris['id_ketanagaan'];

echo"

		<tr>
		<td>".$no++."</td>
		<td>".$baris['jabatanfungsional']."</td>
		<td>".$tenaga."</td>
		<td>".$baris['jumlahtenagakerja']."</td>
		<td>		<a href='?module=2&act=edit&id=$idf' onclick='return confirm('Yakin hapus data ini?')' title='Edit'>
                <i class='glyphicon glyphicon-pencil '> </i> <a href='?module=2&act=hapus&id=$idf' onclick='return confirm('Yakin hapus data ini?')' title='Hapus'>
                <i class='glyphicon glyphicon-trash '>
              </a></td>
		</tr>";
	}
	echo"

</table>
	<br><br>";
	?>
	<form action='?module=2&act=kirim' method='post'>
		<input type='hidden' value='<?php echo $myvars; ?>' name='kirim'>
		<button id="submit" name="submit" class="btn btn-success" type="submit">Kirim Data</button>
		</form>
		<br>
		<br>
	<?php

	break;
	
	case "simpan":
	$tabelname="ketenagaan";
		$jabatanfungsional      = $_POST['jabatanfungsional'];
		$jenistenagakerja      = $_POST['jenistenagakerja'];  
		$jumlahtenagakerja      = $_POST['jumlahtenagakerja']; 

		$attrib="'','$jabatanfungsional','$jenistenagakerja','$jumlahtenagakerja'" ;
		$pesan="$jabatanfungsional";
    
    Tambah($tabelname,$attrib,$pesan);
    echo "<script>alert('Data Berhasil Disimpan'); window.location = '?module=2'</script>";

		
?>

	<?php break ; 
	case  "kirim":
$myvars=$_POST['kirim'];
	
$url= "http://eis.dinkes.jakarta.go.id/api/curl/ws-rl2.php";
		require_once('../conf/curl-send.php');	
		echo "<script>alert('Data Insya Allah Sudah Di Kirim'); window.location = 'javascript:history.go(-1)'</script>";
 break; 
case "edit":
$idket=$_GET[id];
$_sql = "SELECT * FROM ketenagaan WHERE id_ketanagaan='$idket'";  
$hasil=bukaquery($_sql); $no=1;
                 while($baris = mysql_fetch_array($hasil)) { 
                 	$idketenagaan=$baris['id_ketanagaan'];
                 	$jafung=$baris['jabatanfungsional'];
                 	$jten=$baris['jenistenagakerja'];
		$jumlahten=$baris['jumlahtenagakerja'];
		switch($baris['jenistenagakerja'])
              {
              	case "tenaga_medis": $tenaga="Tenaga Medis";
              	break;
              	case "tenaga_non_medis": $tenaga="Tenaga Non Medis";
              	break;
              }
                 	}
;
echo"<form action='?module=2&act=update' method='post'>
	<table>
	<tr>
	<td>Jabatan Fungsional</td><td>:</td><td>
	<select name='jabatanfungsional'>
	<option >$jafung</option>
	<option >Dokter Umum</option>
	<option >Dokter Gigi</option>
	<option >Dokter Gigi Spesialis</option>
	<option >Dokter Spes Obgin</option>
	<option >Dokter Spes Penyakit Dalam</option>
	<option >Dokter Spes Kes. Anak</option>
	<option >Dokter Spes Radiologi</option>
	<option >Dokter Spes Paru</option>
	<option >Dokter Spes Anasthesi</option>
	

	</select> </td>
	</tr>
	<tr>
	<td>Jenis Tenaga Kerja</td><td>:</td><td>
	<select name='jenistenagakerja'>3
	<option value='$jten'>$tenaga</option>
	<option value='tenaga_medis'>Tenaga Medis</option>
	<option value='tenaga_non_medis'>Tenaga Non Medis</option>
	
	</select></td>
	</tr>
	<tr>
	<td>Jumlah</td><td>:</td>
	<td><input type='text' name='jumlahtenagakerja' value='$jumlahten'/>
	</td>
	</tr>
	
	<tr>
	<td>
	<input type='hidden' name='id_ketanagaan' value='$idketenagaan'/>
<input type='submit' value='Update' class='btn btn-primary' ></td>
	</tr>
	</table>
	</form>
	<br>";
break;
case "update":
$tabelname="ketenagaan";
$jabatanfungsional      = $_POST['jabatanfungsional'];
		$jenistenagakerja      = $_POST['jenistenagakerja'];  
		$jumlahtenagakerja      = $_POST['jumlahtenagakerja']; 
		$id_ketanagaan      = $_POST['id_ketanagaan']; 
	

$attrib="jabatanfungsional='$jabatanfungsional',jenistenagakerja='$jenistenagakerja',jumlahtenagakerja='$jumlahtenagakerja' WHERE id_ketanagaan='$id_ketanagaan'" ;
$pesan="$jabatanfungsional";
Ubah($tabelname,$attrib,$pesan);
 echo "<script>alert('Data Berhasil Diupdate'); window.location = '?module=2'</script>";
break;
case "hapus":
$tabelname="ketenagaan";
$idket=$_GET[id];
		
$param="id_ketanagaan='$idket'" ;

Hapus2($tabelname,$param);
 echo "<script>alert('Data Berhasil Dihapus'); window.location = '?module=2'</script>";
break;

}
?>	
   
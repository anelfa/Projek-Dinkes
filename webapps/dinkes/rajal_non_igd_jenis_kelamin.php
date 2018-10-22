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

        $_sql = "SELECT setting.kode_ppk, setting.nama_ppk, pasien.jk, Count(pasien.jk) as jumlah_pasien
				 FROM pasien , reg_periksa ,penjab , poliklinik , setting
				 WHERE pasien.no_rkm_medis = reg_periksa.no_rkm_medis AND reg_periksa.kd_poli = poliklinik.kd_poli AND reg_periksa.kd_pj = penjab.kd_pj AND pasien.jk = pasien.jk AND reg_periksa.kd_poli != 'IGDK'
				 AND reg_periksa.tgl_registrasi BETWEEN '$tanggal1' AND '$tanggal2'
				 GROUP BY
				 pasien.jk";            
        $hasil=bukaquery($_sql);
        
        if(mysql_num_rows($hasil)!=0) { 
          echo "<table width='100%'  border='1' align='left' cellpadding='0' cellspacing='0' class='tbl_form'>
                 <caption><br/><center><font color='000000' size='4' face='Arial'>Laporan Kunjuangan Rawat Jalan Per Jenis Bayar<br> Periode $tanggal1 s.d. $tanggal2 </font></center><br/></caption>
                 <tr class=isi15>
                    <td width='5%' align=center>No</td>
                    <td width='35%' align=center>Kode PPK</td>
                    <td width='20%' align=center>Nama PPK</td>
                    <td width='20%' align=center>Jenis Kelamin</td>
                    <td width='20%' align=center>Jumlah Pasien</td>
                 </tr>";
                 $i=1;
                 $lama=0;
                 $baru=0;
                 $total=0;
                 while($baris = mysql_fetch_array($hasil)) { 
				   $lama=$lama+getOne("select count(no_rawat) from reg_periksa where kd_pj='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2' and stts_daftar='Lama'");
				   $baru=$baru+getOne("select count(no_rawat) from reg_periksa where kd_pj='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2' and stts_daftar='Baru'");
				   $total=$total+getOne("select count(no_rawat) from reg_periksa where kd_pj='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2'");
                   $kd_ppk=$baris['kode_ppk'];
				   $nm_ppk=$baris['nama_ppk'];
				   $instansi='Instalasi Rawat Jalan';
				   $jns_kelamin=$baris['jk'];
				   $jml_pasien=$baris['jumlah_pasien'];
				   echo "<tr class='isi15'>
                           <td>$i &nbsp;</td>
                           <td>$kd_ppk</td>
                           <td>$nm_ppk</td>
						   <td>$jns_kelamin</td>
						   <td>$jml_pasien</td>
                           </tr>";$i++;
						   
				//simpan data untuk kirim ke dinkes
				$myvars="";
				$post[] = array(
	
					'koders'=>$kd_ppk,
					'tanggal'=>$tanggal2,
					'namainstalasi'=>$instansi,
					'jeniskelamin'=>$jns_kelamin,
					'jumlahpasien'=>$jml_pasien,
					'updatedate'=>$datatime,
				);
                                                              }    
                   echo "
                 </table>";
            
        } else {echo "<b>Data masih kosong !</b>";}
		
		//keep data dengan JSON
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
	
    </body>
</html>";

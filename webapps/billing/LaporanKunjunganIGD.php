<?php
 include '../conf/conf.php';
    $line1="ID\tProduct\tColor\tSales\t";
    $line2="1\tPrinter\tGrey\t13\t";
    $line3="2\tCD\tBlue\t15\t";
    $line4="3\tDVD\tRed\t7\t";
    $line5="4\tMonitor\tGreen\t4\t";
    $line6="5\tTelephone\tBlack\t2\t";

    $data="$line1\n$line2\n$line3\n$line4\n$line5\n$line6\n";

    header("Content-type: application/x-msdownload");
    header("Content-Disposition: attachment; filename=LaporanRekapKunjuangnIgd.xls");
    header("Pragma: no-cache");
    header("Expires: 0");
    print "$header\n$data";
?>
<html>
    <body>

    <?php
    reportsqlinjection();
        $tanggal1      = $_GET['tanggal1'];
        $tanggal2      = $_GET['tanggal2'];

        $_sql = "select kd_poli,nm_poli from poliklinik where kd_poli REGEXP 'IGD'";
        $hasil=bukaquery($_sql);

        if(mysql_num_rows($hasil)!=0) {
          echo "<table width='100%'  border='1' align='left' cellpadding='0' cellspacing='0' class='tbl_form'>
                 <caption><br/><center><font color='000000' size='4' face='Arial'>Laporan Kunjuangan IGD<br> Periode $tanggal1 s.d. $tanggal2 </font></center><br/></caption>
                 <tr class=isi15>
                    <td width='5%' align=center>No</td>
                    <td width='35%' align=center>Nama Unit</td>
                    <td width='20%' align=center>Pasien Lama</td>
                    <td width='20%' align=center>Pasien Baru</td>
                    <td width='10%' align=center>Pasien Umum</td>
                    <td width='10%' align=center>Pasien Bpjs</td>
                     <td width='10%' align=center>Laki-laki</td>
                      <td width='10%' align=center>Perempuan</td>
                       <td width='10%' align=center>Dewasa</td>
                      <td width='10%' align=center>Anak</td>
                    <td width='20%' align=center>Jumlah Pasien</td>
                 </tr>";
                 $i=1;
                 $lama=0;
                 $baru=0;
                 $bpjs=0;
                 $umum=0;
                 $l=0;
                 $p=0;
                 $dewasa=0;
                 $anak=0;
                 $total=0;
                 while($baris = mysql_fetch_array($hasil)) {
				   $lama=$lama+getOne("select count(no_rawat) from reg_periksa where kd_poli='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2' and stts_daftar='Lama' and stts!='Batal'");
				   $baru=$baru+getOne("select count(no_rawat) from reg_periksa where kd_poli='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2' and stts_daftar='Baru' and stts!='Batal'");
				   $umum=$umum+getOne("select count(no_rawat) from reg_periksa where kd_poli='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2'   and kd_pj='C01' and stts!='Batal'");
             $bpjs=$bpjs+getOne("select count(no_rawat) from reg_periksa where kd_poli='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2'  and kd_pj='C02' and stts!='Batal'");
             $l=$l+getOne("select count(no_rawat) from reg_periksa JOIN pasien ON reg_periksa.no_rkm_medis=pasien.no_rkm_medis where kd_poli='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2'   and jk='L' and stts!='Batal'");
             $p=$p+getOne("select count(no_rawat) from reg_periksa JOIN pasien ON reg_periksa.no_rkm_medis=pasien.no_rkm_medis where kd_poli='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2'   and jk='P' and stts!='Batal'");
             $dewasa=$dewasa+getOne("select count(no_rawat) from reg_periksa where kd_poli='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2'  and hr_umur>=17 and stts!='Batal'");
             $anak=$anak+getOne("select count(no_rawat) from reg_periksa where kd_poli='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2'  and hr_umur<17 and stts!='Batal'");

             $total=$total+getOne("select count(no_rawat) from reg_periksa where kd_poli='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2' and stts!='Batal'");
                   echo "<tr class='isi15'>
                           <td>$i &nbsp;</td>
                           <td>".$baris[1]." &nbsp;</td>
                           <td>".getOne("select count(no_rawat) from reg_periksa where kd_poli='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2' and stts_daftar='Lama' and stts!='Batal'")." &nbsp;</td>
                           <td>".getOne("select count(no_rawat) from reg_periksa where kd_poli='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2' and stts_daftar='Baru' and stts!='Batal'")." &nbsp;</td>
                           <td>".getOne("select count(no_rawat) from reg_periksa where kd_poli='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2' and kd_pj='C01' and stts!='Batal'")." &nbsp;</td>
                   <td>".getOne("select count(no_rawat) from reg_periksa where kd_poli='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2' and kd_pj='C02' and stts!='Batal'")." &nbsp;</td>
                   <td>".getOne("select count(no_rawat) from reg_periksa JOIN pasien ON reg_periksa.no_rkm_medis=pasien.no_rkm_medis where kd_poli='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2' and jk='L' and stts!='Batal'")." &nbsp;</td>
                   <td>".getOne("select count(no_rawat) from reg_periksa JOIN pasien ON reg_periksa.no_rkm_medis=pasien.no_rkm_medis where kd_poli='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2' and jk='P' and stts!='Batal'")." &nbsp;</td>
                   <td>".getOne("select count(no_rawat) from reg_periksa where kd_poli='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2' and hr_umur>=17 and stts!='Batal'")." &nbsp;</td>
                   <td>".getOne("select count(no_rawat) from reg_periksa where kd_poli='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2' and hr_umur<17 and stts!='Batal'")." &nbsp;</td>
                           <td>".getOne("select count(no_rawat) from reg_periksa where kd_poli='$baris[0]' and tgl_registrasi between '$tanggal1' and '$tanggal2' and stts!='Batal'")." &nbsp;</td>
                         </tr>";$i++;
                                      }
                   echo "
                   <tr class=isi15>
                     <td>&nbsp;</td>
                     <td>Total</td>
                     <td>$lama &nbsp;</td>
                     <td>$baru &nbsp;</td>
                     <td>$umum &nbsp;</td>
                     <td>$bpjs &nbsp;</td>
                     <td>$l &nbsp;</td>
                     <td>$p &nbsp;</td>
                     <td>$dewasa &nbsp;</td>
                     <td>$anak &nbsp;</td>
                     <td>$total &nbsp;</td>
                   </tr>
                 </table>";

        } else {echo "<b>Data masih kosong !</b>";}
    ?>

    </body>
</html>

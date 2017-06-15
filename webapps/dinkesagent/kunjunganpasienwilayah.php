
<meta http-equiv="refresh" content="60">
								
<script type="text/JavaScript">
	function AutoRefresh( t ) {
		setTimeout("location.reload(true);", t);
	}
</script>

<?php
/*] CREATE BY   	: DIDIK ANANG NUGROHO
[*] DATE(DMY)   	: 23-05-2017 19:24:02
[*] COMPANY     	: RUMAH SAKIT UMUM DAERAH KOJA
[*] CITY        	: NORTH JAKARTA, INDONESIA
[*/
include "dfconnectionrs.php";
$query ="
				select	
							KodeRS as koders,
							Tanggal as tanggal,
							NamaInstalasi as namainstalasi,
							Kecamatan as kecamatan,
							JumlahPasien as jumlahpasien,
							UpdateDate as updatedate
				from      dbo.[dinkes_kunjunganpasienwilayah_dayly]
				order by JumlahPasien desc
			";

$data = array();
$zz = sqlsrv_query($conn, $query); 
while ($allRow = sqlsrv_fetch_array($zz, SQLSRV_FETCH_ASSOC)){ 
            $datas[] = $allRow;

        }
echo "Service Informasi Kunjungan Pasien Berdasarkan Wilayah";
echo '<br>';
echo '<br>';
echo json_encode($datas);

$myvars=json_encode($datas);


?>
<input id = 'content' type='hidden' name='content' value='<?php echo $myvars; ?>'>
<div id="result"></div>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	    $.ajax({
	        url: "http://202.147.199.11/wsdashboarddinkes/wskunjunganpasienwilayah.php",
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
	
	
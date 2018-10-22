<div id="post">
    <form name="frm_aturadmin" onsubmit="return validasiIsi();" method="post" action="" enctype=multipart/form-data>
        <?php
                echo "";
                $action      =isset($_GET['action'])?$_GET['action']:NULL;
                $keyword     =isset($_GET['keyword'])?$_GET['keyword']:NULL;
                $norm        =isset($_GET['Pasien'])?$_GET['Pasien']:NULL;
                $poli        =isset($_GET['Poli'])?$_GET['Poli']:NULL;
                $dokter      =isset($_GET['Dokter'])?$_GET['Dokter']:NULL;
                $tgl         =  getOne("select current_date()");
                $jam         =  getOne("select current_time()");
                echo "<input type=hidden name=keyword value=$keyword>"
                        . "<input type=hidden name=norm value=$norm>";
        ?>
            <table width="800px" align="center">
                <tr class="head">
                    <td width="30%" >Tanggal & Jam</td><td width="">:</td>
                    <td width="69%"><?php echo$tgl." ".$jam;?></td>
                </tr>
                <tr class="head">
                    <td width="30%" >No.RM</td><td width="">:</td>
                    <td width="69%"><?php echo$norm;?></td>
                </tr>
                <tr class="head">
                    <td width="30%" >Nama</td><td width="">:</td>
                    <td width="69%"><?php echo getOne("select nm_pasien from pasien where no_rkm_medis='$norm'");?></td>
                </tr>
                <tr class="head">
                    <td width="30%" >Unit/Poliklinik</td><td width="">:</td>
                    <td width="69%"><?php echo getOne("select nm_poli from poliklinik where kd_poli='$poli'");?></td>
                </tr>
                <tr class="head">
                    <td width="30%" >Dokter</td><td width="">:</td>
                    <td width="69%"><?php echo getOne("select nm_dokter from dokter where kd_dokter='$dokter'");?></td>
                </tr>
            </table>
    </form>    
</div>


    <form name="frmregistrasi" onsubmit="return validasiIsi();" method="post" action="" enctype=multipart/form-data>
        <div id="post">
            <table width="100%">
                <caption><h1>Anjungan Registrasi Mandiri Pasien</h1></caption>
                <tr>
                    <td align="center">
                        <table align="center">                        
                            <tr class="head">
                                <td>No.RM Pasien</td>
                                <td>:</td>
                                <td>
                                    <input type="text" class="text" name="norm" value="" size="25" onkeydown="setDefault(this, document.getElementById('MsgIsi1'));" id="TxtIsi1" autofocus/>
                                    <span id="MsgIsi1" style="color:#CC0000; font-size:10px;"></span>
                                </td>
                                <td><a href=?page=PasienBaru><font size="3" color="#ff5555">[Pasien Baru]</font></a></td>
                            </tr>                              
                        </table>                        
                        <?php
                            $norm   = trim(isset($_POST['norm']))?trim($_POST['norm']):NULL;
                            if (!empty($norm)) {
                                $norm2=getOne("select * from pasien where no_rkm_medis='$norm'");
                                if (empty($norm2)) {
                                    echo "Maaf, data pasien dengan No.RM tersebut tidak ditemukan.<br>
                                    Bagi pasien yang baru pertama kali periksa, silahkan klik pada \"Pasien Baru\"  ";
                                }else{
                                    echo"<html><head><title></title><meta http-equiv='refresh' content='1;URL=?page=PilihPoli&Pasien=$norm2'></head><body></body></html>";
                                }
                            }     
                        ?>
                    </td>        
                </tr>
            </table>   
        </div>
    </form>        

     
      <div class="content-wrapper">
        <div class="page-title">
          <div>
            <h1><i class="fa fa-list-alt"></i> Input Aktifitas</h1>
            <p></p>
          </div>
		  
          <div>
            <ul class="breadcrumb">
              <li><i class="fa fa-home fa-lg"></i></li>
              <li><a href="#">Input Aktifitas</a></li>
              <li><a href="#">Input Aktifitas Utama</a></li>
            </ul>
          </div>
        </div>
        <?php if ($bulan_open->open_aktivitas==0){?>
        <div class="row">
                  
					<div class="col-lg-12">
                   <div class="card">
                    <h3 class="card-title">Input Aktifitas Belum Dibuka</h3>
                    
				
                   
                    </div>
                  </div>
		  </div>
<?php }else{?>
                <div class="row">
                  <?php switch($bulan)
					{
					case 1: $bul="Januari";
					break;
					case 2: $bul="Februari";
					break;
					case 3: $bul="Maret";
					break;
					case 4: $bul="April";
					break;
					case 5: $bul="Mei";
					break;
					case 6: $bul="Juni";
					break;
					case 7: $bul="Juli";
					break;
					case 8: $bul="Agustus";
					break;
					case 9: $bul="September";
					break;
					case 10: $bul="Oktober";
					break;
					case 11: $bul="November";
					break;
					case 12: $bul="Desember";
					break;
					}?>
					<div class="col-lg-12">
                   <div class="card">
                    <h3 class="card-title">Input Aktifitas Utama <?php echo $bul;?></h3>
                    <form class="form-inline" method="Post" action="<?php echo base_url();?>aktifitas/sort_utama">
					<div class="form-group">
                    Periode : <br>
                  </div>
                  <div class="form-group">
                    
                    <select class="form-control" id="select" name="bulan">
					
                              <option value="<?php echo $bulan;?>"><?php echo $bul;?></option>
                              <option value="1">Januari</option>
							   <option value="2">Februari</option>
                             <option value="3">Maret</option>
							   <option value="4">April</option>
							   <option value="5">Mei</option>
							   <option value="6">Juni</option>
							   <option value="7">Juli</option>
							   <option value="8">Agustus</option>
							   <option value="9">September</option>
							   <option value="10">Oktober</option>
							   <option value="11">November</option>
							   <option value="12">Desember</option>
                            </select><br>
                  </div>
                  <div class="form-group">
                    <select class="form-control" id="select" name="tahun">
					<option value="<?php echo $tahun;?>"><?php echo $tahun;?></option>
					<?php $i=2015;$a=2025; for($i;$i<$a;$i++){?>
                              <option value="<?php echo $i;?>"><?php echo $i;?></option>
                              <?php }?>
                            </select><br>
                  </div>
                  <div class="form-group">
                    <button class="btn btn-primary icon-btn" type="button" onclick=submit();><i class="fa fa-fw fa-lg fa-search"></i>Tampilkan</button>
                  </div>
                </form>
				<div class="card-footer"></div>
                   <div class="card-body">
                    
                    <div class="bs-component">
                       <?php  $data['bulan']=$bulan;$data['tahun']=$tahun;
					   $this->load->view('aktifitas/submenu',$data);?>
                      <div class="card-footer"></div>
                      <?php if($bulan==$bulan_open->open_aktivitas){?>
                     <p> <a class="btn btn-info btn-custom" href="<?php echo base_url();?>aktifitas/tambah_utama/<?php echo $bulan;?>/<?php echo $tahun;?>"><i class="fa fa-lg fa-plus"></i> Tambah Aktifitas</a>
                     <?php } else{?>
                      <p> <a class="btn btn-default btn-custom" href="#" style="cursor:not-allowed"><i class="fa fa-lg fa-plus"></i> Tambah Aktifitas</a>
                      <?php }?>
                         <div  style="width:100%;  overflow:auto; min-height:auto; ">
                      <table class="table table-hover table-bordered" id="data_skp">
                  <thead>
                    <tr>
                      	<th>No</th>
                      	<th>Tanggal</th>
					 	<th>SKP</th>
						<th>Uraian</th>
						<th>Mulai</th>
						<th>Selesai</th>
						<th>Durasi</th>
						<th>Vol</th>
						<th>Control</th>
                    </tr>
                  </thead>
                  <tbody>
                   <?php $no=1;foreach($aktifitas_utama->result_array() as $aktifitas_utama):
					  $vol=round($aktifitas_utama['jumlah']/$aktifitas_utama['waktu_e'],2) 
					  ?>
                   <tr>
                   <td><?php echo $no;?></td>
                   <td><?php $tgl=explode("-",$aktifitas_utama['tanggal']);echo "".$tgl[2]."-".$tgl[1]."-".$tgl[0]."";?></td>
                   <td><?php echo $aktifitas_utama['kd_skp'];?></td>
                   <td><?php echo $aktifitas_utama['uraian'];?></td>
                   <td><?php echo $aktifitas_utama['jam_mulai'];?></td>
                   <td ><?php echo $aktifitas_utama['jam_akhir'];?></td>
                   <td style="text-align: right"><?php echo str_replace(",",".",number_format($aktifitas_utama['jumlah']));?> menit</td>
                   <td style="text-align: right"><?php echo str_replace(".",",",$vol);?></td>
                   <td style="text-align: center">
                   <?php 
					  if($bulan==$bulan_open->open_aktivitas){
					   if($aktifitas_utama['point']==0){?>
                   <a href='<?php echo base_url();?>aktifitas/edit_utama/<?php echo $aktifitas_utama['id_kinerja'];?>/<?php echo $bulan;?>/<?php echo $tahun;?>' title='EDIT'><i class='fa fa-edit'></i></a></span><span>
	<a href="#" onClick="confirmDeleteKinerja('<?php echo $aktifitas_utama['id_kinerja'];?>')" title='HAPUS'><i class='fa fa-times' style=' color: #EF0509'></i></a>
                  <?php }else{?>
		<i class="fa fa-check-square-o" title="Telah di Validasi"></i>
<?php }}else{}?></td>
                   </tr>
                   <?php $no++;endforeach;?>
                    
                  </tbody>
                </table>
					   </div>
                     </div> 
                    </div>
                    </div>
                  </div>
		  </div>
         <?php }?>
        
      </div>
    </div>
    
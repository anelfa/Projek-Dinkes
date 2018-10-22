<?php 
error_reporting(E_ALL ^ (E_NOTICE | E_WARNING));
if($_GET['module']=="dashboard"){
		include "dashboard.php";
		} 
elseif($_GET['module']=="1.1"){
		include "rl1/1.1.php";
		} 
	elseif($_GET['module']=="1.2"){
		include "rl1/1.2.php";
		} 
	elseif($_GET['module']=="1.3"){
		include "rl1/1.3.php";
		} 
	elseif($_GET['module']=="1.3"){
		include "agent2/rl_1.3.php";
		} 
	elseif($_GET['module']=="2"){
		include "rl2/2.php";
		} 
	elseif($_GET['module']=="3.1"){
		include "rl3/3.1.php";
		} 
	elseif($_GET['module']=="3.2"){
		include "rl3/3.2.php";
		} 
	elseif($_GET['module']=="3.3"){
		include "rl3/3.3.php";
		} 
	elseif($_GET['module']=="3.4"){
		include "rl3/3.4.php";
		}
	elseif($_GET['module']=="3.5"){
		include "rl3/3.5.php";
		} 
	elseif($_GET['module']=="3.6"){
		include "rl3/3.6.php";
		} 
	elseif($_GET['module']=="3.7"){
		include "rl3/3.7.php";
		} 
	elseif($_GET['module']=="3.8"){
		include "rl3/3.8.php";
		}
	elseif($_GET['module']=="3.9"){
		include "rl3/3.9.php";
		}
	elseif($_GET['module']=="3.10-"){
		include "rl3/3.10.php";
		}
	elseif($_GET['module']=="3.11"){
		include "rl3/3.11.php";
		} 
	elseif($_GET['module']=="3.12"){
		include "rl3/3.12.php";
		} 
	elseif($_GET['module']=="3.13"){
		include "rl3/3.13.php";
		}
	elseif($_GET['module']=="3.14"){
		include "rl3/3.14.php";
		} 
	elseif($_GET['module']=="3.15"){
		include "rl3/3.15.php";
		}
	elseif($_GET['module']=="4a"){
		include "rl_4a.php";
		} 
	elseif($_GET['module']=="4b"){
		include "4b.php";
		}
	elseif($_GET['module']=="5.1"){
		include "rl5/5.1.php";
		} 
	elseif($_GET['module']=="5.2"){
		include "rl5/5.2.php";
		} 
	elseif($_GET['module']=="5.3"){
		include "rl5/5.3.php";
		} 
	elseif($_GET['module']=="5.4"){
		include "rl5/5.4.php";
		} 
	elseif($_GET['module']=="jk"){
		include "jk.php";
		} 
	else {
		?>
		<div class="panel-heading">
		<h4>Selamat Datang di menu Laporan</h4></div>
			<div class="panel-body">
			<p>data ni akan di kirimkan ke dashboard dinkes setiap periodenyaaa
		<?php
	}
?>

		

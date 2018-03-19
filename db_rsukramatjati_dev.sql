/*
 Navicat Premium Data Transfer

 Source Server         : MAC
 Source Server Type    : MySQL
 Source Server Version : 50505
 Source Host           : localhost
 Source Database       : db_rsukramatjati_dev

 Target Server Type    : MySQL
 Target Server Version : 50505
 File Encoding         : utf-8

 Date: 03/19/2018 12:38:38 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `usere` text,
  `passworde` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `akun_bayar`
-- ----------------------------
DROP TABLE IF EXISTS `akun_bayar`;
CREATE TABLE `akun_bayar` (
  `nama_bayar` varchar(50) NOT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  `ppn` double DEFAULT NULL,
  PRIMARY KEY (`nama_bayar`),
  KEY `akun_bayar_ibfk_1` (`kd_rek`),
  CONSTRAINT `akun_bayar_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `akun_piutang`
-- ----------------------------
DROP TABLE IF EXISTS `akun_piutang`;
CREATE TABLE `akun_piutang` (
  `nama_bayar` varchar(50) NOT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  `kd_pj` char(3) DEFAULT NULL,
  PRIMARY KEY (`nama_bayar`),
  UNIQUE KEY `kd_rek_2` (`kd_rek`,`kd_pj`),
  KEY `kd_rek` (`kd_rek`),
  KEY `kd_pj` (`kd_pj`),
  CONSTRAINT `akun_piutang_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `akun_piutang_ibfk_2` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `ambil_dankes`
-- ----------------------------
DROP TABLE IF EXISTS `ambil_dankes`;
CREATE TABLE `ambil_dankes` (
  `id` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `ktg` varchar(50) NOT NULL,
  `dankes` double NOT NULL,
  PRIMARY KEY (`id`,`tanggal`),
  KEY `ktg` (`ktg`),
  KEY `dankes` (`dankes`),
  CONSTRAINT `ambil_dankes_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `angsuran_koperasi`
-- ----------------------------
DROP TABLE IF EXISTS `angsuran_koperasi`;
CREATE TABLE `angsuran_koperasi` (
  `id` int(11) NOT NULL,
  `tanggal_pinjam` date NOT NULL,
  `tanggal_angsur` date NOT NULL,
  `pokok` double NOT NULL,
  `jasa` double NOT NULL,
  PRIMARY KEY (`id`,`tanggal_pinjam`,`tanggal_angsur`),
  KEY `id` (`id`),
  KEY `pokok` (`pokok`),
  KEY `jasa` (`jasa`),
  CONSTRAINT `angsuran_koperasi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `antriloket`
-- ----------------------------
DROP TABLE IF EXISTS `antriloket`;
CREATE TABLE `antriloket` (
  `loket` int(11) NOT NULL,
  `antrian` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

-- ----------------------------
--  Table structure for `aplicare_ketersediaan_kamar`
-- ----------------------------
DROP TABLE IF EXISTS `aplicare_ketersediaan_kamar`;
CREATE TABLE `aplicare_ketersediaan_kamar` (
  `kode_kelas_aplicare` varchar(15) NOT NULL DEFAULT '',
  `kd_bangsal` char(5) NOT NULL DEFAULT '',
  `kelas` enum('Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP','ISO') NOT NULL DEFAULT 'Kelas 1',
  `kapasitas` int(11) DEFAULT NULL,
  `tersedia` int(11) DEFAULT NULL,
  `tersediapria` int(11) DEFAULT NULL,
  `tersediawanita` int(11) DEFAULT NULL,
  `tersediapriawanita` int(11) DEFAULT NULL,
  PRIMARY KEY (`kode_kelas_aplicare`,`kd_bangsal`,`kelas`),
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `aplicare_ketersediaan_kamar_ibfk_1` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `asuransi`
-- ----------------------------
DROP TABLE IF EXISTS `asuransi`;
CREATE TABLE `asuransi` (
  `stts` char(5) NOT NULL,
  `biaya` double NOT NULL,
  PRIMARY KEY (`stts`),
  KEY `biaya` (`biaya`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `aturan_pakai`
-- ----------------------------
DROP TABLE IF EXISTS `aturan_pakai`;
CREATE TABLE `aturan_pakai` (
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam` time NOT NULL DEFAULT '00:00:00',
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `aturan` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`tgl_perawatan`,`jam`,`no_rawat`,`kode_brng`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `aturan_pakai_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aturan_pakai_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `bangsal`
-- ----------------------------
DROP TABLE IF EXISTS `bangsal`;
CREATE TABLE `bangsal` (
  `kd_bangsal` char(5) NOT NULL,
  `nm_bangsal` varchar(30) DEFAULT NULL,
  `status` enum('0','1') DEFAULT NULL,
  `publish` int(1) DEFAULT NULL,
  PRIMARY KEY (`kd_bangsal`),
  KEY `nm_bangsal` (`nm_bangsal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `bank`
-- ----------------------------
DROP TABLE IF EXISTS `bank`;
CREATE TABLE `bank` (
  `namabank` varchar(50) NOT NULL,
  PRIMARY KEY (`namabank`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `barcode`
-- ----------------------------
DROP TABLE IF EXISTS `barcode`;
CREATE TABLE `barcode` (
  `id` int(11) NOT NULL,
  `barcode` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `barcode` (`barcode`),
  CONSTRAINT `barcode_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `bayar_pemesanan`
-- ----------------------------
DROP TABLE IF EXISTS `bayar_pemesanan`;
CREATE TABLE `bayar_pemesanan` (
  `tgl_bayar` date DEFAULT NULL,
  `no_faktur` varchar(20) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `besar_bayar` double DEFAULT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  `nama_bayar` varchar(50) DEFAULT NULL,
  `no_bukti` varchar(20) DEFAULT NULL,
  UNIQUE KEY `tgl_bayar` (`tgl_bayar`,`no_faktur`),
  KEY `bayar_pemesanan_ibfk_2` (`nip`),
  KEY `bayar_pemesanan_ibfk_3` (`nama_bayar`),
  KEY `bayar_pemesanan_ibfk_1` (`no_faktur`),
  CONSTRAINT `bayar_pemesanan_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `pemesanan` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bayar_pemesanan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bayar_pemesanan_ibfk_3` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar` (`nama_bayar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `bayar_piutang`
-- ----------------------------
DROP TABLE IF EXISTS `bayar_piutang`;
CREATE TABLE `bayar_piutang` (
  `tgl_bayar` date NOT NULL,
  `no_rkm_medis` varchar(15) NOT NULL,
  `besar_cicilan` double NOT NULL,
  `catatan` varchar(100) NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`tgl_bayar`,`no_rkm_medis`,`no_rawat`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  KEY `nota_piutang` (`no_rawat`),
  KEY `besar_cicilan` (`besar_cicilan`),
  KEY `catatan` (`catatan`),
  KEY `kd_rek` (`kd_rek`),
  CONSTRAINT `bayar_piutang_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON UPDATE CASCADE,
  CONSTRAINT `bayar_piutang_ibfk_2` FOREIGN KEY (`kd_rek`) REFERENCES `akun_bayar` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `beri_bhp_radiologi`
-- ----------------------------
DROP TABLE IF EXISTS `beri_bhp_radiologi`;
CREATE TABLE `beri_bhp_radiologi` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  `kode_sat` char(4) NOT NULL,
  `jumlah` double NOT NULL,
  `harga` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  KEY `no_rawat` (`no_rawat`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `tgl_periksa` (`tgl_periksa`),
  KEY `jam` (`jam`),
  KEY `jumlah` (`jumlah`),
  CONSTRAINT `beri_bhp_radiologi_ibfk_4` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `beri_bhp_radiologi_ibfk_5` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `beri_obat_operasi`
-- ----------------------------
DROP TABLE IF EXISTS `beri_obat_operasi`;
CREATE TABLE `beri_obat_operasi` (
  `no_rawat` varchar(17) NOT NULL,
  `tanggal` datetime NOT NULL,
  `kd_obat` varchar(15) NOT NULL,
  `hargasatuan` double NOT NULL,
  `jumlah` double NOT NULL,
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_obat` (`kd_obat`),
  KEY `tanggal` (`tanggal`),
  KEY `hargasatuan` (`hargasatuan`),
  KEY `jumlah` (`jumlah`),
  CONSTRAINT `beri_obat_operasi_ibfk_2` FOREIGN KEY (`kd_obat`) REFERENCES `obatbhp_ok` (`kd_obat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `beri_obat_operasi_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `berkas_digital_perawatan`
-- ----------------------------
DROP TABLE IF EXISTS `berkas_digital_perawatan`;
CREATE TABLE `berkas_digital_perawatan` (
  `no_rawat` varchar(17) NOT NULL,
  `kode` varchar(10) NOT NULL,
  `lokasi_file` varchar(600) DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`kode`),
  KEY `kode` (`kode`) USING BTREE,
  CONSTRAINT `berkas_digital_perawatan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `berkas_digital_perawatan_ibfk_2` FOREIGN KEY (`kode`) REFERENCES `master_berkas_digital` (`kode`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `biaya_harian`
-- ----------------------------
DROP TABLE IF EXISTS `biaya_harian`;
CREATE TABLE `biaya_harian` (
  `kd_kamar` varchar(15) NOT NULL,
  `nama_biaya` varchar(50) NOT NULL,
  `besar_biaya` double NOT NULL,
  `jml` int(11) NOT NULL,
  PRIMARY KEY (`kd_kamar`,`nama_biaya`),
  KEY `besar_biaya` (`besar_biaya`),
  KEY `jml` (`jml`),
  CONSTRAINT `biaya_harian_ibfk_1` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `biaya_sekali`
-- ----------------------------
DROP TABLE IF EXISTS `biaya_sekali`;
CREATE TABLE `biaya_sekali` (
  `kd_kamar` varchar(15) NOT NULL,
  `nama_biaya` varchar(50) NOT NULL,
  `besar_biaya` double NOT NULL,
  PRIMARY KEY (`kd_kamar`,`nama_biaya`),
  KEY `kd_kamar` (`kd_kamar`),
  KEY `besar_biaya` (`besar_biaya`),
  CONSTRAINT `biaya_sekali_ibfk_1` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `bidang`
-- ----------------------------
DROP TABLE IF EXISTS `bidang`;
CREATE TABLE `bidang` (
  `nama` varchar(15) NOT NULL,
  PRIMARY KEY (`nama`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `billing`
-- ----------------------------
DROP TABLE IF EXISTS `billing`;
CREATE TABLE `billing` (
  `noindex` int(100) NOT NULL AUTO_INCREMENT,
  `no_rawat` varchar(17) NOT NULL,
  `tgl_byr` date DEFAULT NULL,
  `no` varchar(50) NOT NULL,
  `nm_perawatan` varchar(200) NOT NULL,
  `pemisah` char(1) NOT NULL,
  `biaya` double NOT NULL,
  `jumlah` double NOT NULL,
  `tambahan` double NOT NULL,
  `totalbiaya` double NOT NULL,
  `status` enum('Laborat','Radiologi','Operasi','Obat','Ranap Dokter','Ranap Dokter Paramedis','Ranap Paramedis','Ralan Dokter','Ralan Dokter Paramedis','Ralan Paramedis','Tambahan','Potongan','Administrasi','Kamar','-','Registrasi','Harian','Service','TtlObat','TtlRanap Dokter','TtlRanap Paramedis','TtlRalan Dokter','TtlRalan Paramedis','TtlKamar','Dokter','Perawat','TtlTambahan','Retur Obat','TtlRetur Obat','Resep Pulang','TtlResep Pulang','TtlPotongan','TtlLaborat','TtlOperasi','TtlRadiologi','Tagihan') DEFAULT NULL,
  PRIMARY KEY (`noindex`),
  KEY `no_rawat` (`no_rawat`),
  KEY `status` (`status`),
  KEY `totalbiaya` (`totalbiaya`),
  KEY `nm_perawatan` (`nm_perawatan`),
  KEY `tgl_byr` (`tgl_byr`),
  KEY `no` (`no`),
  KEY `pemisah` (`pemisah`),
  KEY `biaya` (`biaya`),
  KEY `jumlah` (`jumlah`),
  KEY `tambahan` (`tambahan`),
  CONSTRAINT `billing_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=316826 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `bpjs`
-- ----------------------------
DROP TABLE IF EXISTS `bpjs`;
CREATE TABLE `bpjs` (
  `stts` char(5) NOT NULL,
  `biaya` double NOT NULL,
  PRIMARY KEY (`stts`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `bridging_dukcapil`
-- ----------------------------
DROP TABLE IF EXISTS `bridging_dukcapil`;
CREATE TABLE `bridging_dukcapil` (
  `no_rkm_medis` varchar(15) NOT NULL,
  `no_id` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`no_rkm_medis`),
  CONSTRAINT `bridging_dukcapil_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `bridging_inhealth`
-- ----------------------------
DROP TABLE IF EXISTS `bridging_inhealth`;
CREATE TABLE `bridging_inhealth` (
  `no_sjp` varchar(40) NOT NULL DEFAULT '',
  `no_rawat` varchar(17) DEFAULT NULL,
  `tglsep` datetime DEFAULT NULL,
  `tglrujukan` datetime DEFAULT NULL,
  `no_rujukan` varchar(30) DEFAULT NULL,
  `kdppkrujukan` varchar(12) DEFAULT NULL,
  `nmppkrujukan` varchar(200) DEFAULT NULL,
  `kdppkpelayanan` varchar(12) DEFAULT NULL,
  `nmppkpelayanan` varchar(200) DEFAULT NULL,
  `jnspelayanan` enum('1','2','3','4') DEFAULT NULL,
  `catatan` varchar(100) DEFAULT NULL,
  `diagawal` varchar(10) DEFAULT NULL,
  `nmdiagnosaawal` varchar(100) DEFAULT NULL,
  `diagawal2` varchar(10) NOT NULL,
  `nmdiagnosaawal2` varchar(100) NOT NULL,
  `kdpolitujuan` varchar(5) DEFAULT NULL,
  `nmpolitujuan` varchar(50) DEFAULT NULL,
  `klsrawat` enum('000','100','101','102','103','104','110','200','201','202','203','204','210','300','301','302','303','304','310','311','312','400','401','402','403','404','410','411','412','413','500','510','511','512','610','611','612','613','710','711','712','713','910','911','912','913') DEFAULT NULL,
  `klsdesc` varchar(50) DEFAULT NULL,
  `kdbu` varchar(12) DEFAULT NULL,
  `nmbu` varchar(200) DEFAULT NULL,
  `lakalantas` enum('0','1','2') DEFAULT NULL,
  `lokasilaka` varchar(100) DEFAULT NULL,
  `user` varchar(25) DEFAULT NULL,
  `nomr` varchar(15) DEFAULT NULL,
  `nama_pasien` varchar(100) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `jkel` enum('LAKI-LAKI','PEREMPUAN') DEFAULT NULL,
  `no_kartu` varchar(25) DEFAULT NULL,
  `tglpulang` datetime DEFAULT NULL,
  `plan` varchar(20) NOT NULL,
  `plandesc` varchar(100) NOT NULL,
  `idakomodasi` varchar(20) DEFAULT NULL,
  `tipesjp` varchar(20) DEFAULT NULL,
  `tipecob` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`no_sjp`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `bridging_inhealth_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `bridging_sep`
-- ----------------------------
DROP TABLE IF EXISTS `bridging_sep`;
CREATE TABLE `bridging_sep` (
  `no_sep` varchar(40) NOT NULL DEFAULT '',
  `no_rawat` varchar(17) DEFAULT NULL,
  `tglsep` datetime DEFAULT NULL,
  `tglrujukan` datetime DEFAULT NULL,
  `no_rujukan` varchar(30) DEFAULT NULL,
  `kdppkrujukan` varchar(12) DEFAULT NULL,
  `nmppkrujukan` varchar(200) DEFAULT NULL,
  `kdppkpelayanan` varchar(12) DEFAULT NULL,
  `nmppkpelayanan` varchar(200) DEFAULT NULL,
  `jnspelayanan` enum('1','2') DEFAULT NULL,
  `catatan` varchar(100) DEFAULT NULL,
  `diagawal` varchar(10) DEFAULT NULL,
  `nmdiagnosaawal` varchar(100) DEFAULT NULL,
  `kdpolitujuan` varchar(15) DEFAULT NULL,
  `nmpolitujuan` varchar(50) DEFAULT NULL,
  `klsrawat` enum('1','2','3') DEFAULT NULL,
  `lakalantas` enum('1','2','0') DEFAULT NULL,
  `lokasilaka` varchar(100) DEFAULT NULL,
  `user` varchar(25) DEFAULT NULL,
  `nomr` varchar(15) DEFAULT NULL,
  `nama_pasien` varchar(100) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `peserta` varchar(100) DEFAULT NULL,
  `jkel` enum('L','P') DEFAULT NULL,
  `no_kartu` varchar(25) DEFAULT NULL,
  `tglpulang` datetime DEFAULT NULL,
  `asal_rujukan` enum('1. Faskes 1','2. Faskes 2(RS)') NOT NULL,
  `eksekutif` enum('0. Tidak','1.Ya') NOT NULL,
  `cob` enum('0. Tidak','1.Ya') NOT NULL,
  `penjamin` varchar(15) NOT NULL,
  `notelep` varchar(20) NOT NULL,
  PRIMARY KEY (`no_sep`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `bridging_sep_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `catatan_pasien`
-- ----------------------------
DROP TABLE IF EXISTS `catatan_pasien`;
CREATE TABLE `catatan_pasien` (
  `no_rkm_medis` varchar(15) NOT NULL,
  `catatan` text,
  PRIMARY KEY (`no_rkm_medis`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  CONSTRAINT `catatan_pasien_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `closing_kasir`
-- ----------------------------
DROP TABLE IF EXISTS `closing_kasir`;
CREATE TABLE `closing_kasir` (
  `shift` enum('Pagi','Siang','Sore','Malam') NOT NULL,
  `jam_masuk` time NOT NULL,
  `jam_pulang` time NOT NULL,
  PRIMARY KEY (`shift`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `dansos`
-- ----------------------------
DROP TABLE IF EXISTS `dansos`;
CREATE TABLE `dansos` (
  `dana` double NOT NULL,
  PRIMARY KEY (`dana`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `data_hais`
-- ----------------------------
DROP TABLE IF EXISTS `data_hais`;
CREATE TABLE `data_hais` (
  `tanggal` date NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `ETT` int(11) DEFAULT NULL,
  `CVL` int(11) DEFAULT NULL,
  `IVL` int(11) DEFAULT NULL,
  `UC` int(11) DEFAULT NULL,
  `VAP` int(11) DEFAULT NULL,
  `IAD` int(11) DEFAULT NULL,
  `PLEB` int(11) DEFAULT NULL,
  `ISK` int(11) DEFAULT NULL,
  `DEKU` enum('IYA','TIDAK') DEFAULT NULL,
  `SPUTUM` varchar(200) DEFAULT NULL,
  `DARAH` varchar(200) DEFAULT NULL,
  `URINE` varchar(200) DEFAULT NULL,
  `ANTIBIOTIK` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`tanggal`,`no_rawat`),
  KEY `no_rawat` (`no_rawat`),
  KEY `ETT` (`ETT`),
  KEY `CVL` (`CVL`),
  KEY `IVL` (`IVL`),
  KEY `SPUTUM` (`SPUTUM`),
  KEY `ANTIBIOTIK` (`ANTIBIOTIK`),
  KEY `DARAH` (`DARAH`),
  KEY `URINE` (`URINE`),
  KEY `DEKU` (`DEKU`),
  KEY `ISK` (`ISK`),
  KEY `PLEB` (`PLEB`),
  KEY `IAD` (`IAD`),
  KEY `VAP` (`VAP`),
  KEY `UC` (`UC`),
  CONSTRAINT `data_HAIs_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `databarang`
-- ----------------------------
DROP TABLE IF EXISTS `databarang`;
CREATE TABLE `databarang` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `nama_brng` varchar(80) DEFAULT NULL,
  `kode_sat` char(4) DEFAULT NULL,
  `letak_barang` varchar(50) DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `ralan` double DEFAULT NULL,
  `kelas1` double DEFAULT NULL,
  `kelas2` double DEFAULT NULL,
  `kelas3` double DEFAULT NULL,
  `utama` double DEFAULT NULL,
  `vip` double DEFAULT NULL,
  `vvip` double DEFAULT NULL,
  `beliluar` double DEFAULT NULL,
  `jualbebas` double DEFAULT NULL,
  `karyawan` double DEFAULT NULL,
  `stokminimal` double DEFAULT NULL,
  `kdjns` char(4) DEFAULT NULL,
  `kapasitas` double NOT NULL,
  `expire` date DEFAULT NULL,
  `status` enum('0','1') NOT NULL,
  `kode_industri` char(5) DEFAULT NULL,
  `gol` enum('Generik','Non Generik','-') DEFAULT '-',
  PRIMARY KEY (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `kdjns` (`kdjns`),
  KEY `nama_brng` (`nama_brng`),
  KEY `letak_barang` (`letak_barang`),
  KEY `h_beli` (`h_beli`),
  KEY `h_distributor` (`ralan`),
  KEY `h_grosir` (`kelas1`),
  KEY `h_retail` (`kelas2`),
  KEY `stok` (`stokminimal`),
  KEY `kapasitas` (`kapasitas`),
  KEY `kode_industri` (`kode_industri`),
  CONSTRAINT `databarang_ibfk_2` FOREIGN KEY (`kdjns`) REFERENCES `jenis` (`kdjns`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `databarang_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `databarang_ibfk_4` FOREIGN KEY (`kode_industri`) REFERENCES `industrifarmasi` (`kode_industri`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `datasuplier`
-- ----------------------------
DROP TABLE IF EXISTS `datasuplier`;
CREATE TABLE `datasuplier` (
  `kode_suplier` char(5) NOT NULL,
  `nama_suplier` varchar(50) DEFAULT NULL,
  `alamat` varchar(50) DEFAULT NULL,
  `kota` varchar(20) DEFAULT NULL,
  `no_telp` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`kode_suplier`),
  KEY `nama_suplier` (`nama_suplier`),
  KEY `alamat` (`alamat`),
  KEY `kota` (`kota`),
  KEY `no_telp` (`no_telp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `departemen`
-- ----------------------------
DROP TABLE IF EXISTS `departemen`;
CREATE TABLE `departemen` (
  `dep_id` char(4) NOT NULL,
  `nama` varchar(25) NOT NULL,
  PRIMARY KEY (`dep_id`),
  KEY `nama` (`nama`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `deposit`
-- ----------------------------
DROP TABLE IF EXISTS `deposit`;
CREATE TABLE `deposit` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_deposit` datetime NOT NULL,
  `besar_deposit` double DEFAULT NULL,
  `nip` varchar(20) NOT NULL,
  PRIMARY KEY (`no_rawat`,`tgl_deposit`),
  KEY `nip` (`nip`),
  KEY `besar_deposit` (`besar_deposit`),
  CONSTRAINT `deposit_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `deposit_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `detail_beri_diet`
-- ----------------------------
DROP TABLE IF EXISTS `detail_beri_diet`;
CREATE TABLE `detail_beri_diet` (
  `no_rawat` varchar(17) NOT NULL,
  `kd_kamar` varchar(15) NOT NULL,
  `tanggal` date NOT NULL,
  `waktu` enum('Pagi','Siang','Sore','Malam') NOT NULL,
  `kd_diet` varchar(3) NOT NULL,
  PRIMARY KEY (`no_rawat`,`kd_kamar`,`tanggal`,`waktu`),
  KEY `kd_kamar` (`kd_kamar`),
  KEY `kd_diet` (`kd_diet`),
  KEY `tanggal` (`tanggal`),
  KEY `waktu` (`waktu`),
  CONSTRAINT `detail_beri_diet_ibfk_4` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `detail_beri_diet_ibfk_5` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `detail_beri_diet_ibfk_6` FOREIGN KEY (`kd_diet`) REFERENCES `diet` (`kd_diet`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `detail_nota_inap`
-- ----------------------------
DROP TABLE IF EXISTS `detail_nota_inap`;
CREATE TABLE `detail_nota_inap` (
  `no_rawat` varchar(17) DEFAULT NULL,
  `nama_bayar` varchar(50) DEFAULT NULL,
  `besarppn` double DEFAULT NULL,
  `besar_bayar` double DEFAULT NULL,
  KEY `no_rawat` (`no_rawat`),
  KEY `nama_bayar` (`nama_bayar`),
  CONSTRAINT `detail_nota_inap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `detail_nota_inap_ibfk_2` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar` (`nama_bayar`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `detail_nota_jalan`
-- ----------------------------
DROP TABLE IF EXISTS `detail_nota_jalan`;
CREATE TABLE `detail_nota_jalan` (
  `no_rawat` varchar(17) DEFAULT NULL,
  `nama_bayar` varchar(50) DEFAULT NULL,
  `besarppn` double DEFAULT NULL,
  `besar_bayar` double DEFAULT NULL,
  KEY `no_rawat` (`no_rawat`),
  KEY `nama_bayar` (`nama_bayar`),
  CONSTRAINT `detail_nota_jalan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `detail_nota_jalan_ibfk_2` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar` (`nama_bayar`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `detail_pemberian_obat`
-- ----------------------------
DROP TABLE IF EXISTS `detail_pemberian_obat`;
CREATE TABLE `detail_pemberian_obat` (
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam` time NOT NULL DEFAULT '00:00:00',
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL,
  `h_beli` double DEFAULT NULL,
  `biaya_obat` double DEFAULT NULL,
  `jml` double NOT NULL,
  `embalase` double DEFAULT NULL,
  `tuslah` double DEFAULT NULL,
  `total` double NOT NULL,
  `status` enum('Ralan','Ranap') DEFAULT NULL,
  PRIMARY KEY (`tgl_perawatan`,`jam`,`no_rawat`,`kode_brng`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_obat` (`kode_brng`),
  KEY `tgl_perawatan` (`tgl_perawatan`),
  KEY `jam` (`jam`),
  KEY `jml` (`jml`),
  KEY `tambahan` (`embalase`),
  KEY `total` (`total`),
  KEY `biaya_obat` (`biaya_obat`),
  CONSTRAINT `detail_pemberian_obat_ibfk_3` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_pemberian_obat_ibfk_4` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `detail_periksa_lab`
-- ----------------------------
DROP TABLE IF EXISTS `detail_periksa_lab`;
CREATE TABLE `detail_periksa_lab` (
  `no_rawat` varchar(17) NOT NULL,
  `kd_jenis_prw` varchar(15) NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `id_template` int(11) NOT NULL,
  `nilai` varchar(60) NOT NULL,
  `nilai_rujukan` varchar(20) NOT NULL,
  `keterangan` varchar(60) NOT NULL,
  `bagian_rs` double NOT NULL,
  `bhp` double NOT NULL,
  `bagian_perujuk` double NOT NULL,
  `bagian_dokter` double NOT NULL,
  `bagian_laborat` double NOT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya_item` double NOT NULL,
  PRIMARY KEY (`no_rawat`,`kd_jenis_prw`,`tgl_periksa`,`jam`,`id_template`),
  KEY `id_template` (`id_template`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `tgl_periksa` (`tgl_periksa`),
  KEY `jam` (`jam`),
  KEY `nilai` (`nilai`),
  KEY `nilai_rujukan` (`nilai_rujukan`),
  KEY `keterangan` (`keterangan`),
  KEY `biaya_item` (`biaya_item`),
  CONSTRAINT `detail_periksa_lab_ibfk_10` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `detail_periksa_lab_ibfk_11` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_periksa_lab_ibfk_12` FOREIGN KEY (`id_template`) REFERENCES `template_laboratorium` (`id_template`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `detail_periksa_lab_rujukan`
-- ----------------------------
DROP TABLE IF EXISTS `detail_periksa_lab_rujukan`;
CREATE TABLE `detail_periksa_lab_rujukan` (
  `no_lab` varchar(17) NOT NULL,
  `kd_jenis_prw` varchar(15) NOT NULL,
  `id_template` int(11) NOT NULL,
  `nilai` varchar(60) NOT NULL,
  `nilai_rujukan` varchar(20) NOT NULL,
  `keterangan` varchar(60) NOT NULL,
  `bagian_rs` double NOT NULL,
  `bhp` double NOT NULL,
  `bagian_perujuk` double NOT NULL,
  `bagian_dokter` double NOT NULL,
  `bagian_laborat` double NOT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya_item` double NOT NULL,
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `no_lab` (`no_lab`),
  KEY `id_template` (`id_template`),
  CONSTRAINT `detail_periksa_lab_rujukan_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_periksa_lab_rujukan_ibfk_2` FOREIGN KEY (`no_lab`) REFERENCES `pendaftaran_lab_rujukan` (`no_lab`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_periksa_lab_rujukan_ibfk_3` FOREIGN KEY (`id_template`) REFERENCES `template_laboratorium` (`id_template`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `detail_piutang_pasien`
-- ----------------------------
DROP TABLE IF EXISTS `detail_piutang_pasien`;
CREATE TABLE `detail_piutang_pasien` (
  `no_rawat` varchar(17) DEFAULT NULL,
  `nama_bayar` varchar(50) DEFAULT NULL,
  `kd_pj` char(3) DEFAULT NULL,
  `totalpiutang` double DEFAULT NULL,
  `sisapiutang` double DEFAULT NULL,
  `tgltempo` date DEFAULT NULL,
  KEY `no_rawat` (`no_rawat`),
  KEY `nama_bayar` (`nama_bayar`),
  KEY `kd_pj` (`kd_pj`),
  CONSTRAINT `detail_piutang_pasien_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `detail_piutang_pasien_ibfk_2` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_piutang` (`nama_bayar`) ON UPDATE CASCADE,
  CONSTRAINT `detail_piutang_pasien_ibfk_3` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `detailbeli`
-- ----------------------------
DROP TABLE IF EXISTS `detailbeli`;
CREATE TABLE `detailbeli` (
  `no_faktur` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `dis` double NOT NULL,
  `besardis` double NOT NULL,
  `total` double NOT NULL,
  `no_batch` varchar(10) NOT NULL,
  `jumlah2` double DEFAULT NULL,
  PRIMARY KEY (`no_faktur`,`kode_brng`),
  KEY `no_faktur` (`no_faktur`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `jumlah` (`jumlah`),
  KEY `h_beli` (`h_beli`),
  KEY `subtotal` (`subtotal`),
  KEY `dis` (`dis`),
  KEY `besardis` (`besardis`),
  KEY `total` (`total`),
  KEY `kode_sat_2` (`kode_sat`),
  CONSTRAINT `detailbeli_ibfk_5` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detailbeli_ibfk_6` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `detailbeli_ibfk_7` FOREIGN KEY (`no_faktur`) REFERENCES `pembelian` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `detailjual`
-- ----------------------------
DROP TABLE IF EXISTS `detailjual`;
CREATE TABLE `detailjual` (
  `nota_jual` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `h_jual` double DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `dis` double DEFAULT NULL,
  `bsr_dis` double DEFAULT NULL,
  `tambahan` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`nota_jual`,`kode_brng`),
  KEY `nota_jual` (`nota_jual`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `h_jual` (`h_jual`),
  KEY `h_beli` (`h_beli`),
  KEY `jumlah` (`jumlah`),
  KEY `subtotal` (`subtotal`),
  KEY `dis` (`dis`),
  KEY `bsr_dis` (`bsr_dis`),
  KEY `tambahan` (`tambahan`),
  KEY `total` (`total`),
  CONSTRAINT `detailjual_ibfk_1` FOREIGN KEY (`nota_jual`) REFERENCES `penjualan` (`nota_jual`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detailjual_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `detailjurnal`
-- ----------------------------
DROP TABLE IF EXISTS `detailjurnal`;
CREATE TABLE `detailjurnal` (
  `no_jurnal` varchar(20) DEFAULT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  `debet` double DEFAULT NULL,
  `kredit` double DEFAULT NULL,
  KEY `no_jurnal` (`no_jurnal`),
  KEY `kd_rek` (`kd_rek`),
  KEY `debet` (`debet`),
  KEY `kredit` (`kredit`),
  CONSTRAINT `detailjurnal_ibfk_1` FOREIGN KEY (`no_jurnal`) REFERENCES `jurnal` (`no_jurnal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detailjurnal_ibfk_2` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `detailpesan`
-- ----------------------------
DROP TABLE IF EXISTS `detailpesan`;
CREATE TABLE `detailpesan` (
  `no_faktur` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `h_pesan` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `dis` double NOT NULL,
  `besardis` double NOT NULL,
  `total` double NOT NULL,
  `no_batch` varchar(10) NOT NULL,
  `jumlah2` double DEFAULT NULL,
  PRIMARY KEY (`no_faktur`,`kode_brng`),
  KEY `no_faktur` (`no_faktur`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `jumlah` (`jumlah`),
  KEY `h_pesan` (`h_pesan`),
  KEY `subtotal` (`subtotal`),
  KEY `dis` (`dis`),
  KEY `besardis` (`besardis`),
  KEY `total` (`total`),
  CONSTRAINT `detailpesan_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detailpesan_ibfk_2` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `detailpesan_ibfk_3` FOREIGN KEY (`no_faktur`) REFERENCES `pemesanan` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `detailpiutang`
-- ----------------------------
DROP TABLE IF EXISTS `detailpiutang`;
CREATE TABLE `detailpiutang` (
  `nota_piutang` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `h_jual` double DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `dis` double DEFAULT NULL,
  `bsr_dis` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`nota_piutang`,`kode_brng`),
  KEY `nota_jual` (`nota_piutang`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `h_jual` (`h_jual`),
  KEY `h_beli` (`h_beli`),
  KEY `jumlah` (`jumlah`),
  KEY `subtotal` (`subtotal`),
  KEY `dis` (`dis`),
  KEY `bsr_dis` (`bsr_dis`),
  KEY `total` (`total`),
  CONSTRAINT `detailpiutang_ibfk_1` FOREIGN KEY (`nota_piutang`) REFERENCES `piutang` (`nota_piutang`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detailpiutang_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `detreturbeli`
-- ----------------------------
DROP TABLE IF EXISTS `detreturbeli`;
CREATE TABLE `detreturbeli` (
  `no_retur_beli` varchar(20) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `jml_beli` double DEFAULT NULL,
  `h_retur` double DEFAULT NULL,
  `jml_retur` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `no_batch` varchar(10) NOT NULL,
  `jml_retur2` double DEFAULT NULL,
  PRIMARY KEY (`no_retur_beli`,`no_faktur`,`kode_brng`),
  KEY `no_retur_beli` (`no_retur_beli`),
  KEY `no_faktur` (`no_faktur`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `h_beli` (`h_beli`),
  KEY `jml_beli` (`jml_beli`),
  KEY `h_retur` (`h_retur`),
  KEY `jml_retur` (`jml_retur`),
  KEY `total` (`total`),
  CONSTRAINT `detreturbeli_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detreturbeli_ibfk_3` FOREIGN KEY (`no_retur_beli`) REFERENCES `returbeli` (`no_retur_beli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `detreturjual`
-- ----------------------------
DROP TABLE IF EXISTS `detreturjual`;
CREATE TABLE `detreturjual` (
  `no_retur_jual` varchar(20) NOT NULL,
  `nota_jual` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `jml_jual` double DEFAULT NULL,
  `h_jual` double DEFAULT NULL,
  `jml_retur` double DEFAULT NULL,
  `h_retur` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  KEY `no_retur_jual` (`no_retur_jual`),
  KEY `nota_jual` (`nota_jual`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `jml_jual` (`jml_jual`),
  KEY `h_jual` (`h_jual`),
  KEY `jml_retur` (`jml_retur`),
  KEY `h_retur` (`h_retur`),
  KEY `subtotal` (`subtotal`),
  CONSTRAINT `detreturjual_ibfk_1` FOREIGN KEY (`no_retur_jual`) REFERENCES `returjual` (`no_retur_jual`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detreturjual_ibfk_3` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `detreturpiutang`
-- ----------------------------
DROP TABLE IF EXISTS `detreturpiutang`;
CREATE TABLE `detreturpiutang` (
  `no_retur_piutang` varchar(20) NOT NULL,
  `nota_piutang` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `jml_piutang` double DEFAULT NULL,
  `h_piutang` double DEFAULT NULL,
  `jml_retur` double DEFAULT NULL,
  `h_retur` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  PRIMARY KEY (`no_retur_piutang`,`nota_piutang`,`kode_brng`),
  KEY `no_retur_piutang` (`no_retur_piutang`),
  KEY `nota_piutang` (`nota_piutang`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `jml_piutang` (`jml_piutang`),
  KEY `h_piutang` (`h_piutang`),
  KEY `jml_retur` (`jml_retur`),
  KEY `h_retur` (`h_retur`),
  KEY `subtotal` (`subtotal`),
  CONSTRAINT `detreturpiutang_ibfk_4` FOREIGN KEY (`no_retur_piutang`) REFERENCES `returpiutang` (`no_retur_piutang`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detreturpiutang_ibfk_5` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `diagnosa_pasien`
-- ----------------------------
DROP TABLE IF EXISTS `diagnosa_pasien`;
CREATE TABLE `diagnosa_pasien` (
  `no_rawat` varchar(17) NOT NULL,
  `kd_penyakit` varchar(10) NOT NULL,
  `status` enum('Ralan','Ranap') NOT NULL,
  `prioritas` tinyint(4) NOT NULL,
  PRIMARY KEY (`no_rawat`,`kd_penyakit`,`status`),
  KEY `kd_penyakit` (`kd_penyakit`),
  KEY `status` (`status`),
  KEY `prioritas` (`prioritas`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `diagnosa_pasien_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `diagnosa_pasien_ibfk_2` FOREIGN KEY (`kd_penyakit`) REFERENCES `penyakit` (`kd_penyakit`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `diet`
-- ----------------------------
DROP TABLE IF EXISTS `diet`;
CREATE TABLE `diet` (
  `kd_diet` varchar(3) NOT NULL,
  `nama_diet` varchar(50) NOT NULL,
  PRIMARY KEY (`kd_diet`),
  KEY `nama_diet` (`nama_diet`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `dokter`
-- ----------------------------
DROP TABLE IF EXISTS `dokter`;
CREATE TABLE `dokter` (
  `kd_dokter` varchar(20) NOT NULL,
  `nm_dokter` varchar(50) DEFAULT NULL,
  `jk` enum('L','P') DEFAULT NULL,
  `tmp_lahir` varchar(20) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `gol_drh` enum('A','B','O','AB','-') DEFAULT NULL,
  `agama` varchar(12) DEFAULT NULL,
  `almt_tgl` varchar(60) DEFAULT NULL,
  `no_telp` varchar(13) DEFAULT NULL,
  `stts_nikah` enum('SINGLE','MENIKAH','JANDA','DUDHA','JOMBLO') DEFAULT NULL,
  `kd_sps` char(5) DEFAULT NULL,
  `alumni` varchar(60) DEFAULT NULL,
  `no_ijn_praktek` varchar(40) DEFAULT NULL,
  `status` enum('0','1') NOT NULL,
  PRIMARY KEY (`kd_dokter`),
  KEY `kd_sps` (`kd_sps`),
  KEY `nm_dokter` (`nm_dokter`),
  KEY `jk` (`jk`),
  KEY `tmp_lahir` (`tmp_lahir`),
  KEY `tgl_lahir` (`tgl_lahir`),
  KEY `gol_drh` (`gol_drh`),
  KEY `agama` (`agama`),
  KEY `almt_tgl` (`almt_tgl`),
  KEY `no_telp` (`no_telp`),
  KEY `stts_nikah` (`stts_nikah`),
  KEY `alumni` (`alumni`),
  KEY `no_ijn_praktek` (`no_ijn_praktek`),
  CONSTRAINT `dokter_ibfk_2` FOREIGN KEY (`kd_sps`) REFERENCES `spesialis` (`kd_sps`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `dokter_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `pegawai` (`nik`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `dpjp_ranap`
-- ----------------------------
DROP TABLE IF EXISTS `dpjp_ranap`;
CREATE TABLE `dpjp_ranap` (
  `no_rawat` varchar(17) NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  PRIMARY KEY (`no_rawat`,`kd_dokter`),
  KEY `dpjp_ranap_ibfk_2` (`kd_dokter`),
  CONSTRAINT `dpjp_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `dpjp_ranap_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `gambar`
-- ----------------------------
DROP TABLE IF EXISTS `gambar`;
CREATE TABLE `gambar` (
  `inde` int(11) NOT NULL,
  `bpjs` longblob NOT NULL,
  PRIMARY KEY (`inde`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `gambar_radiologi`
-- ----------------------------
DROP TABLE IF EXISTS `gambar_radiologi`;
CREATE TABLE `gambar_radiologi` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `lokasi_gambar` varchar(500) NOT NULL,
  PRIMARY KEY (`no_rawat`,`tgl_periksa`,`jam`,`lokasi_gambar`(255)),
  CONSTRAINT `gambar_radiologi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `gol_obat`
-- ----------------------------
DROP TABLE IF EXISTS `gol_obat`;
CREATE TABLE `gol_obat` (
  `id_gol_obat` int(5) NOT NULL AUTO_INCREMENT,
  `nm_gol` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_gol_obat`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `gudangbarang`
-- ----------------------------
DROP TABLE IF EXISTS `gudangbarang`;
CREATE TABLE `gudangbarang` (
  `kode_brng` varchar(15) NOT NULL,
  `kd_bangsal` char(5) NOT NULL DEFAULT '',
  `stok` double NOT NULL,
  PRIMARY KEY (`kd_bangsal`,`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  KEY `stok` (`stok`),
  CONSTRAINT `gudangbarang_ibfk_1` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `gudangbarang_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `harian_kurangi_bulanan`
-- ----------------------------
DROP TABLE IF EXISTS `harian_kurangi_bulanan`;
CREATE TABLE `harian_kurangi_bulanan` (
  `harian` int(11) NOT NULL,
  `bulanan` int(11) NOT NULL,
  KEY `harian` (`harian`),
  KEY `bulanan` (`bulanan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `hasil_radiologi`
-- ----------------------------
DROP TABLE IF EXISTS `hasil_radiologi`;
CREATE TABLE `hasil_radiologi` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `hasil` text NOT NULL,
  PRIMARY KEY (`no_rawat`,`tgl_periksa`,`jam`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `hasil_radiologi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `hemodialisa`
-- ----------------------------
DROP TABLE IF EXISTS `hemodialisa`;
CREATE TABLE `hemodialisa` (
  `tanggal` datetime NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `kd_penyakit` varchar(10) NOT NULL,
  `lama` int(11) NOT NULL,
  `dialist` varchar(30) NOT NULL,
  `penarikan` double NOT NULL,
  `akses` varchar(30) NOT NULL,
  `transfusi` double NOT NULL,
  `ureum` varchar(10) NOT NULL,
  `hb` varchar(10) NOT NULL,
  `hsbag` varchar(10) NOT NULL,
  `creatinin` varchar(10) NOT NULL,
  `gds` varchar(10) NOT NULL,
  `ctbt` varchar(10) NOT NULL,
  `lain` varchar(200) NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  PRIMARY KEY (`tanggal`,`no_rawat`),
  KEY `kd_penyakit` (`kd_penyakit`),
  KEY `kd_dokter` (`kd_dokter`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `hemodialisa_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `hemodialisa_ibfk_2` FOREIGN KEY (`kd_penyakit`) REFERENCES `penyakit` (`kd_penyakit`) ON UPDATE CASCADE,
  CONSTRAINT `hemodialisa_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `icd9`
-- ----------------------------
DROP TABLE IF EXISTS `icd9`;
CREATE TABLE `icd9` (
  `kode` varchar(8) NOT NULL,
  `deskripsi_panjang` varchar(250) DEFAULT NULL,
  `deskripsi_pendek` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `inacbg_coder_nik`
-- ----------------------------
DROP TABLE IF EXISTS `inacbg_coder_nik`;
CREATE TABLE `inacbg_coder_nik` (
  `nik` varchar(20) NOT NULL,
  `no_ik` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`nik`),
  CONSTRAINT `inacbg_coder_nik_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `inacbg_data_terkirim`
-- ----------------------------
DROP TABLE IF EXISTS `inacbg_data_terkirim`;
CREATE TABLE `inacbg_data_terkirim` (
  `no_sep` varchar(40) NOT NULL,
  `nik` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no_sep`),
  CONSTRAINT `inacbg_data_terkirim_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `inacbg_data_terkirim2`
-- ----------------------------
DROP TABLE IF EXISTS `inacbg_data_terkirim2`;
CREATE TABLE `inacbg_data_terkirim2` (
  `no_sep` varchar(40) NOT NULL,
  `nik` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no_sep`),
  CONSTRAINT `inacbg_data_terkirim2_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `inacbg_klaim_baru2` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `inacbg_grouping_stage1`
-- ----------------------------
DROP TABLE IF EXISTS `inacbg_grouping_stage1`;
CREATE TABLE `inacbg_grouping_stage1` (
  `no_sep` varchar(40) NOT NULL,
  `code_cbg` varchar(10) DEFAULT NULL,
  `deskripsi` varchar(200) DEFAULT NULL,
  `tarif` double DEFAULT NULL,
  PRIMARY KEY (`no_sep`),
  CONSTRAINT `inacbg_grouping_stage1_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `inacbg_grouping_stage12`
-- ----------------------------
DROP TABLE IF EXISTS `inacbg_grouping_stage12`;
CREATE TABLE `inacbg_grouping_stage12` (
  `no_sep` varchar(40) NOT NULL,
  `code_cbg` varchar(10) DEFAULT NULL,
  `deskripsi` varchar(200) DEFAULT NULL,
  `tarif` double DEFAULT NULL,
  PRIMARY KEY (`no_sep`),
  CONSTRAINT `inacbg_grouping_stage12_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `inacbg_klaim_baru2` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `inacbg_klaim_baru`
-- ----------------------------
DROP TABLE IF EXISTS `inacbg_klaim_baru`;
CREATE TABLE `inacbg_klaim_baru` (
  `no_sep` varchar(40) NOT NULL DEFAULT '',
  `patient_id` int(11) DEFAULT NULL,
  `admission_id` int(11) DEFAULT NULL,
  `hospital_admission_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`no_sep`),
  CONSTRAINT `inacbg_klaim_baru_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `inacbg_klaim_baru2`
-- ----------------------------
DROP TABLE IF EXISTS `inacbg_klaim_baru2`;
CREATE TABLE `inacbg_klaim_baru2` (
  `no_rawat` varchar(17) NOT NULL,
  `no_sep` varchar(40) NOT NULL DEFAULT '',
  `patient_id` int(11) DEFAULT NULL,
  `admission_id` int(11) DEFAULT NULL,
  `hospital_admission_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`no_rawat`),
  UNIQUE KEY `no_sep` (`no_sep`) USING BTREE,
  CONSTRAINT `inacbg_klaim_baru2_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `indekref`
-- ----------------------------
DROP TABLE IF EXISTS `indekref`;
CREATE TABLE `indekref` (
  `kdindex` char(4) NOT NULL,
  `n` double NOT NULL,
  `ttl` double NOT NULL,
  KEY `kdindex` (`kdindex`),
  KEY `n` (`n`),
  KEY `ttl` (`ttl`),
  CONSTRAINT `indekref_ibfk_1` FOREIGN KEY (`kdindex`) REFERENCES `departemen` (`dep_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `indexins`
-- ----------------------------
DROP TABLE IF EXISTS `indexins`;
CREATE TABLE `indexins` (
  `dep_id` char(4) NOT NULL,
  `persen` double NOT NULL,
  PRIMARY KEY (`dep_id`),
  KEY `persen` (`persen`),
  CONSTRAINT `indexins_ibfk_1` FOREIGN KEY (`dep_id`) REFERENCES `departemen` (`dep_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `indextotal`
-- ----------------------------
DROP TABLE IF EXISTS `indextotal`;
CREATE TABLE `indextotal` (
  `kdindex` char(4) NOT NULL,
  `ttl` double NOT NULL,
  KEY `kdindex` (`kdindex`),
  KEY `ttl` (`ttl`),
  CONSTRAINT `indextotal_ibfk_1` FOREIGN KEY (`kdindex`) REFERENCES `departemen` (`dep_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `indikator_pelayanankesehatan`
-- ----------------------------
DROP TABLE IF EXISTS `indikator_pelayanankesehatan`;
CREATE TABLE `indikator_pelayanankesehatan` (
  `id_indikatorpelkes` int(5) NOT NULL AUTO_INCREMENT,
  `bulan` varchar(2) DEFAULT NULL,
  `tahun` varchar(4) NOT NULL,
  `bor` decimal(6,2) NOT NULL,
  `alos` decimal(6,2) NOT NULL,
  `bto` decimal(6,2) NOT NULL,
  `toi` decimal(6,2) NOT NULL,
  `ndr` decimal(6,2) NOT NULL,
  `gdr` decimal(6,2) NOT NULL,
  `kunjungan_perhari` decimal(6,2) NOT NULL,
  `status` enum('Pending','Send') DEFAULT 'Pending',
  PRIMARY KEY (`id_indikatorpelkes`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `industrifarmasi`
-- ----------------------------
DROP TABLE IF EXISTS `industrifarmasi`;
CREATE TABLE `industrifarmasi` (
  `kode_industri` char(5) NOT NULL DEFAULT '',
  `nama_industri` varchar(50) DEFAULT NULL,
  `alamat` varchar(50) DEFAULT NULL,
  `kota` varchar(20) DEFAULT NULL,
  `no_telp` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kode_industri`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `inhealth_jenpel_ruang_rawat`
-- ----------------------------
DROP TABLE IF EXISTS `inhealth_jenpel_ruang_rawat`;
CREATE TABLE `inhealth_jenpel_ruang_rawat` (
  `kd_kamar` varchar(15) NOT NULL,
  `kode_jenpel_ruang_rawat` varchar(20) NOT NULL,
  `nama_jenpel_ruang_rawat` varchar(100) DEFAULT NULL,
  `tarif` double NOT NULL,
  PRIMARY KEY (`kd_kamar`),
  CONSTRAINT `inhealth_jenpel_ruang_rawat_ibfk_1` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `inventaris`
-- ----------------------------
DROP TABLE IF EXISTS `inventaris`;
CREATE TABLE `inventaris` (
  `no_inventaris` varchar(20) NOT NULL,
  `kode_barang` varchar(20) DEFAULT NULL,
  `asal_barang` enum('Beli','Bantuan','Hibah','-') DEFAULT NULL,
  `tgl_pengadaan` date DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `status_barang` enum('Ada','Rusak','Hilang','Perbaikan','Dipinjam','-') DEFAULT NULL,
  `id_ruang` char(5) DEFAULT NULL,
  `no_rak` char(3) DEFAULT NULL,
  `no_box` char(3) DEFAULT NULL,
  PRIMARY KEY (`no_inventaris`),
  KEY `kode_barang` (`kode_barang`),
  KEY `kd_ruang` (`id_ruang`),
  KEY `asal_barang` (`asal_barang`),
  KEY `tgl_pengadaan` (`tgl_pengadaan`),
  KEY `harga` (`harga`),
  KEY `status_barang` (`status_barang`),
  KEY `no_rak` (`no_rak`),
  KEY `no_box` (`no_box`),
  CONSTRAINT `inventaris_ibfk_1` FOREIGN KEY (`kode_barang`) REFERENCES `inventaris_barang` (`kode_barang`) ON UPDATE CASCADE,
  CONSTRAINT `inventaris_ibfk_2` FOREIGN KEY (`id_ruang`) REFERENCES `inventaris_ruang` (`id_ruang`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `inventaris_barang`
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_barang`;
CREATE TABLE `inventaris_barang` (
  `kode_barang` varchar(20) NOT NULL,
  `nama_barang` varchar(60) DEFAULT NULL,
  `jml_barang` int(11) DEFAULT NULL,
  `kode_produsen` varchar(10) DEFAULT NULL,
  `id_merk` varchar(7) DEFAULT NULL,
  `thn_produksi` year(4) DEFAULT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `id_kategori` char(5) DEFAULT NULL,
  `id_jenis` char(5) DEFAULT NULL,
  PRIMARY KEY (`kode_barang`),
  KEY `kode_produsen` (`kode_produsen`),
  KEY `id_merk` (`id_merk`),
  KEY `id_kategori` (`id_kategori`),
  KEY `id_jenis` (`id_jenis`),
  KEY `nama_barang` (`nama_barang`),
  KEY `jml_barang` (`jml_barang`),
  KEY `thn_produksi` (`thn_produksi`),
  KEY `isbn` (`isbn`),
  CONSTRAINT `inventaris_barang_ibfk_5` FOREIGN KEY (`kode_produsen`) REFERENCES `inventaris_produsen` (`kode_produsen`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `inventaris_barang_ibfk_6` FOREIGN KEY (`id_merk`) REFERENCES `inventaris_merk` (`id_merk`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `inventaris_barang_ibfk_7` FOREIGN KEY (`id_kategori`) REFERENCES `inventaris_kategori` (`id_kategori`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `inventaris_barang_ibfk_8` FOREIGN KEY (`id_jenis`) REFERENCES `inventaris_jenis` (`id_jenis`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `inventaris_jenis`
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_jenis`;
CREATE TABLE `inventaris_jenis` (
  `id_jenis` char(5) NOT NULL,
  `nama_jenis` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_jenis`),
  KEY `nama_jenis` (`nama_jenis`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `inventaris_kategori`
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_kategori`;
CREATE TABLE `inventaris_kategori` (
  `id_kategori` char(5) NOT NULL,
  `nama_kategori` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id_kategori`),
  KEY `nama_kategori` (`nama_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `inventaris_merk`
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_merk`;
CREATE TABLE `inventaris_merk` (
  `id_merk` varchar(7) NOT NULL,
  `nama_merk` varchar(40) NOT NULL,
  PRIMARY KEY (`id_merk`),
  KEY `nama_merk` (`nama_merk`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `inventaris_peminjaman`
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_peminjaman`;
CREATE TABLE `inventaris_peminjaman` (
  `peminjam` varchar(50) NOT NULL DEFAULT '',
  `tlp` varchar(13) NOT NULL,
  `no_inventaris` varchar(20) NOT NULL DEFAULT '',
  `tgl_pinjam` date NOT NULL DEFAULT '0000-00-00',
  `tgl_kembali` date DEFAULT NULL,
  `nip` varchar(20) NOT NULL DEFAULT '',
  `status_pinjam` enum('Masih Dipinjam','Sudah Kembali') DEFAULT NULL,
  PRIMARY KEY (`peminjam`,`no_inventaris`,`tgl_pinjam`,`nip`),
  KEY `no_inventaris` (`no_inventaris`),
  KEY `nip` (`nip`),
  KEY `tgl_kembali` (`tgl_kembali`),
  KEY `status_pinjam` (`status_pinjam`),
  CONSTRAINT `inventaris_peminjaman_ibfk_1` FOREIGN KEY (`no_inventaris`) REFERENCES `inventaris` (`no_inventaris`) ON UPDATE CASCADE,
  CONSTRAINT `inventaris_peminjaman_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `inventaris_produsen`
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_produsen`;
CREATE TABLE `inventaris_produsen` (
  `kode_produsen` varchar(10) NOT NULL,
  `nama_produsen` varchar(40) DEFAULT NULL,
  `alamat_produsen` varchar(70) DEFAULT NULL,
  `no_telp` varchar(13) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  `website_produsen` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`kode_produsen`),
  KEY `nama_produsen` (`nama_produsen`),
  KEY `alamat_produsen` (`alamat_produsen`),
  KEY `no_telp` (`no_telp`),
  KEY `email` (`email`),
  KEY `website_produsen` (`website_produsen`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `inventaris_ruang`
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_ruang`;
CREATE TABLE `inventaris_ruang` (
  `id_ruang` varchar(5) NOT NULL,
  `nama_ruang` varchar(40) NOT NULL,
  PRIMARY KEY (`id_ruang`),
  KEY `nama_ruang` (`nama_ruang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `ipsrsbarang`
-- ----------------------------
DROP TABLE IF EXISTS `ipsrsbarang`;
CREATE TABLE `ipsrsbarang` (
  `kode_brng` varchar(15) NOT NULL,
  `nama_brng` varchar(80) NOT NULL,
  `kode_sat` char(4) NOT NULL,
  `jenis` char(5) DEFAULT NULL,
  `stok` double NOT NULL,
  `harga` double NOT NULL,
  PRIMARY KEY (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `nama_brng` (`nama_brng`),
  KEY `jenis` (`jenis`(1)),
  KEY `stok` (`stok`),
  KEY `harga` (`harga`),
  KEY `jenis_2` (`jenis`),
  CONSTRAINT `ipsrsbarang_ibfk_1` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `ipsrsbarang_ibfk_2` FOREIGN KEY (`jenis`) REFERENCES `ipsrsjenisbarang` (`kd_jenis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `ipsrsdetailbeli`
-- ----------------------------
DROP TABLE IF EXISTS `ipsrsdetailbeli`;
CREATE TABLE `ipsrsdetailbeli` (
  `no_faktur` varchar(15) NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  `kode_sat` char(4) NOT NULL,
  `jumlah` double NOT NULL,
  `harga` double NOT NULL,
  `subtotal` double NOT NULL,
  `dis` double NOT NULL,
  `besardis` double NOT NULL,
  `total` double NOT NULL,
  PRIMARY KEY (`no_faktur`,`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `kode_brng` (`kode_brng`),
  KEY `jumlah` (`jumlah`),
  KEY `harga` (`harga`),
  KEY `subtotal` (`subtotal`),
  KEY `dis` (`dis`),
  KEY `besardis` (`besardis`),
  KEY `total` (`total`),
  CONSTRAINT `ipsrsdetailbeli_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `ipsrspembelian` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ipsrsdetailbeli_ibfk_4` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `ipsrsdetailbeli_ibfk_5` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `ipsrsdetailpengeluaran`
-- ----------------------------
DROP TABLE IF EXISTS `ipsrsdetailpengeluaran`;
CREATE TABLE `ipsrsdetailpengeluaran` (
  `no_keluar` varchar(8) NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  `kode_sat` char(4) NOT NULL,
  `jumlah` double NOT NULL,
  `harga` double NOT NULL,
  `total` double NOT NULL,
  PRIMARY KEY (`no_keluar`,`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `kode_brng` (`kode_brng`),
  KEY `jumlah` (`jumlah`),
  KEY `harga` (`harga`),
  KEY `total` (`total`),
  CONSTRAINT `ipsrsdetailpengeluaran_ibfk_1` FOREIGN KEY (`no_keluar`) REFERENCES `ipsrspengeluaran` (`no_keluar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ipsrsdetailpengeluaran_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `ipsrsdetailpengeluaran_ibfk_4` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `ipsrsjenisbarang`
-- ----------------------------
DROP TABLE IF EXISTS `ipsrsjenisbarang`;
CREATE TABLE `ipsrsjenisbarang` (
  `kd_jenis` char(5) NOT NULL,
  `nm_jenis` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`kd_jenis`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `ipsrspembelian`
-- ----------------------------
DROP TABLE IF EXISTS `ipsrspembelian`;
CREATE TABLE `ipsrspembelian` (
  `no_faktur` varchar(15) NOT NULL,
  `kode_suplier` char(5) NOT NULL,
  `nip` varchar(20) NOT NULL,
  `tgl_beli` date NOT NULL,
  `subtotal` double NOT NULL,
  `potongan` double NOT NULL,
  `total` double NOT NULL,
  `ppn` double DEFAULT NULL,
  `tagihan` double DEFAULT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`no_faktur`),
  KEY `kode_suplier` (`kode_suplier`),
  KEY `nip` (`nip`),
  KEY `tgl_beli` (`tgl_beli`),
  KEY `subtotal` (`subtotal`),
  KEY `potongan` (`potongan`),
  KEY `total` (`total`),
  KEY `ipsrspembelian_ibfk_5` (`kd_rek`),
  CONSTRAINT `ipsrspembelian_ibfk_4` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ipsrspembelian_ibfk_5` FOREIGN KEY (`kd_rek`) REFERENCES `akun_bayar` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ipsrspembelian_ibfk_6` FOREIGN KEY (`kode_suplier`) REFERENCES `ipsrssuplier` (`kode_suplier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `ipsrspengeluaran`
-- ----------------------------
DROP TABLE IF EXISTS `ipsrspengeluaran`;
CREATE TABLE `ipsrspengeluaran` (
  `no_keluar` varchar(8) NOT NULL,
  `tanggal` date NOT NULL,
  `nip` varchar(20) NOT NULL,
  `keterangan` varchar(100) NOT NULL,
  PRIMARY KEY (`no_keluar`),
  KEY `nip` (`nip`),
  KEY `tanggal` (`tanggal`),
  KEY `keterangan` (`keterangan`),
  CONSTRAINT `ipsrspengeluaran_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `ipsrssuplier`
-- ----------------------------
DROP TABLE IF EXISTS `ipsrssuplier`;
CREATE TABLE `ipsrssuplier` (
  `kode_suplier` char(5) NOT NULL,
  `nama_suplier` varchar(50) DEFAULT NULL,
  `alamat` varchar(50) DEFAULT NULL,
  `kota` varchar(20) DEFAULT NULL,
  `no_telp` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`kode_suplier`),
  KEY `nama_suplier` (`nama_suplier`),
  KEY `alamat` (`alamat`),
  KEY `kota` (`kota`),
  KEY `no_telp` (`no_telp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `jabatan`
-- ----------------------------
DROP TABLE IF EXISTS `jabatan`;
CREATE TABLE `jabatan` (
  `kd_jbtn` char(4) NOT NULL DEFAULT '',
  `nm_jbtn` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`kd_jbtn`),
  KEY `nm_jbtn` (`nm_jbtn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `jadwal`
-- ----------------------------
DROP TABLE IF EXISTS `jadwal`;
CREATE TABLE `jadwal` (
  `kd_dokter` varchar(20) NOT NULL,
  `hari_kerja` enum('SENIN','SELASA','RABU','KAMIS','JUMAT','SABTU','AKHAD') NOT NULL DEFAULT 'SENIN',
  `jam_mulai` time NOT NULL DEFAULT '00:00:00',
  `jam_selesai` time DEFAULT NULL,
  `kd_poli` char(5) DEFAULT NULL,
  PRIMARY KEY (`kd_dokter`,`hari_kerja`),
  KEY `kd_dokter` (`kd_dokter`),
  KEY `kd_poli` (`kd_poli`),
  KEY `jam_mulai` (`jam_mulai`),
  KEY `jam_selesai` (`jam_selesai`),
  CONSTRAINT `jadwal_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `jadwal_ibfk_2` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `jadwal_pegawai`
-- ----------------------------
DROP TABLE IF EXISTS `jadwal_pegawai`;
CREATE TABLE `jadwal_pegawai` (
  `id` int(11) NOT NULL,
  `tahun` year(4) NOT NULL,
  `bulan` enum('01','02','03','04','05','06','07','08','09','10','11','12') NOT NULL,
  `h1` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h2` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h3` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h4` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h5` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h6` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h7` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h8` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h9` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h10` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h11` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h12` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h13` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h14` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h15` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h16` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h17` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h18` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h19` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h20` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h21` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h22` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h23` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h24` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h25` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h26` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h27` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h28` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h29` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h30` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h31` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  PRIMARY KEY (`id`,`tahun`,`bulan`),
  CONSTRAINT `jadwal_pegawai_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `jadwal_tambahan`
-- ----------------------------
DROP TABLE IF EXISTS `jadwal_tambahan`;
CREATE TABLE `jadwal_tambahan` (
  `id` int(11) NOT NULL,
  `tahun` year(4) NOT NULL,
  `bulan` enum('01','02','03','04','05','06','07','08','09','10','11','12') NOT NULL,
  `h1` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h2` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h3` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h4` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h5` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h6` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h7` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h8` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h9` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h10` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h11` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h12` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h13` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h14` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h15` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h16` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h17` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h18` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h19` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h20` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h21` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h22` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h23` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h24` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h25` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h26` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h27` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h28` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h29` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h30` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h31` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  PRIMARY KEY (`id`,`tahun`,`bulan`),
  CONSTRAINT `jadwal_tambahan_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `jam_jaga`
-- ----------------------------
DROP TABLE IF EXISTS `jam_jaga`;
CREATE TABLE `jam_jaga` (
  `no_id` int(11) NOT NULL AUTO_INCREMENT,
  `dep_id` char(4) NOT NULL,
  `shift` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10') NOT NULL,
  `jam_masuk` time NOT NULL,
  `jam_pulang` time NOT NULL,
  PRIMARY KEY (`no_id`),
  UNIQUE KEY `dep_id_2` (`dep_id`,`shift`),
  KEY `dep_id` (`dep_id`),
  KEY `shift` (`shift`),
  KEY `jam_masuk` (`jam_masuk`),
  KEY `jam_pulang` (`jam_pulang`),
  CONSTRAINT `jam_jaga_ibfk_1` FOREIGN KEY (`dep_id`) REFERENCES `departemen` (`dep_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `jam_masuk`
-- ----------------------------
DROP TABLE IF EXISTS `jam_masuk`;
CREATE TABLE `jam_masuk` (
  `shift` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10') NOT NULL,
  `jam_masuk` time NOT NULL,
  `jam_pulang` time NOT NULL,
  PRIMARY KEY (`shift`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `jamsostek`
-- ----------------------------
DROP TABLE IF EXISTS `jamsostek`;
CREATE TABLE `jamsostek` (
  `stts` char(5) NOT NULL,
  `biaya` double NOT NULL,
  PRIMARY KEY (`stts`),
  KEY `biaya` (`biaya`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `jasa_lain`
-- ----------------------------
DROP TABLE IF EXISTS `jasa_lain`;
CREATE TABLE `jasa_lain` (
  `thn` year(4) NOT NULL,
  `bln` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `bsr_jasa` double NOT NULL,
  `ktg` varchar(40) NOT NULL,
  PRIMARY KEY (`thn`,`bln`,`id`,`bsr_jasa`,`ktg`),
  KEY `id` (`id`),
  CONSTRAINT `jasa_lain_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `jenis`
-- ----------------------------
DROP TABLE IF EXISTS `jenis`;
CREATE TABLE `jenis` (
  `kdjns` char(4) NOT NULL,
  `nama` varchar(30) NOT NULL,
  `keterangan` varchar(50) NOT NULL,
  PRIMARY KEY (`kdjns`),
  KEY `nama` (`nama`),
  KEY `keterangan` (`keterangan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `jgmlm`
-- ----------------------------
DROP TABLE IF EXISTS `jgmlm`;
CREATE TABLE `jgmlm` (
  `tgl` date NOT NULL,
  `id` int(11) NOT NULL,
  `jml` int(11) NOT NULL,
  PRIMARY KEY (`tgl`,`id`),
  KEY `id` (`id`),
  KEY `jml` (`jml`),
  CONSTRAINT `jgmlm_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `jnj_jabatan`
-- ----------------------------
DROP TABLE IF EXISTS `jnj_jabatan`;
CREATE TABLE `jnj_jabatan` (
  `kode` varchar(10) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `tnj` double NOT NULL,
  PRIMARY KEY (`kode`),
  KEY `nama` (`nama`),
  KEY `tnj` (`tnj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `jns_perawatan`
-- ----------------------------
DROP TABLE IF EXISTS `jns_perawatan`;
CREATE TABLE `jns_perawatan` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `nm_perawatan` varchar(80) DEFAULT NULL,
  `kd_kategori` char(5) DEFAULT NULL,
  `material` double DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double DEFAULT NULL,
  `tarif_tindakanpr` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `total_byrdr` double DEFAULT NULL,
  `total_byrpr` double DEFAULT NULL,
  `total_byrdrpr` double NOT NULL,
  `kd_pj` char(3) NOT NULL,
  `kd_poli` char(5) NOT NULL,
  `status` enum('0','1') NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`),
  KEY `kd_kategori` (`kd_kategori`),
  KEY `kd_pj` (`kd_pj`),
  KEY `kd_poli` (`kd_poli`),
  KEY `nm_perawatan` (`nm_perawatan`),
  KEY `material` (`material`),
  KEY `tarif_tindakandr` (`tarif_tindakandr`),
  KEY `tarif_tindakanpr` (`tarif_tindakanpr`),
  KEY `total_byrdr` (`total_byrdr`),
  KEY `total_byrpr` (`total_byrpr`),
  CONSTRAINT `jns_perawatan_ibfk_1` FOREIGN KEY (`kd_kategori`) REFERENCES `kategori_perawatan` (`kd_kategori`) ON UPDATE CASCADE,
  CONSTRAINT `jns_perawatan_ibfk_2` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE,
  CONSTRAINT `jns_perawatan_ibfk_3` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `jns_perawatan_inap`
-- ----------------------------
DROP TABLE IF EXISTS `jns_perawatan_inap`;
CREATE TABLE `jns_perawatan_inap` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `nm_perawatan` varchar(80) DEFAULT NULL,
  `kd_kategori` char(5) NOT NULL,
  `material` double DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double DEFAULT NULL,
  `tarif_tindakanpr` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `total_byrdr` double DEFAULT NULL,
  `total_byrpr` double DEFAULT NULL,
  `total_byrdrpr` double NOT NULL,
  `kd_pj` char(3) NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  `status` enum('0','1') NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`),
  KEY `kd_pj` (`kd_pj`),
  KEY `kd_bangsal` (`kd_bangsal`),
  KEY `kd_kategori` (`kd_kategori`),
  KEY `nm_perawatan` (`nm_perawatan`),
  KEY `material` (`material`),
  KEY `tarif_tindakandr` (`tarif_tindakandr`),
  KEY `tarif_tindakanpr` (`tarif_tindakanpr`),
  KEY `total_byrdr` (`total_byrdr`),
  KEY `total_byrpr` (`total_byrpr`),
  CONSTRAINT `jns_perawatan_inap_ibfk_7` FOREIGN KEY (`kd_kategori`) REFERENCES `kategori_perawatan` (`kd_kategori`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `jns_perawatan_inap_ibfk_8` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `jns_perawatan_inap_ibfk_9` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `jns_perawatan_lab`
-- ----------------------------
DROP TABLE IF EXISTS `jns_perawatan_lab`;
CREATE TABLE `jns_perawatan_lab` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `nm_perawatan` varchar(80) DEFAULT NULL,
  `bagian_rs` double DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_perujuk` double NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  `tarif_tindakan_petugas` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `total_byr` double DEFAULT NULL,
  `kd_pj` char(3) NOT NULL,
  `status` enum('0','1') NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`),
  KEY `kd_pj` (`kd_pj`),
  KEY `nm_perawatan` (`nm_perawatan`),
  KEY `tarif_perujuk` (`tarif_perujuk`),
  KEY `tarif_tindakan_dokter` (`tarif_tindakan_dokter`),
  KEY `tarif_tindakan_petugas` (`tarif_tindakan_petugas`),
  KEY `total_byr` (`total_byr`),
  KEY `bagian_rs` (`bagian_rs`),
  CONSTRAINT `jns_perawatan_lab_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `jns_perawatan_radiologi`
-- ----------------------------
DROP TABLE IF EXISTS `jns_perawatan_radiologi`;
CREATE TABLE `jns_perawatan_radiologi` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `nm_perawatan` varchar(80) DEFAULT NULL,
  `bagian_rs` double DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_perujuk` double NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  `tarif_tindakan_petugas` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `total_byr` double DEFAULT NULL,
  `kd_pj` char(3) NOT NULL,
  `status` enum('0','1') NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`),
  KEY `kd_pj` (`kd_pj`),
  KEY `nm_perawatan` (`nm_perawatan`),
  KEY `bagian_rs` (`bagian_rs`),
  KEY `tarif_perujuk` (`tarif_perujuk`),
  KEY `tarif_tindakan_dokter` (`tarif_tindakan_dokter`),
  KEY `tarif_tindakan_petugas` (`tarif_tindakan_petugas`),
  KEY `total_byr` (`total_byr`),
  CONSTRAINT `jns_perawatan_radiologi_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `jns_perawatan_utd`
-- ----------------------------
DROP TABLE IF EXISTS `jns_perawatan_utd`;
CREATE TABLE `jns_perawatan_utd` (
  `kd_jenis_prw` varchar(15) NOT NULL DEFAULT '',
  `nm_perawatan` varchar(80) DEFAULT NULL,
  `bagian_rs` double DEFAULT NULL,
  `bhp` double DEFAULT NULL,
  `tarif_perujuk` double DEFAULT NULL,
  `tarif_tindakan_dokter` double DEFAULT NULL,
  `tarif_tindakan_petugas` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `manajemen` double DEFAULT NULL,
  `total_byr` double DEFAULT NULL,
  `kd_pj` char(3) DEFAULT NULL,
  `status` enum('0','1') DEFAULT NULL,
  PRIMARY KEY (`kd_jenis_prw`),
  KEY `kd_pj` (`kd_pj`),
  CONSTRAINT `jns_perawatan_utd_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `jumpasien`
-- ----------------------------
DROP TABLE IF EXISTS `jumpasien`;
CREATE TABLE `jumpasien` (
  `thn` year(4) NOT NULL,
  `bln` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `jml` int(11) NOT NULL,
  PRIMARY KEY (`thn`,`bln`,`id`),
  KEY `id` (`id`),
  KEY `jml` (`jml`),
  CONSTRAINT `jumpasien_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `jurnal`
-- ----------------------------
DROP TABLE IF EXISTS `jurnal`;
CREATE TABLE `jurnal` (
  `no_jurnal` varchar(20) NOT NULL,
  `no_bukti` varchar(20) DEFAULT NULL,
  `tgl_jurnal` date DEFAULT NULL,
  `jenis` enum('U','P') DEFAULT NULL,
  `keterangan` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`no_jurnal`),
  KEY `no_bukti` (`no_bukti`),
  KEY `tgl_jurnal` (`tgl_jurnal`),
  KEY `jenis` (`jenis`),
  KEY `keterangan` (`keterangan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `kabupaten`
-- ----------------------------
DROP TABLE IF EXISTS `kabupaten`;
CREATE TABLE `kabupaten` (
  `kd_kab` varchar(6) NOT NULL,
  `nm_kab` varchar(60) NOT NULL,
  PRIMARY KEY (`kd_kab`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `kamar`
-- ----------------------------
DROP TABLE IF EXISTS `kamar`;
CREATE TABLE `kamar` (
  `kd_kamar` varchar(15) NOT NULL,
  `kd_bangsal` char(5) DEFAULT NULL,
  `trf_kamar` double DEFAULT NULL,
  `status` enum('ISI','KOSONG') DEFAULT NULL,
  `kelas` enum('Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP','ISO') DEFAULT NULL,
  `statusdata` enum('0','1') DEFAULT NULL,
  PRIMARY KEY (`kd_kamar`),
  KEY `kd_bangsal` (`kd_bangsal`),
  KEY `trf_kamar` (`trf_kamar`),
  KEY `status` (`status`),
  KEY `kelas` (`kelas`),
  CONSTRAINT `kamar_ibfk_1` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `kamar_inap`
-- ----------------------------
DROP TABLE IF EXISTS `kamar_inap`;
CREATE TABLE `kamar_inap` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kd_kamar` varchar(15) NOT NULL,
  `trf_kamar` double DEFAULT NULL,
  `diagnosa_awal` varchar(100) DEFAULT NULL,
  `diagnosa_akhir` varchar(100) DEFAULT NULL,
  `tgl_masuk` date NOT NULL DEFAULT '0000-00-00',
  `jam_masuk` time NOT NULL DEFAULT '00:00:00',
  `tgl_keluar` date DEFAULT NULL,
  `jam_keluar` time DEFAULT NULL,
  `lama` double DEFAULT NULL,
  `ttl_biaya` double DEFAULT NULL,
  `stts_pulang` enum('Sehat','Rujuk','APS','+','Meninggal','Sembuh','Membaik','Pulang Paksa','-','Pindah Kamar','Status Belum Lengkap') NOT NULL,
  PRIMARY KEY (`no_rawat`,`tgl_masuk`,`jam_masuk`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_kamar` (`kd_kamar`),
  KEY `diagnosa_awal` (`diagnosa_awal`),
  KEY `diagnosa_akhir` (`diagnosa_akhir`),
  KEY `tgl_keluar` (`tgl_keluar`),
  KEY `jam_keluar` (`jam_keluar`),
  KEY `lama` (`lama`),
  KEY `ttl_biaya` (`ttl_biaya`),
  KEY `stts_pulang` (`stts_pulang`),
  CONSTRAINT `kamar_inap_ibfk_2` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kamar_inap_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `kasift`
-- ----------------------------
DROP TABLE IF EXISTS `kasift`;
CREATE TABLE `kasift` (
  `id` int(11) NOT NULL,
  `jmlks` bigint(20) NOT NULL,
  `bsr` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jmlks` (`jmlks`),
  KEY `bsr` (`bsr`),
  CONSTRAINT `kasift_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `kategori_pemasukan_lain`
-- ----------------------------
DROP TABLE IF EXISTS `kategori_pemasukan_lain`;
CREATE TABLE `kategori_pemasukan_lain` (
  `kode_kategori` varchar(5) NOT NULL,
  `nama_kategori` varchar(40) DEFAULT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  `kd_rek2` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`kode_kategori`),
  KEY `kd_rek` (`kd_rek`),
  KEY `kd_rek2` (`kd_rek2`),
  CONSTRAINT `kategori_pemasukan_lain_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `kategori_pemasukan_lain_ibfk_2` FOREIGN KEY (`kd_rek2`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `kategori_pengeluaran_harian`
-- ----------------------------
DROP TABLE IF EXISTS `kategori_pengeluaran_harian`;
CREATE TABLE `kategori_pengeluaran_harian` (
  `kode_kategori` varchar(5) NOT NULL,
  `nama_kategori` varchar(40) DEFAULT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  `kd_rek2` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`kode_kategori`),
  KEY `kd_rek` (`kd_rek`),
  KEY `kd_rek2` (`kd_rek2`),
  CONSTRAINT `kategori_pengeluaran_harian_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `kategori_pengeluaran_harian_ibfk_2` FOREIGN KEY (`kd_rek2`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `kategori_penyakit`
-- ----------------------------
DROP TABLE IF EXISTS `kategori_penyakit`;
CREATE TABLE `kategori_penyakit` (
  `kd_ktg` varchar(8) NOT NULL,
  `nm_kategori` varchar(30) DEFAULT NULL,
  `ciri_umum` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`kd_ktg`),
  KEY `nm_kategori` (`nm_kategori`),
  KEY `ciri_umum` (`ciri_umum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `kategori_perawatan`
-- ----------------------------
DROP TABLE IF EXISTS `kategori_perawatan`;
CREATE TABLE `kategori_perawatan` (
  `kd_kategori` char(5) NOT NULL,
  `nm_kategori` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`kd_kategori`),
  KEY `nm_kategori` (`nm_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `keanggotaan`
-- ----------------------------
DROP TABLE IF EXISTS `keanggotaan`;
CREATE TABLE `keanggotaan` (
  `id` int(11) NOT NULL,
  `koperasi` char(5) NOT NULL,
  `jamsostek` char(5) NOT NULL,
  `bpjs` char(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `koperasi` (`koperasi`),
  KEY `jamsostek` (`jamsostek`),
  KEY `bpjs` (`bpjs`),
  CONSTRAINT `keanggotaan_ibfk_3` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `keanggotaan_ibfk_4` FOREIGN KEY (`koperasi`) REFERENCES `koperasi` (`stts`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `keanggotaan_ibfk_5` FOREIGN KEY (`jamsostek`) REFERENCES `jamsostek` (`stts`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `keanggotaan_ibfk_6` FOREIGN KEY (`bpjs`) REFERENCES `bpjs` (`stts`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `kecamatan`
-- ----------------------------
DROP TABLE IF EXISTS `kecamatan`;
CREATE TABLE `kecamatan` (
  `kd_kec` varchar(8) NOT NULL,
  `kd_kab` varchar(6) NOT NULL,
  `nm_kec` varchar(60) NOT NULL,
  PRIMARY KEY (`kd_kec`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `kelurahan`
-- ----------------------------
DROP TABLE IF EXISTS `kelurahan`;
CREATE TABLE `kelurahan` (
  `kd_kel` varchar(22) NOT NULL,
  `kd_kec` varchar(8) NOT NULL,
  `nm_kel` varchar(80) NOT NULL,
  PRIMARY KEY (`kd_kel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `ketenagaan`
-- ----------------------------
DROP TABLE IF EXISTS `ketenagaan`;
CREATE TABLE `ketenagaan` (
  `id_ketanagaan` bigint(10) NOT NULL AUTO_INCREMENT,
  `jabatanfungsional` varchar(50) NOT NULL,
  `jenistenagakerja` varchar(50) DEFAULT NULL,
  `jumlahtenagakerja` int(10) DEFAULT NULL,
  PRIMARY KEY (`id_ketanagaan`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `ketidakhadiran`
-- ----------------------------
DROP TABLE IF EXISTS `ketidakhadiran`;
CREATE TABLE `ketidakhadiran` (
  `tgl` date NOT NULL,
  `id` int(11) NOT NULL,
  `jns` enum('A','S','C','I') NOT NULL,
  `ktg` varchar(40) NOT NULL,
  `jml` int(10) DEFAULT NULL,
  PRIMARY KEY (`tgl`,`id`,`jns`),
  KEY `id` (`id`),
  KEY `ktg` (`ktg`),
  KEY `jml` (`jml`),
  CONSTRAINT `ketidakhadiran_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `kodesatuan`
-- ----------------------------
DROP TABLE IF EXISTS `kodesatuan`;
CREATE TABLE `kodesatuan` (
  `kode_sat` char(4) NOT NULL,
  `satuan` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`kode_sat`),
  KEY `satuan` (`satuan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `konver_sat`
-- ----------------------------
DROP TABLE IF EXISTS `konver_sat`;
CREATE TABLE `konver_sat` (
  `nilai` double DEFAULT NULL,
  `kode_sat` char(4) NOT NULL DEFAULT '',
  `nilai_konversi` double DEFAULT NULL,
  `sat_konversi` char(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`kode_sat`,`sat_konversi`),
  KEY `kode_sat` (`kode_sat`),
  KEY `nilai` (`nilai`),
  KEY `nilai_konversi` (`nilai_konversi`),
  CONSTRAINT `konver_sat_ibfk_1` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `koperasi`
-- ----------------------------
DROP TABLE IF EXISTS `koperasi`;
CREATE TABLE `koperasi` (
  `stts` char(5) NOT NULL,
  `wajib` double NOT NULL,
  PRIMARY KEY (`stts`),
  KEY `wajib` (`wajib`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `kuota_poli`
-- ----------------------------
DROP TABLE IF EXISTS `kuota_poli`;
CREATE TABLE `kuota_poli` (
  `id_kuota` bigint(11) NOT NULL AUTO_INCREMENT,
  `kd_poli` char(5) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `sisakuota` int(11) NOT NULL,
  `totalkuota` int(11) NOT NULL,
  PRIMARY KEY (`id_kuota`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `laporanrl_51`
-- ----------------------------
DROP TABLE IF EXISTS `laporanrl_51`;
CREATE TABLE `laporanrl_51` (
  `id_rl5` int(5) NOT NULL AUTO_INCREMENT,
  `tahun` varchar(4) DEFAULT NULL,
  `bulan` varchar(2) DEFAULT NULL,
  `status` varchar(40) DEFAULT NULL,
  `baru` int(8) DEFAULT NULL,
  `lama` int(8) DEFAULT NULL,
  `send` enum('Pending','Send') DEFAULT 'Pending',
  `catatan` text,
  `dateupdate` datetime DEFAULT NULL,
  PRIMARY KEY (`id_rl5`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `laporanrl_52`
-- ----------------------------
DROP TABLE IF EXISTS `laporanrl_52`;
CREATE TABLE `laporanrl_52` (
  `id_laporanrl52` bigint(5) NOT NULL AUTO_INCREMENT,
  `tahun` varchar(4) DEFAULT NULL,
  `bulan` varchar(2) DEFAULT NULL,
  `nm_poli` varchar(35) DEFAULT NULL,
  `jumlah_pasien` int(6) DEFAULT NULL,
  `send` enum('Pending','Send') DEFAULT 'Pending',
  `dateupdate` datetime DEFAULT NULL,
  PRIMARY KEY (`id_laporanrl52`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `master_aturan_pakai`
-- ----------------------------
DROP TABLE IF EXISTS `master_aturan_pakai`;
CREATE TABLE `master_aturan_pakai` (
  `aturan` varchar(150) NOT NULL,
  PRIMARY KEY (`aturan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `master_tindakan`
-- ----------------------------
DROP TABLE IF EXISTS `master_tindakan`;
CREATE TABLE `master_tindakan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  `jm` double NOT NULL,
  `jns` enum('Karyawan','dr umum','dr spesialis') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nama` (`nama`),
  KEY `jm` (`jm`),
  KEY `jns` (`jns`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `master_tunjangan_bulanan`
-- ----------------------------
DROP TABLE IF EXISTS `master_tunjangan_bulanan`;
CREATE TABLE `master_tunjangan_bulanan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(60) NOT NULL,
  `tnj` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nama` (`nama`),
  KEY `tnj` (`tnj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `master_tunjangan_harian`
-- ----------------------------
DROP TABLE IF EXISTS `master_tunjangan_harian`;
CREATE TABLE `master_tunjangan_harian` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(40) NOT NULL,
  `tnj` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nama` (`nama`),
  KEY `tnj` (`tnj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `mutasi_berkas`
-- ----------------------------
DROP TABLE IF EXISTS `mutasi_berkas`;
CREATE TABLE `mutasi_berkas` (
  `no_rawat` varchar(17) NOT NULL,
  `status` enum('Sudah Dikirim','Sudah Diterima','Sudah Kembali','Tidak Ada') DEFAULT NULL,
  `dikirim` datetime DEFAULT NULL,
  `diterima` datetime DEFAULT NULL,
  `kembali` datetime DEFAULT NULL,
  `tidakada` datetime DEFAULT NULL,
  PRIMARY KEY (`no_rawat`),
  CONSTRAINT `mutasi_berkas_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `mutasibarang`
-- ----------------------------
DROP TABLE IF EXISTS `mutasibarang`;
CREATE TABLE `mutasibarang` (
  `kode_brng` varchar(15) NOT NULL,
  `jml` double NOT NULL,
  `kd_bangsaldari` char(5) NOT NULL,
  `kd_bangsalke` char(5) NOT NULL,
  `tanggal` date NOT NULL,
  `keterangan` varchar(60) NOT NULL,
  PRIMARY KEY (`kode_brng`,`kd_bangsaldari`,`kd_bangsalke`,`tanggal`),
  KEY `kd_bangsaldari` (`kd_bangsaldari`),
  KEY `kd_bangsalke` (`kd_bangsalke`),
  KEY `jml` (`jml`),
  KEY `keterangan` (`keterangan`),
  CONSTRAINT `mutasibarang_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mutasibarang_ibfk_2` FOREIGN KEY (`kd_bangsaldari`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mutasibarang_ibfk_3` FOREIGN KEY (`kd_bangsalke`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `no_urut`
-- ----------------------------
DROP TABLE IF EXISTS `no_urut`;
CREATE TABLE `no_urut` (
  `kd_poli` varchar(5) DEFAULT NULL,
  `tgl_reg` date DEFAULT NULL,
  `no_urut` varchar(6) DEFAULT NULL,
  KEY `kd_poli` (`kd_poli`),
  CONSTRAINT `kdpoli_ibfk` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `nota_inap`
-- ----------------------------
DROP TABLE IF EXISTS `nota_inap`;
CREATE TABLE `nota_inap` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `no_nota` varchar(17) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `jam` time DEFAULT NULL,
  `Uang_Muka` double DEFAULT NULL,
  PRIMARY KEY (`no_rawat`),
  UNIQUE KEY `no_nota` (`no_nota`),
  CONSTRAINT `nota_inap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `nota_jalan`
-- ----------------------------
DROP TABLE IF EXISTS `nota_jalan`;
CREATE TABLE `nota_jalan` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `no_nota` varchar(17) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `jam` time DEFAULT NULL,
  `Jasa_Medik_Dokter_Tindakan_Ralan` double DEFAULT NULL,
  `Jasa_Medik_Paramedis_Tindakan_Ralan` double DEFAULT NULL,
  `KSO_Tindakan_Ralan` double DEFAULT NULL,
  `Jasa_Medik_Dokter_Laborat_Ralan` double DEFAULT NULL,
  `Jasa_Medik_Petugas_Laborat_Ralan` double DEFAULT NULL,
  `Kso_Laborat_Ralan` double DEFAULT NULL,
  `Persediaan_Laborat_Rawat_Jalan` double DEFAULT NULL,
  `Jasa_Medik_Dokter_Radiologi_Ralan` double DEFAULT NULL,
  `Jasa_Medik_Petugas_Radiologi_Ralan` double DEFAULT NULL,
  `Kso_Radiologi_Ralan` double DEFAULT NULL,
  `Persediaan_Radiologi_Rawat_Jalan` double DEFAULT NULL,
  `Obat_Rawat_Jalan` double DEFAULT NULL,
  `Jasa_Medik_Dokter_Operasi_Ralan` double DEFAULT NULL,
  `Jasa_Medik_Paramedis_Operasi_Ralan` double DEFAULT NULL,
  `Obat_Operasi_Ralan` double DEFAULT NULL,
  PRIMARY KEY (`no_rawat`),
  UNIQUE KEY `no_nota` (`no_nota`),
  CONSTRAINT `nota_jalan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `obat_penyakit`
-- ----------------------------
DROP TABLE IF EXISTS `obat_penyakit`;
CREATE TABLE `obat_penyakit` (
  `kd_penyakit` varchar(10) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL,
  `referensi` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`kd_penyakit`,`kode_brng`),
  KEY `kd_penyakit` (`kd_penyakit`),
  KEY `kd_obat` (`kode_brng`),
  CONSTRAINT `obat_penyakit_ibfk_1` FOREIGN KEY (`kd_penyakit`) REFERENCES `penyakit` (`kd_penyakit`) ON UPDATE CASCADE,
  CONSTRAINT `obat_penyakit_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `obatbhp_ok`
-- ----------------------------
DROP TABLE IF EXISTS `obatbhp_ok`;
CREATE TABLE `obatbhp_ok` (
  `kd_obat` varchar(15) NOT NULL,
  `nm_obat` varchar(50) NOT NULL,
  `kode_sat` char(4) NOT NULL,
  `hargasatuan` double NOT NULL,
  PRIMARY KEY (`kd_obat`),
  KEY `kode_sat` (`kode_sat`),
  KEY `nm_obat` (`nm_obat`),
  KEY `hargasatuan` (`hargasatuan`),
  CONSTRAINT `obatbhp_ok_ibfk_1` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `operasi`
-- ----------------------------
DROP TABLE IF EXISTS `operasi`;
CREATE TABLE `operasi` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_operasi` datetime NOT NULL,
  `jenis_anasthesi` varchar(8) NOT NULL,
  `kategori` enum('-','Khusus','Besar','Sedang','Kecil') DEFAULT NULL,
  `operator1` varchar(20) NOT NULL,
  `operator2` varchar(20) NOT NULL,
  `operator3` varchar(20) NOT NULL,
  `asisten_operator1` varchar(20) NOT NULL,
  `asisten_operator2` varchar(20) NOT NULL,
  `asisten_operator3` varchar(20) DEFAULT NULL,
  `instrumen` varchar(20) DEFAULT NULL,
  `dokter_anak` varchar(20) NOT NULL,
  `perawaat_resusitas` varchar(20) NOT NULL,
  `dokter_anestesi` varchar(20) NOT NULL,
  `asisten_anestesi` varchar(20) NOT NULL,
  `asisten_anestesi2` varchar(20) DEFAULT NULL,
  `bidan` varchar(20) NOT NULL,
  `bidan2` varchar(20) DEFAULT NULL,
  `bidan3` varchar(20) DEFAULT NULL,
  `perawat_luar` varchar(20) NOT NULL,
  `omloop` varchar(20) DEFAULT NULL,
  `omloop2` varchar(20) DEFAULT NULL,
  `omloop3` varchar(20) DEFAULT NULL,
  `omloop4` varchar(20) DEFAULT NULL,
  `omloop5` varchar(20) DEFAULT NULL,
  `dokter_pjanak` varchar(20) DEFAULT NULL,
  `dokter_umum` varchar(20) DEFAULT NULL,
  `kode_paket` varchar(15) NOT NULL,
  `biayaoperator1` double NOT NULL,
  `biayaoperator2` double NOT NULL,
  `biayaoperator3` double NOT NULL,
  `biayaasisten_operator1` double NOT NULL,
  `biayaasisten_operator2` double NOT NULL,
  `biayaasisten_operator3` double DEFAULT NULL,
  `biayainstrumen` double DEFAULT NULL,
  `biayadokter_anak` double NOT NULL,
  `biayaperawaat_resusitas` double NOT NULL,
  `biayadokter_anestesi` double NOT NULL,
  `biayaasisten_anestesi` double NOT NULL,
  `biayaasisten_anestesi2` double DEFAULT NULL,
  `biayabidan` double NOT NULL,
  `biayabidan2` double DEFAULT NULL,
  `biayabidan3` double DEFAULT NULL,
  `biayaperawat_luar` double NOT NULL,
  `biayaalat` double NOT NULL,
  `biayasewaok` double NOT NULL,
  `akomodasi` double DEFAULT NULL,
  `bagian_rs` double NOT NULL,
  `biaya_omloop` double DEFAULT NULL,
  `biaya_omloop2` double DEFAULT NULL,
  `biaya_omloop3` double DEFAULT NULL,
  `biaya_omloop4` double DEFAULT NULL,
  `biaya_omloop5` double DEFAULT NULL,
  `biayasarpras` double DEFAULT NULL,
  `biaya_dokter_pjanak` double DEFAULT NULL,
  `biaya_dokter_umum` double DEFAULT NULL,
  `status` enum('Ranap','Ralan') DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`tgl_operasi`,`kode_paket`),
  KEY `no_rawat` (`no_rawat`),
  KEY `operator1` (`operator1`),
  KEY `operator2` (`operator2`),
  KEY `operator3` (`operator3`),
  KEY `asisten_operator1` (`asisten_operator1`),
  KEY `asisten_operator2` (`asisten_operator2`),
  KEY `asisten_operator3` (`instrumen`),
  KEY `dokter_anak` (`dokter_anak`),
  KEY `perawaat_resusitas` (`perawaat_resusitas`),
  KEY `dokter_anestesi` (`dokter_anestesi`),
  KEY `asisten_anestesi` (`asisten_anestesi`),
  KEY `bidan` (`bidan`),
  KEY `perawat_luar` (`perawat_luar`),
  KEY `kode_paket` (`kode_paket`),
  KEY `operasi_ibfk_45` (`bidan2`),
  KEY `operasi_ibfk_46` (`bidan3`),
  KEY `operasi_ibfk_47` (`omloop`),
  KEY `operasi_ibfk_48` (`omloop2`),
  KEY `operasi_ibfk_49` (`omloop3`),
  KEY `dokter_pjanak` (`dokter_pjanak`),
  KEY `dokter_umum` (`dokter_umum`),
  KEY `asisten_operator3_2` (`asisten_operator3`),
  KEY `asisten_anestesi2` (`asisten_anestesi2`),
  KEY `omloop4` (`omloop4`),
  KEY `omloop5` (`omloop5`),
  CONSTRAINT `operasi_ibfk_31` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_32` FOREIGN KEY (`operator1`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_33` FOREIGN KEY (`operator2`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_34` FOREIGN KEY (`operator3`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_35` FOREIGN KEY (`asisten_operator1`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_36` FOREIGN KEY (`asisten_operator2`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_37` FOREIGN KEY (`instrumen`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_38` FOREIGN KEY (`dokter_anak`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_39` FOREIGN KEY (`perawaat_resusitas`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_40` FOREIGN KEY (`dokter_anestesi`) REFERENCES `dokter` (`kd_dokter`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_41` FOREIGN KEY (`asisten_anestesi`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_42` FOREIGN KEY (`bidan`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_43` FOREIGN KEY (`perawat_luar`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_44` FOREIGN KEY (`kode_paket`) REFERENCES `paket_operasi` (`kode_paket`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_45` FOREIGN KEY (`bidan2`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_46` FOREIGN KEY (`bidan3`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_47` FOREIGN KEY (`omloop`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_48` FOREIGN KEY (`omloop2`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_49` FOREIGN KEY (`omloop3`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_50` FOREIGN KEY (`dokter_pjanak`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_51` FOREIGN KEY (`dokter_umum`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_52` FOREIGN KEY (`asisten_operator3`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_53` FOREIGN KEY (`asisten_anestesi2`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_54` FOREIGN KEY (`omloop4`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_55` FOREIGN KEY (`omloop5`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `opname`
-- ----------------------------
DROP TABLE IF EXISTS `opname`;
CREATE TABLE `opname` (
  `kode_brng` varchar(15) NOT NULL,
  `h_beli` double DEFAULT NULL,
  `tanggal` date NOT NULL,
  `stok` int(11) NOT NULL,
  `real` int(11) NOT NULL,
  `selisih` int(11) NOT NULL,
  `nomihilang` double NOT NULL,
  `keterangan` varchar(60) NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  PRIMARY KEY (`kode_brng`,`tanggal`,`kd_bangsal`),
  KEY `kd_bangsal` (`kd_bangsal`),
  KEY `stok` (`stok`),
  KEY `real` (`real`),
  KEY `selisih` (`selisih`),
  KEY `nomihilang` (`nomihilang`),
  KEY `keterangan` (`keterangan`),
  CONSTRAINT `opname_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `opname_ibfk_2` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `paket_operasi`
-- ----------------------------
DROP TABLE IF EXISTS `paket_operasi`;
CREATE TABLE `paket_operasi` (
  `kode_paket` varchar(15) NOT NULL,
  `nm_perawatan` varchar(80) NOT NULL,
  `kategori` enum('Kebidanan','Operasi') DEFAULT NULL,
  `operator1` double NOT NULL,
  `operator2` double NOT NULL,
  `operator3` double NOT NULL,
  `asisten_operator1` double DEFAULT NULL,
  `asisten_operator2` double NOT NULL,
  `asisten_operator3` double DEFAULT NULL,
  `instrumen` double DEFAULT NULL,
  `dokter_anak` double NOT NULL,
  `perawaat_resusitas` double NOT NULL,
  `dokter_anestesi` double NOT NULL,
  `asisten_anestesi` double NOT NULL,
  `asisten_anestesi2` double DEFAULT NULL,
  `bidan` double NOT NULL,
  `bidan2` double DEFAULT NULL,
  `bidan3` double DEFAULT NULL,
  `perawat_luar` double NOT NULL,
  `sewa_ok` double NOT NULL,
  `alat` double NOT NULL,
  `akomodasi` double DEFAULT NULL,
  `bagian_rs` double NOT NULL,
  `omloop` double NOT NULL,
  `omloop2` double DEFAULT NULL,
  `omloop3` double DEFAULT NULL,
  `omloop4` double DEFAULT NULL,
  `omloop5` double DEFAULT NULL,
  `sarpras` double DEFAULT NULL,
  `dokter_pjanak` double DEFAULT NULL,
  `dokter_umum` double DEFAULT NULL,
  `kd_pj` char(3) DEFAULT NULL,
  `status` enum('0','1') DEFAULT NULL,
  PRIMARY KEY (`kode_paket`),
  KEY `nm_perawatan` (`nm_perawatan`),
  KEY `operator1` (`operator1`),
  KEY `operator2` (`operator2`),
  KEY `operator3` (`operator3`),
  KEY `asisten_operator1` (`asisten_operator1`),
  KEY `asisten_operator2` (`asisten_operator2`),
  KEY `asisten_operator3` (`instrumen`),
  KEY `dokter_anak` (`dokter_anak`),
  KEY `perawat_resusitas` (`perawaat_resusitas`),
  KEY `dokter_anestasi` (`dokter_anestesi`),
  KEY `asisten_anastesi` (`asisten_anestesi`),
  KEY `bidan` (`bidan`),
  KEY `perawat_luar` (`perawat_luar`),
  KEY `sewa_ok` (`sewa_ok`),
  KEY `alat` (`alat`),
  KEY `sewa_vk` (`akomodasi`),
  KEY `bagian_rs` (`bagian_rs`),
  KEY `omloop` (`omloop`),
  KEY `kd_pj` (`kd_pj`),
  CONSTRAINT `paket_operasi_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `parkir`
-- ----------------------------
DROP TABLE IF EXISTS `parkir`;
CREATE TABLE `parkir` (
  `nip` varchar(20) DEFAULT NULL,
  `nomer_kartu` varchar(5) DEFAULT NULL,
  `kd_parkir` varchar(5) DEFAULT NULL,
  `no_kendaraan` varchar(15) NOT NULL DEFAULT '',
  `tgl_masuk` date NOT NULL DEFAULT '0000-00-00',
  `jam_masuk` time NOT NULL DEFAULT '00:00:00',
  `tgl_keluar` date DEFAULT NULL,
  `jam_keluar` time DEFAULT NULL,
  `lama_parkir` int(11) DEFAULT NULL,
  `ttl_biaya` double DEFAULT NULL,
  PRIMARY KEY (`no_kendaraan`,`tgl_masuk`,`jam_masuk`),
  KEY `kd_barcode` (`nomer_kartu`),
  KEY `kd_petugas` (`nip`),
  KEY `kd_parkir` (`kd_parkir`),
  CONSTRAINT `parkir_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parkir_ibfk_2` FOREIGN KEY (`kd_parkir`) REFERENCES `parkir_jenis` (`kd_parkir`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `parkir_barcode`
-- ----------------------------
DROP TABLE IF EXISTS `parkir_barcode`;
CREATE TABLE `parkir_barcode` (
  `kode_barcode` varchar(15) NOT NULL,
  `nomer_kartu` varchar(5) NOT NULL,
  PRIMARY KEY (`kode_barcode`),
  UNIQUE KEY `no_card` (`nomer_kartu`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `parkir_jenis`
-- ----------------------------
DROP TABLE IF EXISTS `parkir_jenis`;
CREATE TABLE `parkir_jenis` (
  `kd_parkir` char(5) NOT NULL,
  `jns_parkir` varchar(50) NOT NULL,
  `biaya` double NOT NULL,
  `jenis` enum('Harian','Jam') NOT NULL,
  PRIMARY KEY (`kd_parkir`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pasien`
-- ----------------------------
DROP TABLE IF EXISTS `pasien`;
CREATE TABLE `pasien` (
  `no_rkm_medis` varchar(15) NOT NULL,
  `nm_pasien` varchar(40) DEFAULT NULL,
  `no_ktp` varchar(20) DEFAULT NULL,
  `jk` enum('L','P') DEFAULT NULL,
  `tmp_lahir` varchar(15) DEFAULT NULL,
  `tgl_lahir` date NOT NULL,
  `nm_ibu` varchar(40) NOT NULL,
  `alamat` varchar(200) DEFAULT NULL,
  `gol_darah` enum('A','B','O','AB','-') DEFAULT NULL,
  `pekerjaan` varchar(70) DEFAULT NULL,
  `stts_nikah` enum('SINGLE','MENIKAH','JANDA','DUDHA','JOMBLO') DEFAULT NULL,
  `agama` varchar(12) DEFAULT NULL,
  `tgl_daftar` date DEFAULT NULL,
  `no_tlp` varchar(13) DEFAULT NULL,
  `umur` varchar(20) NOT NULL,
  `pnd` enum('TS','TK','SD','SMP','SMA','D1','D2','D3','D4','S1','S2','S3','-') NOT NULL,
  `keluarga` enum('AYAH','IBU','ISTRI','SUAMI','SAUDARA','ANAK') DEFAULT NULL,
  `namakeluarga` varchar(50) NOT NULL,
  `kd_pj` char(3) NOT NULL,
  `no_peserta` varchar(25) DEFAULT NULL,
  `kd_kel` varchar(22) NOT NULL,
  `kd_kec` varchar(8) NOT NULL,
  `kd_kab` varchar(6) NOT NULL,
  `pekerjaanpj` varchar(15) NOT NULL,
  `alamatpj` varchar(100) NOT NULL,
  `kelurahanpj` varchar(60) NOT NULL,
  `kecamatanpj` varchar(60) NOT NULL,
  `kabupatenpj` varchar(60) NOT NULL,
  `tgl_input` datetime DEFAULT NULL,
  `tgl_edit` datetime DEFAULT NULL,
  `user` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`no_rkm_medis`),
  KEY `kd_pj` (`kd_pj`),
  KEY `kd_kec` (`kd_kec`),
  KEY `kd_kab` (`kd_kab`),
  KEY `nm_pasien` (`nm_pasien`),
  KEY `alamat` (`alamat`),
  KEY `kd_kel_2` (`kd_kel`),
  KEY `keluarga` (`keluarga`),
  KEY `no_ktp` (`no_ktp`),
  KEY `jk` (`jk`),
  KEY `tmp_lahir` (`tmp_lahir`),
  KEY `tgl_lahir` (`tgl_lahir`),
  KEY `nm_ibu` (`nm_ibu`),
  KEY `gol_darah` (`gol_darah`),
  KEY `pekerjaan` (`pekerjaan`),
  KEY `stts_nikah` (`stts_nikah`),
  KEY `agama` (`agama`),
  KEY `tgl_daftar` (`tgl_daftar`),
  KEY `no_tlp` (`no_tlp`),
  KEY `umur` (`umur`),
  KEY `pnd` (`pnd`),
  CONSTRAINT `pasien_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pasien_bayi`
-- ----------------------------
DROP TABLE IF EXISTS `pasien_bayi`;
CREATE TABLE `pasien_bayi` (
  `no_rkm_medis` varchar(15) NOT NULL,
  `umur_ibu` varchar(8) NOT NULL,
  `nama_ayah` varchar(50) NOT NULL,
  `umur_ayah` varchar(8) NOT NULL,
  `berat_badan` varchar(10) NOT NULL,
  `panjang_badan` varchar(10) NOT NULL,
  `lingkar_kepala` varchar(10) NOT NULL,
  `proses_lahir` varchar(10) NOT NULL,
  `anakke` char(2) NOT NULL,
  `jam_lahir` time NOT NULL,
  `keterangan` varchar(50) NOT NULL,
  PRIMARY KEY (`no_rkm_medis`),
  KEY `umur_ibu` (`umur_ibu`),
  KEY `umur_ayah` (`umur_ayah`),
  KEY `berat_badan` (`berat_badan`),
  KEY `panjang_badan` (`panjang_badan`),
  KEY `lingkar_kepala` (`lingkar_kepala`),
  KEY `proses_lahir` (`proses_lahir`),
  KEY `anakke` (`anakke`),
  KEY `jam_lahir` (`jam_lahir`),
  KEY `keterangan` (`keterangan`),
  CONSTRAINT `pasien_bayi_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pasien_mati`
-- ----------------------------
DROP TABLE IF EXISTS `pasien_mati`;
CREATE TABLE `pasien_mati` (
  `tanggal` date DEFAULT NULL,
  `jam` time DEFAULT NULL,
  `no_rkm_medis` varchar(15) NOT NULL DEFAULT '',
  `keterangan` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`no_rkm_medis`),
  CONSTRAINT `pasien_mati_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pasien_temporary`
-- ----------------------------
DROP TABLE IF EXISTS `pasien_temporary`;
CREATE TABLE `pasien_temporary` (
  `idpasien_temporary` bigint(11) NOT NULL AUTO_INCREMENT,
  `nm_pasien` varchar(40) DEFAULT NULL,
  `no_ktp` varchar(20) DEFAULT NULL,
  `jk` enum('L','P') DEFAULT NULL,
  `tmp_lahir` varchar(15) DEFAULT NULL,
  `tgl_lahir` date NOT NULL,
  `nm_ibu` varchar(40) NOT NULL,
  `alamat` varchar(200) DEFAULT NULL,
  `gol_darah` enum('A','B','O','AB','-') DEFAULT NULL,
  `pekerjaan` varchar(70) DEFAULT NULL,
  `stts_nikah` enum('SINGLE','MENIKAH','JANDA','DUDHA','JOMBLO','KAWIN','-') DEFAULT NULL,
  `agama` varchar(12) DEFAULT NULL,
  `tgl_daftar` date DEFAULT NULL,
  `no_tlp` varchar(13) DEFAULT NULL,
  `umur` varchar(20) NOT NULL,
  `pnd` enum('TS','TK','SD','SMP','SMA','D1','D2','D3','D4','S1','S2','S3','-') NOT NULL,
  `keluarga` enum('AYAH','IBU','ISTRI','SUAMI','SAUDARA','ANAK') DEFAULT NULL,
  `namakeluarga` varchar(50) NOT NULL,
  `kd_pj` char(3) NOT NULL,
  `no_peserta` varchar(25) DEFAULT NULL,
  `kd_kel` varchar(22) NOT NULL,
  `kd_kec` varchar(8) NOT NULL,
  `kd_kab` varchar(6) NOT NULL,
  `pekerjaanpj` varchar(15) NOT NULL,
  `alamatpj` varchar(100) NOT NULL,
  `kelurahanpj` varchar(60) NOT NULL,
  `kecamatanpj` varchar(60) NOT NULL,
  `kabupatenpj` varchar(60) NOT NULL,
  `tgl_input` datetime DEFAULT NULL,
  `tgl_edit` datetime DEFAULT NULL,
  `user` varchar(60) DEFAULT NULL,
  `no_registrasi` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idpasien_temporary`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pegawai`
-- ----------------------------
DROP TABLE IF EXISTS `pegawai`;
CREATE TABLE `pegawai` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nik` varchar(50) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `jk` enum('Pria','Wanita') NOT NULL,
  `jbtn` varchar(25) NOT NULL,
  `jnj_jabatan` varchar(5) NOT NULL,
  `departemen` char(4) NOT NULL,
  `bidang` varchar(15) NOT NULL,
  `stts_wp` char(5) NOT NULL,
  `stts_kerja` char(3) NOT NULL,
  `npwp` varchar(15) NOT NULL,
  `pendidikan` varchar(80) NOT NULL,
  `gapok` double NOT NULL,
  `tmp_lahir` varchar(20) NOT NULL,
  `tgl_lahir` date NOT NULL,
  `alamat` varchar(60) NOT NULL,
  `kota` varchar(20) NOT NULL,
  `mulai_kerja` date NOT NULL,
  `ms_kerja` enum('<1','PT','FT>1') NOT NULL,
  `indexins` char(4) NOT NULL,
  `bpd` varchar(50) NOT NULL,
  `rekening` varchar(25) NOT NULL,
  `stts_aktif` enum('AKTIF','CUTI','KELUAR','TENAGA LUAR') NOT NULL,
  `wajibmasuk` tinyint(4) NOT NULL,
  `pengurang` double NOT NULL,
  `indek` tinyint(4) NOT NULL,
  `mulai_kontrak` date DEFAULT NULL,
  `cuti_diambil` int(11) NOT NULL,
  `dankes` double NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nik_2` (`nik`),
  KEY `departemen` (`departemen`),
  KEY `bidang` (`bidang`),
  KEY `stts_wp` (`stts_wp`),
  KEY `stts_kerja` (`stts_kerja`),
  KEY `pendidikan` (`pendidikan`),
  KEY `indexins` (`indexins`),
  KEY `jnj_jabatan` (`jnj_jabatan`),
  KEY `bpd` (`bpd`),
  CONSTRAINT `pegawai_ibfk_1` FOREIGN KEY (`jnj_jabatan`) REFERENCES `jnj_jabatan` (`kode`) ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_2` FOREIGN KEY (`departemen`) REFERENCES `departemen` (`dep_id`) ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_3` FOREIGN KEY (`bidang`) REFERENCES `bidang` (`nama`) ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_4` FOREIGN KEY (`stts_wp`) REFERENCES `stts_wp` (`stts`) ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_5` FOREIGN KEY (`stts_kerja`) REFERENCES `stts_kerja` (`stts`) ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_6` FOREIGN KEY (`pendidikan`) REFERENCES `pendidikan` (`tingkat`) ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_7` FOREIGN KEY (`indexins`) REFERENCES `departemen` (`dep_id`) ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_8` FOREIGN KEY (`bpd`) REFERENCES `bank` (`namabank`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `pemasukan_lain`
-- ----------------------------
DROP TABLE IF EXISTS `pemasukan_lain`;
CREATE TABLE `pemasukan_lain` (
  `tanggal` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `kode_kategori` varchar(5) NOT NULL DEFAULT '',
  `besar` double DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `keterangan` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`tanggal`,`kode_kategori`),
  KEY `pemasukan_lain_ibfk_2` (`kode_kategori`),
  KEY `pemasukan_lain_ibfk_1` (`nip`),
  CONSTRAINT `pemasukan_lain_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pemasukan_lain_ibfk_2` FOREIGN KEY (`kode_kategori`) REFERENCES `kategori_pemasukan_lain` (`kode_kategori`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pembagian_akte`
-- ----------------------------
DROP TABLE IF EXISTS `pembagian_akte`;
CREATE TABLE `pembagian_akte` (
  `id` int(11) NOT NULL,
  `persen` double NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `pembagian_akte_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pembagian_resume`
-- ----------------------------
DROP TABLE IF EXISTS `pembagian_resume`;
CREATE TABLE `pembagian_resume` (
  `id` int(11) NOT NULL,
  `persen` double NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `pembagian_resume_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pembagian_tuslah`
-- ----------------------------
DROP TABLE IF EXISTS `pembagian_tuslah`;
CREATE TABLE `pembagian_tuslah` (
  `id` int(11) NOT NULL,
  `persen` double NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `pembagian_tuslah_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pembagian_warung`
-- ----------------------------
DROP TABLE IF EXISTS `pembagian_warung`;
CREATE TABLE `pembagian_warung` (
  `id` int(11) NOT NULL,
  `persen` double NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `pembagian_warung_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pembelian`
-- ----------------------------
DROP TABLE IF EXISTS `pembelian`;
CREATE TABLE `pembelian` (
  `no_faktur` varchar(20) NOT NULL,
  `kode_suplier` char(5) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `tgl_beli` date DEFAULT NULL,
  `total1` double NOT NULL,
  `potongan` double NOT NULL,
  `total2` double NOT NULL,
  `ppn` double NOT NULL,
  `tagihan` double NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`no_faktur`),
  KEY `kode_suplier` (`kode_suplier`),
  KEY `nip` (`nip`),
  KEY `kd_bangsal` (`kd_bangsal`),
  KEY `pembelian_ibfk_4` (`kd_rek`),
  CONSTRAINT `pembelian_ibfk_1` FOREIGN KEY (`kode_suplier`) REFERENCES `datasuplier` (`kode_suplier`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pembelian_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pembelian_ibfk_3` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pembelian_ibfk_4` FOREIGN KEY (`kd_rek`) REFERENCES `akun_bayar` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pemeriksaan_ralan`
-- ----------------------------
DROP TABLE IF EXISTS `pemeriksaan_ralan`;
CREATE TABLE `pemeriksaan_ralan` (
  `no_rawat` varchar(17) NOT NULL,
  `suhu_tubuh` char(5) DEFAULT NULL,
  `tensi` char(7) NOT NULL,
  `nadi` char(3) DEFAULT NULL,
  `respirasi` char(3) DEFAULT NULL,
  `tinggi` char(5) DEFAULT NULL,
  `berat` char(5) DEFAULT NULL,
  `gcs` varchar(10) DEFAULT NULL,
  `keluhan` varchar(400) DEFAULT NULL,
  `pemeriksaan` varchar(400) DEFAULT NULL,
  `alergi` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`no_rawat`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `pemeriksaan_ralan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pemeriksaan_ranap`
-- ----------------------------
DROP TABLE IF EXISTS `pemeriksaan_ranap`;
CREATE TABLE `pemeriksaan_ranap` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `suhu_tubuh` char(5) DEFAULT NULL,
  `tensi` char(7) NOT NULL,
  `nadi` char(3) DEFAULT NULL,
  `respirasi` char(3) DEFAULT NULL,
  `tinggi` char(5) DEFAULT NULL,
  `berat` char(5) DEFAULT NULL,
  `gcs` varchar(10) DEFAULT NULL,
  `keluhan` varchar(400) DEFAULT NULL,
  `pemeriksaan` varchar(400) DEFAULT NULL,
  `alergi` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`tgl_perawatan`,`jam_rawat`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `pemeriksaan_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pemesanan`
-- ----------------------------
DROP TABLE IF EXISTS `pemesanan`;
CREATE TABLE `pemesanan` (
  `no_faktur` varchar(20) NOT NULL,
  `no_order` varchar(20) NOT NULL,
  `kode_suplier` char(5) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `tgl_pesan` date DEFAULT NULL,
  `tgl_faktur` date DEFAULT NULL,
  `tgl_tempo` date DEFAULT NULL,
  `total1` double NOT NULL,
  `potongan` double NOT NULL,
  `total2` double NOT NULL,
  `ppn` double NOT NULL,
  `tagihan` double NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  `status` enum('Sudah Dibayar','Belum Dibayar','Belum Lunas') DEFAULT NULL,
  PRIMARY KEY (`no_faktur`),
  KEY `kode_suplier` (`kode_suplier`),
  KEY `nip` (`nip`),
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `pemesanan_ibfk_1` FOREIGN KEY (`kode_suplier`) REFERENCES `datasuplier` (`kode_suplier`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pemesanan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pemesanan_ibfk_3` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `peminjaman_berkas`
-- ----------------------------
DROP TABLE IF EXISTS `peminjaman_berkas`;
CREATE TABLE `peminjaman_berkas` (
  `peminjam` varchar(60) NOT NULL,
  `id_ruang` varchar(5) NOT NULL,
  `no_rkm_medis` varchar(15) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `nip` varchar(20) NOT NULL,
  `status_pinjam` enum('Masih Dipinjam','Sudah Kembali') NOT NULL,
  PRIMARY KEY (`peminjam`,`id_ruang`,`no_rkm_medis`,`tgl_pinjam`,`nip`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  KEY `nip` (`nip`),
  KEY `id_ruang` (`id_ruang`),
  CONSTRAINT `peminjaman_berkas_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON UPDATE CASCADE,
  CONSTRAINT `peminjaman_berkas_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `peminjaman_berkas_ibfk_3` FOREIGN KEY (`id_ruang`) REFERENCES `inventaris_ruang` (`id_ruang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `peminjaman_koperasi`
-- ----------------------------
DROP TABLE IF EXISTS `peminjaman_koperasi`;
CREATE TABLE `peminjaman_koperasi` (
  `id` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `pinjaman` double NOT NULL,
  `banyak_angsur` int(11) NOT NULL,
  `pokok` double NOT NULL,
  `jasa` double NOT NULL,
  `status` enum('Lunas','Belum Lunas') NOT NULL,
  PRIMARY KEY (`id`,`tanggal`),
  CONSTRAINT `peminjaman_koperasi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pendaftaran_lab_rujukan`
-- ----------------------------
DROP TABLE IF EXISTS `pendaftaran_lab_rujukan`;
CREATE TABLE `pendaftaran_lab_rujukan` (
  `no_lab` varchar(17) NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `dokter_perujuk` varchar(40) NOT NULL,
  `nm_pasien` varchar(40) DEFAULT NULL,
  `no_ktp` varchar(20) DEFAULT NULL,
  `jk` enum('L','P') DEFAULT NULL,
  `tmp_lahir` varchar(15) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `umur` varchar(20) NOT NULL,
  `alamat` varchar(200) DEFAULT NULL,
  `gol_darah` enum('A','B','O','AB','-') DEFAULT NULL,
  `pekerjaan` varchar(15) DEFAULT NULL,
  `stts_nikah` enum('SINGLE','MENIKAH','JANDA','DUDHA','JOMBLO') DEFAULT NULL,
  `agama` varchar(12) DEFAULT NULL,
  `no_tlp` varchar(13) DEFAULT NULL,
  `pnd` enum('TS','TK','SD','SMP','SMA','D1','D2','D3','D4','S1','S2','S3','-') DEFAULT NULL,
  `nip` varchar(20) NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  `status` enum('Sudah Dibayar','Belum Dibayar') DEFAULT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`no_lab`),
  KEY `nip` (`nip`),
  KEY `kd_dokter` (`kd_dokter`),
  KEY `kd_rek` (`kd_rek`),
  CONSTRAINT `pendaftaran_lab_rujukan_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pendaftaran_lab_rujukan_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pendaftaran_lab_rujukan_ibfk_3` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pendidikan`
-- ----------------------------
DROP TABLE IF EXISTS `pendidikan`;
CREATE TABLE `pendidikan` (
  `tingkat` varchar(80) NOT NULL,
  `indek` tinyint(4) NOT NULL,
  `gapok1` double NOT NULL,
  `kenaikan` double NOT NULL,
  `maksimal` int(11) NOT NULL,
  PRIMARY KEY (`tingkat`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pengeluaran_harian`
-- ----------------------------
DROP TABLE IF EXISTS `pengeluaran_harian`;
CREATE TABLE `pengeluaran_harian` (
  `tanggal` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `kode_kategori` varchar(5) DEFAULT NULL,
  `biaya` double NOT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `keterangan` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`tanggal`,`keterangan`),
  KEY `nip` (`nip`),
  KEY `pengeluaran_harian_ibfk_2` (`kode_kategori`),
  CONSTRAINT `pengeluaran_harian_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pengeluaran_harian_ibfk_2` FOREIGN KEY (`kode_kategori`) REFERENCES `kategori_pengeluaran_harian` (`kode_kategori`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pengurangan_biaya`
-- ----------------------------
DROP TABLE IF EXISTS `pengurangan_biaya`;
CREATE TABLE `pengurangan_biaya` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `nama_pengurangan` varchar(60) NOT NULL,
  `besar_pengurangan` double DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`nama_pengurangan`),
  CONSTRAINT `pengurangan_biaya_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `penjab`
-- ----------------------------
DROP TABLE IF EXISTS `penjab`;
CREATE TABLE `penjab` (
  `kd_pj` char(3) NOT NULL,
  `png_jawab` varchar(30) NOT NULL,
  PRIMARY KEY (`kd_pj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `penjualan`
-- ----------------------------
DROP TABLE IF EXISTS `penjualan`;
CREATE TABLE `penjualan` (
  `nota_jual` varchar(20) NOT NULL,
  `tgl_jual` date DEFAULT NULL,
  `nip` char(20) DEFAULT NULL,
  `no_rkm_medis` varchar(10) DEFAULT NULL,
  `nm_pasien` varchar(50) DEFAULT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  `jns_jual` enum('Jual Bebas','Karyawan','Beli Luar','Rawat Jalan','Kelas 1','Kelas 2','Kelas 3','Utama/BPJS','VIP','VVIP') DEFAULT NULL,
  `ongkir` double DEFAULT NULL,
  `status` enum('Belum Dibayar','Sudah Dibayar') DEFAULT NULL,
  `kd_bangsal` char(5) NOT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`nota_jual`),
  KEY `nip` (`nip`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  KEY `kd_bangsal` (`kd_bangsal`),
  KEY `penjualan_ibfk_12` (`kd_rek`),
  CONSTRAINT `penjualan_ibfk_10` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `penjualan_ibfk_11` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penjualan_ibfk_12` FOREIGN KEY (`kd_rek`) REFERENCES `akun_bayar` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penjualan_ibfk_9` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `penyakit`
-- ----------------------------
DROP TABLE IF EXISTS `penyakit`;
CREATE TABLE `penyakit` (
  `kd_penyakit` varchar(10) NOT NULL,
  `nm_penyakit` varchar(100) DEFAULT NULL,
  `ciri_ciri` text,
  `keterangan` varchar(60) DEFAULT NULL,
  `kd_ktg` varchar(8) DEFAULT NULL,
  `status` enum('Menular','Tidak Menular') NOT NULL,
  PRIMARY KEY (`kd_penyakit`),
  KEY `kd_ktg` (`kd_ktg`),
  KEY `nm_penyakit` (`nm_penyakit`),
  KEY `status` (`status`),
  CONSTRAINT `penyakit_ibfk_1` FOREIGN KEY (`kd_ktg`) REFERENCES `kategori_penyakit` (`kd_ktg`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `penyakit_pd3i`
-- ----------------------------
DROP TABLE IF EXISTS `penyakit_pd3i`;
CREATE TABLE `penyakit_pd3i` (
  `kd_penyakit` varchar(10) NOT NULL,
  PRIMARY KEY (`kd_penyakit`),
  CONSTRAINT `penyakit_pd3i_ibfk_1` FOREIGN KEY (`kd_penyakit`) REFERENCES `penyakit` (`kd_penyakit`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `periksa_lab`
-- ----------------------------
DROP TABLE IF EXISTS `periksa_lab`;
CREATE TABLE `periksa_lab` (
  `no_rawat` varchar(17) NOT NULL,
  `nip` varchar(20) NOT NULL,
  `kd_jenis_prw` varchar(15) NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `dokter_perujuk` varchar(20) NOT NULL,
  `bagian_rs` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_perujuk` double NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  `tarif_tindakan_petugas` double NOT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya` double NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  `status` enum('Ralan','Ranap') DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`kd_jenis_prw`,`tgl_periksa`,`jam`),
  KEY `nip` (`nip`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `kd_dokter` (`kd_dokter`),
  KEY `dokter_perujuk` (`dokter_perujuk`),
  CONSTRAINT `periksa_lab_ibfk_10` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `periksa_lab_ibfk_11` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `periksa_lab_ibfk_12` FOREIGN KEY (`dokter_perujuk`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `periksa_lab_ibfk_13` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `periksa_lab_ibfk_9` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `periksa_lab_rujukan`
-- ----------------------------
DROP TABLE IF EXISTS `periksa_lab_rujukan`;
CREATE TABLE `periksa_lab_rujukan` (
  `no_lab` varchar(17) DEFAULT NULL,
  `kd_jenis_prw` varchar(15) NOT NULL,
  `bagian_rs` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_perujuk` double NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  `tarif_tindakan_petugas` double NOT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya` double NOT NULL,
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `no_lab` (`no_lab`),
  CONSTRAINT `periksa_lab_rujukan_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `periksa_lab_rujukan_ibfk_2` FOREIGN KEY (`no_lab`) REFERENCES `pendaftaran_lab_rujukan` (`no_lab`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `periksa_radiologi`
-- ----------------------------
DROP TABLE IF EXISTS `periksa_radiologi`;
CREATE TABLE `periksa_radiologi` (
  `no_rawat` varchar(17) NOT NULL,
  `nip` varchar(20) NOT NULL,
  `kd_jenis_prw` varchar(15) NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `dokter_perujuk` varchar(20) NOT NULL,
  `bagian_rs` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_perujuk` double NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  `tarif_tindakan_petugas` double NOT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya` double NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  `status` enum('Ranap','Ralan') DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`kd_jenis_prw`,`tgl_periksa`,`jam`),
  KEY `nip` (`nip`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `kd_dokter` (`kd_dokter`),
  KEY `dokter_perujuk` (`dokter_perujuk`),
  CONSTRAINT `periksa_radiologi_ibfk_4` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `periksa_radiologi_ibfk_5` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `periksa_radiologi_ibfk_6` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_radiologi` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `periksa_radiologi_ibfk_7` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `periksa_radiologi_ibfk_8` FOREIGN KEY (`dokter_perujuk`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `petugas`
-- ----------------------------
DROP TABLE IF EXISTS `petugas`;
CREATE TABLE `petugas` (
  `nip` varchar(50) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `jk` enum('L','P') DEFAULT NULL,
  `tmp_lahir` varchar(20) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `gol_darah` enum('A','B','O','AB','-') DEFAULT NULL,
  `agama` varchar(12) DEFAULT NULL,
  `stts_nikah` enum('SINGLE','MENIKAH','JANDA','DUDHA','JOMBLO') DEFAULT NULL,
  `alamat` varchar(60) DEFAULT NULL,
  `kd_jbtn` char(4) DEFAULT NULL,
  `no_telp` varchar(13) DEFAULT NULL,
  `status` enum('0','1') DEFAULT NULL,
  PRIMARY KEY (`nip`),
  KEY `kd_jbtn` (`kd_jbtn`),
  CONSTRAINT `petugas_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nik`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `petugas_ibfk_2` FOREIGN KEY (`kd_jbtn`) REFERENCES `jabatan` (`kd_jbtn`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `piutang`
-- ----------------------------
DROP TABLE IF EXISTS `piutang`;
CREATE TABLE `piutang` (
  `nota_piutang` varchar(20) NOT NULL,
  `tgl_piutang` date DEFAULT NULL,
  `nip` char(20) DEFAULT NULL,
  `no_rkm_medis` varchar(10) DEFAULT NULL,
  `nm_pasien` varchar(50) DEFAULT NULL,
  `catatan` varchar(40) DEFAULT NULL,
  `jns_jual` enum('Jual Bebas','Karyawan','Beli Luar','Rawat Jalan','Kelas 1','Kelas 2','Kelas 3','Utama','VIP','VVIP') DEFAULT NULL,
  `ongkir` double DEFAULT NULL,
  `uangmuka` double DEFAULT NULL,
  `sisapiutang` double NOT NULL,
  `status` enum('UMUM','PAJAK') DEFAULT NULL,
  `tgltempo` date NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  PRIMARY KEY (`nota_piutang`),
  KEY `nip` (`nip`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `piutang_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `piutang_ibfk_2` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON UPDATE CASCADE,
  CONSTRAINT `piutang_ibfk_3` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `piutang_pasien`
-- ----------------------------
DROP TABLE IF EXISTS `piutang_pasien`;
CREATE TABLE `piutang_pasien` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_piutang` date DEFAULT NULL,
  `no_rkm_medis` varchar(15) DEFAULT NULL,
  `status` enum('Lunas','Belum Lunas') NOT NULL,
  `totalpiutang` double DEFAULT NULL,
  `uangmuka` double DEFAULT NULL,
  `sisapiutang` double NOT NULL,
  `tgltempo` date NOT NULL,
  PRIMARY KEY (`no_rawat`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  CONSTRAINT `piutang_pasien_ibfk_2` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `piutang_pasien_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pnm_tnj_bulanan`
-- ----------------------------
DROP TABLE IF EXISTS `pnm_tnj_bulanan`;
CREATE TABLE `pnm_tnj_bulanan` (
  `id` int(11) NOT NULL,
  `id_tnj` int(11) NOT NULL,
  PRIMARY KEY (`id`,`id_tnj`),
  KEY `id_tnj` (`id_tnj`),
  CONSTRAINT `pnm_tnj_bulanan_ibfk_5` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `pnm_tnj_bulanan_ibfk_6` FOREIGN KEY (`id_tnj`) REFERENCES `master_tunjangan_bulanan` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pnm_tnj_harian`
-- ----------------------------
DROP TABLE IF EXISTS `pnm_tnj_harian`;
CREATE TABLE `pnm_tnj_harian` (
  `id` int(11) NOT NULL,
  `id_tnj` int(11) NOT NULL,
  PRIMARY KEY (`id`,`id_tnj`),
  KEY `id_tnj` (`id_tnj`),
  CONSTRAINT `pnm_tnj_harian_ibfk_5` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `pnm_tnj_harian_ibfk_6` FOREIGN KEY (`id_tnj`) REFERENCES `master_tunjangan_harian` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `poliklinik`
-- ----------------------------
DROP TABLE IF EXISTS `poliklinik`;
CREATE TABLE `poliklinik` (
  `kd_poli` char(5) NOT NULL DEFAULT '',
  `nm_poli` varchar(50) DEFAULT NULL,
  `registrasi` double NOT NULL,
  `registrasilama` double NOT NULL,
  PRIMARY KEY (`kd_poli`),
  KEY `nm_poli` (`nm_poli`),
  KEY `registrasi` (`registrasi`),
  KEY `registrasilama` (`registrasilama`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `potongan`
-- ----------------------------
DROP TABLE IF EXISTS `potongan`;
CREATE TABLE `potongan` (
  `tahun` year(4) NOT NULL,
  `bulan` tinyint(4) NOT NULL,
  `id` int(11) NOT NULL,
  `bpjs` double NOT NULL,
  `jamsostek` double NOT NULL,
  `dansos` double NOT NULL,
  `simwajib` double NOT NULL,
  `angkop` double NOT NULL,
  `angla` double NOT NULL,
  `telpri` double NOT NULL,
  `pajak` double NOT NULL,
  `pribadi` double NOT NULL,
  `lain` double NOT NULL,
  `ktg` varchar(50) NOT NULL,
  PRIMARY KEY (`tahun`,`bulan`,`id`),
  KEY `id` (`id`),
  CONSTRAINT `potongan_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `presensi`
-- ----------------------------
DROP TABLE IF EXISTS `presensi`;
CREATE TABLE `presensi` (
  `tgl` date NOT NULL,
  `id` int(11) NOT NULL,
  `jns` enum('HR','HB') NOT NULL,
  `lembur` int(11) NOT NULL,
  PRIMARY KEY (`tgl`,`id`),
  KEY `id` (`id`),
  CONSTRAINT `presensi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `prosedur_pasien`
-- ----------------------------
DROP TABLE IF EXISTS `prosedur_pasien`;
CREATE TABLE `prosedur_pasien` (
  `no_rawat` varchar(17) NOT NULL,
  `kode` varchar(8) NOT NULL,
  `status` enum('Ralan','Ranap') NOT NULL,
  `prioritas` tinyint(4) NOT NULL,
  PRIMARY KEY (`no_rawat`,`kode`,`status`),
  KEY `kode` (`kode`),
  CONSTRAINT `prosedur_pasien_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `prosedur_pasien_ibfk_2` FOREIGN KEY (`kode`) REFERENCES `icd9` (`kode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `provinsi`
-- ----------------------------
DROP TABLE IF EXISTS `provinsi`;
CREATE TABLE `provinsi` (
  `kd_prov` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `nm_prov` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`kd_prov`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `ranap_gabung`
-- ----------------------------
DROP TABLE IF EXISTS `ranap_gabung`;
CREATE TABLE `ranap_gabung` (
  `no_rawat` varchar(17) NOT NULL,
  `no_rawat2` varchar(17) NOT NULL,
  PRIMARY KEY (`no_rawat`,`no_rawat2`),
  KEY `no_rawat2` (`no_rawat2`),
  CONSTRAINT `ranap_gabung_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `ranap_gabung_ibfk_2` FOREIGN KEY (`no_rawat2`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `rawat_inap_dr`
-- ----------------------------
DROP TABLE IF EXISTS `rawat_inap_dr`;
CREATE TABLE `rawat_inap_dr` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam_rawat` time NOT NULL DEFAULT '00:00:00',
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double NOT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya_rawat` double DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`kd_jenis_prw`,`kd_dokter`,`tgl_perawatan`,`jam_rawat`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `kd_dokter` (`kd_dokter`),
  KEY `tgl_perawatan` (`tgl_perawatan`),
  KEY `biaya_rawat` (`biaya_rawat`),
  KEY `jam_rawat` (`jam_rawat`),
  CONSTRAINT `rawat_inap_dr_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_dr_ibfk_6` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_inap` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_dr_ibfk_7` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `rawat_inap_drpr`
-- ----------------------------
DROP TABLE IF EXISTS `rawat_inap_drpr`;
CREATE TABLE `rawat_inap_drpr` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  `nip` varchar(20) NOT NULL DEFAULT '',
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam_rawat` time NOT NULL DEFAULT '00:00:00',
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double DEFAULT NULL,
  `tarif_tindakanpr` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya_rawat` double DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`kd_jenis_prw`,`kd_dokter`,`nip`,`tgl_perawatan`,`jam_rawat`),
  KEY `rawat_inap_drpr_ibfk_2` (`kd_jenis_prw`),
  KEY `rawat_inap_drpr_ibfk_3` (`kd_dokter`),
  KEY `rawat_inap_drpr_ibfk_4` (`nip`),
  CONSTRAINT `rawat_inap_drpr_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_drpr_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_inap` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_drpr_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_drpr_ibfk_4` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `rawat_inap_pr`
-- ----------------------------
DROP TABLE IF EXISTS `rawat_inap_pr`;
CREATE TABLE `rawat_inap_pr` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) NOT NULL,
  `nip` varchar(20) NOT NULL DEFAULT '',
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam_rawat` time NOT NULL DEFAULT '00:00:00',
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakanpr` double NOT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya_rawat` double DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`kd_jenis_prw`,`nip`,`tgl_perawatan`,`jam_rawat`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `nip` (`nip`),
  KEY `biaya_rawat` (`biaya_rawat`),
  CONSTRAINT `rawat_inap_pr_ibfk_3` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_pr_ibfk_6` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_inap` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_pr_ibfk_7` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `rawat_jl_dr`
-- ----------------------------
DROP TABLE IF EXISTS `rawat_jl_dr`;
CREATE TABLE `rawat_jl_dr` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double NOT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya_rawat` double DEFAULT NULL,
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `kd_dokter` (`kd_dokter`),
  KEY `biaya_rawat` (`biaya_rawat`),
  CONSTRAINT `rawat_jl_dr_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_dr_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_dr_ibfk_5` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `rawat_jl_drpr`
-- ----------------------------
DROP TABLE IF EXISTS `rawat_jl_drpr`;
CREATE TABLE `rawat_jl_drpr` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  `nip` varchar(20) NOT NULL,
  `material` double DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double DEFAULT NULL,
  `tarif_tindakanpr` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya_rawat` double DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`kd_jenis_prw`,`kd_dokter`,`nip`),
  KEY `rawat_jl_drpr_ibfk_2` (`kd_jenis_prw`),
  KEY `rawat_jl_drpr_ibfk_3` (`kd_dokter`),
  KEY `rawat_jl_drpr_ibfk_4` (`nip`),
  CONSTRAINT `rawat_jl_drpr_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_drpr_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_drpr_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_drpr_ibfk_4` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `rawat_jl_pr`
-- ----------------------------
DROP TABLE IF EXISTS `rawat_jl_pr`;
CREATE TABLE `rawat_jl_pr` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) NOT NULL,
  `nip` varchar(20) NOT NULL DEFAULT '',
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakanpr` double NOT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya_rawat` double DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`kd_jenis_prw`,`nip`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `nip` (`nip`),
  KEY `biaya_rawat` (`biaya_rawat`),
  CONSTRAINT `rawat_jl_pr_ibfk_10` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_pr_ibfk_8` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_pr_ibfk_9` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `rawatjalan`
-- ----------------------------
DROP TABLE IF EXISTS `rawatjalan`;
CREATE TABLE `rawatjalan` (
  `tgl` datetime NOT NULL,
  `id` int(11) NOT NULL,
  `tnd` int(11) NOT NULL,
  `jm` double NOT NULL,
  `nm_pasien` varchar(30) NOT NULL,
  `kamar` varchar(20) NOT NULL,
  `diagnosa` varchar(50) NOT NULL,
  `jmlh` int(11) NOT NULL,
  PRIMARY KEY (`tgl`,`id`,`tnd`),
  KEY `id` (`id`),
  KEY `tnd` (`tnd`),
  CONSTRAINT `rawatjalan_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `reg_hapus`
-- ----------------------------
DROP TABLE IF EXISTS `reg_hapus`;
CREATE TABLE `reg_hapus` (
  `no_rawat` varchar(50) NOT NULL,
  `no_rm` varchar(8) NOT NULL,
  `tanggal_hapus` date NOT NULL,
  `jam_hapus` time NOT NULL,
  `user_hapus` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `reg_periksa`
-- ----------------------------
DROP TABLE IF EXISTS `reg_periksa`;
CREATE TABLE `reg_periksa` (
  `no_reg` varchar(8) DEFAULT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `tgl_registrasi` date DEFAULT NULL,
  `jam_reg` time DEFAULT NULL,
  `kd_dokter` varchar(20) DEFAULT NULL,
  `no_rkm_medis` varchar(15) DEFAULT NULL,
  `kd_poli` char(5) DEFAULT NULL,
  `p_jawab` varchar(100) DEFAULT NULL,
  `almt_pj` varchar(200) DEFAULT NULL,
  `hubunganpj` varchar(20) DEFAULT NULL,
  `biaya_reg` double DEFAULT NULL,
  `stts` enum('Belum','Sudah','Bayar','Batal','Berkas Diterima') DEFAULT NULL,
  `stts_daftar` enum('-','Lama','Baru') NOT NULL,
  `status_lanjut` enum('Ralan','Ranap') NOT NULL,
  `kd_pj` char(3) NOT NULL,
  `hr_umur` int(11) DEFAULT NULL,
  `bln_umur` int(5) DEFAULT NULL,
  `thn_umur` int(8) DEFAULT NULL,
  `nm_user` varchar(100) NOT NULL,
  `no_poli` varchar(5) DEFAULT NULL,
  `no_urut` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`no_rawat`),
  KEY `nip` (`kd_dokter`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  KEY `kd_poli` (`kd_poli`),
  KEY `kd_pj` (`kd_pj`),
  KEY `no_reg` (`no_reg`),
  KEY `tgl_registrasi` (`tgl_registrasi`),
  KEY `jam_reg` (`jam_reg`),
  KEY `p_jawab` (`p_jawab`),
  KEY `almt_pj` (`almt_pj`),
  KEY `hubunganpj` (`hubunganpj`),
  KEY `biaya_reg` (`biaya_reg`),
  KEY `stts` (`stts`),
  KEY `stts_daftar` (`stts_daftar`),
  KEY `status_lanjut` (`status_lanjut`),
  CONSTRAINT `reg_periksa_ibfk_3` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reg_periksa_ibfk_4` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reg_periksa_ibfk_6` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reg_periksa_ibfk_7` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `reg_periksa_temporary`
-- ----------------------------
DROP TABLE IF EXISTS `reg_periksa_temporary`;
CREATE TABLE `reg_periksa_temporary` (
  `no_reg` varchar(8) DEFAULT NULL,
  `no_rawat` varchar(17) DEFAULT NULL,
  `tgl_registrasi` date DEFAULT NULL,
  `jam_reg` time DEFAULT NULL,
  `kd_dokter` varchar(20) DEFAULT NULL,
  `no_rkm_medis` varchar(15) DEFAULT NULL,
  `kd_poli` char(5) DEFAULT NULL,
  `p_jawab` varchar(100) DEFAULT NULL,
  `almt_pj` varchar(200) DEFAULT NULL,
  `hubunganpj` varchar(20) DEFAULT NULL,
  `biaya_reg` double DEFAULT NULL,
  `stts` enum('Belum','Sudah','Bayar','Batal','Berkas Diterima') DEFAULT NULL,
  `stts_daftar` enum('-','Lama','Baru') NOT NULL,
  `status_lanjut` enum('Ralan','Ranap') NOT NULL,
  `kd_pj` char(3) NOT NULL,
  `sumber` varchar(100) NOT NULL,
  `no_urut` varchar(5) DEFAULT NULL,
  `no_rujukan` varchar(25) NOT NULL DEFAULT '',
  `no_registrasi` varchar(30) DEFAULT NULL,
  `waktu_pelayanan` varchar(30) DEFAULT NULL,
  `hr_umur` int(11) DEFAULT NULL,
  `bln_umur` int(5) DEFAULT NULL,
  `thn_umur` int(8) DEFAULT NULL,
  `status_reg` enum('Teregistrasi','Pending') NOT NULL DEFAULT 'Pending',
  `faskes_asal` varchar(200) NOT NULL,
  `dokter_perujuk` varchar(200) DEFAULT NULL,
  `kd_penyakit` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `rekap_presensi`
-- ----------------------------
DROP TABLE IF EXISTS `rekap_presensi`;
CREATE TABLE `rekap_presensi` (
  `id` int(10) NOT NULL,
  `shift` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10') NOT NULL,
  `jam_datang` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `jam_pulang` datetime DEFAULT NULL,
  `status` enum('Tepat Waktu','Terlambat Toleransi','Terlambat I','Terlambat II','Tepat Waktu & PSW','Terlambat Toleransi & PSW','Terlambat I & PSW','Terlambat II & PSW') NOT NULL,
  `keterlambatan` varchar(20) NOT NULL,
  `durasi` varchar(20) DEFAULT NULL,
  `keterangan` varchar(100) NOT NULL,
  `photo` varchar(500) NOT NULL,
  PRIMARY KEY (`id`,`jam_datang`),
  KEY `id` (`id`),
  CONSTRAINT `rekap_presensi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `rekening`
-- ----------------------------
DROP TABLE IF EXISTS `rekening`;
CREATE TABLE `rekening` (
  `kd_rek` varchar(15) NOT NULL DEFAULT '',
  `nm_rek` varchar(100) DEFAULT NULL,
  `tipe` enum('N','M','R') DEFAULT NULL,
  `balance` enum('D','K') DEFAULT NULL,
  `level` enum('0','1') DEFAULT NULL,
  PRIMARY KEY (`kd_rek`),
  KEY `nm_rek` (`nm_rek`),
  KEY `tipe` (`tipe`),
  KEY `balance` (`balance`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `rekeningtahun`
-- ----------------------------
DROP TABLE IF EXISTS `rekeningtahun`;
CREATE TABLE `rekeningtahun` (
  `thn` year(4) NOT NULL,
  `kd_rek` varchar(15) NOT NULL DEFAULT '',
  `saldo_awal` double NOT NULL,
  PRIMARY KEY (`thn`,`kd_rek`),
  KEY `kd_rek` (`kd_rek`),
  KEY `saldo_awal` (`saldo_awal`),
  CONSTRAINT `rekeningtahun_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `resep_dokter`
-- ----------------------------
DROP TABLE IF EXISTS `resep_dokter`;
CREATE TABLE `resep_dokter` (
  `no_resep` varchar(10) DEFAULT NULL,
  `kode_brng` varchar(15) DEFAULT NULL,
  `jml` double DEFAULT NULL,
  `aturan_pakai` varchar(150) DEFAULT NULL,
  KEY `no_resep` (`no_resep`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `resep_dokter_ibfk_1` FOREIGN KEY (`no_resep`) REFERENCES `resep_obat` (`no_resep`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resep_dokter_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `resep_obat`
-- ----------------------------
DROP TABLE IF EXISTS `resep_obat`;
CREATE TABLE `resep_obat` (
  `no_resep` varchar(10) NOT NULL DEFAULT '',
  `tgl_perawatan` date DEFAULT NULL,
  `jam` time NOT NULL,
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kd_dokter` varchar(20) NOT NULL,
  `tgl_peresepan` date DEFAULT NULL,
  `jam_peresepan` time DEFAULT NULL,
  PRIMARY KEY (`no_resep`),
  UNIQUE KEY `tgl_perawatan` (`tgl_perawatan`,`jam`,`no_rawat`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_dokter` (`kd_dokter`),
  CONSTRAINT `resep_obat_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `resep_obat_ibfk_4` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `resep_pulang`
-- ----------------------------
DROP TABLE IF EXISTS `resep_pulang`;
CREATE TABLE `resep_pulang` (
  `no_rawat` varchar(17) NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  `jml_barang` double NOT NULL,
  `harga` double NOT NULL,
  `total` double NOT NULL,
  `dosis` varchar(20) NOT NULL,
  PRIMARY KEY (`no_rawat`,`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `resep_pulang_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resep_pulang_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `retensi_pasien`
-- ----------------------------
DROP TABLE IF EXISTS `retensi_pasien`;
CREATE TABLE `retensi_pasien` (
  `no_rkm_medis` varchar(15) DEFAULT NULL,
  `terakhir_daftar` date DEFAULT NULL,
  `tgl_retensi` date DEFAULT NULL,
  `lokasi_pdf` varchar(500) DEFAULT NULL,
  KEY `no_rkm_medis` (`no_rkm_medis`),
  CONSTRAINT `retensi_pasien_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `returbeli`
-- ----------------------------
DROP TABLE IF EXISTS `returbeli`;
CREATE TABLE `returbeli` (
  `no_retur_beli` varchar(20) NOT NULL,
  `tgl_retur` date DEFAULT NULL,
  `nip` char(20) DEFAULT NULL,
  `kode_suplier` char(5) NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  PRIMARY KEY (`no_retur_beli`),
  KEY `nip` (`nip`),
  KEY `kode_suplier` (`kode_suplier`),
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `returbeli_ibfk_2` FOREIGN KEY (`kode_suplier`) REFERENCES `datasuplier` (`kode_suplier`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `returbeli_ibfk_3` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `returbeli_ibfk_4` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `returjual`
-- ----------------------------
DROP TABLE IF EXISTS `returjual`;
CREATE TABLE `returjual` (
  `no_retur_jual` varchar(20) NOT NULL,
  `tgl_retur` date DEFAULT NULL,
  `nip` char(20) DEFAULT NULL,
  `no_rkm_medis` varchar(10) NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  PRIMARY KEY (`no_retur_jual`),
  KEY `nip` (`nip`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  KEY `kd_bangsal` (`kd_bangsal`),
  KEY `tgl_retur` (`tgl_retur`),
  CONSTRAINT `returjual_ibfk_6` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `returjual_ibfk_7` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `returjual_ibfk_8` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `returpasien`
-- ----------------------------
DROP TABLE IF EXISTS `returpasien`;
CREATE TABLE `returpasien` (
  `tanggal` date NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  `jml` double NOT NULL,
  PRIMARY KEY (`tanggal`,`no_rawat`,`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `returpasien_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `returpasien_ibfk_4` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `returpiutang`
-- ----------------------------
DROP TABLE IF EXISTS `returpiutang`;
CREATE TABLE `returpiutang` (
  `no_retur_piutang` varchar(20) NOT NULL,
  `tgl_retur` date DEFAULT NULL,
  `nip` char(20) DEFAULT NULL,
  `no_rkm_medis` varchar(10) NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  PRIMARY KEY (`no_retur_piutang`),
  KEY `nip` (`nip`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `returpiutang_ibfk_3` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `returpiutang_ibfk_4` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `returpiutang_ibfk_5` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `riwayat_barang_medis`
-- ----------------------------
DROP TABLE IF EXISTS `riwayat_barang_medis`;
CREATE TABLE `riwayat_barang_medis` (
  `kode_brng` varchar(15) DEFAULT NULL,
  `stok_awal` double DEFAULT NULL,
  `masuk` double DEFAULT NULL,
  `keluar` double DEFAULT NULL,
  `stok_akhir` double NOT NULL,
  `posisi` enum('Pemberian Obat','Pengadaan','Pemesanan','Piutang','Retur Beli','Retur Jual','Retur Piutang','Mutasi','Opname','Resep Pulang','Retur Pasien','Stok Pasien Ranap','Pengambilan Medis','Penjualan') DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `jam` time DEFAULT NULL,
  `petugas` varchar(20) DEFAULT NULL,
  `kd_bangsal` char(5) DEFAULT NULL,
  `status` enum('Simpan','Hapus') DEFAULT NULL,
  KEY `riwayat_barang_medis_ibfk_1` (`kode_brng`),
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `riwayat_barang_medis_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `riwayat_barang_medis_ibfk_2` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `riwayat_jabatan`
-- ----------------------------
DROP TABLE IF EXISTS `riwayat_jabatan`;
CREATE TABLE `riwayat_jabatan` (
  `id` int(11) NOT NULL,
  `jabatan` varchar(50) NOT NULL,
  `tmt_pangkat` date NOT NULL,
  `tmt_pangkat_yad` date NOT NULL,
  `pejabat_penetap` varchar(50) NOT NULL,
  `nomor_sk` varchar(25) NOT NULL,
  `tgl_sk` date NOT NULL,
  `dasar_peraturan` varchar(50) NOT NULL,
  `masa_kerja` int(11) NOT NULL,
  `bln_kerja` int(11) NOT NULL,
  PRIMARY KEY (`id`,`jabatan`),
  KEY `jnj_jabatan` (`jabatan`),
  CONSTRAINT `riwayat_jabatan_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `riwayat_naik_gaji`
-- ----------------------------
DROP TABLE IF EXISTS `riwayat_naik_gaji`;
CREATE TABLE `riwayat_naik_gaji` (
  `id` int(11) NOT NULL,
  `pangkatjabatan` varchar(50) NOT NULL,
  `gapok` double NOT NULL,
  `tmt_berkala` date NOT NULL,
  `tmt_berkala_yad` date NOT NULL,
  `no_sk` varchar(25) NOT NULL,
  `tgl_sk` date NOT NULL,
  `masa_kerja` int(11) NOT NULL,
  `bulan_kerja` int(11) NOT NULL,
  PRIMARY KEY (`id`,`pangkatjabatan`,`gapok`),
  CONSTRAINT `riwayat_naik_gaji_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `riwayat_pendidikan`
-- ----------------------------
DROP TABLE IF EXISTS `riwayat_pendidikan`;
CREATE TABLE `riwayat_pendidikan` (
  `id` int(11) NOT NULL,
  `pendidikan` enum('SD','SMP','SMA','SMK','D I','D II','D III','D IV','S1','S2','S3','Post Doctor') NOT NULL,
  `sekolah` varchar(50) NOT NULL,
  `jurusan` varchar(40) NOT NULL,
  `thn_lulus` year(4) NOT NULL,
  `kepala` varchar(50) NOT NULL,
  `pendanaan` enum('Biaya Sendiri','Biaya Instansi Sendiri','Lembaga Swasta Kerjasama','Lembaga Swasta Kompetisi','Lembaga Pemerintah Kerjasama','Lembaga Pemerintah Kompetisi','Lembaga Internasional') NOT NULL,
  `keterangan` varchar(50) NOT NULL,
  `status` varchar(40) NOT NULL,
  PRIMARY KEY (`id`,`pendidikan`,`sekolah`),
  CONSTRAINT `riwayat_pendidikan_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `riwayat_seminar`
-- ----------------------------
DROP TABLE IF EXISTS `riwayat_seminar`;
CREATE TABLE `riwayat_seminar` (
  `id` int(11) NOT NULL,
  `tingkat` enum('Local','Regional','Nasional','Internasional') NOT NULL,
  `jenis` enum('WORKSHOP','SIMPOSIUM','SEMINAR','FGD','PELATIHAN','LAINNYA') NOT NULL,
  `nama_seminar` varchar(50) NOT NULL,
  `peranan` varchar(40) NOT NULL,
  `mulai` date NOT NULL,
  `selesai` date NOT NULL,
  `penyelengara` varchar(50) NOT NULL,
  `tempat` varchar(50) NOT NULL,
  PRIMARY KEY (`id`,`nama_seminar`,`mulai`),
  KEY `id` (`id`),
  CONSTRAINT `riwayat_seminar_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `rujuk`
-- ----------------------------
DROP TABLE IF EXISTS `rujuk`;
CREATE TABLE `rujuk` (
  `no_rujuk` varchar(10) NOT NULL,
  `no_rawat` varchar(17) DEFAULT NULL,
  `rujuk_ke` varchar(45) DEFAULT NULL,
  `tgl_rujuk` date DEFAULT NULL,
  `keterangan_diagnosa` text,
  `kd_dokter` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`no_rujuk`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_dokter` (`kd_dokter`),
  CONSTRAINT `rujuk_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rujuk_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `rujuk_masuk`
-- ----------------------------
DROP TABLE IF EXISTS `rujuk_masuk`;
CREATE TABLE `rujuk_masuk` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `perujuk` varchar(60) DEFAULT NULL,
  `alamat` varchar(70) NOT NULL,
  `no_rujuk` varchar(20) NOT NULL,
  `jm_perujuk` double NOT NULL,
  `dokter_perujuk` varchar(50) DEFAULT NULL,
  `kd_penyakit` varchar(10) DEFAULT NULL,
  `kategori_rujuk` enum('-','Bedah','Non Bedah','Kebidanan','Anak') DEFAULT NULL,
  `keterangan` varchar(200) DEFAULT NULL,
  `no_balasan` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`no_rawat`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_dokter` (`perujuk`),
  KEY `perujuk` (`perujuk`),
  KEY `alamat` (`alamat`),
  KEY `jm_perujuk` (`jm_perujuk`),
  CONSTRAINT `rujuk_masuk_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `rujukanranap_dokter_rs`
-- ----------------------------
DROP TABLE IF EXISTS `rujukanranap_dokter_rs`;
CREATE TABLE `rujukanranap_dokter_rs` (
  `tanggal` date NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  `no_rkm_medis` varchar(15) NOT NULL,
  `kd_kamar` varchar(15) NOT NULL,
  `jasarujuk` double NOT NULL,
  PRIMARY KEY (`tanggal`,`kd_dokter`,`no_rkm_medis`,`kd_kamar`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  KEY `kd_kamar` (`kd_kamar`),
  KEY `rujukanranap_dokter_rs_ibfk_1` (`kd_dokter`),
  CONSTRAINT `rujukanranap_dokter_rs_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rujukanranap_dokter_rs_ibfk_2` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON UPDATE CASCADE,
  CONSTRAINT `rujukanranap_dokter_rs_ibfk_3` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `runtext`
-- ----------------------------
DROP TABLE IF EXISTS `runtext`;
CREATE TABLE `runtext` (
  `teks` text NOT NULL,
  `aktifkan` enum('Yes','No') NOT NULL,
  `gambar` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_akte`
-- ----------------------------
DROP TABLE IF EXISTS `set_akte`;
CREATE TABLE `set_akte` (
  `tahun` year(4) NOT NULL,
  `bulan` tinyint(4) NOT NULL,
  `pendapatan_akte` double NOT NULL,
  `persen_rs` double NOT NULL,
  `bagian_rs` double NOT NULL,
  `persen_kry` double NOT NULL,
  `bagian_kry` double NOT NULL,
  PRIMARY KEY (`tahun`,`bulan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_akun`
-- ----------------------------
DROP TABLE IF EXISTS `set_akun`;
CREATE TABLE `set_akun` (
  `Pengadaan_Obat` varchar(15) DEFAULT NULL,
  `Pemesanan_Obat` varchar(15) DEFAULT NULL,
  `Kontra_Pemesanan_Obat` varchar(15) DEFAULT NULL,
  `Bayar_Pemesanan_Obat` varchar(15) DEFAULT NULL,
  `Penjualan_Obat` varchar(15) DEFAULT NULL,
  `Piutang_Obat` varchar(15) DEFAULT NULL,
  `Kontra_Piutang_Obat` varchar(15) DEFAULT NULL,
  `Retur_Ke_Suplayer` varchar(15) DEFAULT NULL,
  `Kontra_Retur_Ke_Suplayer` varchar(15) DEFAULT NULL,
  `Retur_Dari_pembeli` varchar(15) DEFAULT NULL,
  `Kontra_Retur_Dari_Pembeli` varchar(15) DEFAULT NULL,
  `Retur_Piutang_Obat` varchar(15) DEFAULT NULL,
  `Kontra_Retur_Piutang_Obat` varchar(15) DEFAULT NULL,
  `Pengadaan_Ipsrs` varchar(15) DEFAULT NULL,
  `Stok_Keluar_Ipsrs` varchar(15) DEFAULT NULL,
  `Kontra_Stok_Keluar_Ipsrs` varchar(15) DEFAULT NULL,
  `Bayar_Piutang_Pasien` varchar(15) DEFAULT NULL,
  `Pengambilan_Utd` varchar(15) DEFAULT NULL,
  `Kontra_Pengambilan_Utd` varchar(15) DEFAULT NULL,
  `Pengambilan_Penunjang_Utd` varchar(15) DEFAULT NULL,
  `Kontra_Pengambilan_Penunjang_Utd` varchar(15) DEFAULT NULL,
  `Penyerahan_Darah` varchar(15) DEFAULT NULL,
  KEY `Pengadaan_Obat` (`Pengadaan_Obat`),
  KEY `Pemesanan_Obat` (`Pemesanan_Obat`),
  KEY `Kontra_Pemesanan_Obat` (`Kontra_Pemesanan_Obat`),
  KEY `Bayar_Pemesanan_Obat` (`Bayar_Pemesanan_Obat`),
  KEY `Penjualan_Obat` (`Penjualan_Obat`),
  KEY `Piutang_Obat` (`Piutang_Obat`),
  KEY `Kontra_Piutang_Obat` (`Kontra_Piutang_Obat`),
  KEY `Retur_Ke_Suplayer` (`Retur_Ke_Suplayer`),
  KEY `Kontra_Retur_Ke_Suplayer` (`Kontra_Retur_Ke_Suplayer`),
  KEY `Retur_Dari_pembeli` (`Retur_Dari_pembeli`),
  KEY `Kontra_Retur_Dari_Pembeli` (`Kontra_Retur_Dari_Pembeli`),
  KEY `Retur_Piutang_Obat` (`Retur_Piutang_Obat`),
  KEY `Kontra_Retur_Piutang_Obat` (`Kontra_Retur_Piutang_Obat`),
  KEY `Pengadaan_Ipsrs` (`Pengadaan_Ipsrs`),
  KEY `Stok_Keluar_Ipsrs` (`Stok_Keluar_Ipsrs`),
  KEY `Kontra_Stok_Keluar_Ipsrs` (`Kontra_Stok_Keluar_Ipsrs`),
  KEY `Bayar_Piutang_Pasien` (`Bayar_Piutang_Pasien`),
  KEY `Pengambilan_Utd` (`Pengambilan_Utd`),
  KEY `Kontra_Pengambilan_Utd` (`Kontra_Pengambilan_Utd`),
  KEY `Pengambilan_Penunjang_Utd` (`Pengambilan_Penunjang_Utd`),
  KEY `Kontra_Pengambilan_Penunjang_Utd` (`Kontra_Pengambilan_Penunjang_Utd`),
  KEY `Penyerahan_Darah` (`Penyerahan_Darah`),
  CONSTRAINT `set_akun_ibfk_1` FOREIGN KEY (`Pengadaan_Obat`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_10` FOREIGN KEY (`Retur_Dari_pembeli`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_11` FOREIGN KEY (`Kontra_Retur_Dari_Pembeli`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_12` FOREIGN KEY (`Retur_Piutang_Obat`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_13` FOREIGN KEY (`Kontra_Retur_Piutang_Obat`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_14` FOREIGN KEY (`Pengadaan_Ipsrs`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_15` FOREIGN KEY (`Stok_Keluar_Ipsrs`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_16` FOREIGN KEY (`Kontra_Stok_Keluar_Ipsrs`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_17` FOREIGN KEY (`Bayar_Piutang_Pasien`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_18` FOREIGN KEY (`Pengambilan_Utd`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_19` FOREIGN KEY (`Kontra_Pengambilan_Utd`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_2` FOREIGN KEY (`Pemesanan_Obat`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_20` FOREIGN KEY (`Pengambilan_Penunjang_Utd`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_21` FOREIGN KEY (`Kontra_Pengambilan_Penunjang_Utd`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_22` FOREIGN KEY (`Penyerahan_Darah`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_3` FOREIGN KEY (`Kontra_Pemesanan_Obat`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_4` FOREIGN KEY (`Bayar_Pemesanan_Obat`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_5` FOREIGN KEY (`Penjualan_Obat`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_6` FOREIGN KEY (`Piutang_Obat`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_7` FOREIGN KEY (`Kontra_Piutang_Obat`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_8` FOREIGN KEY (`Retur_Ke_Suplayer`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_9` FOREIGN KEY (`Kontra_Retur_Ke_Suplayer`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_akun_ralan`
-- ----------------------------
DROP TABLE IF EXISTS `set_akun_ralan`;
CREATE TABLE `set_akun_ralan` (
  `Tindakan_Ralan` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Dokter_Tindakan_Ralan` varchar(15) DEFAULT NULL,
  `Utang_Jasa_Medik_Dokter_Tindakan_Ralan` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Paramedis_Tindakan_Ralan` varchar(15) DEFAULT NULL,
  `Utang_Jasa_Medik_Paramedis_Tindakan_Ralan` varchar(15) DEFAULT NULL,
  `Beban_KSO_Tindakan_Ralan` varchar(15) NOT NULL,
  `Utang_KSO_Tindakan_Ralan` varchar(15) NOT NULL,
  `Laborat_Ralan` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Dokter_Laborat_Ralan` varchar(15) DEFAULT NULL,
  `Utang_Jasa_Medik_Dokter_Laborat_Ralan` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Petugas_Laborat_Ralan` varchar(15) DEFAULT NULL,
  `Utang_Jasa_Medik_Petugas_Laborat_Ralan` varchar(15) DEFAULT NULL,
  `Beban_Kso_Laborat_Ralan` varchar(15) DEFAULT NULL,
  `Utang_Kso_Laborat_Ralan` varchar(15) DEFAULT NULL,
  `HPP_Persediaan_Laborat_Rawat_Jalan` varchar(15) DEFAULT NULL,
  `Persediaan_BHP_Laborat_Rawat_Jalan` varchar(15) DEFAULT NULL,
  `Radiologi_Ralan` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Dokter_Radiologi_Ralan` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Dokter_Radiologi_Ralan` varchar(15) NOT NULL,
  `Beban_Jasa_Medik_Petugas_Radiologi_Ralan` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Petugas_Radiologi_Ralan` varchar(15) NOT NULL,
  `Beban_Kso_Radiologi_Ralan` varchar(15) NOT NULL,
  `Utang_Kso_Radiologi_Ralan` varchar(15) NOT NULL,
  `HPP_Persediaan_Radiologi_Rawat_Jalan` varchar(15) NOT NULL,
  `Persediaan_BHP_Radiologi_Rawat_Jalan` varchar(15) NOT NULL,
  `Obat_Ralan` varchar(15) DEFAULT NULL,
  `HPP_Obat_Rawat_Jalan` varchar(15) NOT NULL,
  `Persediaan_Obat_Rawat_Jalan` varchar(15) NOT NULL,
  `Registrasi_Ralan` varchar(15) DEFAULT NULL,
  `Operasi_Ralan` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Dokter_Operasi_Ralan` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Dokter_Operasi_Ralan` varchar(15) NOT NULL,
  `Beban_Jasa_Medik_Paramedis_Operasi_Ralan` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Paramedis_Operasi_Ralan` varchar(15) NOT NULL,
  `HPP_Obat_Operasi_Ralan` varchar(15) NOT NULL,
  `Persediaan_Obat_Kamar_Operasi_Ralan` varchar(15) NOT NULL,
  `Tambahan_Ralan` varchar(15) DEFAULT NULL,
  `Potongan_Ralan` varchar(15) DEFAULT NULL,
  KEY `Tindakan_Ralan` (`Tindakan_Ralan`),
  KEY `Beban_Jasa_Medik_Dokter_Tindakan_Ralan` (`Beban_Jasa_Medik_Dokter_Tindakan_Ralan`),
  KEY `Utang_Jasa_Medik_Dokter_Tindakan_Ralan` (`Utang_Jasa_Medik_Dokter_Tindakan_Ralan`),
  KEY `Beban_Jasa_Medik_Paramedis_Tindakan_Ralan` (`Beban_Jasa_Medik_Paramedis_Tindakan_Ralan`),
  KEY `Utang_Jasa_Medik_Paramedis_Tindakan_Ralan` (`Utang_Jasa_Medik_Paramedis_Tindakan_Ralan`),
  KEY `Beban_KSO_Tindakan_Ralan` (`Beban_KSO_Tindakan_Ralan`),
  KEY `Utang_KSO_Tindakan_Ralan` (`Utang_KSO_Tindakan_Ralan`),
  KEY `Laborat_Ralan` (`Laborat_Ralan`),
  KEY `Beban_Jasa_Medik_Dokter_Laborat_Ralan` (`Beban_Jasa_Medik_Dokter_Laborat_Ralan`),
  KEY `Utang_Jasa_Medik_Dokter_Laborat_Ralan` (`Utang_Jasa_Medik_Dokter_Laborat_Ralan`),
  KEY `Beban_Jasa_Medik_Petugas_Laborat_Ralan` (`Beban_Jasa_Medik_Petugas_Laborat_Ralan`),
  KEY `Utang_Jasa_Medik_Petugas_Laborat_Ralan` (`Utang_Jasa_Medik_Petugas_Laborat_Ralan`),
  KEY `Beban_Kso_Laborat_Ralan` (`Beban_Kso_Laborat_Ralan`),
  KEY `Utang_Kso_Laborat_Ralan` (`Utang_Kso_Laborat_Ralan`),
  KEY `HPP_Persediaan_Laborat_Rawat_Jalan` (`HPP_Persediaan_Laborat_Rawat_Jalan`),
  KEY `Persediaan_BHP_Laborat_Rawat_Jalan` (`Persediaan_BHP_Laborat_Rawat_Jalan`),
  KEY `Radiologi_Ralan` (`Radiologi_Ralan`),
  KEY `Beban_Jasa_Medik_Dokter_Radiologi_Ralan` (`Beban_Jasa_Medik_Dokter_Radiologi_Ralan`),
  KEY `Utang_Jasa_Medik_Dokter_Radiologi_Ralan` (`Utang_Jasa_Medik_Dokter_Radiologi_Ralan`),
  KEY `Beban_Jasa_Medik_Petugas_Radiologi_Ralan` (`Beban_Jasa_Medik_Petugas_Radiologi_Ralan`),
  KEY `Utang_Jasa_Medik_Petugas_Radiologi_Ralan` (`Utang_Jasa_Medik_Petugas_Radiologi_Ralan`),
  KEY `Beban_Kso_Radiologi_Ralan` (`Beban_Kso_Radiologi_Ralan`),
  KEY `Utang_Kso_Radiologi_Ralan` (`Utang_Kso_Radiologi_Ralan`),
  KEY `HPP_Persediaan_Radiologi_Rawat_Jalan` (`HPP_Persediaan_Radiologi_Rawat_Jalan`),
  KEY `Persediaan_BHP_Radiologi_Rawat_Jalan` (`Persediaan_BHP_Radiologi_Rawat_Jalan`),
  KEY `Obat_Ralan` (`Obat_Ralan`),
  KEY `HPP_Obat_Rawat_Jalan` (`HPP_Obat_Rawat_Jalan`),
  KEY `Persediaan_Obat_Rawat_Jalan` (`Persediaan_Obat_Rawat_Jalan`),
  KEY `Registrasi_Ralan` (`Registrasi_Ralan`),
  KEY `Operasi_Ralan` (`Operasi_Ralan`),
  KEY `Beban_Jasa_Medik_Dokter_Operasi_Ralan` (`Beban_Jasa_Medik_Dokter_Operasi_Ralan`),
  KEY `Utang_Jasa_Medik_Dokter_Operasi_Ralan` (`Utang_Jasa_Medik_Dokter_Operasi_Ralan`),
  KEY `Beban_Jasa_Medik_Paramedis_Operasi_Ralan` (`Beban_Jasa_Medik_Paramedis_Operasi_Ralan`),
  KEY `Utang_Jasa_Medik_Paramedis_Operasi_Ralan` (`Utang_Jasa_Medik_Paramedis_Operasi_Ralan`),
  KEY `HPP_Obat_Operasi_Ralan` (`HPP_Obat_Operasi_Ralan`),
  KEY `Persediaan_Obat_Kamar_Operasi_Ralan` (`Persediaan_Obat_Kamar_Operasi_Ralan`),
  KEY `Tambahan_Ralan` (`Tambahan_Ralan`),
  KEY `Potongan_Ralan` (`Potongan_Ralan`),
  CONSTRAINT `set_akun_ralan_ibfk_1` FOREIGN KEY (`Tindakan_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_10` FOREIGN KEY (`Beban_Jasa_Medik_Dokter_Radiologi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_11` FOREIGN KEY (`Utang_Jasa_Medik_Dokter_Radiologi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_12` FOREIGN KEY (`Beban_Jasa_Medik_Dokter_Tindakan_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_13` FOREIGN KEY (`Beban_Jasa_Medik_Petugas_Radiologi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_14` FOREIGN KEY (`Utang_Jasa_Medik_Petugas_Radiologi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_15` FOREIGN KEY (`Beban_Kso_Radiologi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_16` FOREIGN KEY (`Utang_Kso_Radiologi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_17` FOREIGN KEY (`HPP_Persediaan_Radiologi_Rawat_Jalan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_18` FOREIGN KEY (`Persediaan_BHP_Radiologi_Rawat_Jalan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_19` FOREIGN KEY (`Obat_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_2` FOREIGN KEY (`Utang_Jasa_Medik_Dokter_Laborat_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_20` FOREIGN KEY (`HPP_Obat_Rawat_Jalan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_21` FOREIGN KEY (`Persediaan_Obat_Rawat_Jalan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_22` FOREIGN KEY (`Registrasi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_23` FOREIGN KEY (`Utang_Jasa_Medik_Dokter_Tindakan_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_24` FOREIGN KEY (`Operasi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_25` FOREIGN KEY (`Beban_Jasa_Medik_Dokter_Operasi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_26` FOREIGN KEY (`Utang_Jasa_Medik_Dokter_Operasi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_27` FOREIGN KEY (`Beban_Jasa_Medik_Paramedis_Operasi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_28` FOREIGN KEY (`Utang_Jasa_Medik_Paramedis_Operasi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_29` FOREIGN KEY (`HPP_Obat_Operasi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_3` FOREIGN KEY (`Beban_Jasa_Medik_Petugas_Laborat_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_30` FOREIGN KEY (`Persediaan_Obat_Kamar_Operasi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_31` FOREIGN KEY (`Tambahan_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_32` FOREIGN KEY (`Potongan_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_33` FOREIGN KEY (`Beban_Jasa_Medik_Paramedis_Tindakan_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_34` FOREIGN KEY (`Utang_Jasa_Medik_Paramedis_Tindakan_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_35` FOREIGN KEY (`Beban_KSO_Tindakan_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_36` FOREIGN KEY (`Utang_KSO_Tindakan_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_37` FOREIGN KEY (`Laborat_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_38` FOREIGN KEY (`Beban_Jasa_Medik_Dokter_Laborat_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_4` FOREIGN KEY (`Utang_Jasa_Medik_Petugas_Laborat_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_5` FOREIGN KEY (`Beban_Kso_Laborat_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_6` FOREIGN KEY (`Utang_Kso_Laborat_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_7` FOREIGN KEY (`HPP_Persediaan_Laborat_Rawat_Jalan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_8` FOREIGN KEY (`Persediaan_BHP_Laborat_Rawat_Jalan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_9` FOREIGN KEY (`Radiologi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_akun_ranap`
-- ----------------------------
DROP TABLE IF EXISTS `set_akun_ranap`;
CREATE TABLE `set_akun_ranap` (
  `Suspen_Piutang_Tindakan_Ranap` varchar(15) NOT NULL,
  `Tindakan_Ranap` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Dokter_Tindakan_Ranap` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Dokter_Tindakan_Ranap` varchar(15) NOT NULL,
  `Beban_Jasa_Medik_Paramedis_Tindakan_Ranap` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Paramedis_Tindakan_Ranap` varchar(15) NOT NULL,
  `Beban_KSO_Tindakan_Ranap` varchar(15) NOT NULL,
  `Utang_KSO_Tindakan_Ranap` varchar(15) NOT NULL,
  `Suspen_Piutang_Laborat_Ranap` varchar(15) NOT NULL,
  `Laborat_Ranap` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Dokter_Laborat_Ranap` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Dokter_Laborat_Ranap` varchar(15) NOT NULL,
  `Beban_Jasa_Medik_Petugas_Laborat_Ranap` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Petugas_Laborat_Ranap` varchar(15) NOT NULL,
  `Beban_Kso_Laborat_Ranap` varchar(15) NOT NULL,
  `Utang_Kso_Laborat_Ranap` varchar(15) NOT NULL,
  `HPP_Persediaan_Laborat_Rawat_inap` varchar(15) NOT NULL,
  `Persediaan_BHP_Laborat_Rawat_Inap` varchar(15) NOT NULL,
  `Suspen_Piutang_Radiologi_Ranap` varchar(15) NOT NULL,
  `Radiologi_Ranap` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Dokter_Radiologi_Ranap` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Dokter_Radiologi_Ranap` varchar(15) NOT NULL,
  `Beban_Jasa_Medik_Petugas_Radiologi_Ranap` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Petugas_Radiologi_Ranap` varchar(15) NOT NULL,
  `Beban_Kso_Radiologi_Ranap` varchar(15) NOT NULL,
  `Utang_Kso_Radiologi_Ranap` varchar(15) NOT NULL,
  `HPP_Persediaan_Radiologi_Rawat_Inap` varchar(15) NOT NULL,
  `Persediaan_BHP_Radiologi_Rawat_Inap` varchar(15) NOT NULL,
  `Suspen_Piutang_Obat_Ranap` varchar(15) NOT NULL,
  `Obat_Ranap` varchar(15) DEFAULT NULL,
  `HPP_Obat_Rawat_Inap` varchar(15) NOT NULL,
  `Persediaan_Obat_Rawat_Inap` varchar(15) NOT NULL,
  `Registrasi_Ranap` varchar(15) DEFAULT NULL,
  `Service_Ranap` varchar(15) DEFAULT NULL,
  `Tambahan_Ranap` varchar(15) DEFAULT NULL,
  `Potongan_Ranap` varchar(15) DEFAULT NULL,
  `Retur_Obat_Ranap` varchar(15) DEFAULT NULL,
  `Resep_Pulang_Ranap` varchar(15) DEFAULT NULL,
  `Kamar_Inap` varchar(15) DEFAULT NULL,
  `Suspen_Piutang_Operasi_Ranap` varchar(15) NOT NULL,
  `Operasi_Ranap` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Dokter_Operasi_Ranap` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Dokter_Operasi_Ranap` varchar(15) NOT NULL,
  `Beban_Jasa_Medik_Paramedis_Operasi_Ranap` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Paramedis_Operasi_Ranap` varchar(15) NOT NULL,
  `HPP_Obat_Operasi_Ranap` varchar(15) NOT NULL,
  `Persediaan_Obat_Kamar_Operasi_Ranap` varchar(15) NOT NULL,
  `Harian_Ranap` varchar(15) DEFAULT NULL,
  `Uang_Muka_Ranap` varchar(15) DEFAULT NULL,
  `Piutang_Pasien_Ranap` varchar(15) DEFAULT NULL,
  KEY `Suspen_Piutang_Tindakan_Ranap` (`Suspen_Piutang_Tindakan_Ranap`),
  KEY `Tindakan_Ranap` (`Tindakan_Ranap`),
  KEY `Beban_Jasa_Medik_Dokter_Tindakan_Ranap` (`Beban_Jasa_Medik_Dokter_Tindakan_Ranap`),
  KEY `Utang_Jasa_Medik_Dokter_Tindakan_Ranap` (`Utang_Jasa_Medik_Dokter_Tindakan_Ranap`),
  KEY `Beban_Jasa_Medik_Paramedis_Tindakan_Ranap` (`Beban_Jasa_Medik_Paramedis_Tindakan_Ranap`),
  KEY `Utang_Jasa_Medik_Paramedis_Tindakan_Ranap` (`Utang_Jasa_Medik_Paramedis_Tindakan_Ranap`),
  KEY `Beban_KSO_Tindakan_Ranap` (`Beban_KSO_Tindakan_Ranap`),
  KEY `Utang_KSO_Tindakan_Ranap` (`Utang_KSO_Tindakan_Ranap`),
  KEY `Suspen_Piutang_Laborat_Ranap` (`Suspen_Piutang_Laborat_Ranap`),
  KEY `Laborat_Ranap` (`Laborat_Ranap`),
  KEY `Beban_Jasa_Medik_Dokter_Laborat_Ranap` (`Beban_Jasa_Medik_Dokter_Laborat_Ranap`),
  KEY `Utang_Jasa_Medik_Dokter_Laborat_Ranap` (`Utang_Jasa_Medik_Dokter_Laborat_Ranap`),
  KEY `Beban_Jasa_Medik_Petugas_Laborat_Ranap` (`Beban_Jasa_Medik_Petugas_Laborat_Ranap`),
  KEY `Utang_Jasa_Medik_Petugas_Laborat_Ranap` (`Utang_Jasa_Medik_Petugas_Laborat_Ranap`),
  KEY `Beban_Kso_Laborat_Ranap` (`Beban_Kso_Laborat_Ranap`),
  KEY `Utang_Kso_Laborat_Ranap` (`Utang_Kso_Laborat_Ranap`),
  KEY `HPP_Persediaan_Laborat_Rawat_inap` (`HPP_Persediaan_Laborat_Rawat_inap`),
  KEY `Persediaan_BHP_Laborat_Rawat_Inap` (`Persediaan_BHP_Laborat_Rawat_Inap`),
  KEY `Suspen_Piutang_Radiologi_Ranap` (`Suspen_Piutang_Radiologi_Ranap`),
  KEY `Radiologi_Ranap` (`Radiologi_Ranap`),
  KEY `Beban_Jasa_Medik_Dokter_Radiologi_Ranap` (`Beban_Jasa_Medik_Dokter_Radiologi_Ranap`),
  KEY `Utang_Jasa_Medik_Dokter_Radiologi_Ranap` (`Utang_Jasa_Medik_Dokter_Radiologi_Ranap`),
  KEY `Beban_Jasa_Medik_Petugas_Radiologi_Ranap` (`Beban_Jasa_Medik_Petugas_Radiologi_Ranap`),
  KEY `Utang_Jasa_Medik_Petugas_Radiologi_Ranap` (`Utang_Jasa_Medik_Petugas_Radiologi_Ranap`),
  KEY `Beban_Kso_Radiologi_Ranap` (`Beban_Kso_Radiologi_Ranap`),
  KEY `Utang_Kso_Radiologi_Ranap` (`Utang_Kso_Radiologi_Ranap`),
  KEY `HPP_Persediaan_Radiologi_Rawat_Inap` (`HPP_Persediaan_Radiologi_Rawat_Inap`),
  KEY `Persediaan_BHP_Radiologi_Rawat_Inap` (`Persediaan_BHP_Radiologi_Rawat_Inap`),
  KEY `Obat_Ranap` (`Obat_Ranap`),
  KEY `Registrasi_Ranap` (`Registrasi_Ranap`),
  KEY `Service_Ranap` (`Service_Ranap`),
  KEY `Tambahan_Ranap` (`Tambahan_Ranap`),
  KEY `Potongan_Ranap` (`Potongan_Ranap`),
  KEY `Retur_Obat_Ranap` (`Retur_Obat_Ranap`),
  KEY `Resep_Pulang_Ranap` (`Resep_Pulang_Ranap`),
  KEY `Kamar_Inap` (`Kamar_Inap`),
  KEY `Operasi_Ranap` (`Operasi_Ranap`),
  KEY `Harian_Ranap` (`Harian_Ranap`),
  KEY `Uang_Muka_Ranap` (`Uang_Muka_Ranap`),
  KEY `Piutang_Pasien_Ranap` (`Piutang_Pasien_Ranap`),
  KEY `Suspen_Piutang_Obat_Ranap` (`Suspen_Piutang_Obat_Ranap`),
  KEY `HPP_Obat_Rawat_Inap` (`HPP_Obat_Rawat_Inap`),
  KEY `Persediaan_Obat_Rawat_Inap` (`Persediaan_Obat_Rawat_Inap`),
  KEY `Suspen_Piutang_Operasi_Ranap` (`Suspen_Piutang_Operasi_Ranap`),
  KEY `Beban_Jasa_Medik_Dokter_Operasi_Ranap` (`Beban_Jasa_Medik_Dokter_Operasi_Ranap`),
  KEY `Utang_Jasa_Medik_Dokter_Operasi_Ranap` (`Utang_Jasa_Medik_Dokter_Operasi_Ranap`),
  KEY `Beban_Jasa_Medik_Paramedis_Operasi_Ranap` (`Beban_Jasa_Medik_Paramedis_Operasi_Ranap`),
  KEY `Utang_Jasa_Medik_Paramedis_Operasi_Ranap` (`Utang_Jasa_Medik_Paramedis_Operasi_Ranap`),
  KEY `HPP_Obat_Operasi_Ranap` (`HPP_Obat_Operasi_Ranap`),
  KEY `Persediaan_Obat_Kamar_Operasi_Ranap` (`Persediaan_Obat_Kamar_Operasi_Ranap`),
  CONSTRAINT `set_akun_ranap_ibfk_1` FOREIGN KEY (`Suspen_Piutang_Tindakan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_10` FOREIGN KEY (`Beban_Kso_Radiologi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_11` FOREIGN KEY (`Utang_Kso_Radiologi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_12` FOREIGN KEY (`Laborat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_13` FOREIGN KEY (`HPP_Persediaan_Radiologi_Rawat_Inap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_14` FOREIGN KEY (`Persediaan_BHP_Radiologi_Rawat_Inap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_15` FOREIGN KEY (`Obat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_16` FOREIGN KEY (`Beban_Jasa_Medik_Dokter_Tindakan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_17` FOREIGN KEY (`Registrasi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_18` FOREIGN KEY (`Service_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_19` FOREIGN KEY (`Tambahan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_2` FOREIGN KEY (`Persediaan_BHP_Laborat_Rawat_Inap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_20` FOREIGN KEY (`Potongan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_21` FOREIGN KEY (`Retur_Obat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_22` FOREIGN KEY (`Resep_Pulang_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_23` FOREIGN KEY (`Beban_Jasa_Medik_Dokter_Laborat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_24` FOREIGN KEY (`Kamar_Inap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_25` FOREIGN KEY (`Operasi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_26` FOREIGN KEY (`Harian_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_27` FOREIGN KEY (`Uang_Muka_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_28` FOREIGN KEY (`Utang_Jasa_Medik_Dokter_Tindakan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_29` FOREIGN KEY (`Piutang_Pasien_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_3` FOREIGN KEY (`Suspen_Piutang_Radiologi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_30` FOREIGN KEY (`Suspen_Piutang_Obat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_31` FOREIGN KEY (`HPP_Obat_Rawat_Inap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_32` FOREIGN KEY (`Persediaan_Obat_Rawat_Inap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_33` FOREIGN KEY (`Suspen_Piutang_Operasi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_34` FOREIGN KEY (`Utang_Jasa_Medik_Dokter_Laborat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_35` FOREIGN KEY (`Beban_Jasa_Medik_Dokter_Operasi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_36` FOREIGN KEY (`Utang_Jasa_Medik_Dokter_Operasi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_37` FOREIGN KEY (`Beban_Jasa_Medik_Paramedis_Operasi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_38` FOREIGN KEY (`Utang_Jasa_Medik_Paramedis_Operasi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_39` FOREIGN KEY (`HPP_Obat_Operasi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_4` FOREIGN KEY (`Tindakan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_40` FOREIGN KEY (`Beban_Jasa_Medik_Paramedis_Tindakan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_41` FOREIGN KEY (`Persediaan_Obat_Kamar_Operasi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_42` FOREIGN KEY (`Utang_Jasa_Medik_Paramedis_Tindakan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_43` FOREIGN KEY (`Beban_KSO_Tindakan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_44` FOREIGN KEY (`Utang_KSO_Tindakan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_45` FOREIGN KEY (`Beban_Jasa_Medik_Petugas_Laborat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_46` FOREIGN KEY (`Suspen_Piutang_Laborat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_47` FOREIGN KEY (`Utang_Jasa_Medik_Petugas_Laborat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_48` FOREIGN KEY (`Beban_Kso_Laborat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_49` FOREIGN KEY (`Utang_Kso_Laborat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_5` FOREIGN KEY (`Radiologi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_50` FOREIGN KEY (`HPP_Persediaan_Laborat_Rawat_inap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_6` FOREIGN KEY (`Beban_Jasa_Medik_Dokter_Radiologi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_7` FOREIGN KEY (`Utang_Jasa_Medik_Dokter_Radiologi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_8` FOREIGN KEY (`Beban_Jasa_Medik_Petugas_Radiologi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_9` FOREIGN KEY (`Utang_Jasa_Medik_Petugas_Radiologi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_alamat_pasien`
-- ----------------------------
DROP TABLE IF EXISTS `set_alamat_pasien`;
CREATE TABLE `set_alamat_pasien` (
  `kelurahan` enum('true','false') DEFAULT NULL,
  `kecamatan` enum('true','false') DEFAULT NULL,
  `kabupaten` enum('true','false') DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

-- ----------------------------
--  Table structure for `set_embalase`
-- ----------------------------
DROP TABLE IF EXISTS `set_embalase`;
CREATE TABLE `set_embalase` (
  `embalase_per_obat` double NOT NULL,
  `tuslah_per_obat` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_hadir`
-- ----------------------------
DROP TABLE IF EXISTS `set_hadir`;
CREATE TABLE `set_hadir` (
  `tnj` double NOT NULL,
  PRIMARY KEY (`tnj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_harga_kamar`
-- ----------------------------
DROP TABLE IF EXISTS `set_harga_kamar`;
CREATE TABLE `set_harga_kamar` (
  `kd_kamar` varchar(15) NOT NULL,
  `kd_pj` char(3) NOT NULL,
  `tarif` double NOT NULL,
  PRIMARY KEY (`kd_kamar`,`kd_pj`),
  KEY `kd_pj` (`kd_pj`),
  CONSTRAINT `set_harga_kamar_ibfk_1` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `set_harga_kamar_ibfk_2` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_harga_obat_ralan`
-- ----------------------------
DROP TABLE IF EXISTS `set_harga_obat_ralan`;
CREATE TABLE `set_harga_obat_ralan` (
  `kd_pj` char(3) NOT NULL,
  `hargajual` double NOT NULL,
  PRIMARY KEY (`kd_pj`),
  CONSTRAINT `set_harga_obat_ralan_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_harga_obat_ranap`
-- ----------------------------
DROP TABLE IF EXISTS `set_harga_obat_ranap`;
CREATE TABLE `set_harga_obat_ranap` (
  `kd_pj` char(3) NOT NULL,
  `kelas` enum('Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') NOT NULL DEFAULT 'Kelas 1',
  `hargajual` double NOT NULL,
  PRIMARY KEY (`kd_pj`,`kelas`),
  CONSTRAINT `set_harga_obat_ranap_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_hari_libur`
-- ----------------------------
DROP TABLE IF EXISTS `set_hari_libur`;
CREATE TABLE `set_hari_libur` (
  `tanggal` date NOT NULL,
  `ktg` varchar(40) NOT NULL,
  PRIMARY KEY (`tanggal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_insentif`
-- ----------------------------
DROP TABLE IF EXISTS `set_insentif`;
CREATE TABLE `set_insentif` (
  `tahun` year(4) NOT NULL,
  `bulan` tinyint(4) NOT NULL,
  `pendapatan` double NOT NULL,
  `persen` double NOT NULL,
  `total_insentif` double NOT NULL,
  PRIMARY KEY (`tahun`,`bulan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_jam_minimal`
-- ----------------------------
DROP TABLE IF EXISTS `set_jam_minimal`;
CREATE TABLE `set_jam_minimal` (
  `lamajam` int(11) NOT NULL,
  `hariawal` enum('Yes','No') NOT NULL,
  `feeperujuk` double NOT NULL,
  `diagnosaakhir` enum('Yes','No') DEFAULT NULL,
  `bayi` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

-- ----------------------------
--  Table structure for `set_jgmlm`
-- ----------------------------
DROP TABLE IF EXISTS `set_jgmlm`;
CREATE TABLE `set_jgmlm` (
  `tnj` double NOT NULL,
  PRIMARY KEY (`tnj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_jgtambah`
-- ----------------------------
DROP TABLE IF EXISTS `set_jgtambah`;
CREATE TABLE `set_jgtambah` (
  `tnj` double NOT NULL,
  `pendidikan` varchar(80) NOT NULL,
  PRIMARY KEY (`pendidikan`),
  CONSTRAINT `set_jgtambah_ibfk_1` FOREIGN KEY (`pendidikan`) REFERENCES `pendidikan` (`tingkat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_kelengkapan_data_pasien`
-- ----------------------------
DROP TABLE IF EXISTS `set_kelengkapan_data_pasien`;
CREATE TABLE `set_kelengkapan_data_pasien` (
  `no_ktp` enum('Yes','No') DEFAULT NULL,
  `p_no_ktp` tinyint(4) DEFAULT NULL,
  `tmp_lahir` enum('Yes','No') DEFAULT NULL,
  `p_tmp_lahir` tinyint(4) DEFAULT NULL,
  `nm_ibu` enum('Yes','No') DEFAULT NULL,
  `p_nm_ibu` tinyint(4) DEFAULT NULL,
  `alamat` enum('Yes','No') DEFAULT NULL,
  `p_alamat` tinyint(4) DEFAULT NULL,
  `pekerjaan` enum('Yes','No') DEFAULT NULL,
  `p_pekerjaan` tinyint(4) DEFAULT NULL,
  `no_tlp` enum('Yes','No') DEFAULT NULL,
  `p_no_tlp` tinyint(4) DEFAULT NULL,
  `umur` enum('Yes','No') DEFAULT NULL,
  `p_umur` tinyint(4) DEFAULT NULL,
  `namakeluarga` enum('Yes','No') DEFAULT NULL,
  `p_namakeluarga` tinyint(4) DEFAULT NULL,
  `no_peserta` enum('Yes','No') DEFAULT NULL,
  `p_no_peserta` tinyint(4) DEFAULT NULL,
  `kelurahan` enum('Yes','No') DEFAULT NULL,
  `p_kelurahan` tinyint(4) DEFAULT NULL,
  `kecamatan` enum('Yes','No') DEFAULT NULL,
  `p_kecamatan` tinyint(4) DEFAULT NULL,
  `kabupaten` enum('Yes','No') DEFAULT NULL,
  `p_kabupaten` tinyint(4) DEFAULT NULL,
  `pekerjaanpj` enum('Yes','No') DEFAULT NULL,
  `p_pekerjaanpj` tinyint(4) DEFAULT NULL,
  `alamatpj` enum('Yes','No') DEFAULT NULL,
  `p_alamatpj` tinyint(4) DEFAULT NULL,
  `kelurahanpj` enum('Yes','No') DEFAULT NULL,
  `p_kelurahanpj` tinyint(4) DEFAULT NULL,
  `kecamatanpj` enum('Yes','No') DEFAULT NULL,
  `p_kecamatanpj` tinyint(4) DEFAULT NULL,
  `kabupatenpj` enum('Yes','No') DEFAULT NULL,
  `p_kabupatenpj` tinyint(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

-- ----------------------------
--  Table structure for `set_keterlambatan`
-- ----------------------------
DROP TABLE IF EXISTS `set_keterlambatan`;
CREATE TABLE `set_keterlambatan` (
  `toleransi` int(11) DEFAULT NULL,
  `terlambat1` int(11) DEFAULT NULL,
  `terlambat2` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

-- ----------------------------
--  Table structure for `set_lemburhb`
-- ----------------------------
DROP TABLE IF EXISTS `set_lemburhb`;
CREATE TABLE `set_lemburhb` (
  `tnj` double NOT NULL,
  PRIMARY KEY (`tnj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_lemburhr`
-- ----------------------------
DROP TABLE IF EXISTS `set_lemburhr`;
CREATE TABLE `set_lemburhr` (
  `tnj` double NOT NULL,
  PRIMARY KEY (`tnj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_lokasi`
-- ----------------------------
DROP TABLE IF EXISTS `set_lokasi`;
CREATE TABLE `set_lokasi` (
  `kd_bangsal` char(5) NOT NULL,
  `asal_stok` enum('Gunakan Stok Utama Obat','Gunakan Stok Bangsal') NOT NULL,
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `set_lokasi_ibfk_1` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_modal_payment`
-- ----------------------------
DROP TABLE IF EXISTS `set_modal_payment`;
CREATE TABLE `set_modal_payment` (
  `modal_awal` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

-- ----------------------------
--  Table structure for `set_no_antrian`
-- ----------------------------
DROP TABLE IF EXISTS `set_no_antrian`;
CREATE TABLE `set_no_antrian` (
  `dasar_no_antrian` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_no_rkm_medis`
-- ----------------------------
DROP TABLE IF EXISTS `set_no_rkm_medis`;
CREATE TABLE `set_no_rkm_medis` (
  `no_rkm_medis` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_nota`
-- ----------------------------
DROP TABLE IF EXISTS `set_nota`;
CREATE TABLE `set_nota` (
  `notaralan` varchar(11) NOT NULL,
  `kwitansiralan` varchar(11) NOT NULL,
  `nota1ranap` varchar(11) NOT NULL,
  `nota2ranap` varchar(11) NOT NULL,
  `kwitansiranap` varchar(11) NOT NULL,
  `notaapotek` varchar(11) NOT NULL,
  `notalabrad` varchar(11) NOT NULL,
  `cetaknotasimpanralan` enum('Yes','No') NOT NULL,
  `cetaknotasimpanranap` enum('Yes','No') NOT NULL,
  `rinciandokterralan` enum('Yes','No') NOT NULL,
  `rinciandokterranap` enum('Yes','No') NOT NULL,
  `centangdokterralan` enum('Yes','No') NOT NULL,
  `centangdokterranap` enum('Yes','No') NOT NULL,
  `tampilkan_administrasi_di_billingranap` enum('Yes','No') NOT NULL,
  `rincianoperasi` enum('Yes','No') DEFAULT NULL,
  `tampilkan_ppnobat_ralan` enum('Yes','No') DEFAULT NULL,
  `tampilkan_ppnobat_ranap` enum('Yes','No') DEFAULT NULL,
  `tampilkan_tombol_nota_ralan` enum('Yes','No') DEFAULT NULL,
  `tampilkan_tombol_nota_ranap` enum('Yes','No') DEFAULT NULL,
  `verifikasi_penjualan_di_kasir` enum('Yes','No') DEFAULT NULL,
  `verifikasi_penyerahan_darah_di_kasir` enum('Yes','No') DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `set_otomatis_tindakan_ralan`
-- ----------------------------
DROP TABLE IF EXISTS `set_otomatis_tindakan_ralan`;
CREATE TABLE `set_otomatis_tindakan_ralan` (
  `kd_dokter` varchar(20) NOT NULL,
  `kd_jenis_prw` varchar(15) NOT NULL,
  `kd_pj` char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`kd_dokter`,`kd_jenis_prw`,`kd_pj`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `kd_pj` (`kd_pj`),
  CONSTRAINT `set_otomatis_tindakan_ralan_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `set_otomatis_tindakan_ralan_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `set_otomatis_tindakan_ralan_ibfk_3` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_pjlab`
-- ----------------------------
DROP TABLE IF EXISTS `set_pjlab`;
CREATE TABLE `set_pjlab` (
  `kd_dokterlab` varchar(20) NOT NULL,
  `kd_dokterrad` varchar(20) NOT NULL,
  `kd_dokterhemodialisa` varchar(20) NOT NULL,
  `kd_dokterutd` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kd_dokterlab`,`kd_dokterrad`,`kd_dokterhemodialisa`),
  KEY `kd_dokterrad` (`kd_dokterrad`),
  KEY `kd_dokterhemodialisa` (`kd_dokterhemodialisa`),
  KEY `kd_dokterutd` (`kd_dokterutd`),
  CONSTRAINT `set_pjlab_ibfk_1` FOREIGN KEY (`kd_dokterlab`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `set_pjlab_ibfk_2` FOREIGN KEY (`kd_dokterrad`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `set_pjlab_ibfk_3` FOREIGN KEY (`kd_dokterhemodialisa`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `set_pjlab_ibfk_4` FOREIGN KEY (`kd_dokterutd`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_resume`
-- ----------------------------
DROP TABLE IF EXISTS `set_resume`;
CREATE TABLE `set_resume` (
  `tahun` year(4) NOT NULL,
  `bulan` tinyint(4) NOT NULL,
  `pendapatan_resume` double NOT NULL,
  `persen_rs` double NOT NULL,
  `bagian_rs` double NOT NULL,
  `persen_kry` double NOT NULL,
  `bagian_kry` double NOT NULL,
  PRIMARY KEY (`tahun`,`bulan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_service_ranap`
-- ----------------------------
DROP TABLE IF EXISTS `set_service_ranap`;
CREATE TABLE `set_service_ranap` (
  `nama_service` varchar(100) NOT NULL DEFAULT '',
  `besar` double DEFAULT NULL,
  `laborat` enum('Yes','No') DEFAULT NULL,
  `radiologi` enum('Yes','No') DEFAULT NULL,
  `operasi` enum('Yes','No') DEFAULT NULL,
  `obat` enum('Yes','No') DEFAULT NULL,
  `ranap_dokter` enum('Yes','No') DEFAULT NULL,
  `ranap_paramedis` enum('Yes','No') DEFAULT NULL,
  `ralan_dokter` enum('Yes','No') DEFAULT NULL,
  `ralan_paramedis` enum('Yes','No') DEFAULT NULL,
  `tambahan` enum('Yes','No') DEFAULT NULL,
  `potongan` enum('Yes','No') DEFAULT NULL,
  `kamar` enum('Yes','No') DEFAULT NULL,
  `registrasi` enum('Yes','No') DEFAULT NULL,
  `harian` enum('Yes','No') DEFAULT NULL,
  `retur_Obat` enum('Yes','No') DEFAULT NULL,
  `resep_Pulang` enum('Yes','No') DEFAULT NULL,
  PRIMARY KEY (`nama_service`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_service_ranap_piutang`
-- ----------------------------
DROP TABLE IF EXISTS `set_service_ranap_piutang`;
CREATE TABLE `set_service_ranap_piutang` (
  `nama_service` varchar(100) NOT NULL DEFAULT '',
  `besar` double DEFAULT NULL,
  `laborat` enum('Yes','No') DEFAULT NULL,
  `radiologi` enum('Yes','No') DEFAULT NULL,
  `operasi` enum('Yes','No') DEFAULT NULL,
  `obat` enum('Yes','No') DEFAULT NULL,
  `ranap_dokter` enum('Yes','No') DEFAULT NULL,
  `ranap_paramedis` enum('Yes','No') DEFAULT NULL,
  `ralan_dokter` enum('Yes','No') DEFAULT NULL,
  `ralan_paramedis` enum('Yes','No') DEFAULT NULL,
  `tambahan` enum('Yes','No') DEFAULT NULL,
  `potongan` enum('Yes','No') DEFAULT NULL,
  `kamar` enum('Yes','No') DEFAULT NULL,
  `registrasi` enum('Yes','No') DEFAULT NULL,
  `harian` enum('Yes','No') DEFAULT NULL,
  `retur_Obat` enum('Yes','No') DEFAULT NULL,
  `resep_Pulang` enum('Yes','No') DEFAULT NULL,
  PRIMARY KEY (`nama_service`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_tahun`
-- ----------------------------
DROP TABLE IF EXISTS `set_tahun`;
CREATE TABLE `set_tahun` (
  `tahun` year(4) NOT NULL,
  `bulan` tinyint(2) NOT NULL,
  `jmlhr` int(11) NOT NULL,
  `jmllbr` int(11) NOT NULL,
  `normal` int(11) NOT NULL,
  PRIMARY KEY (`tahun`,`bulan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_tarif`
-- ----------------------------
DROP TABLE IF EXISTS `set_tarif`;
CREATE TABLE `set_tarif` (
  `poli_ralan` enum('Yes','No') NOT NULL,
  `cara_bayar_ralan` enum('Yes','No') NOT NULL,
  `ruang_ranap` enum('Yes','No') NOT NULL,
  `cara_bayar_ranap` enum('Yes','No') NOT NULL,
  `cara_bayar_lab` enum('Yes','No') NOT NULL,
  `cara_bayar_radiologi` enum('Yes','No') NOT NULL,
  `cara_bayar_operasi` enum('Yes','No') DEFAULT NULL,
  KEY `poli_ralan` (`poli_ralan`,`cara_bayar_ralan`,`ruang_ranap`,`cara_bayar_ranap`,`cara_bayar_lab`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_tnjanak`
-- ----------------------------
DROP TABLE IF EXISTS `set_tnjanak`;
CREATE TABLE `set_tnjanak` (
  `tnj` double NOT NULL,
  PRIMARY KEY (`tnj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_tnjnikah`
-- ----------------------------
DROP TABLE IF EXISTS `set_tnjnikah`;
CREATE TABLE `set_tnjnikah` (
  `tnj` double NOT NULL,
  PRIMARY KEY (`tnj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_tuslah`
-- ----------------------------
DROP TABLE IF EXISTS `set_tuslah`;
CREATE TABLE `set_tuslah` (
  `tahun` year(4) NOT NULL,
  `bulan` tinyint(4) NOT NULL,
  `pendapatan_tuslah` double NOT NULL,
  `persen_rs` double NOT NULL,
  `bagian_rs` double NOT NULL,
  `persen_kry` double NOT NULL,
  `bagian_kry` double NOT NULL,
  PRIMARY KEY (`tahun`,`bulan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_urut_no_rkm_medis`
-- ----------------------------
DROP TABLE IF EXISTS `set_urut_no_rkm_medis`;
CREATE TABLE `set_urut_no_rkm_medis` (
  `urutan` enum('Straight','Middle','Terminal') NOT NULL,
  `tahun` enum('Yes','No') NOT NULL,
  `bulan` enum('Yes','No') NOT NULL,
  `posisi_tahun_bulan` enum('Depan','Belakang') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `set_validasi_registrasi`
-- ----------------------------
DROP TABLE IF EXISTS `set_validasi_registrasi`;
CREATE TABLE `set_validasi_registrasi` (
  `wajib_closing_kasir` enum('Yes','No') DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

-- ----------------------------
--  Table structure for `set_warung`
-- ----------------------------
DROP TABLE IF EXISTS `set_warung`;
CREATE TABLE `set_warung` (
  `tahun` year(4) NOT NULL,
  `bulan` tinyint(4) NOT NULL,
  `pendapatan_warung` double NOT NULL,
  `persen_rs` double NOT NULL,
  `bagian_rs` double NOT NULL,
  `persen_kry` double NOT NULL,
  `bagian_kry` double NOT NULL,
  PRIMARY KEY (`tahun`,`bulan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `setpenjualan`
-- ----------------------------
DROP TABLE IF EXISTS `setpenjualan`;
CREATE TABLE `setpenjualan` (
  `ralan` double DEFAULT NULL,
  `kelas1` double DEFAULT NULL,
  `kelas2` double DEFAULT NULL,
  `kelas3` double DEFAULT NULL,
  `utama` double DEFAULT NULL,
  `vip` double DEFAULT NULL,
  `vvip` double DEFAULT NULL,
  `beliluar` double DEFAULT NULL,
  `jualbebas` double DEFAULT NULL,
  `karyawan` double DEFAULT NULL,
  `kdjns` char(4) DEFAULT NULL,
  KEY `kdjns` (`kdjns`),
  CONSTRAINT `setpenjualan_ibfk_1` FOREIGN KEY (`kdjns`) REFERENCES `jenis` (`kdjns`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `setsms`
-- ----------------------------
DROP TABLE IF EXISTS `setsms`;
CREATE TABLE `setsms` (
  `kode_sms` varchar(200) NOT NULL DEFAULT '',
  `sintax_balasan` text,
  PRIMARY KEY (`kode_sms`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `setting`
-- ----------------------------
DROP TABLE IF EXISTS `setting`;
CREATE TABLE `setting` (
  `nama_instansi` varchar(60) NOT NULL DEFAULT '',
  `alamat_instansi` varchar(150) DEFAULT NULL,
  `kabupaten` varchar(30) DEFAULT NULL,
  `propinsi` varchar(30) DEFAULT NULL,
  `kontak` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `aktifkan` enum('Yes','No') NOT NULL,
  `kode_ppk` varchar(15) DEFAULT NULL,
  `kode_ppkinhealth` varchar(15) DEFAULT NULL,
  `nama_ppk` varchar(100) DEFAULT NULL,
  `wallpaper` longblob,
  `logo` longblob NOT NULL,
  PRIMARY KEY (`nama_instansi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `sidikjari`
-- ----------------------------
DROP TABLE IF EXISTS `sidikjari`;
CREATE TABLE `sidikjari` (
  `id` int(11) NOT NULL,
  `sidikjari` text NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `sidikjari_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `sidikjaripasien`
-- ----------------------------
DROP TABLE IF EXISTS `sidikjaripasien`;
CREATE TABLE `sidikjaripasien` (
  `no_rkm_medis` varchar(15) NOT NULL,
  `sidikjari` text NOT NULL,
  PRIMARY KEY (`no_rkm_medis`),
  CONSTRAINT `sidikjaripasien_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `sms`
-- ----------------------------
DROP TABLE IF EXISTS `sms`;
CREATE TABLE `sms` (
  `id_pesan` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sms_masuk` varchar(255) DEFAULT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  `pdu_pesan` varchar(255) DEFAULT NULL,
  `encoding` varchar(20) DEFAULT NULL,
  `id_gateway` varchar(20) DEFAULT NULL,
  `tgl_sms` datetime DEFAULT NULL,
  PRIMARY KEY (`id_pesan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `spesialis`
-- ----------------------------
DROP TABLE IF EXISTS `spesialis`;
CREATE TABLE `spesialis` (
  `kd_sps` char(5) NOT NULL DEFAULT '',
  `nm_sps` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`kd_sps`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `stok_obat_pasien`
-- ----------------------------
DROP TABLE IF EXISTS `stok_obat_pasien`;
CREATE TABLE `stok_obat_pasien` (
  `tanggal` date NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  `jumlah` double NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  PRIMARY KEY (`tanggal`,`no_rawat`,`kode_brng`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `stok_obat_pasien_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stok_obat_pasien_ibfk_3` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON UPDATE CASCADE,
  CONSTRAINT `stok_obat_pasien_ibfk_4` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `stts_kerja`
-- ----------------------------
DROP TABLE IF EXISTS `stts_kerja`;
CREATE TABLE `stts_kerja` (
  `stts` char(3) NOT NULL,
  `ktg` varchar(20) NOT NULL,
  `indek` tinyint(4) NOT NULL,
  PRIMARY KEY (`stts`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `stts_wp`
-- ----------------------------
DROP TABLE IF EXISTS `stts_wp`;
CREATE TABLE `stts_wp` (
  `stts` char(5) NOT NULL,
  `ktg` varchar(50) NOT NULL,
  PRIMARY KEY (`stts`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `subrekening`
-- ----------------------------
DROP TABLE IF EXISTS `subrekening`;
CREATE TABLE `subrekening` (
  `kd_rek` varchar(15) NOT NULL,
  `kd_rek2` varchar(15) NOT NULL,
  PRIMARY KEY (`kd_rek2`),
  KEY `kd_rek` (`kd_rek`),
  CONSTRAINT `subrekening_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `subrekening_ibfk_2` FOREIGN KEY (`kd_rek2`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `tagihan_obat_langsung`
-- ----------------------------
DROP TABLE IF EXISTS `tagihan_obat_langsung`;
CREATE TABLE `tagihan_obat_langsung` (
  `no_rawat` varchar(17) NOT NULL,
  `besar_tagihan` double NOT NULL,
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `tagihan_obat_langsung_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `tagihan_sadewa`
-- ----------------------------
DROP TABLE IF EXISTS `tagihan_sadewa`;
CREATE TABLE `tagihan_sadewa` (
  `no_nota` varchar(17) NOT NULL,
  `no_rkm_medis` varchar(15) NOT NULL,
  `nama_pasien` varchar(60) NOT NULL,
  `alamat` varchar(200) NOT NULL,
  `tgl_bayar` datetime NOT NULL,
  `jenis_bayar` enum('Pelunasan','Deposit','Cicilan','Uang Muka') NOT NULL,
  `jumlah_tagihan` double NOT NULL,
  `jumlah_bayar` double NOT NULL,
  `status` enum('Sudah','Belum') NOT NULL,
  PRIMARY KEY (`no_nota`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `tambahan_biaya`
-- ----------------------------
DROP TABLE IF EXISTS `tambahan_biaya`;
CREATE TABLE `tambahan_biaya` (
  `no_rawat` varchar(17) NOT NULL,
  `nama_biaya` varchar(60) NOT NULL,
  `besar_biaya` double NOT NULL,
  PRIMARY KEY (`no_rawat`,`nama_biaya`),
  CONSTRAINT `tambahan_biaya_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `tambahanpotongan`
-- ----------------------------
DROP TABLE IF EXISTS `tambahanpotongan`;
CREATE TABLE `tambahanpotongan` (
  `indexins` char(4) NOT NULL,
  `potongan` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `tambahjaga`
-- ----------------------------
DROP TABLE IF EXISTS `tambahjaga`;
CREATE TABLE `tambahjaga` (
  `tgl` date NOT NULL,
  `id` int(11) NOT NULL,
  `jml` int(11) NOT NULL,
  PRIMARY KEY (`tgl`,`id`),
  KEY `id` (`id`),
  CONSTRAINT `tambahjaga_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `tampbeli1`
-- ----------------------------
DROP TABLE IF EXISTS `tampbeli1`;
CREATE TABLE `tampbeli1` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `nama_brng` varchar(100) DEFAULT NULL,
  `satuan` varchar(10) DEFAULT NULL,
  `satuan_stok` varchar(10) DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `jumlah_stok` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `tampbeli1_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `tampjual1`
-- ----------------------------
DROP TABLE IF EXISTS `tampjual1`;
CREATE TABLE `tampjual1` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `nama_brng` varchar(100) DEFAULT NULL,
  `satuan` varchar(10) DEFAULT NULL,
  `h_jual` double DEFAULT NULL,
  `h_beli` double NOT NULL,
  `jumlah` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `dis` double DEFAULT NULL,
  `bsr_dis` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `tampjual1_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `tampjurnal`
-- ----------------------------
DROP TABLE IF EXISTS `tampjurnal`;
CREATE TABLE `tampjurnal` (
  `kd_rek` char(7) NOT NULL,
  `nm_rek` varchar(100) DEFAULT NULL,
  `debet` double DEFAULT NULL,
  `kredit` double DEFAULT NULL,
  PRIMARY KEY (`kd_rek`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `tamppiutang`
-- ----------------------------
DROP TABLE IF EXISTS `tamppiutang`;
CREATE TABLE `tamppiutang` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `nama_brng` varchar(50) DEFAULT NULL,
  `satuan` varchar(10) DEFAULT NULL,
  `h_jual` double DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `dis` double DEFAULT NULL,
  `bsr_dis` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `tamppiutang_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `tampreturbeli`
-- ----------------------------
DROP TABLE IF EXISTS `tampreturbeli`;
CREATE TABLE `tampreturbeli` (
  `no_faktur` varchar(8) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `nama_brng` varchar(100) DEFAULT NULL,
  `satuan` varchar(10) DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `jml_beli` double DEFAULT NULL,
  `h_retur` double DEFAULT NULL,
  `jml_retur` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `no_batch` varchar(10) NOT NULL,
  `jml_retur2` double DEFAULT NULL,
  PRIMARY KEY (`no_faktur`,`kode_brng`),
  KEY `no_faktur` (`no_faktur`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `tampreturbeli_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `tampreturjual`
-- ----------------------------
DROP TABLE IF EXISTS `tampreturjual`;
CREATE TABLE `tampreturjual` (
  `nota_jual` varchar(8) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `nama_brng` varchar(100) DEFAULT NULL,
  `jml_jual` double DEFAULT NULL,
  `h_jual` double DEFAULT NULL,
  `jml_retur` double DEFAULT NULL,
  `h_retur` double DEFAULT NULL,
  `satuan` varchar(10) DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  PRIMARY KEY (`nota_jual`,`kode_brng`),
  KEY `nota_jual` (`nota_jual`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `tampreturjual_ibfk_3` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `tampreturpiutang`
-- ----------------------------
DROP TABLE IF EXISTS `tampreturpiutang`;
CREATE TABLE `tampreturpiutang` (
  `nota_piutang` varchar(8) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `nama_brng` varchar(100) DEFAULT NULL,
  `jml_piutang` double DEFAULT NULL,
  `h_piutang` double DEFAULT NULL,
  `jml_retur` double DEFAULT NULL,
  `h_retur` double DEFAULT NULL,
  `satuan` varchar(10) DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  PRIMARY KEY (`nota_piutang`,`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `tampreturpiutang_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `tarif_penjab_ralan`
-- ----------------------------
DROP TABLE IF EXISTS `tarif_penjab_ralan`;
CREATE TABLE `tarif_penjab_ralan` (
  `kode_tarif` varchar(15) NOT NULL,
  `deskripsi` varchar(150) NOT NULL,
  `tarif` double NOT NULL,
  `kd_pj` char(3) NOT NULL,
  PRIMARY KEY (`kode_tarif`),
  KEY `kd_pj` (`kd_pj`),
  CONSTRAINT `tarif_penjab_ralan_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `tarif_penjab_ranap`
-- ----------------------------
DROP TABLE IF EXISTS `tarif_penjab_ranap`;
CREATE TABLE `tarif_penjab_ranap` (
  `kode_tarif` varchar(15) NOT NULL,
  `deskripsi` varchar(150) NOT NULL,
  `kelas_1` double NOT NULL,
  `kelas_2` double NOT NULL,
  `kelas_3` double NOT NULL,
  `kelas_utama` double NOT NULL,
  `kelas_vip` double NOT NULL,
  `kelas_vvip` int(11) NOT NULL,
  `lainnya` double NOT NULL,
  `kd_pj` char(3) NOT NULL,
  PRIMARY KEY (`kode_tarif`),
  KEY `kd_pj` (`kd_pj`),
  CONSTRAINT `tarif_penjab_ranap_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `template_laboratorium`
-- ----------------------------
DROP TABLE IF EXISTS `template_laboratorium`;
CREATE TABLE `template_laboratorium` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `id_template` int(11) NOT NULL AUTO_INCREMENT,
  `Pemeriksaan` varchar(200) NOT NULL,
  `satuan` varchar(20) NOT NULL,
  `nilai_rujukan_ld` varchar(20) NOT NULL,
  `nilai_rujukan_la` varchar(20) NOT NULL,
  `nilai_rujukan_pd` varchar(20) NOT NULL,
  `nilai_rujukan_pa` varchar(20) NOT NULL,
  `bagian_rs` double NOT NULL,
  `bhp` double NOT NULL,
  `bagian_perujuk` double NOT NULL,
  `bagian_dokter` double NOT NULL,
  `bagian_laborat` double NOT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya_item` double NOT NULL,
  `urut` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id_template`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  CONSTRAINT `template_laboratorium_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `temporary`
-- ----------------------------
DROP TABLE IF EXISTS `temporary`;
CREATE TABLE `temporary` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(100) NOT NULL,
  `temp2` varchar(100) NOT NULL,
  `temp3` varchar(100) NOT NULL,
  `temp4` varchar(100) NOT NULL,
  `temp5` varchar(100) NOT NULL,
  `temp6` varchar(100) NOT NULL,
  `temp7` varchar(100) NOT NULL,
  `temp8` varchar(100) NOT NULL,
  `temp9` varchar(100) NOT NULL,
  `temp10` varchar(100) NOT NULL,
  `temp11` varchar(100) NOT NULL,
  `temp12` varchar(100) NOT NULL,
  `temp13` varchar(100) NOT NULL,
  `temp14` varchar(100) NOT NULL,
  `temp15` varchar(100) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  `temp18` varchar(100) NOT NULL,
  `temp19` varchar(100) NOT NULL,
  `temp20` varchar(100) NOT NULL,
  `temp21` varchar(100) NOT NULL,
  `temp22` varchar(100) NOT NULL,
  `temp23` varchar(100) NOT NULL,
  `temp24` varchar(100) NOT NULL,
  `temp25` varchar(100) NOT NULL,
  `temp26` varchar(100) NOT NULL,
  `temp27` varchar(100) NOT NULL,
  `temp28` varchar(100) NOT NULL,
  `temp29` varchar(100) NOT NULL,
  `temp30` varchar(100) NOT NULL,
  `temp31` varchar(100) NOT NULL,
  `temp32` varchar(100) NOT NULL,
  `temp33` varchar(100) NOT NULL,
  `temp34` varchar(100) NOT NULL,
  `temp35` varchar(100) NOT NULL,
  `temp36` varchar(100) NOT NULL,
  `temp37` varchar(100) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=79502 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `temporary2`
-- ----------------------------
DROP TABLE IF EXISTS `temporary2`;
CREATE TABLE `temporary2` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(100) NOT NULL,
  `temp2` varchar(100) NOT NULL,
  `temp3` varchar(100) NOT NULL,
  `temp4` varchar(100) NOT NULL,
  `temp5` varchar(100) NOT NULL,
  `temp6` varchar(100) NOT NULL,
  `temp7` varchar(100) NOT NULL,
  `temp8` varchar(100) NOT NULL,
  `temp9` varchar(100) NOT NULL,
  `temp10` varchar(100) NOT NULL,
  `temp11` varchar(100) NOT NULL,
  `temp12` varchar(100) NOT NULL,
  `temp13` varchar(100) NOT NULL,
  `temp14` varchar(100) NOT NULL,
  `temp15` varchar(100) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  `temp18` varchar(100) NOT NULL,
  `temp19` varchar(100) NOT NULL,
  `temp20` varchar(100) NOT NULL,
  `temp21` varchar(100) NOT NULL,
  `temp22` varchar(100) NOT NULL,
  `temp23` varchar(100) NOT NULL,
  `temp24` varchar(100) NOT NULL,
  `temp25` varchar(100) NOT NULL,
  `temp26` varchar(100) NOT NULL,
  `temp27` varchar(100) NOT NULL,
  `temp28` varchar(100) NOT NULL,
  `temp29` varchar(100) NOT NULL,
  `temp30` varchar(100) NOT NULL,
  `temp31` varchar(100) NOT NULL,
  `temp32` varchar(100) NOT NULL,
  `temp33` varchar(100) NOT NULL,
  `temp34` varchar(100) NOT NULL,
  `temp35` varchar(100) NOT NULL,
  `temp36` varchar(100) NOT NULL,
  `temp37` varchar(100) NOT NULL,
  `temp38` varchar(100) NOT NULL,
  `temp39` varchar(100) NOT NULL,
  `temp40` varchar(100) NOT NULL,
  `temp41` varchar(100) NOT NULL,
  `temp42` varchar(100) NOT NULL,
  `temp43` varchar(100) NOT NULL,
  `temp44` varchar(100) NOT NULL,
  `temp45` varchar(100) NOT NULL,
  `temp46` varchar(100) NOT NULL,
  `temp47` varchar(100) NOT NULL,
  `temp48` varchar(100) NOT NULL,
  `temp49` varchar(100) NOT NULL,
  `temp50` varchar(100) NOT NULL,
  `temp51` varchar(100) NOT NULL,
  `temp52` varchar(100) NOT NULL,
  `temp53` varchar(100) NOT NULL,
  `temp54` varchar(100) NOT NULL,
  `temp55` varchar(100) NOT NULL,
  `temp56` varchar(100) NOT NULL,
  `temp57` varchar(100) NOT NULL,
  `temp58` varchar(100) NOT NULL,
  `temp59` varchar(100) NOT NULL,
  `temp60` varchar(100) NOT NULL,
  `temp61` varchar(100) NOT NULL,
  `temp62` varchar(100) NOT NULL,
  `temp63` varchar(100) NOT NULL,
  `temp64` varchar(100) NOT NULL,
  `temp65` varchar(100) NOT NULL,
  `temp66` varchar(100) NOT NULL,
  `temp67` varchar(100) NOT NULL,
  `temp68` varchar(100) NOT NULL,
  `temp69` varchar(100) NOT NULL,
  `temp70` varchar(100) NOT NULL,
  `temp71` varchar(100) NOT NULL,
  `temp72` varchar(100) NOT NULL,
  `temp73` varchar(100) NOT NULL,
  `temp74` varchar(100) NOT NULL,
  `temp75` varchar(100) NOT NULL,
  `temp76` varchar(100) NOT NULL,
  `temp77` varchar(100) NOT NULL,
  `temp78` varchar(100) NOT NULL,
  `temp79` varchar(100) NOT NULL,
  `temp80` varchar(100) NOT NULL,
  `temp81` varchar(100) NOT NULL,
  `temp82` varchar(100) NOT NULL,
  `temp83` varchar(100) NOT NULL,
  `temp84` varchar(100) NOT NULL,
  `temp85` varchar(100) NOT NULL,
  `temp86` varchar(100) NOT NULL,
  `temp87` varchar(100) NOT NULL,
  `temp88` varchar(100) NOT NULL,
  `temp89` varchar(100) NOT NULL,
  `temp90` varchar(100) NOT NULL,
  `temp91` varchar(100) NOT NULL,
  `temp92` varchar(100) NOT NULL,
  `temp93` varchar(100) NOT NULL,
  `temp94` varchar(100) NOT NULL,
  `temp95` varchar(100) NOT NULL,
  `temp96` varchar(100) NOT NULL,
  `temp97` varchar(100) NOT NULL,
  `temp98` varchar(100) NOT NULL,
  `temp99` varchar(100) NOT NULL,
  `temp100` varchar(100) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `temporary_bayar_ralan`
-- ----------------------------
DROP TABLE IF EXISTS `temporary_bayar_ralan`;
CREATE TABLE `temporary_bayar_ralan` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(100) NOT NULL,
  `temp2` varchar(200) NOT NULL,
  `temp3` varchar(100) NOT NULL,
  `temp4` varchar(100) NOT NULL,
  `temp5` varchar(100) NOT NULL,
  `temp6` varchar(100) NOT NULL,
  `temp7` varchar(100) NOT NULL,
  `temp8` varchar(100) NOT NULL,
  `temp9` varchar(100) NOT NULL,
  `temp10` varchar(100) NOT NULL,
  `temp11` varchar(100) NOT NULL,
  `temp12` varchar(100) NOT NULL,
  `temp13` varchar(100) NOT NULL,
  `temp14` varchar(100) NOT NULL,
  `temp15` varchar(100) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=712311 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `temporary_bayar_ranap`
-- ----------------------------
DROP TABLE IF EXISTS `temporary_bayar_ranap`;
CREATE TABLE `temporary_bayar_ranap` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(100) NOT NULL,
  `temp2` varchar(200) NOT NULL,
  `temp3` varchar(100) NOT NULL,
  `temp4` varchar(100) NOT NULL,
  `temp5` varchar(100) NOT NULL,
  `temp6` varchar(100) NOT NULL,
  `temp7` varchar(100) NOT NULL,
  `temp8` varchar(100) NOT NULL,
  `temp9` varchar(100) NOT NULL,
  `temp10` varchar(100) NOT NULL,
  `temp11` varchar(100) NOT NULL,
  `temp12` varchar(100) NOT NULL,
  `temp13` varchar(100) NOT NULL,
  `temp14` varchar(100) NOT NULL,
  `temp15` varchar(100) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=194549 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `temporary_presensi`
-- ----------------------------
DROP TABLE IF EXISTS `temporary_presensi`;
CREATE TABLE `temporary_presensi` (
  `id` int(11) NOT NULL,
  `shift` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10') NOT NULL,
  `jam_datang` datetime DEFAULT NULL,
  `jam_pulang` datetime DEFAULT NULL,
  `status` enum('Tepat Waktu','Terlambat Toleransi','Terlambat I','Terlambat II','Tepat Waktu & PSW','Terlambat Toleransi & PSW','Terlambat I & PSW','Terlambat II & PSW') NOT NULL,
  `keterlambatan` varchar(20) NOT NULL,
  `durasi` varchar(20) DEFAULT NULL,
  `photo` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `temporary_presensi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `temporary_surveilens_penyakit`
-- ----------------------------
DROP TABLE IF EXISTS `temporary_surveilens_penyakit`;
CREATE TABLE `temporary_surveilens_penyakit` (
  `kd_penyakit` varchar(10) NOT NULL,
  `kd_penyakit2` varchar(10) NOT NULL,
  KEY `kd_penyakit` (`kd_penyakit`),
  KEY `kd_penyakit2` (`kd_penyakit2`),
  CONSTRAINT `temporary_surveilens_penyakit_ibfk_1` FOREIGN KEY (`kd_penyakit`) REFERENCES `penyakit` (`kd_penyakit`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `temporary_surveilens_penyakit_ibfk_2` FOREIGN KEY (`kd_penyakit2`) REFERENCES `penyakit` (`kd_penyakit`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `temporary_tambahan_potongan`
-- ----------------------------
DROP TABLE IF EXISTS `temporary_tambahan_potongan`;
CREATE TABLE `temporary_tambahan_potongan` (
  `no_rawat` varchar(17) NOT NULL,
  `nama_tambahan` varchar(100) NOT NULL,
  `biaya` double NOT NULL,
  `status` varchar(30) NOT NULL,
  PRIMARY KEY (`no_rawat`,`nama_tambahan`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `temppanggilrm`
-- ----------------------------
DROP TABLE IF EXISTS `temppanggilrm`;
CREATE TABLE `temppanggilrm` (
  `no_rkm_medis` varchar(15) NOT NULL,
  PRIMARY KEY (`no_rkm_medis`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `tindakan`
-- ----------------------------
DROP TABLE IF EXISTS `tindakan`;
CREATE TABLE `tindakan` (
  `tgl` datetime NOT NULL,
  `id` int(11) NOT NULL,
  `tnd` int(11) NOT NULL,
  `jm` double NOT NULL,
  `nm_pasien` varchar(30) NOT NULL,
  `kamar` varchar(20) NOT NULL,
  `diagnosa` varchar(50) NOT NULL,
  `jmlh` int(11) NOT NULL,
  PRIMARY KEY (`tgl`,`id`,`tnd`,`nm_pasien`),
  KEY `id` (`id`),
  KEY `tnd` (`tnd`),
  CONSTRAINT `tindakan_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `tracker`
-- ----------------------------
DROP TABLE IF EXISTS `tracker`;
CREATE TABLE `tracker` (
  `nip` varchar(20) NOT NULL,
  `tgl_login` date NOT NULL,
  `jam_login` time NOT NULL,
  PRIMARY KEY (`nip`,`tgl_login`,`jam_login`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `trackersql`
-- ----------------------------
DROP TABLE IF EXISTS `trackersql`;
CREATE TABLE `trackersql` (
  `tanggal` date NOT NULL,
  `sql` text NOT NULL,
  `error` text NOT NULL,
  `form` varchar(30) NOT NULL,
  `event` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `ubah_penjab`
-- ----------------------------
DROP TABLE IF EXISTS `ubah_penjab`;
CREATE TABLE `ubah_penjab` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_ubah` datetime NOT NULL,
  `kd_pj1` char(3) NOT NULL,
  `kd_pj2` char(3) NOT NULL,
  KEY `no_rawat` (`no_rawat`),
  KEY `tgl_ubah` (`tgl_ubah`),
  KEY `kd_pj1` (`kd_pj1`),
  KEY `kd_pj2` (`kd_pj2`),
  CONSTRAINT `ubah_penjab_ibfk_4` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `ubah_penjab_ibfk_5` FOREIGN KEY (`kd_pj1`) REFERENCES `penjab` (`kd_pj`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `ubah_penjab_ibfk_6` FOREIGN KEY (`kd_pj2`) REFERENCES `penjab` (`kd_pj`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id_user` varchar(700) NOT NULL,
  `password` text NOT NULL,
  `penyakit` enum('true','false') NOT NULL,
  `obat_penyakit` enum('true','false') NOT NULL,
  `dokter` enum('true','false') NOT NULL,
  `jadwal_praktek` enum('true','false') NOT NULL,
  `petugas` enum('true','false') NOT NULL,
  `pasien` enum('true','false') NOT NULL,
  `registrasi` enum('true','false') NOT NULL,
  `tindakan_ralan` enum('true','false') NOT NULL,
  `kamar_inap` enum('true','false') NOT NULL,
  `tindakan_ranap` enum('true','false') NOT NULL,
  `operasi` enum('true','false') NOT NULL,
  `rujukan_keluar` enum('true','false') NOT NULL,
  `rujukan_masuk` enum('true','false') NOT NULL,
  `beri_obat` enum('true','false') NOT NULL,
  `resep_pulang` enum('true','false') NOT NULL,
  `pasien_meninggal` enum('true','false') NOT NULL,
  `diet_pasien` enum('true','false') NOT NULL,
  `kelahiran_bayi` enum('true','false') NOT NULL,
  `periksa_lab` enum('true','false') NOT NULL,
  `periksa_radiologi` enum('true','false') NOT NULL,
  `kasir_ralan` enum('true','false') NOT NULL,
  `deposit_pasien` enum('true','false') NOT NULL,
  `piutang_pasien` enum('true','false') NOT NULL,
  `peminjaman_berkas` enum('true','false') NOT NULL,
  `barcode` enum('true','false') NOT NULL,
  `presensi_harian` enum('true','false') NOT NULL,
  `presensi_bulanan` enum('true','false') NOT NULL,
  `pegawai_admin` enum('true','false') NOT NULL,
  `pegawai_user` enum('true','false') NOT NULL,
  `suplier` enum('true','false') NOT NULL,
  `satuan_barang` enum('true','false') NOT NULL,
  `konversi_satuan` enum('true','false') NOT NULL,
  `jenis_barang` enum('true','false') NOT NULL,
  `obat` enum('true','false') NOT NULL,
  `stok_opname_obat` enum('true','false') NOT NULL,
  `stok_obat_pasien` enum('true','false') NOT NULL,
  `pengadaan_obat` enum('true','false') NOT NULL,
  `pemesanan_obat` enum('true','false') NOT NULL,
  `penjualan_obat` enum('true','false') NOT NULL,
  `piutang_obat` enum('true','false') NOT NULL,
  `retur_ke_suplier` enum('true','false') NOT NULL,
  `retur_dari_pembeli` enum('true','false') NOT NULL,
  `retur_obat_ranap` enum('true','false') NOT NULL,
  `retur_piutang_pasien` enum('true','false') NOT NULL,
  `keuntungan_penjualan` enum('true','false') NOT NULL,
  `keuntungan_beri_obat` enum('true','false') NOT NULL,
  `sirkulasi_obat` enum('true','false') NOT NULL,
  `ipsrs_barang` enum('true','false') NOT NULL,
  `ipsrs_pengadaan_barang` enum('true','false') NOT NULL,
  `ipsrs_stok_keluar` enum('true','false') NOT NULL,
  `ipsrs_rekap_pengadaan` enum('true','false') NOT NULL,
  `ipsrs_rekap_stok_keluar` enum('true','false') NOT NULL,
  `ipsrs_pengeluaran_harian` enum('true','false') NOT NULL,
  `inventaris_jenis` enum('true','false') NOT NULL,
  `inventaris_kategori` enum('true','false') NOT NULL,
  `inventaris_merk` enum('true','false') NOT NULL,
  `inventaris_ruang` enum('true','false') NOT NULL,
  `inventaris_produsen` enum('true','false') NOT NULL,
  `inventaris_koleksi` enum('true','false') NOT NULL,
  `inventaris_inventaris` enum('true','false') NOT NULL,
  `inventaris_sirkulasi` enum('true','false') NOT NULL,
  `parkir_jenis` enum('true','false') NOT NULL,
  `parkir_in` enum('true','false') NOT NULL,
  `parkir_out` enum('true','false') NOT NULL,
  `parkir_rekap_harian` enum('true','false') NOT NULL,
  `parkir_rekap_bulanan` enum('true','false') NOT NULL,
  `informasi_kamar` enum('true','false') NOT NULL,
  `harian_tindakan_poli` enum('true','false') NOT NULL,
  `obat_per_poli` enum('true','false') NOT NULL,
  `obat_per_kamar` enum('true','false') NOT NULL,
  `obat_per_dokter_ralan` enum('true','false') NOT NULL,
  `obat_per_dokter_ranap` enum('true','false') NOT NULL,
  `harian_dokter` enum('true','false') NOT NULL,
  `bulanan_dokter` enum('true','false') NOT NULL,
  `harian_paramedis` enum('true','false') NOT NULL,
  `bulanan_paramedis` enum('true','false') NOT NULL,
  `pembayaran_ralan` enum('true','false') NOT NULL,
  `pembayaran_ranap` enum('true','false') NOT NULL,
  `rekap_pembayaran_ralan` enum('true','false') NOT NULL,
  `rekap_pembayaran_ranap` enum('true','false') NOT NULL,
  `tagihan_masuk` enum('true','false') NOT NULL,
  `tambahan_biaya` enum('true','false') NOT NULL,
  `potongan_biaya` enum('true','false') NOT NULL,
  `resep_obat` enum('true','false') NOT NULL,
  `resume_pasien` enum('true','false') NOT NULL,
  `penyakit_ralan` enum('true','false') NOT NULL,
  `penyakit_ranap` enum('true','false') NOT NULL,
  `kamar` enum('true','false') NOT NULL,
  `tarif_ralan` enum('true','false') NOT NULL,
  `tarif_ranap` enum('true','false') NOT NULL,
  `tarif_lab` enum('true','false') NOT NULL,
  `tarif_radiologi` enum('true','false') NOT NULL,
  `tarif_operasi` enum('true','false') NOT NULL,
  `akun_rekening` enum('true','false') NOT NULL,
  `rekening_tahun` enum('true','false') NOT NULL,
  `posting_jurnal` enum('true','false') NOT NULL,
  `buku_besar` enum('true','false') NOT NULL,
  `cashflow` enum('true','false') NOT NULL,
  `keuangan` enum('true','false') NOT NULL,
  `pengeluaran` enum('true','false') NOT NULL,
  `setup_pjlab` enum('true','false') NOT NULL,
  `setup_otolokasi` enum('true','false') NOT NULL,
  `setup_jam_kamin` enum('true','false') NOT NULL,
  `setup_embalase` enum('true','false') NOT NULL,
  `tracer_login` enum('true','false') NOT NULL,
  `display` enum('true','false') NOT NULL,
  `set_harga_obat` enum('true','false') NOT NULL,
  `set_penggunaan_tarif` enum('true','false') NOT NULL,
  `set_oto_ralan` enum('true','false') NOT NULL,
  `biaya_harian` enum('true','false') NOT NULL,
  `biaya_masuk_sekali` enum('true','false') NOT NULL,
  `set_no_rm` enum('true','false') NOT NULL,
  `billing_ralan` enum('true','false') NOT NULL,
  `billing_ranap` enum('true','false') NOT NULL,
  `jm_ranap_dokter` enum('true','false') NOT NULL,
  `igd` enum('true','false') NOT NULL,
  `barcoderalan` enum('true','false') NOT NULL,
  `barcoderanap` enum('true','false') NOT NULL,
  `set_harga_obat_ralan` enum('true','false') NOT NULL,
  `set_harga_obat_ranap` enum('true','false') NOT NULL,
  `penyakit_pd3i` enum('true','false') NOT NULL,
  `surveilans_pd3i` enum('true','false') NOT NULL,
  `surveilans_ralan` enum('true','false') NOT NULL,
  `diagnosa_pasien` enum('true','false') NOT NULL,
  `surveilans_ranap` enum('true','false') NOT NULL,
  `pny_takmenular_ranap` enum('true','false') NOT NULL,
  `pny_takmenular_ralan` enum('true','false') NOT NULL,
  `kunjungan_ralan` enum('true','false') NOT NULL,
  `rl32` enum('true','false') NOT NULL,
  `rl33` enum('true','false') NOT NULL,
  `rl37` enum('true','false') NOT NULL,
  `rl38` enum('true','false') NOT NULL,
  `harian_tindakan_dokter` enum('true','false') NOT NULL,
  `sms` enum('true','false') NOT NULL,
  `sidikjari` enum('true','false') NOT NULL,
  `jam_masuk` enum('true','false') NOT NULL,
  `jadwal_pegawai` enum('true','false') NOT NULL,
  `parkir_barcode` enum('true','false') NOT NULL,
  `set_nota` enum('true','false') NOT NULL,
  `dpjp_ranap` enum('true','false') NOT NULL,
  `mutasi_barang` enum('true','false') NOT NULL,
  `rl34` enum('true','false') DEFAULT NULL,
  `rl36` enum('true','false') NOT NULL,
  `fee_visit_dokter` enum('true','false') DEFAULT NULL,
  `fee_bacaan_ekg` enum('true','false') DEFAULT NULL,
  `fee_rujukan_rontgen` enum('true','false') DEFAULT NULL,
  `fee_rujukan_ranap` enum('true','false') DEFAULT NULL,
  `fee_ralan` enum('true','false') DEFAULT NULL,
  `akun_bayar` enum('true','false') DEFAULT NULL,
  `bayar_pemesanan_obat` enum('true','false') DEFAULT NULL,
  `obat_per_dokter_peresep` enum('true','false') DEFAULT NULL,
  `ipsrs_jenis_barang` enum('true','false') DEFAULT NULL,
  `pemasukan_lain` enum('true','false') DEFAULT NULL,
  `pengaturan_rekening` enum('true','false') DEFAULT NULL,
  `closing_kasir` enum('true','false') DEFAULT NULL,
  `keterlambatan_presensi` enum('true','false') DEFAULT NULL,
  `set_harga_kamar` enum('true','false') DEFAULT NULL,
  `rekap_per_shift` enum('true','false') DEFAULT NULL,
  `bpjs_cek_nik` enum('true','false') DEFAULT NULL,
  `bpjs_cek_kartu` enum('true','false') DEFAULT NULL,
  `bpjs_cek_riwayat` enum('true','false') DEFAULT NULL,
  `obat_per_cara_bayar` enum('true','false') DEFAULT NULL,
  `kunjungan_ranap` enum('true','false') DEFAULT NULL,
  `bayar_piutang` enum('true','false') DEFAULT NULL,
  `payment_point` enum('true','false') DEFAULT NULL,
  `bpjs_cek_nomor_rujukan` enum('true','false') DEFAULT NULL,
  `icd9` enum('true','false') DEFAULT NULL,
  `darurat_stok` enum('true','false') DEFAULT NULL,
  `retensi_rm` enum('true','false') DEFAULT NULL,
  `temporary_presensi` enum('true','false') DEFAULT NULL,
  `jurnal_harian` enum('true','false') DEFAULT NULL,
  `sirkulasi_obat2` enum('true','false') DEFAULT NULL,
  `edit_registrasi` enum('true','false') DEFAULT NULL,
  `bpjs_referensi_diagnosa` enum('true','false') DEFAULT NULL,
  `bpjs_referensi_poli` enum('true','false') DEFAULT NULL,
  `industrifarmasi` enum('true','false') DEFAULT NULL,
  `harian_js` enum('true','false') DEFAULT NULL,
  `bulanan_js` enum('true','false') DEFAULT NULL,
  `harian_paket_bhp` enum('true','false') DEFAULT NULL,
  `bulanan_paket_bhp` enum('true','false') DEFAULT NULL,
  `piutang_pasien2` enum('true','false') DEFAULT NULL,
  `bpjs_referensi_faskes` enum('true','false') DEFAULT NULL,
  `bpjs_sep` enum('true','false') DEFAULT NULL,
  `pengambilan_utd` enum('true','false') DEFAULT NULL,
  `tarif_utd` enum('true','false') DEFAULT NULL,
  `pengambilan_utd2` enum('true','false') DEFAULT NULL,
  `utd_medis_rusak` enum('true','false') DEFAULT NULL,
  `pengambilan_penunjang_utd` enum('true','false') DEFAULT NULL,
  `pengambilan_penunjang_utd2` enum('true','false') DEFAULT NULL,
  `utd_penunjang_rusak` enum('true','false') DEFAULT NULL,
  `suplier_penunjang` enum('true','false') DEFAULT NULL,
  `utd_donor` enum('true','false') DEFAULT NULL,
  `bpjs_monitoring_klaim` enum('true','false') DEFAULT NULL,
  `utd_cekal_darah` enum('true','false') DEFAULT NULL,
  `utd_komponen_darah` enum('true','false') DEFAULT NULL,
  `utd_stok_darah` enum('true','false') DEFAULT NULL,
  `utd_pemisahan_darah` enum('true','false') DEFAULT NULL,
  `harian_kamar` enum('true','false') DEFAULT NULL,
  `rincian_piutang_pasien` enum('true','false') DEFAULT NULL,
  `keuntungan_beri_obat_nonpiutang` enum('true','false') DEFAULT NULL,
  `reklasifikasi_ralan` enum('true','false') DEFAULT NULL,
  `reklasifikasi_ranap` enum('true','false') DEFAULT NULL,
  `utd_penyerahan_darah` enum('true','false') DEFAULT NULL,
  `hutang_obat` enum('true','false') DEFAULT NULL,
  `riwayat_obat_alkes_bhp` enum('true','false') DEFAULT NULL,
  `sensus_harian_poli` enum('true','false') DEFAULT NULL,
  `rl4a` enum('true','false') DEFAULT NULL,
  `aplicare_referensi_kamar` enum('true','false') DEFAULT NULL,
  `aplicare_ketersediaan_kamar` enum('true','false') DEFAULT NULL,
  `inacbg_klaim_baru_otomatis` enum('true','false') DEFAULT NULL,
  `inacbg_klaim_baru_manual` enum('true','false') DEFAULT NULL,
  `inacbg_coder_nik` enum('true','false') DEFAULT NULL,
  `mutasi_berkas` enum('true','false') DEFAULT NULL,
  `akun_piutang` enum('true','false') DEFAULT NULL,
  `harian_kso` enum('true','false') DEFAULT NULL,
  `bulanan_kso` enum('true','false') DEFAULT NULL,
  `harian_menejemen` enum('true','false') DEFAULT NULL,
  `bulanan_menejemen` enum('true','false') DEFAULT NULL,
  `inhealth_cek_eligibilitas` enum('true','false') DEFAULT NULL,
  `inhealth_referensi_jenpel_ruang_rawat` enum('true','false') DEFAULT NULL,
  `inhealth_referensi_poli` enum('true','false') DEFAULT NULL,
  `inhealth_referensi_faskes` enum('true','false') DEFAULT NULL,
  `inhealth_sjp` enum('true','false') DEFAULT NULL,
  `piutang_ralan` enum('true','false') DEFAULT NULL,
  `piutang_ranap` enum('true','false') DEFAULT NULL,
  `detail_piutang_penjab` enum('true','false') DEFAULT NULL,
  `lama_pelayanan_ralan` enum('true','false') DEFAULT NULL,
  `catatan_pasien` enum('true','false') DEFAULT NULL,
  `rl4b` enum('true','false') DEFAULT NULL,
  `rl4asebab` enum('true','false') DEFAULT NULL,
  `rl4bsebab` enum('true','false') DEFAULT NULL,
  `data_HAIs` enum('true','false') DEFAULT NULL,
  `harian_HAIs` enum('true','false') DEFAULT NULL,
  `bulanan_HAIs` enum('true','false') DEFAULT NULL,
  `hitung_bor` enum('true','false') DEFAULT NULL,
  `perusahaan_pasien` enum('true','false') DEFAULT NULL,
  `resep_dokter` enum('true','false') DEFAULT NULL,
  `lama_pelayanan_apotek` enum('true','false') DEFAULT NULL,
  `hitung_alos` enum('true','false') DEFAULT NULL,
  `detail_tindakan` enum('true','false') DEFAULT NULL,
  `apotek` enum('false','true') DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `utd_cekal_darah`
-- ----------------------------
DROP TABLE IF EXISTS `utd_cekal_darah`;
CREATE TABLE `utd_cekal_darah` (
  `no_donor` varchar(15) NOT NULL,
  `tanggal` date DEFAULT NULL,
  `dinas` enum('Pagi','Siang','Sore','Malam') DEFAULT NULL,
  `petugas_pemusnahan` varchar(20) DEFAULT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`no_donor`),
  KEY `petugas_pemusnahan` (`petugas_pemusnahan`),
  CONSTRAINT `utd_cekal_darah_ibfk_1` FOREIGN KEY (`no_donor`) REFERENCES `utd_donor` (`no_donor`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_cekal_darah_ibfk_2` FOREIGN KEY (`petugas_pemusnahan`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_detail_pemisahan_komponen`
-- ----------------------------
DROP TABLE IF EXISTS `utd_detail_pemisahan_komponen`;
CREATE TABLE `utd_detail_pemisahan_komponen` (
  `no_donor` varchar(15) DEFAULT NULL,
  `no_kantong` varchar(15) NOT NULL,
  `kode_komponen` varchar(5) DEFAULT NULL,
  `tanggal_kadaluarsa` date DEFAULT NULL,
  PRIMARY KEY (`no_kantong`),
  KEY `no_donor` (`no_donor`),
  CONSTRAINT `utd_detail_pemisahan_komponen_ibfk_1` FOREIGN KEY (`no_donor`) REFERENCES `utd_pemisahan_komponen` (`no_donor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_donor`
-- ----------------------------
DROP TABLE IF EXISTS `utd_donor`;
CREATE TABLE `utd_donor` (
  `no_donor` varchar(15) NOT NULL,
  `nama` varchar(60) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `dinas` enum('Pagi','Siang','Sore','Malam') DEFAULT NULL,
  `jk` enum('L','P') DEFAULT NULL,
  `umur` tinyint(4) DEFAULT NULL,
  `alamat` varchar(100) DEFAULT NULL,
  `golongan_darah` enum('A','AB','B','O') DEFAULT NULL,
  `resus` enum('(-)','(+)') DEFAULT NULL,
  `tensi` varchar(7) DEFAULT NULL,
  `no_bag` int(11) DEFAULT NULL,
  `no_telp` varchar(13) DEFAULT NULL,
  `jenis_bag` enum('SB','DB','TB','QB') DEFAULT NULL,
  `jenis_donor` enum('DB','DP','DS') DEFAULT NULL,
  `tempat_aftap` enum('Dalam Gedung','Luar Gedung') DEFAULT NULL,
  `petugas_aftap` varchar(20) DEFAULT NULL,
  `hbsag` enum('Negatif','Positif') DEFAULT NULL,
  `hcv` enum('Negatif','Positif') DEFAULT NULL,
  `hiv` enum('Negatif','Positif') DEFAULT NULL,
  `spilis` enum('Negatif','Positif') DEFAULT NULL,
  `malaria` enum('Negatif','Positif') DEFAULT NULL,
  `petugas_u_saring` varchar(20) DEFAULT NULL,
  `status` enum('Aman','Cekal') DEFAULT NULL,
  PRIMARY KEY (`no_donor`),
  KEY `petugas_aftap` (`petugas_aftap`),
  KEY `petugas_u_saring` (`petugas_u_saring`),
  KEY `no_selang` (`no_telp`),
  CONSTRAINT `utd_donor_ibfk_1` FOREIGN KEY (`petugas_aftap`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_donor_ibfk_2` FOREIGN KEY (`petugas_u_saring`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_komponen_darah`
-- ----------------------------
DROP TABLE IF EXISTS `utd_komponen_darah`;
CREATE TABLE `utd_komponen_darah` (
  `kode` varchar(5) NOT NULL,
  `nama` varchar(70) DEFAULT NULL,
  `lama` smallint(6) DEFAULT NULL,
  `jasa_sarana` double DEFAULT NULL,
  `paket_bhp` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `manajemen` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `pembatalan` double DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_medis_rusak`
-- ----------------------------
DROP TABLE IF EXISTS `utd_medis_rusak`;
CREATE TABLE `utd_medis_rusak` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `hargabeli` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `nip` varchar(20) NOT NULL DEFAULT '',
  `tanggal` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `keterangan` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`kode_brng`,`nip`,`tanggal`),
  KEY `nip` (`nip`),
  CONSTRAINT `utd_medis_rusak_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_medis_rusak_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_pemisahan_komponen`
-- ----------------------------
DROP TABLE IF EXISTS `utd_pemisahan_komponen`;
CREATE TABLE `utd_pemisahan_komponen` (
  `no_donor` varchar(15) NOT NULL,
  `tanggal` date DEFAULT NULL,
  `dinas` enum('Pagi','Siang','Sore','Malam') DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`no_donor`),
  KEY `nip` (`nip`),
  CONSTRAINT `utd_pemisahan_komponen_ibfk_1` FOREIGN KEY (`no_donor`) REFERENCES `utd_donor` (`no_donor`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_pemisahan_komponen_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_pengambilan_medis`
-- ----------------------------
DROP TABLE IF EXISTS `utd_pengambilan_medis`;
CREATE TABLE `utd_pengambilan_medis` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `hargabeli` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `kd_bangsal_dr` char(5) NOT NULL DEFAULT '',
  `tanggal` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `keterangan` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`kode_brng`,`kd_bangsal_dr`,`tanggal`),
  KEY `kd_bangsal_dr` (`kd_bangsal_dr`),
  CONSTRAINT `utd_pengambilan_medis_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_pengambilan_medis_ibfk_2` FOREIGN KEY (`kd_bangsal_dr`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_pengambilan_penunjang`
-- ----------------------------
DROP TABLE IF EXISTS `utd_pengambilan_penunjang`;
CREATE TABLE `utd_pengambilan_penunjang` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `nip` varchar(20) NOT NULL DEFAULT '',
  `tanggal` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `keterangan` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`kode_brng`,`nip`,`tanggal`),
  KEY `kode_brng` (`kode_brng`),
  KEY `nip` (`nip`),
  CONSTRAINT `utd_pengambilan_penunjang_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_pengambilan_penunjang_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_penggunaan_medis_donor`
-- ----------------------------
DROP TABLE IF EXISTS `utd_penggunaan_medis_donor`;
CREATE TABLE `utd_penggunaan_medis_donor` (
  `no_donor` varchar(15) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`no_donor`,`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `utd_penggunaan_medis_donor_ibfk_1` FOREIGN KEY (`no_donor`) REFERENCES `utd_donor` (`no_donor`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_penggunaan_medis_donor_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_penggunaan_medis_pemisahan_komponen`
-- ----------------------------
DROP TABLE IF EXISTS `utd_penggunaan_medis_pemisahan_komponen`;
CREATE TABLE `utd_penggunaan_medis_pemisahan_komponen` (
  `no_donor` varchar(15) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`no_donor`,`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `utd_penggunaan_medis_pemisahan_komponen_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_penggunaan_medis_pemisahan_komponen_ibfk_3` FOREIGN KEY (`no_donor`) REFERENCES `utd_pemisahan_komponen` (`no_donor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_penggunaan_medis_penyerahan_darah`
-- ----------------------------
DROP TABLE IF EXISTS `utd_penggunaan_medis_penyerahan_darah`;
CREATE TABLE `utd_penggunaan_medis_penyerahan_darah` (
  `no_penyerahan` varchar(17) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`no_penyerahan`,`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `utd_penggunaan_medis_penyerahan_darah_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_penggunaan_medis_penyerahan_darah_ibfk_2` FOREIGN KEY (`no_penyerahan`) REFERENCES `utd_penyerahan_darah` (`no_penyerahan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_penggunaan_penunjang_donor`
-- ----------------------------
DROP TABLE IF EXISTS `utd_penggunaan_penunjang_donor`;
CREATE TABLE `utd_penggunaan_penunjang_donor` (
  `no_donor` varchar(15) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`no_donor`,`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `utd_penggunaan_penunjang_donor_ibfk_1` FOREIGN KEY (`no_donor`) REFERENCES `utd_donor` (`no_donor`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_penggunaan_penunjang_donor_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_penggunaan_penunjang_pemisahan_komponen`
-- ----------------------------
DROP TABLE IF EXISTS `utd_penggunaan_penunjang_pemisahan_komponen`;
CREATE TABLE `utd_penggunaan_penunjang_pemisahan_komponen` (
  `no_donor` varchar(15) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`no_donor`,`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `utd_penggunaan_penunjang_pemisahan_komponen_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_penggunaan_penunjang_pemisahan_komponen_ibfk_3` FOREIGN KEY (`no_donor`) REFERENCES `utd_pemisahan_komponen` (`no_donor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_penggunaan_penunjang_penyerahan_darah`
-- ----------------------------
DROP TABLE IF EXISTS `utd_penggunaan_penunjang_penyerahan_darah`;
CREATE TABLE `utd_penggunaan_penunjang_penyerahan_darah` (
  `no_penyerahan` varchar(17) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`no_penyerahan`,`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `utd_penggunaan_penunjang_penyerahan_darah_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_penggunaan_penunjang_penyerahan_darah_ibfk_2` FOREIGN KEY (`no_penyerahan`) REFERENCES `utd_penyerahan_darah` (`no_penyerahan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_penunjang_rusak`
-- ----------------------------
DROP TABLE IF EXISTS `utd_penunjang_rusak`;
CREATE TABLE `utd_penunjang_rusak` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `nip` varchar(20) NOT NULL DEFAULT '',
  `tanggal` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `keterangan` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`kode_brng`,`nip`,`tanggal`),
  KEY `nip` (`nip`),
  CONSTRAINT `utd_penunjang_rusak_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_penunjang_rusak_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_penyerahan_darah`
-- ----------------------------
DROP TABLE IF EXISTS `utd_penyerahan_darah`;
CREATE TABLE `utd_penyerahan_darah` (
  `no_penyerahan` varchar(17) NOT NULL DEFAULT '',
  `tanggal` date DEFAULT NULL,
  `dinas` enum('Pagi','Siang','Sore','Malam') DEFAULT NULL,
  `nip_cross` varchar(20) DEFAULT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  `status` enum('Belum Dibayar','Sudah Dibayar') DEFAULT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  `pengambil_darah` varchar(70) DEFAULT NULL,
  `alamat_pengambil_darah` varchar(120) DEFAULT NULL,
  `nip_pj` varchar(20) DEFAULT NULL,
  `besarppn` double DEFAULT NULL,
  PRIMARY KEY (`no_penyerahan`),
  KEY `nip` (`nip_cross`),
  KEY `kd_rek` (`kd_rek`),
  CONSTRAINT `utd_penyerahan_darah_ibfk_1` FOREIGN KEY (`nip_cross`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_penyerahan_darah_ibfk_2` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_penyerahan_darah_detail`
-- ----------------------------
DROP TABLE IF EXISTS `utd_penyerahan_darah_detail`;
CREATE TABLE `utd_penyerahan_darah_detail` (
  `no_penyerahan` varchar(17) NOT NULL DEFAULT '',
  `no_kantong` varchar(20) NOT NULL DEFAULT '',
  `jasa_sarana` double DEFAULT NULL,
  `paket_bhp` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `manajemen` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`no_penyerahan`,`no_kantong`),
  KEY `no_kantong` (`no_kantong`),
  CONSTRAINT `utd_penyerahan_darah_detail_ibfk_1` FOREIGN KEY (`no_penyerahan`) REFERENCES `utd_penyerahan_darah` (`no_penyerahan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_penyerahan_darah_detail_ibfk_2` FOREIGN KEY (`no_kantong`) REFERENCES `utd_stok_darah` (`no_kantong`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_stok_darah`
-- ----------------------------
DROP TABLE IF EXISTS `utd_stok_darah`;
CREATE TABLE `utd_stok_darah` (
  `no_kantong` varchar(20) NOT NULL DEFAULT '',
  `kode_komponen` varchar(5) DEFAULT NULL,
  `golongan_darah` enum('A','AB','B','O') DEFAULT NULL,
  `resus` enum('(-)','(+)') DEFAULT NULL,
  `tanggal_aftap` date DEFAULT NULL,
  `tanggal_kadaluarsa` date DEFAULT NULL,
  `asal_darah` enum('Hibah','Beli','Produksi Sendiri') DEFAULT NULL,
  `status` enum('Ada','Diambil','Dimusnahkan') DEFAULT NULL,
  PRIMARY KEY (`no_kantong`),
  KEY `kode_komponen` (`kode_komponen`),
  CONSTRAINT `utd_stok_darah_ibfk_1` FOREIGN KEY (`kode_komponen`) REFERENCES `utd_komponen_darah` (`kode`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_stok_medis`
-- ----------------------------
DROP TABLE IF EXISTS `utd_stok_medis`;
CREATE TABLE `utd_stok_medis` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `stok` double DEFAULT NULL,
  `hargaterakhir` double DEFAULT NULL,
  PRIMARY KEY (`kode_brng`),
  CONSTRAINT `utd_stok_medis_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `utd_stok_penunjang`
-- ----------------------------
DROP TABLE IF EXISTS `utd_stok_penunjang`;
CREATE TABLE `utd_stok_penunjang` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `stok` double DEFAULT NULL,
  `hargaterakhir` double DEFAULT NULL,
  PRIMARY KEY (`kode_brng`),
  CONSTRAINT `utd_stok_penunjang_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

SET FOREIGN_KEY_CHECKS = 1;

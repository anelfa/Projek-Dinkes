/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * DlgKamar.java
 *
 * Created on May 23, 2010, 12:07:21 AM
 */

package bridging;

import fungsi.WarnaTable;
import java.awt.Dimension;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumn;
import fungsi.sekuel;
import fungsi.validasi;
import fungsi.var;
import java.awt.Cursor;
import java.awt.event.KeyEvent;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import javax.swing.JOptionPane;

/**
 *
 * @author dosen
 */
public final class BPJSPeserta extends javax.swing.JDialog {
    private final DefaultTableModel tabMode;
    private final Properties prop = new Properties();
    private validasi Valid=new validasi();
    private sekuel Sequel=new sekuel();
    private BPJSCekNoKartu cekViaBPJSKartu=new BPJSCekNoKartu();

    /** Creates new form DlgKamar
     * @param parent
     * @param modal */
    public BPJSPeserta(java.awt.Frame parent, boolean modal) {
        super(parent, modal);
        initComponents();

        this.setLocation(10,2);
        setSize(628,674);

        Object[] row={"",""};
        tabMode=new DefaultTableModel(null,row){
              @Override public boolean isCellEditable(int rowIndex, int colIndex){return false;}
        };
        tbKamar.setModel(tabMode);

        //tbKamar.setDefaultRenderer(Object.class, new WarnaTable(panelJudul.getBackground(),tbKamar.getBackground()));
        tbKamar.setPreferredScrollableViewportSize(new Dimension(500,500));
        tbKamar.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);

        for (int i = 0; i < 2; i++) {
            TableColumn column = tbKamar.getColumnModel().getColumn(i);
            if(i==0){
                column.setPreferredWidth(160);
            }else if(i==1){
                column.setPreferredWidth(420);
            }
        }
        tbKamar.setDefaultRenderer(Object.class, new WarnaTable());
    }
    
    

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        internalFrame1 = new widget.InternalFrame();
        Scroll = new widget.ScrollPane();
        tbKamar = new widget.Table();
        panelGlass6 = new widget.panelisi();
        BtnPrint = new widget.Button();
        BtnKeluar = new widget.Button();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setIconImage(null);
        setIconImages(null);
        setUndecorated(true);
        setResizable(false);

        internalFrame1.setBorder(javax.swing.BorderFactory.createTitledBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(240, 245, 235)), "::[ Pencarian Peserta BPJS Berdasarkan Nomor Kepesertaan VClaim ]::", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 0, 11), new java.awt.Color(130, 100, 100))); // NOI18N
        internalFrame1.setName("internalFrame1"); // NOI18N
        internalFrame1.setLayout(new java.awt.BorderLayout(1, 1));

        Scroll.setName("Scroll"); // NOI18N
        Scroll.setOpaque(true);

        tbKamar.setAutoCreateRowSorter(true);
        tbKamar.setToolTipText("Silahkan klik untuk memilih data yang mau diedit ataupun dihapus");
        tbKamar.setName("tbKamar"); // NOI18N
        Scroll.setViewportView(tbKamar);

        internalFrame1.add(Scroll, java.awt.BorderLayout.CENTER);

        panelGlass6.setName("panelGlass6"); // NOI18N
        panelGlass6.setPreferredSize(new java.awt.Dimension(44, 54));
        panelGlass6.setLayout(new java.awt.FlowLayout(java.awt.FlowLayout.LEFT, 5, 9));

        BtnPrint.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/b_print.png"))); // NOI18N
        BtnPrint.setMnemonic('T');
        BtnPrint.setText("Cetak");
        BtnPrint.setToolTipText("Alt+T");
        BtnPrint.setName("BtnPrint"); // NOI18N
        BtnPrint.setPreferredSize(new java.awt.Dimension(100, 30));
        BtnPrint.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnPrintActionPerformed(evt);
            }
        });
        panelGlass6.add(BtnPrint);

        BtnKeluar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/exit.png"))); // NOI18N
        BtnKeluar.setMnemonic('K');
        BtnKeluar.setText("Keluar");
        BtnKeluar.setToolTipText("Alt+K");
        BtnKeluar.setName("BtnKeluar"); // NOI18N
        BtnKeluar.setPreferredSize(new java.awt.Dimension(100, 30));
        BtnKeluar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnKeluarActionPerformed(evt);
            }
        });
        BtnKeluar.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                BtnKeluarKeyPressed(evt);
            }
        });
        panelGlass6.add(BtnKeluar);

        internalFrame1.add(panelGlass6, java.awt.BorderLayout.PAGE_END);

        getContentPane().add(internalFrame1, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void BtnKeluarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnKeluarActionPerformed
        dispose();
    }//GEN-LAST:event_BtnKeluarActionPerformed

    private void BtnKeluarKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_BtnKeluarKeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_SPACE){
            dispose();
        }else{Valid.pindah(evt,BtnPrint,BtnKeluar);}
    }//GEN-LAST:event_BtnKeluarKeyPressed

    private void BtnPrintActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnPrintActionPerformed
        if(tabMode.getRowCount()==0){
            JOptionPane.showMessageDialog(null,"Maaf, data sudah habis. Tidak ada data yang bisa anda print...!!!!");
            //TCari.requestFocus();
        }else if(tabMode.getRowCount()!=0){
            this.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
            Sequel.AutoComitFalse();
            Sequel.queryu("delete from temporary");
            int row=tabMode.getRowCount();
            for(int r=0;r<row;r++){  
                Sequel.menyimpan("temporary","'0','"+
                                tabMode.getValueAt(r,0).toString()+"','"+
                                tabMode.getValueAt(r,1).toString()+"','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''","Rekap Harian Pengadaan Ipsrs"); 
            }
            Sequel.AutoComitTrue();
            Map<String, Object> param = new HashMap<>();                 
            param.put("namars",var.getnamars());
            param.put("alamatrs",var.getalamatrs());
            param.put("kotars",var.getkabupatenrs());
            param.put("propinsirs",var.getpropinsirs());
            param.put("kontakrs",var.getkontakrs());
            param.put("emailrs",var.getemailrs());   
            param.put("logo",Sequel.cariGambar("select logo from setting")); 
            Valid.MyReport("rptCariBPJSNoPeserta.jrxml","report","[ Pencarian Peserta BPJS Berdasarkan Nomor Kepesertaan ]",
                "select no, temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9, temp10, temp11, temp12, temp13, temp14 from temporary order by no asc",param);
            this.setCursor(Cursor.getDefaultCursor());
        }        
    }//GEN-LAST:event_BtnPrintActionPerformed

    /**
    * @param args the command line arguments
    */
    public static void main(String args[]) {
        java.awt.EventQueue.invokeLater(() -> {
            BPJSPeserta dialog = new BPJSPeserta(new javax.swing.JFrame(), true);
            dialog.addWindowListener(new java.awt.event.WindowAdapter() {
                @Override
                public void windowClosing(java.awt.event.WindowEvent e) {
                    System.exit(0);
                }
            });
            dialog.setVisible(true);
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private widget.Button BtnKeluar;
    private widget.Button BtnPrint;
    private widget.ScrollPane Scroll;
    private widget.InternalFrame internalFrame1;
    private widget.panelisi panelGlass6;
    private widget.Table tbKamar;
    // End of variables declaration//GEN-END:variables

    public void tampil(String nomorpeserta) {
        cekViaBPJSKartu.tampil(nomorpeserta);
        if(cekViaBPJSKartu.informasi.equals("OK")){
            Valid.tabelKosong(tabMode);             
            tabMode.addRow(new Object[]{
                "Nama",": "+cekViaBPJSKartu.nama
            });
            tabMode.addRow(new Object[]{
                "NIK",": "+cekViaBPJSKartu.nik
            });
            tabMode.addRow(new Object[]{
                "Nomor Kartu",": "+cekViaBPJSKartu.noKartu
            });
            tabMode.addRow(new Object[]{
                "Nomor MR",": "+cekViaBPJSKartu.mrnoMR
            });
            tabMode.addRow(new Object[]{
                "Nomor Telp",": "+cekViaBPJSKartu.mrnoTelepon
            });
            tabMode.addRow(new Object[]{
                "Pisa",": "+cekViaBPJSKartu.pisa
            });
            tabMode.addRow(new Object[]{
                "Jenis Kelamin",": "+cekViaBPJSKartu.sex.replaceAll("L","Laki-Laki").replaceAll("P","Perempuan")
            });
            tabMode.addRow(new Object[]{
                "Status Peserta",":"
            });
            tabMode.addRow(new Object[]{
                "       Keterangan",": "+cekViaBPJSKartu.statusPesertaketerangan
            });
            tabMode.addRow(new Object[]{
                "       Kode",": "+cekViaBPJSKartu.statusPesertakode
            });
            tabMode.addRow(new Object[]{
                "Jenis Peserta",":"
            });
            tabMode.addRow(new Object[]{
                "       Kode Jenis Peserta",": "+cekViaBPJSKartu.jenisPesertakode
            });
            tabMode.addRow(new Object[]{
                "       Nama Jenis Peserta",": "+cekViaBPJSKartu.jenisPesertaketerangan
            });            
            tabMode.addRow(new Object[]{
                "Kelas Tanggungan",":"
            });
            tabMode.addRow(new Object[]{
                "       Kode Kelas",": "+cekViaBPJSKartu.hakKelaskode
            });
            tabMode.addRow(new Object[]{
                "       Nama Kelas",": "+cekViaBPJSKartu.hakKelasketerangan
            });
            tabMode.addRow(new Object[]{
                "Provider Umum",":"
            });
            tabMode.addRow(new Object[]{
                "       Kode Provider",": "+cekViaBPJSKartu.provUmumkdProvider
            });                
            tabMode.addRow(new Object[]{
                "       Nama Provider",": "+cekViaBPJSKartu.provUmumnmProvider
            });
            tabMode.addRow(new Object[]{
                "Tanggal Cetak Kartu",": "+cekViaBPJSKartu.tglCetakKartu
            });
            tabMode.addRow(new Object[]{
                "Tanggal Lahir",": "+cekViaBPJSKartu.tglLahir
            });
            tabMode.addRow(new Object[]{
                "Tanggal TAT",": "+cekViaBPJSKartu.tglTAT
            });
            tabMode.addRow(new Object[]{
                "Tanggal TMT",": "+cekViaBPJSKartu.tglTMT
            });
            tabMode.addRow(new Object[]{
                "Umur",":"
            });
            tabMode.addRow(new Object[]{
                "       Umur Saat Pelayanan",": "+cekViaBPJSKartu.umurumurSaatPelayanan
            });
            tabMode.addRow(new Object[]{
                "       Umur Sekarang",": "+cekViaBPJSKartu.umurumurSekarang.replaceAll("tahun ,","Th ").replaceAll("bulan ,","Bl ").replaceAll("hari","Hr")
            });
            tabMode.addRow(new Object[]{
                "Informasi",":"
            });
            tabMode.addRow(new Object[]{
                "       Dinsos",": "+cekViaBPJSKartu.informasidinsos
            });
            tabMode.addRow(new Object[]{
                "       No.SKTM",": "+cekViaBPJSKartu.informasinoSKTM
            });
            tabMode.addRow(new Object[]{
                "       Prolanis PRB",": "+cekViaBPJSKartu.informasiprolanisPRB
            });
            tabMode.addRow(new Object[]{
                "COB",":"
            });
            tabMode.addRow(new Object[]{
                "       Nama Asuransi",": "+cekViaBPJSKartu.cobnmAsuransi
            });
            tabMode.addRow(new Object[]{
                "       No Asuransi",": "+cekViaBPJSKartu.cobnoAsuransi
            });
            tabMode.addRow(new Object[]{
                "       Tanggal TAT",": "+cekViaBPJSKartu.cobtglTAT
            });
            tabMode.addRow(new Object[]{
                "       Tanggal TMT",": "+cekViaBPJSKartu.cobtglTMT
            });
        }else {
            JOptionPane.showMessageDialog(null,cekViaBPJSKartu.informasi);                
        }
    }    
 
}

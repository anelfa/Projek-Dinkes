/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * DlgLhtBiaya.java
 *
 * Created on 12 Jul 10, 16:21:34
 */

package keuangan;

import fungsi.WarnaTable;
import fungsi.batasInput;
import fungsi.koneksiDB;
import fungsi.sekuel;
import fungsi.validasi;
import fungsi.var;
import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.event.KeyEvent;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumn;

/**
 *
 * @author perpustakaan
 */
public final class DlgPembyaranRanapPerhari extends javax.swing.JDialog {
    private final DefaultTableModel tabMode;
    private Connection koneksi=koneksiDB.condb();
    private sekuel Sequel=new sekuel();
    private validasi Valid=new validasi();
    private PreparedStatement ps,ps2,pstanggal;
    private ResultSet rs,rs2,rstanggal;
    private double all=0,Laborat=0,Radiologi=0,Operasi=0,Obat=0,Ranap_Dokter=0,Ranap_Dokter_Paramedis=0,Ranap_Paramedis=0,Ralan_Dokter=0,
             Ralan_Dokter_Paramedis=0,Ralan_Paramedis=0,Tambahan=0,Potongan=0,Kamar=0,Registrasi=0,Harian=0,Retur_Obat=0,Resep_Pulang=0,
             Service=0,ttlLaborat=0,ttlRadiologi=0,ttlOperasi=0,ttlObat=0,ttlRanap_Dokter=0,ttlRanap_Paramedis=0,ttlRalan_Dokter=0,
             ttlRalan_Paramedis=0,ttlTambahan=0,ttlPotongan=0,ttlKamar=0,ttlRegistrasi=0,ttlHarian=0,ttlRetur_Obat=0,ttlResep_Pulang=0,ttlService=0;

    /** Creates new form DlgLhtBiaya
     * @param parent
     * @param modal */
    public DlgPembyaranRanapPerhari(java.awt.Frame parent, boolean modal) {
        super(parent, modal);
        initComponents();
        this.setLocation(8,1);
        setSize(885,674);

        Object[] rowRwJlDr={"Tgl.Pulang","Registrasi","Tindakan","Obat+Emb+Tsl","Retur Obat","Resep Pulang",
                            "Laborat","Radiologi","Potongan","Tambahan","Kamar+Service","Operasi","Harian","Total"};
        tabMode=new DefaultTableModel(null,rowRwJlDr){
              @Override public boolean isCellEditable(int rowIndex, int colIndex){return false;}
        };
        tbBangsal.setModel(tabMode);
        //tbBangsal.setDefaultRenderer(Object.class, new WarnaTable(jPanel2.getBackground(),tbBangsal.getBackground()));
        tbBangsal.setPreferredScrollableViewportSize(new Dimension(500,500));
        tbBangsal.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);

        for (int i = 0; i < 14; i++) {
            TableColumn column = tbBangsal.getColumnModel().getColumn(i);
            if(i==0){
                column.setPreferredWidth(70);
            }else if(i==13){
                column.setPreferredWidth(110);
            }else{
                column.setPreferredWidth(85);
            }
        }
        tbBangsal.setDefaultRenderer(Object.class, new WarnaTable());

        TKd.setDocument(new batasInput((byte)20).getKata(TKd));
        
        try{
            ps= koneksi.prepareStatement(
                "select kamar_inap.no_rawat,kamar_inap.tgl_keluar,kamar_inap.stts_pulang  from kamar_inap inner join reg_periksa inner join pasien inner join penjab inner join nota_inap "+
                "on kamar_inap.no_rawat=reg_periksa.no_rawat and reg_periksa.kd_pj=penjab.kd_pj and reg_periksa.no_rawat=nota_inap.no_rawat "+
                "and reg_periksa.no_rkm_medis=pasien.no_rkm_medis where reg_periksa.no_rawat not in (select piutang_pasien.no_rawat from piutang_pasien where piutang_pasien.no_rawat=reg_periksa.no_rawat) and kamar_inap.tgl_keluar=? "+
                "order by kamar_inap.tgl_keluar");
            pstanggal=koneksi.prepareStatement(
                    "select kamar_inap.tgl_keluar from kamar_inap where kamar_inap.tgl_keluar between ? and ? "+
                    "group by kamar_inap.tgl_keluar order by kamar_inap.tgl_keluar");                
            ps2=koneksi.prepareStatement(
                        "select sum(totalbiaya) from billing where no_rawat=? and status=? ");
        }catch(SQLException e){
            System.out.println(e);
        }

    }    
    

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        TKd = new widget.TextBox();
        internalFrame1 = new widget.InternalFrame();
        Scroll = new widget.ScrollPane();
        tbBangsal = new widget.Table();
        panelGlass5 = new widget.panelisi();
        BtnPrint = new widget.Button();
        BtnKeluar = new widget.Button();
        panelisi4 = new widget.panelisi();
        label11 = new widget.Label();
        Tgl1 = new widget.Tanggal();
        label18 = new widget.Label();
        Tgl2 = new widget.Tanggal();
        BtnCari1 = new widget.Button();
        jLabel10 = new javax.swing.JLabel();
        LCount = new javax.swing.JLabel();

        TKd.setForeground(new java.awt.Color(255, 255, 255));
        TKd.setName("TKd"); // NOI18N

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setUndecorated(true);
        setResizable(false);
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowOpened(java.awt.event.WindowEvent evt) {
                formWindowOpened(evt);
            }
        });

        internalFrame1.setBorder(javax.swing.BorderFactory.createTitledBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(240, 245, 235)), "::[ Data Pembayaran Pasien Ranap Perhari ]::", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 0, 11), new java.awt.Color(130, 100, 100))); // NOI18N
        internalFrame1.setName("internalFrame1"); // NOI18N
        internalFrame1.setLayout(new java.awt.BorderLayout(1, 1));

        Scroll.setName("Scroll"); // NOI18N
        Scroll.setOpaque(true);

        tbBangsal.setAutoCreateRowSorter(true);
        tbBangsal.setToolTipText("Silahkan klik untuk memilih data yang mau diedit ataupun dihapus");
        tbBangsal.setName("tbBangsal"); // NOI18N
        tbBangsal.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                tbBangsalMouseClicked(evt);
            }
        });
        tbBangsal.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                tbBangsalKeyPressed(evt);
            }
        });
        Scroll.setViewportView(tbBangsal);

        internalFrame1.add(Scroll, java.awt.BorderLayout.CENTER);

        panelGlass5.setName("panelGlass5"); // NOI18N
        panelGlass5.setPreferredSize(new java.awt.Dimension(55, 55));
        panelGlass5.setLayout(new java.awt.FlowLayout(java.awt.FlowLayout.LEFT, 5, 9));

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
        BtnPrint.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                BtnPrintKeyPressed(evt);
            }
        });
        panelGlass5.add(BtnPrint);

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
        panelGlass5.add(BtnKeluar);

        internalFrame1.add(panelGlass5, java.awt.BorderLayout.PAGE_END);

        panelisi4.setName("panelisi4"); // NOI18N
        panelisi4.setPreferredSize(new java.awt.Dimension(100, 44));
        panelisi4.setLayout(new java.awt.FlowLayout(java.awt.FlowLayout.LEFT, 5, 9));

        label11.setText("Tgl.Tagihan :");
        label11.setName("label11"); // NOI18N
        label11.setPreferredSize(new java.awt.Dimension(80, 23));
        panelisi4.add(label11);

        Tgl1.setEditable(false);
        Tgl1.setDisplayFormat("dd-MM-yyyy");
        Tgl1.setName("Tgl1"); // NOI18N
        Tgl1.setPreferredSize(new java.awt.Dimension(100, 23));
        panelisi4.add(Tgl1);

        label18.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        label18.setText("s.d.");
        label18.setName("label18"); // NOI18N
        label18.setPreferredSize(new java.awt.Dimension(30, 23));
        panelisi4.add(label18);

        Tgl2.setEditable(false);
        Tgl2.setDisplayFormat("dd-MM-yyyy");
        Tgl2.setName("Tgl2"); // NOI18N
        Tgl2.setPreferredSize(new java.awt.Dimension(100, 23));
        panelisi4.add(Tgl2);

        BtnCari1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/accept.png"))); // NOI18N
        BtnCari1.setMnemonic('2');
        BtnCari1.setToolTipText("Alt+2");
        BtnCari1.setName("BtnCari1"); // NOI18N
        BtnCari1.setPreferredSize(new java.awt.Dimension(28, 23));
        BtnCari1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnCari1ActionPerformed(evt);
            }
        });
        BtnCari1.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                BtnCari1KeyPressed(evt);
            }
        });
        panelisi4.add(BtnCari1);

        jLabel10.setFont(new java.awt.Font("Tahoma", 0, 11)); // NOI18N
        jLabel10.setForeground(new java.awt.Color(130, 100, 100));
        jLabel10.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        jLabel10.setText("Total Pembayaran :");
        jLabel10.setName("jLabel10"); // NOI18N
        jLabel10.setPreferredSize(new java.awt.Dimension(120, 23));
        panelisi4.add(jLabel10);

        LCount.setFont(new java.awt.Font("Tahoma", 0, 15)); // NOI18N
        LCount.setForeground(new java.awt.Color(130, 100, 100));
        LCount.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
        LCount.setText("0");
        LCount.setName("LCount"); // NOI18N
        LCount.setPreferredSize(new java.awt.Dimension(210, 23));
        panelisi4.add(LCount);

        internalFrame1.add(panelisi4, java.awt.BorderLayout.PAGE_START);

        getContentPane().add(internalFrame1, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void BtnPrintActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnPrintActionPerformed
        this.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
        if(tabMode.getRowCount()==0){
            JOptionPane.showMessageDialog(null,"Maaf, data sudah habis. Tidak ada data yang bisa anda print...!!!!");
            //TCari.requestFocus();
        }else if(tabMode.getRowCount()!=0){
            Sequel.AutoComitFalse();
            Sequel.queryu("delete from temporary");
            for(int r=0;r<tabMode.getRowCount();r++){  
                    Sequel.menyimpan("temporary","'0','"+
                                    tabMode.getValueAt(r,0).toString().replaceAll("'","`") +"','"+
                                    tabMode.getValueAt(r,1).toString().replaceAll("'","`")+"','"+
                                    tabMode.getValueAt(r,2).toString().replaceAll("'","`")+"','"+
                                    tabMode.getValueAt(r,3).toString().replaceAll("'","`")+"','"+
                                    tabMode.getValueAt(r,4).toString().replaceAll("'","`")+"','"+
                                    tabMode.getValueAt(r,5).toString().replaceAll("'","`")+"','"+
                                    tabMode.getValueAt(r,6).toString().replaceAll("'","`")+"','"+
                                    tabMode.getValueAt(r,7).toString().replaceAll("'","`")+"','"+
                                    tabMode.getValueAt(r,8).toString().replaceAll("'","`")+"','"+
                                    tabMode.getValueAt(r,9).toString().replaceAll("'","`")+"','"+
                                    tabMode.getValueAt(r,10).toString().replaceAll("'","`")+"','"+
                                    tabMode.getValueAt(r,11).toString().replaceAll("'","`")+"','"+
                                    tabMode.getValueAt(r,12).toString().replaceAll("'","`")+"','"+
                                    tabMode.getValueAt(r,13).toString().replaceAll("'","`")+"','','','','','','','','','','','','','','','','','','','','','','',''","Rekap Nota Pembayaran");
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
            Valid.MyReport("rptRTagihanRanapHarian.jrxml","report","::[ Rekap Tagihan Ranap Masuk ]::",
                "select * from temporary order by no asc",param);
        }
        this.setCursor(Cursor.getDefaultCursor());
}//GEN-LAST:event_BtnPrintActionPerformed

    private void BtnPrintKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_BtnPrintKeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_SPACE){
            BtnPrintActionPerformed(null);
        }else{
            //Valid.pindah(evt, BtnHapus, BtnAll);
        }
}//GEN-LAST:event_BtnPrintKeyPressed

    private void BtnKeluarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnKeluarActionPerformed
        dispose();
}//GEN-LAST:event_BtnKeluarActionPerformed

    private void BtnKeluarKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_BtnKeluarKeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_SPACE){
            dispose();
        }else{Valid.pindah(evt,BtnKeluar,TKd);}
}//GEN-LAST:event_BtnKeluarKeyPressed

    private void tbBangsalMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_tbBangsalMouseClicked
        if(tabMode.getRowCount()!=0){
            try {
                getData();
            } catch (java.lang.NullPointerException e) {
            }
        }
}//GEN-LAST:event_tbBangsalMouseClicked

    private void tbBangsalKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_tbBangsalKeyPressed
        if(tabMode.getRowCount()!=0){
            if((evt.getKeyCode()==KeyEvent.VK_ENTER)||(evt.getKeyCode()==KeyEvent.VK_UP)||(evt.getKeyCode()==KeyEvent.VK_DOWN)){
                try {
                    getData();
                } catch (java.lang.NullPointerException e) {
                }
            }
        }
}//GEN-LAST:event_tbBangsalKeyPressed

private void BtnCari1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnCari1ActionPerformed
        
        tampil();
}//GEN-LAST:event_BtnCari1ActionPerformed

private void BtnCari1KeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_BtnCari1KeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_SPACE){
            this.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR)); 
            tampil();
            this.setCursor(Cursor.getDefaultCursor());
        }else{
            Valid.pindah(evt, TKd, BtnPrint);
        }
}//GEN-LAST:event_BtnCari1KeyPressed

    private void formWindowOpened(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowOpened
        tampil();
    }//GEN-LAST:event_formWindowOpened

    /**
    * @param args the command line arguments
    */
    public static void main(String args[]) {
        java.awt.EventQueue.invokeLater(() -> {
            DlgPembyaranRanapPerhari dialog = new DlgPembyaranRanapPerhari(new javax.swing.JFrame(), true);
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
    private widget.Button BtnCari1;
    private widget.Button BtnKeluar;
    private widget.Button BtnPrint;
    private javax.swing.JLabel LCount;
    private widget.ScrollPane Scroll;
    private widget.TextBox TKd;
    private widget.Tanggal Tgl1;
    private widget.Tanggal Tgl2;
    private widget.InternalFrame internalFrame1;
    private javax.swing.JLabel jLabel10;
    private widget.Label label11;
    private widget.Label label18;
    private widget.panelisi panelGlass5;
    private widget.panelisi panelisi4;
    private widget.Table tbBangsal;
    // End of variables declaration//GEN-END:variables

    public void tampil(){
        this.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR)); 
        Valid.tabelKosong(tabMode);
        try{           
            pstanggal.setString(1,Valid.SetTgl(Tgl1.getSelectedItem()+""));
            pstanggal.setString(2,Valid.SetTgl(Tgl2.getSelectedItem()+""));
            rstanggal=pstanggal.executeQuery();
            all=0;ttlLaborat=0;ttlRadiologi=0;ttlOperasi=0;ttlObat=0;
            ttlRanap_Dokter=0;ttlRanap_Paramedis=0;ttlRalan_Dokter=0;
            ttlRalan_Paramedis=0;ttlTambahan=0;ttlPotongan=0;ttlKamar=0;
            ttlRegistrasi=0;ttlHarian=0;ttlRetur_Obat=0;ttlResep_Pulang=0;
            ttlService=0;
            while(rstanggal.next()){
                Laborat=0;Radiologi=0;Operasi=0;Obat=0;Ranap_Dokter=0;Ranap_Dokter_Paramedis=0;
                Ralan_Paramedis=0;Ranap_Paramedis=0;Ralan_Dokter=0;Ralan_Dokter_Paramedis=0;
                Tambahan=0;Potongan=0;Kamar=0;Registrasi=0;Harian=0;Retur_Obat=0;Resep_Pulang=0;Service=0;
                ps.setString(1,rstanggal.getString(1));
                rs=ps.executeQuery();            
                while(rs.next()){
                    if(!rs.getString("stts_pulang").equals("-")){
                    if(!rs.getString("stts_pulang").equals("Pindah Kamar")){
                        ps2.setString(1,rs.getString(1));
                        ps2.setString(2,"Laborat");
                        rs2=ps2.executeQuery();
                        while(rs2.next()){
                            ttlLaborat=ttlLaborat+rs2.getDouble(1);
                            Laborat=Laborat+rs2.getDouble(1);
                        }

                        ps2.setString(1,rs.getString(1));
                        ps2.setString(2,"Radiologi");
                        rs2=ps2.executeQuery();
                        while(rs2.next()){
                            ttlRadiologi=ttlRadiologi+rs2.getDouble(1);
                            Radiologi=Radiologi+rs2.getDouble(1);
                        }

                        ps2.setString(1,rs.getString(1));
                        ps2.setString(2,"Operasi");
                        rs2=ps2.executeQuery();
                        while(rs2.next()){
                            ttlOperasi=ttlOperasi+rs2.getDouble(1);
                            Operasi=Operasi+rs2.getDouble(1);
                        }

                        ps2.setString(1,rs.getString(1));
                        ps2.setString(2,"Obat");
                        rs2=ps2.executeQuery();
                        while(rs2.next()){
                            ttlObat=ttlObat+rs2.getDouble(1);
                            Obat=Obat+rs2.getDouble(1);
                        }

                        ps2.setString(1,rs.getString(1));
                        ps2.setString(2,"Ranap Dokter");
                        rs2=ps2.executeQuery();
                        while(rs2.next()){
                            ttlRanap_Dokter=ttlRanap_Dokter+rs2.getDouble(1);
                            Ranap_Dokter=Ranap_Dokter+rs2.getDouble(1);
                        }

                        ps2.setString(1,rs.getString(1));
                        ps2.setString(2,"Ranap Dokter Paramedis");
                        rs2=ps2.executeQuery();
                        while(rs2.next()){
                            ttlRanap_Dokter=ttlRanap_Dokter+rs2.getDouble(1);
                            Ranap_Dokter_Paramedis=Ranap_Dokter_Paramedis+rs2.getDouble(1);
                        }

                        ps2.setString(1,rs.getString(1));
                        ps2.setString(2,"Ranap Paramedis");
                        rs2=ps2.executeQuery();
                        while(rs2.next()){
                            ttlRanap_Paramedis=ttlRanap_Paramedis+rs2.getDouble(1);
                            Ranap_Paramedis=Ranap_Paramedis+rs2.getDouble(1);
                        }

                        ps2.setString(1,rs.getString(1));
                        ps2.setString(2,"Ralan Dokter");
                        rs2=ps2.executeQuery();
                        while(rs2.next()){
                            ttlRalan_Dokter=ttlRalan_Dokter+rs2.getDouble(1);
                            Ralan_Dokter=Ralan_Dokter+rs2.getDouble(1);
                        }

                        ps2.setString(1,rs.getString(1));
                        ps2.setString(2,"Ralan Dokter Paramedis");
                        rs2=ps2.executeQuery();
                        while(rs2.next()){
                            ttlRalan_Dokter=ttlRalan_Dokter+rs2.getDouble(1);
                            Ralan_Dokter_Paramedis=Ralan_Dokter_Paramedis+rs2.getDouble(1);
                        }

                        ps2.setString(1,rs.getString(1));
                        ps2.setString(2,"Ralan Paramedis");
                        rs2=ps2.executeQuery();
                        while(rs2.next()){
                            ttlRalan_Paramedis=ttlRalan_Paramedis+rs2.getDouble(1);
                            Ralan_Paramedis=Ralan_Paramedis+rs2.getDouble(1);
                        }

                        ps2.setString(1,rs.getString(1));
                        ps2.setString(2,"Tambahan");
                        rs2=ps2.executeQuery();
                        while(rs2.next()){
                            ttlTambahan=ttlTambahan+rs2.getDouble(1);
                            Tambahan=Tambahan+rs2.getDouble(1);
                        }

                        ps2.setString(1,rs.getString(1));
                        ps2.setString(2,"Potongan");
                        rs2=ps2.executeQuery();
                        while(rs2.next()){
                            ttlPotongan=ttlPotongan+rs2.getDouble(1);
                            Potongan=Potongan+rs2.getDouble(1);
                        }

                        ps2.setString(1,rs.getString(1));
                        ps2.setString(2,"Kamar");
                        rs2=ps2.executeQuery();
                        while(rs2.next()){
                            ttlKamar=ttlKamar+rs2.getDouble(1);
                            Kamar=Kamar+rs2.getDouble(1);
                        }

                        ps2.setString(1,rs.getString(1));
                        ps2.setString(2,"Registrasi");
                        rs2=ps2.executeQuery();
                        while(rs2.next()){
                            ttlRegistrasi=ttlRegistrasi+rs2.getDouble(1);
                            Registrasi=Registrasi+rs2.getDouble(1);
                        }

                        ps2.setString(1,rs.getString(1));
                        ps2.setString(2,"Harian");
                        rs2=ps2.executeQuery();
                        while(rs2.next()){
                            ttlHarian=ttlHarian+rs2.getDouble(1);
                            Harian=Harian+rs2.getDouble(1);
                        }

                        ps2.setString(1,rs.getString(1));
                        ps2.setString(2,"Retur Obat");
                        rs2=ps2.executeQuery();
                        while(rs2.next()){
                            ttlRetur_Obat=ttlRetur_Obat+rs2.getDouble(1);
                            Retur_Obat=Retur_Obat+rs2.getDouble(1);
                        }

                        ps2.setString(1,rs.getString(1));
                        ps2.setString(2,"Resep Pulang");
                        rs2=ps2.executeQuery();
                        while(rs2.next()){
                            ttlResep_Pulang=ttlResep_Pulang+rs2.getDouble(1);
                            Resep_Pulang=Resep_Pulang+rs2.getDouble(1);
                        }  
                        
                        ps2.setString(1,rs.getString(1));
                        ps2.setString(2,"Service");
                        rs2=ps2.executeQuery();
                        while(rs2.next()){
                            ttlService=ttlService+rs2.getDouble(1);
                            Service=Service+rs2.getDouble(1);
                        } 
                    }}                    
                }
                all=all+Laborat+Radiologi+Operasi+Obat+Ranap_Dokter+Ranap_Dokter_Paramedis+Ranap_Paramedis+Ralan_Dokter+Ralan_Dokter_Paramedis+Ralan_Paramedis+Tambahan+Potongan+Kamar+Registrasi+Harian+Retur_Obat+Resep_Pulang+Service;
                tabMode.addRow(new Object[]{
                    rstanggal.getString("tgl_keluar"),Valid.SetAngka(Registrasi),
                    Valid.SetAngka(Ranap_Dokter+Ranap_Dokter_Paramedis+Ranap_Paramedis+Ralan_Dokter+Ralan_Paramedis+Ralan_Dokter_Paramedis),
                    Valid.SetAngka(Obat),Valid.SetAngka(Retur_Obat),Valid.SetAngka(Resep_Pulang),Valid.SetAngka(Laborat),
                    Valid.SetAngka(Radiologi),Valid.SetAngka(Potongan),
                    Valid.SetAngka(Tambahan),Valid.SetAngka(Kamar+Service),Valid.SetAngka(Operasi),Valid.SetAngka(Harian),
                    Valid.SetAngka(Laborat+Radiologi+Operasi+Obat+Ranap_Dokter+Ranap_Dokter_Paramedis+
                        Ranap_Paramedis+Ralan_Dokter+Ralan_Dokter_Paramedis+Ralan_Paramedis+Tambahan+Potongan+Kamar+Registrasi+Harian+Retur_Obat+Resep_Pulang+Service)
                });
            }
            tabMode.addRow(new Object[]{
                    ">> Total : ",Valid.SetAngka(ttlRegistrasi),Valid.SetAngka(ttlRanap_Dokter+ttlRanap_Paramedis+ttlRalan_Dokter+ttlRalan_Paramedis),
                    Valid.SetAngka(ttlObat),Valid.SetAngka(ttlRetur_Obat),Valid.SetAngka(ttlResep_Pulang),Valid.SetAngka(ttlLaborat),Valid.SetAngka(ttlRadiologi),Valid.SetAngka(ttlPotongan),
                    Valid.SetAngka(ttlTambahan),Valid.SetAngka(ttlKamar+ttlService),Valid.SetAngka(ttlOperasi),Valid.SetAngka(ttlHarian),Valid.SetAngka(all)
            });
            LCount.setText(Valid.SetAngka(all));
            this.setCursor(Cursor.getDefaultCursor());
        }catch(Exception e){
            System.out.println("Notifikasi : "+e);
        }
    }

    private void getData() {
        int row=tbBangsal.getSelectedRow();
        if(row!= -1){
            TKd.setText(tabMode.getValueAt(row,0).toString());
        }
    }

}

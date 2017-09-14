/*
  Dilarang keras menggandakan/mengcopy/menyebarkan/membajak/mendecompile 
  Software ini dalam bentuk apapun tanpa seijin pembuat software
  (Khanza.Soft Media). Bagi yang sengaja membajak softaware ini ta
  npa ijin, kami sumpahi sial 1000 turunan, miskin sampai 500 turu
  nan. Selalu mendapat kecelakaan sampai 400 turunan. Anak pertama
  nya cacat tidak punya kaki sampai 300 turunan. Susah cari jodoh
  sampai umur 50 tahun sampai 200 turunan. Ya Alloh maafkan kami 
  karena telah berdoa buruk, semua ini kami lakukan karena kami ti
  dak pernah rela karya kami dibajak tanpa ijin.
 */


package setting;
import fungsi.WarnaTable;
import fungsi.batasInput;
import fungsi.koneksiDB;
import fungsi.sekuel;
import fungsi.validasi;
import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.event.KeyEvent;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.event.DocumentEvent;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumn;
import simrskhanza.DlgCariDokter;
import simrskhanza.DlgCariPetugas;

/**
 *
 * @author perpustakaan
 */
public class DlgSetAntrian extends javax.swing.JDialog {
    private final DefaultTableModel tabMode;
    private Connection koneksi=koneksiDB.condb();
    private sekuel Sequel=new sekuel();
    private validasi Valid=new validasi();
    private PreparedStatement ps;
    private ResultSet rs;
    private String user="";
    private int i=0;

    /** Creates new form DlgUser
     * @param parent
     * @param modal */
    public DlgSetAntrian(java.awt.Frame parent, boolean modal) {
        super(parent, modal);
        initComponents();
        this.setLocation(10,2);
        setSize(706,674);

        Object[] row={"Pengurutan Berdasarkan"
        };
        
        tabMode=new DefaultTableModel(null,row){
              @Override 
              public boolean isCellEditable(int rowIndex, int colIndex){
                  boolean a = true;
                    if ((colIndex==0)||(colIndex==1)||(colIndex==2)) {
                        a=false;
                    }
                    return a;
              }              
              Class[] types = new Class[] {
                java.lang.Object.class
             };
             @Override
             public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
             }
        };

        tbSetAntrian.setModel(tabMode);
        //tbJabatan.setDefaultRenderer(Object.class, new WarnaTable(Scroll.getBackground(),Color.GREEN));
        tbSetAntrian.setPreferredScrollableViewportSize(new Dimension(500,500));
        tbSetAntrian.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);

        for (i = 0; i < 1; i++) {
            TableColumn column = tbSetAntrian.getColumnModel().getColumn(i);
            if(i==0){
                column.setPreferredWidth(150);
            }
        }
        tbSetAntrian.setDefaultRenderer(Object.class, new WarnaTable());


        

        
        dlgdokter.addWindowListener(new WindowListener() {
            @Override
            public void windowOpened(WindowEvent e) {}
            @Override
            public void windowClosing(WindowEvent e) {}
            @Override
            public void windowClosed(WindowEvent e) {
                if(dlgdokter.getTable().getSelectedRow()!= -1){
                  

                }  
               
            }
            @Override
            public void windowIconified(WindowEvent e) {}
            @Override
            public void windowDeiconified(WindowEvent e) {}
            @Override
            public void windowActivated(WindowEvent e) {}
            @Override
            public void windowDeactivated(WindowEvent e) {}
        });
        
        dlgpetugas.addWindowListener(new WindowListener() {
            @Override
            public void windowOpened(WindowEvent e) {}
            @Override
            public void windowClosing(WindowEvent e) {}
            @Override
            public void windowClosed(WindowEvent e) {
                if(dlgpetugas.getTable().getSelectedRow()!= -1){                   
                    
                }            
               }
            @Override
            public void windowIconified(WindowEvent e) {}
            @Override
            public void windowDeiconified(WindowEvent e) {}
            @Override
            public void windowActivated(WindowEvent e) {}
            @Override
            public void windowDeactivated(WindowEvent e) {}
        });

       
    }

    DlgCariDokter dlgdokter=new DlgCariDokter(null,false);
    DlgCariPetugas dlgpetugas=new DlgCariPetugas(null,false);

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do falseT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        internalFrame1 = new widget.InternalFrame();
        Scroll = new widget.ScrollPane();
        tbSetAntrian = new widget.Table();
        panelGlass5 = new widget.panelisi();
        jLabel3 = new widget.Label();
        pilihSetAntrian = new widget.ComboBox();
        jPanel1 = new javax.swing.JPanel();
        panelGlass6 = new widget.panelisi();
        BtnSimpan = new widget.Button();
        BtnHapus = new widget.Button();
        BtnKeluar = new widget.Button();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setUndecorated(true);
        setResizable(false);
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowOpened(java.awt.event.WindowEvent evt) {
                formWindowOpened(evt);
            }
        });

        internalFrame1.setBorder(javax.swing.BorderFactory.createTitledBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(240, 245, 235)), "::[ Setup Nomor Antrian ]::", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 0, 11), new java.awt.Color(50, 70, 40))); // NOI18N
        internalFrame1.setName("internalFrame1"); // NOI18N
        internalFrame1.setLayout(new java.awt.BorderLayout(1, 1));

        Scroll.setName("Scroll"); // NOI18N
        Scroll.setOpaque(true);

        tbSetAntrian.setAutoCreateRowSorter(true);
        tbSetAntrian.setToolTipText("Silahkan klik untuk memilih data yang mau diedit ataupun dihapus");
        tbSetAntrian.setName("tbSetAntrian"); // NOI18N
        tbSetAntrian.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                tbSetAntrianMouseClicked(evt);
            }
        });
        tbSetAntrian.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                tbSetAntrianKeyPressed(evt);
            }
        });
        Scroll.setViewportView(tbSetAntrian);

        internalFrame1.add(Scroll, java.awt.BorderLayout.CENTER);

        panelGlass5.setName("panelGlass5"); // NOI18N
        panelGlass5.setPreferredSize(new java.awt.Dimension(55, 47));
        panelGlass5.setLayout(null);

        jLabel3.setText("Pilih Antrian Berdasarkan :");
        jLabel3.setName("jLabel3"); // NOI18N
        panelGlass5.add(jLabel3);
        jLabel3.setBounds(10, 12, 160, 23);

        pilihSetAntrian.setModel(new javax.swing.DefaultComboBoxModel(new String[] {"Poliklinik", "Dokter" }));
        pilihSetAntrian.setName("pilihSetAntrian"); // NOI18N
        pilihSetAntrian.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                pilihSetAntrianActionPerformed(evt);
            }
        });
        pilihSetAntrian.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                pilihSetAntrianKeyPressed(evt);
            }
        });
        panelGlass5.add(pilihSetAntrian);
        pilihSetAntrian.setBounds(180, 10, 190, 23);

        internalFrame1.add(panelGlass5, java.awt.BorderLayout.PAGE_START);

        jPanel1.setName("jPanel1"); // NOI18N
        jPanel1.setOpaque(false);
        jPanel1.setLayout(new java.awt.BorderLayout(1, 1));

        panelGlass6.setName("panelGlass6"); // NOI18N
        panelGlass6.setPreferredSize(new java.awt.Dimension(55, 55));
        panelGlass6.setLayout(new java.awt.FlowLayout(java.awt.FlowLayout.LEFT, 5, 9));

        BtnSimpan.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/save-16x16.png"))); // NOI18N
        BtnSimpan.setMnemonic('S');
        BtnSimpan.setText("Simpan");
        BtnSimpan.setToolTipText("Alt+S");
        BtnSimpan.setName("BtnSimpan"); // NOI18N
        BtnSimpan.setPreferredSize(new java.awt.Dimension(100, 30));
        BtnSimpan.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnSimpanActionPerformed(evt);
            }
        });
        BtnSimpan.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                BtnSimpanKeyPressed(evt);
            }
        });
        panelGlass6.add(BtnSimpan);

        BtnHapus.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/stop_f2.png"))); // NOI18N
        BtnHapus.setMnemonic('H');
        BtnHapus.setText("Hapus");
        BtnHapus.setToolTipText("Alt+H");
        BtnHapus.setName("BtnHapus"); // NOI18N
        BtnHapus.setPreferredSize(new java.awt.Dimension(100, 30));
        BtnHapus.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnHapusActionPerformed(evt);
            }
        });
        BtnHapus.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                BtnHapusKeyPressed(evt);
            }
        });
        panelGlass6.add(BtnHapus);

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

        jPanel1.add(panelGlass6, java.awt.BorderLayout.PAGE_END);

        internalFrame1.add(jPanel1, java.awt.BorderLayout.PAGE_END);

        getContentPane().add(internalFrame1, java.awt.BorderLayout.CENTER);
        internalFrame1.getAccessibleContext().setAccessibleName("::[ Setup Nomor Antrian ]:");
        internalFrame1.getAccessibleContext().setAccessibleDescription("");

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void BtnSimpanActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnSimpanActionPerformed
if(tabMode.getRowCount()==0){
        Sequel.menyimpan("set_no_antrian","'"+pilihSetAntrian.getSelectedItem()+"'","Setup Pengaturan Nomor Antrian");        
                tampil();
                emptTeks();
}
else if(tabMode.getRowCount()>0){
                JOptionPane.showMessageDialog(null,"Maaf, Hanya diijinkan satu pengaturan ...!!!!");
                pilihSetAntrian.requestFocus();
            }
           
}//GEN-LAST:event_BtnSimpanActionPerformed

    private void BtnSimpanKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_BtnSimpanKeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_PAGE_DOWN){
            BtnSimpanActionPerformed(null);
        }else{
           
        }
}//GEN-LAST:event_BtnSimpanKeyPressed

    private void BtnHapusActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnHapusActionPerformed
 if(tabMode.getRowCount()==0){
            JOptionPane.showMessageDialog(null,"Maaf, data sudah habis...!!!!");
            pilihSetAntrian.requestFocus();
        }else if(pilihSetAntrian.getSelectedItem().equals("")){
            JOptionPane.showMessageDialog(null,"Maaf, Gagal menghapus. Pilih dulu data yang mau dihapus.\nKlik data pada table untuk memilih...!!!!");
        }else if(! pilihSetAntrian.getSelectedItem().equals("")){
            Sequel.queryu("delete from set_no_antrian ");
            tampil();
            emptTeks();
        }        
}//GEN-LAST:event_BtnHapusActionPerformed

    private void BtnHapusKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_BtnHapusKeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_PAGE_DOWN){
            BtnHapusActionPerformed(null);
        }
}//GEN-LAST:event_BtnHapusKeyPressed

    private void BtnKeluarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnKeluarActionPerformed
        dispose();
}//GEN-LAST:event_BtnKeluarActionPerformed

    private void BtnKeluarKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_BtnKeluarKeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_PAGE_DOWN){
            dispose();
        }
}//GEN-LAST:event_BtnKeluarKeyPressed

    private void tbSetAntrianMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_tbSetAntrianMouseClicked
        if(tabMode.getRowCount()!=0){
            try {
                getData();
            } catch (java.lang.NullPointerException e) {
            }
        }
}//GEN-LAST:event_tbSetAntrianMouseClicked

    private void tbSetAntrianKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_tbSetAntrianKeyPressed
        if(tabMode.getRowCount()!=0){
            if((evt.getKeyCode()==KeyEvent.VK_ENTER)||(evt.getKeyCode()==KeyEvent.VK_UP)||(evt.getKeyCode()==KeyEvent.VK_DOWN)){
                try {
                    getData();
                } catch (java.lang.NullPointerException e) {
                }
            }
        }
}//GEN-LAST:event_tbSetAntrianKeyPressed

    private void formWindowOpened(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowOpened
        tampil();
    }//GEN-LAST:event_formWindowOpened

    private void pilihSetAntrianKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_pilihSetAntrianKeyPressed
      
    }//GEN-LAST:event_pilihSetAntrianKeyPressed

    private void pilihSetAntrianActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_pilihSetAntrianActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_pilihSetAntrianActionPerformed

    /**
    * @param args the command line arguments
    */
    public static void main(String args[]) {
        java.awt.EventQueue.invokeLater(() -> {
            DlgUser dialog = new DlgUser(new javax.swing.JFrame(), true);
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
    private widget.Button BtnHapus;
    private widget.Button BtnKeluar;
    private widget.Button BtnSimpan;
    private widget.ScrollPane Scroll;
    private widget.InternalFrame internalFrame1;
    private widget.Label jLabel3;
    private javax.swing.JPanel jPanel1;
    private widget.panelisi panelGlass5;
    private widget.panelisi panelGlass6;
    private widget.ComboBox pilihSetAntrian;
    private widget.Table tbSetAntrian;
    // End of variables declaration//GEN-END:variables

    private void tampil() {        
        try{    
            Valid.tabelKosong(tabMode);
            ps=koneksi.prepareStatement("select dasar_no_antrian"+
                    " from set_no_antrian");
            try {
                rs=ps.executeQuery();
                while(rs.next()){
                    user="";
                    user=Sequel.cariIsi("select nm_dokter from dokter where kd_dokter=?",rs.getString(1));
                    if(user.equals("")){
                        user=Sequel.cariIsi("select nama from petugas where nip=?",rs.getString(1));
                    }    
                    try {
                           tabMode.addRow(new Object[]{rs.getString(1)});
                    } catch (Exception e) {
                        tabMode.addRow(new Object[]{rs.getString(1)
                                         
                            });
                    }                                             
                 }

            } catch (Exception e) {
                System.out.println(e);
            } finally{
                if(rs!=null){
                    rs.close();
                }
                if(ps!=null){
                    ps.close();
                }
            }
                        
        }catch(Exception e){
            System.out.println("Notifikasi : "+e);
        }
    }

    private void isUser() {
        try{
           
        }catch(Exception e){
            System.out.println("Notifikasi : "+e);
        }
    }

    public void emptTeks() {

    }

    private void getData() {
        i=tbSetAntrian.getSelectedRow();
        if(i!= -1){
            
                   
        }
    }

}

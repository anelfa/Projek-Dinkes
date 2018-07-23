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
import java.awt.Dimension;
import java.awt.event.KeyEvent;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.Key;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumn;
import javax.xml.bind.DatatypeConverter;

/**
 *
 * @author perpustakaan
 */
public class DlgSetDatabase extends javax.swing.JDialog {

   
    private final DefaultTableModel tabMode;
    private Connection koneksi=koneksiDB.condb();
    private sekuel Sequel=new sekuel();
    private String  kunciEnkripsi = "",hostEn="",databaseEn="",portEn="",userEn="",pasEn="",
                    hostDe="",databaseDe="",portDe="",userDe="",pasDe=""; // kunci maksimal 16 karakter="";
    private validasi Valid=new validasi();
    private final Properties prop = new Properties();  

    public static String decryptAES(String encryptedData, String kunciEnkripsi)
            throws Exception {
        Cipher c = Cipher.getInstance("AES");
        Key key = generateKey(kunciEnkripsi);
        c.init(Cipher.DECRYPT_MODE, key);
 
        // byte[] decordedValue = new
        // BASE64Decoder().decodeBuffer(encryptedData); // deprecated
        byte[] decordedValue = DatatypeConverter
                .parseBase64Binary(encryptedData);
        byte[] decValue = c.doFinal(decordedValue);
        String decryptedValue = new String(decValue);
        return decryptedValue;
    }
public static String encryptAES(String Data, String kunciEnkripsi)
            throws Exception {
        Cipher c = Cipher.getInstance("AES");
        Key key = generateKey(kunciEnkripsi);
        c.init(Cipher.ENCRYPT_MODE, key);
        byte[] encVal = c.doFinal(Data.getBytes());
        // String encryptedValue = new BASE64Encoder().encode(encVal); //
        // deprecated
        String encryptedValue = DatatypeConverter.printBase64Binary(encVal);
        return encryptedValue;
    }
private static Key generateKey(String kunciEnkripsi) throws Exception {
        Key key = new SecretKeySpec(konversiKeByte(kunciEnkripsi), "AES");
        return key;
    }
private static byte[] konversiKeByte(String kunci) {
        byte[] array_byte = new byte[16];
        int i = 0;
        while (i < kunci.length()) {
            array_byte[i] = (byte) kunci.charAt(i);
            i++;
        }
        if (i < 16) {
            while (i < 16) {
                array_byte[i] = (byte) i;
                i++;
            }
        }
        return array_byte;
    }
    /** Creates new form DlgAdmin
     * @param parent
     * @param modal */
    public DlgSetDatabase(java.awt.Frame parent, boolean modal) throws Exception {
        
        super(parent, modal);
        initComponents();
        this.setLocation(10,10);
        setSize(457,249);

        Object[] row={"ID Admin",
                      "Password"};
        tabMode=new DefaultTableModel(null,row){
              @Override public boolean isCellEditable(int rowIndex, int colIndex){return false;}
        };

        try {
            prop.loadFromXML(new FileInputStream("setting/config.xml"));
             
            
        } catch (Exception e) {
            System.out.println("Notif Setting : "+e);
        }
        kunciEnkripsi="thama";
        hostDe = decryptAES(prop.getProperty("HOST"), kunciEnkripsi);
        databaseDe = decryptAES(prop.getProperty("DATABASE"), kunciEnkripsi);
        portDe = decryptAES(prop.getProperty("PORT"), kunciEnkripsi);
        userDe = decryptAES(prop.getProperty("USER"), kunciEnkripsi);
        pasDe = decryptAES(prop.getProperty("PAS"), kunciEnkripsi);
        //-----------
        THost.setText(hostDe);
        TDatabase.setText(databaseDe);
        TPort.setText(portDe);
        TUser.setText(userDe);
        TPassword.setText(pasDe);
        
        //THost.setDocument(new batasInput((byte)30).getKata(THost));
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
        panelGlass7 = new widget.panelisi();
        jLabel3 = new widget.Label();
        TPassword = new widget.TextBox();
        jLabel5 = new widget.Label();
        THost = new widget.TextBox();
        jLabel6 = new widget.Label();
        TDatabase = new widget.TextBox();
        jLabel7 = new widget.Label();
        jLabel8 = new widget.Label();
        TPort = new widget.TextBox();
        TUser = new widget.TextBox();
        panelGlass5 = new widget.panelisi();
        BtnSimpan = new widget.Button();
        BtnEdit = new widget.Button();
        BtnKeluar = new widget.Button();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setUndecorated(true);
        setPreferredSize(new java.awt.Dimension(0, 0));
        setResizable(false);
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowActivated(java.awt.event.WindowEvent evt) {
                formWindowActivated(evt);
            }
            public void windowOpened(java.awt.event.WindowEvent evt) {
                formWindowOpened(evt);
            }
        });

        internalFrame1.setBorder(javax.swing.BorderFactory.createTitledBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(240, 245, 235)), "::[ Setup Database Server ]::", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 0, 11), new java.awt.Color(50, 70, 40))); // NOI18N
        internalFrame1.setAlignmentX(10.0F);
        internalFrame1.setAlignmentY(10.0F);
        internalFrame1.setFont(new java.awt.Font("Tahoma", 2, 12)); // NOI18N
        internalFrame1.setName("internalFrame1"); // NOI18N
        internalFrame1.setPreferredSize(new java.awt.Dimension(65, 56));
        internalFrame1.setLayout(new java.awt.BorderLayout(1, 1));

        panelGlass7.setName("panelGlass7"); // NOI18N
        panelGlass7.setPreferredSize(new java.awt.Dimension(44, 180));
        panelGlass7.setLayout(null);

        jLabel3.setText("Password :");
        jLabel3.setName("jLabel3"); // NOI18N
        jLabel3.setPreferredSize(new java.awt.Dimension(55, 14));
        panelGlass7.add(jLabel3);
        jLabel3.setBounds(0, 130, 65, 23);

        TPassword.setHighlighter(null);
        TPassword.setName("TPassword"); // NOI18N
        TPassword.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                TPasswordKeyPressed(evt);
            }
        });
        panelGlass7.add(TPassword);
        TPassword.setBounds(70, 130, 260, 23);

        jLabel5.setText("Host : ");
        jLabel5.setName("jLabel5"); // NOI18N
        panelGlass7.add(jLabel5);
        jLabel5.setBounds(0, 12, 69, 23);

        THost.setHighlighter(null);
        THost.setName("THost"); // NOI18N
        THost.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                THostActionPerformed(evt);
            }
        });
        THost.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                THostKeyPressed(evt);
            }
        });
        panelGlass7.add(THost);
        THost.setBounds(70, 10, 260, 23);

        jLabel6.setText("Database : ");
        jLabel6.setName("jLabel6"); // NOI18N
        panelGlass7.add(jLabel6);
        jLabel6.setBounds(0, 40, 69, 23);

        TDatabase.setHighlighter(null);
        TDatabase.setName("TDatabase"); // NOI18N
        TDatabase.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                TDatabaseKeyPressed(evt);
            }
        });
        panelGlass7.add(TDatabase);
        TDatabase.setBounds(70, 40, 260, 23);

        jLabel7.setText("Port : ");
        jLabel7.setName("jLabel7"); // NOI18N
        panelGlass7.add(jLabel7);
        jLabel7.setBounds(0, 70, 69, 23);

        jLabel8.setText("User : ");
        jLabel8.setName("jLabel8"); // NOI18N
        panelGlass7.add(jLabel8);
        jLabel8.setBounds(0, 100, 69, 23);

        TPort.setHighlighter(null);
        TPort.setName("TPort"); // NOI18N
        TPort.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                TPortKeyPressed(evt);
            }
        });
        panelGlass7.add(TPort);
        TPort.setBounds(70, 70, 260, 23);

        TUser.setHighlighter(null);
        TUser.setName("TUser"); // NOI18N
        TUser.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                TUserKeyPressed(evt);
            }
        });
        panelGlass7.add(TUser);
        TUser.setBounds(70, 100, 260, 23);

        internalFrame1.add(panelGlass7, java.awt.BorderLayout.PAGE_START);

        panelGlass5.setName("panelGlass5"); // NOI18N
        panelGlass5.setPreferredSize(new java.awt.Dimension(55, 55));
        panelGlass5.setLayout(new java.awt.FlowLayout(java.awt.FlowLayout.LEFT, 5, 9));

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
        panelGlass5.add(BtnSimpan);

        BtnEdit.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/inventaris.png"))); // NOI18N
        BtnEdit.setMnemonic('G');
        BtnEdit.setText("Ganti");
        BtnEdit.setToolTipText("Alt+G");
        BtnEdit.setIconTextGap(3);
        BtnEdit.setName("BtnEdit"); // NOI18N
        BtnEdit.setPreferredSize(new java.awt.Dimension(100, 30));
        BtnEdit.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnEditActionPerformed(evt);
            }
        });
        BtnEdit.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                BtnEditKeyPressed(evt);
            }
        });
        panelGlass5.add(BtnEdit);

        BtnKeluar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/exit.png"))); // NOI18N
        BtnKeluar.setMnemonic('K');
        BtnKeluar.setText("Keluar");
        BtnKeluar.setToolTipText("Alt+K");
        BtnKeluar.setIconTextGap(3);
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

        getContentPane().add(internalFrame1, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void TPasswordKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_TPasswordKeyPressed
   //     Valid.pindah(evt,BtnSimpan,TNm);
}//GEN-LAST:event_TPasswordKeyPressed

    private void BtnSimpanActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnSimpanActionPerformed
//AES_ENCRYPT
 
        
        try{
        kunciEnkripsi="thama";   
         hostEn = encryptAES(THost.getText(), kunciEnkripsi);
         databaseEn = encryptAES(TDatabase.getText(), kunciEnkripsi);
         portEn = encryptAES(TPort.getText(), kunciEnkripsi);
         userEn = encryptAES(TUser.getText(), kunciEnkripsi);
         pasEn = encryptAES(TPassword.getText(), kunciEnkripsi);
        Properties properties =new Properties();
        properties.setProperty("HOST",hostEn);
        properties.setProperty("DATABASE",databaseEn);
        properties.setProperty("PORT",portEn);
        properties.setProperty("USER",userEn);
        properties.setProperty("PAS",pasEn);
   
        File file = new File("setting/config.xml");
        FileOutputStream fileOut = new FileOutputStream(file);
        properties.storeToXML(fileOut, "KhanzaHMS");
        fileOut.close();
      }catch(FileNotFoundException e)
      {
          e.printStackTrace();
      }catch(IOException e)
      {
          e.printStackTrace();
      } catch (Exception ex) {
            Logger.getLogger(DlgSetDatabase.class.getName()).log(Level.SEVERE, null, ex);
        }
}//GEN-LAST:event_BtnSimpanActionPerformed

    private void BtnSimpanKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_BtnSimpanKeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_ENTER){
            BtnSimpanActionPerformed(null);
        }else{
          //  Valid.pindah(evt,TNm,BtnBatal);
        }
}//GEN-LAST:event_BtnSimpanKeyPressed

    private void BtnEditActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnEditActionPerformed
      try{
         kunciEnkripsi="thama";
       hostEn = encryptAES(THost.getText(), kunciEnkripsi);
         databaseEn = encryptAES(TDatabase.getText(), kunciEnkripsi);
         portEn = encryptAES(TPort.getText(), kunciEnkripsi);
         userEn = encryptAES(TUser.getText(), kunciEnkripsi);
         pasEn = encryptAES(TPassword.getText(), kunciEnkripsi);
        Properties properties =new Properties();
        properties.setProperty("HOST",hostEn);
        properties.setProperty("DATABASE",databaseEn);
        properties.setProperty("PORT",portEn);
        properties.setProperty("USER",userEn);
        properties.setProperty("PAS",pasEn);
        File file = new File("setting/config.xml");
        FileOutputStream fileOut = new FileOutputStream(file);
        properties.storeToXML(fileOut, "KhanzaHMS");
        fileOut.close();
      }catch(FileNotFoundException e)
      {
          e.printStackTrace();
      }catch(IOException e)
      {
          e.printStackTrace();
      } catch (Exception ex) {
            Logger.getLogger(DlgSetDatabase.class.getName()).log(Level.SEVERE, null, ex);
        }

        
        /*  if(TPassword.getText().trim().equals("")){
            Valid.textKosong(TPassword,"kode jabatan");
        }else if(TNm.getText().trim().equals("")){
            Valid.textKosong(TNm,"nama jabatan");
        }else{
            Sequel.queryu("delete from admin");
            Sequel.menyimpan("admin","AES_ENCRYPT('"+TPassword.getText()+"','nur'),AES_ENCRYPT('"+TNm.getText()+"','windi')","Kode Admin");
            if(tabMode.getRowCount()!=0){tampil();}
            emptTeks();
        }*/
}//GEN-LAST:event_BtnEditActionPerformed

    private void BtnEditKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_BtnEditKeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_SPACE){
            BtnEditActionPerformed(null);
        }else{
      //      Valid.pindah(evt, BtnHapus, BtnKeluar);
        }
}//GEN-LAST:event_BtnEditKeyPressed

    private void BtnKeluarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnKeluarActionPerformed
       
            dispose();
        
}//GEN-LAST:event_BtnKeluarActionPerformed

    private void BtnKeluarKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_BtnKeluarKeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_SPACE){
            dispose();
        }else{Valid.pindah(evt,BtnEdit,BtnKeluar);}
}//GEN-LAST:event_BtnKeluarKeyPressed

    private void formWindowActivated(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowActivated
        //emptTeks();
    }//GEN-LAST:event_formWindowActivated

    private void formWindowOpened(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowOpened
       // tampil();
    }//GEN-LAST:event_formWindowOpened

    private void THostKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_THostKeyPressed
       Valid.pindah(evt,BtnSimpan,TDatabase);
    }//GEN-LAST:event_THostKeyPressed

    private void TDatabaseKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_TDatabaseKeyPressed
       Valid.pindah(evt,BtnSimpan,TPort); // TODO add your handling code here:
    }//GEN-LAST:event_TDatabaseKeyPressed

    private void TPortKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_TPortKeyPressed
        // TODO add your handling code here:
    }//GEN-LAST:event_TPortKeyPressed

    private void TUserKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_TUserKeyPressed
        // TODO add your handling code here:
    }//GEN-LAST:event_TUserKeyPressed

    private void THostActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_THostActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_THostActionPerformed

    /**
    * @param args the command line arguments
    */
    public static void main(String args[]) {
        java.awt.EventQueue.invokeLater(() -> {
            DlgAdmin dialog = new DlgAdmin(new javax.swing.JFrame(), true);
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
    private widget.Button BtnEdit;
    private widget.Button BtnKeluar;
    private widget.Button BtnSimpan;
    private widget.TextBox TDatabase;
    private widget.TextBox THost;
    private widget.TextBox TPassword;
    private widget.TextBox TPort;
    private widget.TextBox TUser;
    private widget.InternalFrame internalFrame1;
    private widget.Label jLabel3;
    private widget.Label jLabel5;
    private widget.Label jLabel6;
    private widget.Label jLabel7;
    private widget.Label jLabel8;
    private widget.panelisi panelGlass5;
    private widget.panelisi panelGlass7;
    // End of variables declaration//GEN-END:variables


    private void prosesCari(String sql) {
        Valid.tabelKosong(tabMode);
        try{
            java.sql.Statement stat=koneksi.createStatement();
            ResultSet rs=stat.executeQuery(sql);
            while(rs.next()){
                String kd=rs.getString(1);
                String nm=rs.getString(2);
                String[] data={kd,nm};
                tabMode.addRow(data);
             }
        }catch(SQLException e){
            System.out.println("Notifikasi : "+e);
        }
    }

    private void getData() {
/*        int row=tbAdmin.getSelectedRow();
        if(row!= -1){
            String kode=tabMode.getValueAt(row,0).toString();
            String nama=tabMode.getValueAt(row,1).toString();
            TPassword.setText(kode);
            TNm.setText(nama);
        }*/
    }

    
}

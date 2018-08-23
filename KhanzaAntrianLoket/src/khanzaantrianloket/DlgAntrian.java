/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * DlgBiling.java
 *
 * Created on 07 Jun 10, 19:07:06
 */

package khanzaantrianloket;

import fungsi.BackgroundMusic;
import fungsi.koneksiDB;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.awt.*;
import javax.swing.*;
import java.awt.event.*;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author perpustakaan
 */
public class DlgAntrian extends javax.swing.JDialog implements ActionListener{    
    private final Connection koneksi=koneksiDB.condb();
    private final Dimension screen=Toolkit.getDefaultToolkit().getScreenSize();   
    private static final Properties prop = new Properties();
    private String antri="0",loket="0",status="0";
    private PreparedStatement pshapus,pssimpan,pscari,psupdate,pssimpan_tmp,pscari_tmp,psupdate_tmp;
    private ResultSet rs,rs2;
    private int urut;
    private BackgroundMusic music;
    /** Creates new form DlgBiling
     * @param parent
     * @param modal */
    public DlgAntrian(java.awt.Frame parent, boolean modal) {
        super(parent, modal);
        initComponents();
        setIconImage(new ImageIcon(super.getClass().getResource("/picture/addressbook-edit24.png")).getImage());
        
        this.setSize(350,400);
        try {
            prop.loadFromXML(new FileInputStream("setting/database.xml"));
        } catch (IOException ex) {
            System.out.println(ex);
        }
        txtLoket.setText(prop.getProperty("LOKET"));
        try {
            pshapus=koneksi.prepareStatement("delete from antriloket");
            pssimpan=koneksi.prepareStatement("insert into antriloket values(?,?,?)");
            
            psupdate=koneksi.prepareStatement("update antriloket SET status=? where loket=?");
            pscari=koneksi.prepareStatement("select antrian,loket,status from antriloket");
            
            pssimpan_tmp=koneksi.prepareStatement("insert into antrianloket_tmp values(?,?)");
            psupdate_tmp=koneksi.prepareStatement("update antrianloket_tmp SET antrian=? where loket=?");
            pscari_tmp=koneksi.prepareStatement("select loket,antrian from antrianloket_tmp where loket=?");
            pscari_tmp.setString(1,prop.getProperty("LOKET"));
            rs2=pscari_tmp.executeQuery();
            if(!rs2.next())
           {
            Antrian.setText("0");
            
           }
           else{
            Antrian.setText(rs2.getString("antrian"));
           }
        } catch (Exception e) {
            System.out.println(e);
        }
       
            
           
           
        jam();
        javax.swing.Timer timer = new javax.swing.Timer(100, this);
        timer.start();
    }
    int i;
    


    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        DlgDisplay = new javax.swing.JDialog();
        internalFrame5 = new widget.InternalFrame();
        paneliklan = new usu.widget.glass.PanelGlass();
        panelruntext = new javax.swing.JPanel();
        labelruntext = new widget.Label();
        form1 = new widget.InternalFrame();
        labelantri1 = new widget.Label();
        labelLoket = new widget.Label();
        internalFrame1 = new widget.InternalFrame();
        panelisi1 = new widget.panelisi();
        BtnDisplay = new widget.Button();
        BtnKeluar = new widget.Button();
        panelisi5 = new widget.panelisi();
        BtnAntri1 = new widget.Button();
        BtnBatal1 = new widget.Button();
        label1 = new widget.Label();
        label2 = new widget.Label();
        Antrian = new widget.TextBox();
        BtnBatal2 = new widget.Button();
        BtnPanggil = new widget.Button();
        txtLoket = new widget.TextBox();

        DlgDisplay.setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        DlgDisplay.setModalExclusionType(java.awt.Dialog.ModalExclusionType.APPLICATION_EXCLUDE);
        DlgDisplay.setName("DlgDisplay"); // NOI18N

        internalFrame5.setBorder(javax.swing.BorderFactory.createTitledBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(100, 200, 100)), "::[ Informasi ]::", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 0, 32), new java.awt.Color(50, 100, 50))); // NOI18N
        internalFrame5.setName("internalFrame5"); // NOI18N
        internalFrame5.setPreferredSize(new java.awt.Dimension(500, 110));
        internalFrame5.setWarnaAtas(new java.awt.Color(255, 255, 255));
        internalFrame5.setWarnaBawah(new java.awt.Color(230, 255, 230));
        internalFrame5.setLayout(new java.awt.BorderLayout());

        paneliklan.setBackgroundImage(new javax.swing.ImageIcon(getClass().getResource("/picture/coba.gif"))); // NOI18N
        paneliklan.setBackgroundImageType(usu.widget.constan.BackgroundConstan.BACKGROUND_IMAGE_STRECT);
        paneliklan.setPreferredSize(new java.awt.Dimension(200, 140));
        paneliklan.setRound(false);
        paneliklan.setWarna(new java.awt.Color(150, 255, 150));
        paneliklan.setLayout(null);
        internalFrame5.add(paneliklan, java.awt.BorderLayout.CENTER);

        panelruntext.setBackground(new java.awt.Color(230, 255, 230));
        panelruntext.setName("panelruntext"); // NOI18N
        panelruntext.setPreferredSize(new java.awt.Dimension(100, 100));
        panelruntext.setLayout(new java.awt.BorderLayout());

        labelruntext.setBackground(new java.awt.Color(238, 255, 238));
        labelruntext.setForeground(new java.awt.Color(50, 100, 50));
        labelruntext.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
        labelruntext.setFont(new java.awt.Font("Tahoma", 0, 35)); // NOI18N
        labelruntext.setName("labelruntext"); // NOI18N
        labelruntext.setPreferredSize(new java.awt.Dimension(853, 50));
        panelruntext.add(labelruntext, java.awt.BorderLayout.CENTER);

        internalFrame5.add(panelruntext, java.awt.BorderLayout.PAGE_END);

        DlgDisplay.getContentPane().add(internalFrame5, java.awt.BorderLayout.CENTER);

        form1.setBorder(javax.swing.BorderFactory.createTitledBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(100, 200, 100)), " Antrian Registrasi", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 0, 45), new java.awt.Color(50, 100, 50))); // NOI18N
        form1.setName("form1"); // NOI18N
        form1.setPreferredSize(new java.awt.Dimension(550, 150));
        form1.setWarnaAtas(new java.awt.Color(255, 255, 255));
        form1.setWarnaBawah(new java.awt.Color(230, 255, 230));
        form1.setLayout(new java.awt.GridLayout(2, 0));

        labelantri1.setBorder(javax.swing.BorderFactory.createTitledBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(150, 250, 150)), "No.Antrian :", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 0, 32), new java.awt.Color(50, 100, 50))); // NOI18N
        labelantri1.setForeground(new java.awt.Color(50, 100, 50));
        labelantri1.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        labelantri1.setText("1");
        labelantri1.setFont(new java.awt.Font("Tahoma", 1, 200)); // NOI18N
        labelantri1.setName("labelantri1"); // NOI18N
        labelantri1.setPreferredSize(new java.awt.Dimension(300, 50));
        form1.add(labelantri1);

        labelLoket.setBorder(javax.swing.BorderFactory.createTitledBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(150, 250, 150)), "Loket :", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 0, 32), new java.awt.Color(50, 100, 50))); // NOI18N
        labelLoket.setForeground(new java.awt.Color(50, 100, 50));
        labelLoket.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        labelLoket.setText("1");
        labelLoket.setFocusable(false);
        labelLoket.setFont(new java.awt.Font("Tahoma", 1, 200)); // NOI18N
        labelLoket.setName("labelLoket"); // NOI18N
        labelLoket.setPreferredSize(new java.awt.Dimension(150, 50));
        form1.add(labelLoket);

        DlgDisplay.getContentPane().add(form1, java.awt.BorderLayout.LINE_END);

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setModalExclusionType(java.awt.Dialog.ModalExclusionType.APPLICATION_EXCLUDE);
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowOpened(java.awt.event.WindowEvent evt) {
                formWindowOpened(evt);
            }
            public void windowClosed(java.awt.event.WindowEvent evt) {
                formWindowClosed(evt);
            }
            public void windowActivated(java.awt.event.WindowEvent evt) {
                formWindowActivated(evt);
            }
        });

        internalFrame1.setBorder(javax.swing.BorderFactory.createTitledBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(240, 245, 235)), "::[ Antrian Registrasi Pasien ]::", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 0, 11), new java.awt.Color(50, 70, 40))); // NOI18N
        internalFrame1.setName("internalFrame1"); // NOI18N
        internalFrame1.setLayout(new java.awt.BorderLayout(1, 1));

        panelisi1.setName("panelisi1"); // NOI18N
        panelisi1.setPreferredSize(new java.awt.Dimension(55, 55));
        panelisi1.setLayout(new java.awt.FlowLayout(java.awt.FlowLayout.LEFT, 5, 9));

        BtnDisplay.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/editcopy.png"))); // NOI18N
        BtnDisplay.setMnemonic('D');
        BtnDisplay.setText("Display");
        BtnDisplay.setToolTipText("Alt+D");
        BtnDisplay.setIconTextGap(3);
        BtnDisplay.setName("BtnDisplay"); // NOI18N
        BtnDisplay.setPreferredSize(new java.awt.Dimension(100, 30));
        BtnDisplay.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnDisplayActionPerformed(evt);
            }
        });
        panelisi1.add(BtnDisplay);

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
        panelisi1.add(BtnKeluar);

        internalFrame1.add(panelisi1, java.awt.BorderLayout.PAGE_END);

        panelisi5.setName("panelisi5"); // NOI18N
        panelisi5.setPreferredSize(new java.awt.Dimension(12, 44));
        panelisi5.setLayout(null);

        BtnAntri1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/2rightarrow.png"))); // NOI18N
        BtnAntri1.setMnemonic('7');
        BtnAntri1.setText("Next Call");
        BtnAntri1.setToolTipText("Alt+7");
        BtnAntri1.setIconTextGap(3);
        BtnAntri1.setName("BtnAntri1"); // NOI18N
        BtnAntri1.setPreferredSize(new java.awt.Dimension(100, 30));
        BtnAntri1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnAntri1ActionPerformed(evt);
            }
        });
        panelisi5.add(BtnAntri1);
        BtnAntri1.setBounds(20, 60, 100, 30);

        BtnBatal1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/cross.png"))); // NOI18N
        BtnBatal1.setMnemonic('8');
        BtnBatal1.setText("Reset");
        BtnBatal1.setToolTipText("Alt+8");
        BtnBatal1.setIconTextGap(3);
        BtnBatal1.setName("BtnBatal1"); // NOI18N
        BtnBatal1.setPreferredSize(new java.awt.Dimension(100, 30));
        BtnBatal1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnBatal1ActionPerformed(evt);
            }
        });
        panelisi5.add(BtnBatal1);
        BtnBatal1.setBounds(180, 130, 100, 30);

        label1.setText("Antrian :");
        label1.setName("label1"); // NOI18N
        panelisi5.add(label1);
        label1.setBounds(145, 12, 60, 23);

        label2.setText("Loket :");
        label2.setName("label2"); // NOI18N
        panelisi5.add(label2);
        label2.setBounds(0, 12, 60, 23);

        Antrian.setHorizontalAlignment(javax.swing.JTextField.CENTER);
        Antrian.setText("0");
        Antrian.setName("Antrian"); // NOI18N
        panelisi5.add(Antrian);
        Antrian.setBounds(210, 12, 60, 24);

        BtnBatal2.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/Cancel-2-16x16.png"))); // NOI18N
        BtnBatal2.setMnemonic('8');
        BtnBatal2.setText("Stop");
        BtnBatal2.setToolTipText("Alt+8");
        BtnBatal2.setIconTextGap(3);
        BtnBatal2.setName("BtnBatal2"); // NOI18N
        BtnBatal2.setPreferredSize(new java.awt.Dimension(100, 30));
        BtnBatal2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnBatal2ActionPerformed(evt);
            }
        });
        panelisi5.add(BtnBatal2);
        BtnBatal2.setBounds(20, 130, 100, 30);

        BtnPanggil.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/42a.png"))); // NOI18N
        BtnPanggil.setMnemonic('7');
        BtnPanggil.setText("Re-Call");
        BtnPanggil.setToolTipText("Alt+7");
        BtnPanggil.setIconTextGap(3);
        BtnPanggil.setName("BtnPanggil"); // NOI18N
        BtnPanggil.setPreferredSize(new java.awt.Dimension(100, 30));
        BtnPanggil.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnPanggilActionPerformed(evt);
            }
        });
        panelisi5.add(BtnPanggil);
        BtnPanggil.setBounds(180, 60, 100, 30);

        txtLoket.setHorizontalAlignment(javax.swing.JTextField.CENTER);
        txtLoket.setText("1");
        txtLoket.setEnabled(false);
        txtLoket.setName("txtLoket"); // NOI18N
        txtLoket.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtLoketActionPerformed(evt);
            }
        });
        panelisi5.add(txtLoket);
        txtLoket.setBounds(60, 12, 60, 24);

        internalFrame1.add(panelisi5, java.awt.BorderLayout.CENTER);

        getContentPane().add(internalFrame1, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void BtnDisplayActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnDisplayActionPerformed
        Dimension screen=Toolkit.getDefaultToolkit().getScreenSize();
        isTampil();
        DlgDisplay.setSize(screen.width,screen.height);
        DlgDisplay.setIconImage(new ImageIcon(super.getClass().getResource("/picture/addressbook-edit24.png")).getImage());
        DlgDisplay.setAlwaysOnTop(false);
        DlgDisplay.setVisible(true);
    }//GEN-LAST:event_BtnDisplayActionPerformed

    private void BtnKeluarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnKeluarActionPerformed
        System.exit(0);
    }//GEN-LAST:event_BtnKeluarActionPerformed

    private void BtnAntri1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnAntri1ActionPerformed
        try {
            urut=Integer.parseInt(Antrian.getText())+1;
             Antrian.setText(""+urut);
            pshapus.executeUpdate();
            
            pscari_tmp.setString(1,prop.getProperty("LOKET"));
            rs2=pscari_tmp.executeQuery();
            
           
           if(!rs2.next())
           {
            pssimpan_tmp.setString(1,prop.getProperty("LOKET"));
            pssimpan_tmp.setString(2,Integer.toString(urut));          
            pssimpan_tmp.executeUpdate();
           }
           else{
            psupdate_tmp.setString(1,Integer.toString(urut));
            psupdate_tmp.setString(2,prop.getProperty("LOKET"));          
            psupdate_tmp.executeUpdate();  
           }
            pssimpan.setString(1,prop.getProperty("LOKET"));
            pssimpan.setString(2,Integer.toString(urut));
            pssimpan.setString(3,"0");
            pssimpan.executeUpdate();
            
            
         //   System.out.println("Loket : "+cmbloket.getSelectedItem().toString()+" Antrian : "+Antrian.getText());
        } catch (Exception e) {
            System.out.println(e);
        }                          
    }//GEN-LAST:event_BtnAntri1ActionPerformed

    private void BtnBatal1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnBatal1ActionPerformed
        Antrian.setText("1");
    }//GEN-LAST:event_BtnBatal1ActionPerformed

    private void formWindowClosed(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowClosed
        System.exit(0);
    }//GEN-LAST:event_formWindowClosed

    private void formWindowActivated(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowActivated
        
    }//GEN-LAST:event_formWindowActivated

    private void formWindowOpened(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowOpened
        BtnDisplayActionPerformed(null);
    }//GEN-LAST:event_formWindowOpened

    private void BtnBatal2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnBatal2ActionPerformed
        try {
            pshapus.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }  
    }//GEN-LAST:event_BtnBatal2ActionPerformed

    private void BtnPanggilActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnPanggilActionPerformed
 try {
     pshapus.executeUpdate();
     
            pscari_tmp.setString(1,prop.getProperty("LOKET"));
            rs2=pscari_tmp.executeQuery();
            while(rs2.next())
            {
             pssimpan.setString(1,prop.getProperty("LOKET"));
            pssimpan.setString(2,rs2.getString("antrian"));
            pssimpan.setString(3,"0");
            pssimpan.executeUpdate();  
            }
            
        } catch (Exception e) {
            System.out.println(e);
        }         // TODO add your handling code here:
    }//GEN-LAST:event_BtnPanggilActionPerformed

    private void txtLoketActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtLoketActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtLoketActionPerformed



    /**
    * @param args the command line arguments
    */
    public static void main(String args[]) {
        java.awt.EventQueue.invokeLater(new Runnable() {
            @Override
            public void run() {
                DlgAntrian dialog = new DlgAntrian(new javax.swing.JFrame(), true);
                dialog.addWindowListener(new java.awt.event.WindowAdapter() {
                    @Override
                    public void windowClosing(java.awt.event.WindowEvent e) {
                        System.exit(0);
                    }
                });
                dialog.setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private widget.TextBox Antrian;
    private widget.Button BtnAntri1;
    private widget.Button BtnBatal1;
    private widget.Button BtnBatal2;
    private widget.Button BtnDisplay;
    private widget.Button BtnKeluar;
    private widget.Button BtnPanggil;
    private javax.swing.JDialog DlgDisplay;
    private widget.InternalFrame form1;
    private widget.InternalFrame internalFrame1;
    private widget.InternalFrame internalFrame5;
    private widget.Label label1;
    private widget.Label label2;
    private widget.Label labelLoket;
    private widget.Label labelantri1;
    private widget.Label labelruntext;
    private usu.widget.glass.PanelGlass paneliklan;
    private widget.panelisi panelisi1;
    private widget.panelisi panelisi5;
    private javax.swing.JPanel panelruntext;
    private widget.TextBox txtLoket;
    // End of variables declaration//GEN-END:variables
    
    
    @Override
    public void actionPerformed(ActionEvent e) {
        paneliklan.repaint();
        String oldText = labelruntext.getText();
        String newText = oldText.substring(1) + oldText.substring(0, 1);
        labelruntext.setText( newText );
    }
    
    private  void isTampil(){
        try{
            ResultSet rs=koneksi.createStatement().executeQuery("select teks, aktifkan, gambar from runtext");
            while(rs.next()){
                labelruntext.setText(rs.getString(1));
                if(rs.getString(2).equals("Yes")){
                    Blob blob = rs.getBlob(3);
                    paneliklan.setBackgroundImage(new javax.swing.ImageIcon(blob.getBytes(1, (int) (blob.length()))));                    
                }
            }
        }catch(SQLException e){
            System.out.println(e+"Error : Silahkan Set Aplikasi");
        }
    } 
    
    private void panggil(int antrian){
        String[] urut={"","./suara/1.mp3","./suara/2.mp3","./suara/3.mp3","./suara/4.mp3",
                       "./suara/5.mp3","./suara/6.mp3","./suara/7.mp3","./suara/8.mp3",
                       "./suara/9.mp3","./suara/10.mp3","./suara/11.mp3","./suara/12.mp3",
                       "./suara/13.mp3","./suara/14.mp3","./suara/15.mp3","./suara/16.mp3",
                        "./suara/17.mp3","./suara/18.mp3","./suara/19.mp3","./suara/20.mp3",
                        "./suara/30.mp3","./suara/40.mp3","./suara/50.mp3","./suara/60.mp3",
                       "./suara/70.mp3","./suara/80.mp3","./suara/90.mp3","./suara/100.mp3",
                       "./suara/200.mp3","./suara/300.mp3","./suara/400.mp3","./suara/500.mp3",
                        "./suara/600.mp3","./suara/700.mp3","./suara/800.mp3","./suara/900.mp3",
                        "./suara/1000.mp3"};
        
        if (antrian <= 20){
            try {
                music = new BackgroundMusic(urut[antrian]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }            
        }else if (antrian < 30){
            try {
                music = new BackgroundMusic(urut[20]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
            
            
            panggil(antrian%10);
        }else if (antrian == 30){
            try {
                music = new BackgroundMusic(urut[21]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
        }else if (antrian < 40){
            try {
                music = new BackgroundMusic(urut[21]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
            panggil(antrian%10);
        }else if (antrian == 40){
            try {
                music = new BackgroundMusic(urut[22]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
        }else if (antrian < 50){
            try {
                music = new BackgroundMusic(urut[22]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
            panggil(antrian%10);
        }
        else if (antrian == 50){
            try {
                music = new BackgroundMusic(urut[23]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
        }else if (antrian < 60){
            try {
                music = new BackgroundMusic(urut[23]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
            panggil(antrian%10);
        }else if (antrian == 60){
            try {
                music = new BackgroundMusic(urut[24]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
        }else if (antrian < 70){
            try {
                music = new BackgroundMusic(urut[24]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
            panggil(antrian%10);
        }
        else if (antrian == 70){
            try {
                music = new BackgroundMusic(urut[25]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
        }else if (antrian < 80){
            try {
                music = new BackgroundMusic(urut[25]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
            panggil(antrian%10);
        }else if (antrian == 80){
            try {
                music = new BackgroundMusic(urut[26]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
        }else if (antrian < 90){
            try {
                music = new BackgroundMusic(urut[26]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
            panggil(antrian%10);
        }else if (antrian == 90){
            try {
                music = new BackgroundMusic(urut[27]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
        }else if (antrian < 100){
            try {
                music = new BackgroundMusic(urut[27]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
            panggil(antrian%10);
        }else if (antrian == 100){
            try {
                music = new BackgroundMusic(urut[28]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
        }else if (antrian < 200){
            try {
                music = new BackgroundMusic(urut[28]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
            panggil(antrian-100);
        }else if (antrian == 200){
            try {
                music = new BackgroundMusic(urut[29]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
        }else if (antrian < 300){
            try {
                music = new BackgroundMusic(urut[29]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
            
            panggil(antrian-200);
        }else if (antrian == 300){
            try {
                music = new BackgroundMusic(urut[30]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
        }else if (antrian < 400){
            try {
                music = new BackgroundMusic(urut[30]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
            
            panggil(antrian-300);
        }else if (antrian == 400){
            try {
                music = new BackgroundMusic(urut[31]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
        }else if (antrian < 500){
            try {
                music = new BackgroundMusic(urut[31]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
            
            panggil(antrian-400);
        }else if (antrian == 500){
            try {
                music = new BackgroundMusic(urut[32]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
        }else if (antrian < 600){
            try {
                music = new BackgroundMusic(urut[32]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
            
            panggil(antrian-500);
        }else if (antrian == 600){
            try {
                music = new BackgroundMusic(urut[33]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
        }else if (antrian < 700){
            try {
                music = new BackgroundMusic(urut[33]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
            
            panggil(antrian-600);
        }else if (antrian == 700){
            try {
                music = new BackgroundMusic(urut[34]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
        }else if (antrian < 800){
            try {
                music = new BackgroundMusic(urut[34]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
            
            panggil(antrian-700);
        }else if (antrian == 800){
            try {
                music = new BackgroundMusic(urut[35]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
        }else if (antrian < 900){
            try {
                music = new BackgroundMusic(urut[35]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
            
            panggil(antrian-800);
        }else if (antrian == 900){
            try {
                music = new BackgroundMusic(urut[36]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
        }else if (antrian < 1000){
            try {
                music = new BackgroundMusic(urut[36]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
            
            panggil(antrian-900);
        }else if (antrian == 1000){
            try {
                music = new BackgroundMusic(urut[37]);
                music.start();
                Thread.sleep(1000);                
            } catch (InterruptedException ex) {
                System.out.println(ex);
            }
           
        }
        
    }
    
    private void jam(){
        ActionListener taskPerformer = new ActionListener(){
            private int nilai_detik;
            public void actionPerformed(ActionEvent e) {
                String nol_detik = "";                
                Date now = Calendar.getInstance().getTime();
                nilai_detik = now.getSeconds();
                if (nilai_detik <= 9) {
                    nol_detik = "0";
                }
                
                String detik = nol_detik + Integer.toString(nilai_detik);
                //System.out.println("detik : "+detik);
                if(detik.equals("05")||detik.equals("10")||detik.equals("15")||detik.equals("20")||detik.equals("25")||detik.equals("30")||detik.equals("35")||detik.equals("40")||detik.equals("45")||detik.equals("50")||detik.equals("55")||detik.equals("00")){                    
                    antri="";
                    loket="";
                    try {
                        rs=pscari.executeQuery();
                        if(rs.next()){
                            antri=rs.getString("antrian");
                           // loket=rs.getString("loket");
                           loket=prop.getProperty("LOKET");
                           
                             status=rs.getString("status");
                        }
                    } catch (Exception ez) {
                        System.out.println(ez);
                    }
                    if(status.equals("0")){
                    if(!antri.equals("")){
                        Antrian.setText(antri);                    
                        labelLoket.setText(loket);
                        labelantri1.setText(antri);
                        if(prop.getProperty("ANTRIAN").equals("player")){
                            try {
                                music=new BackgroundMusic("./suara/Nomor_Antrian.mp3");
                                music.start();
                                Thread.sleep(1500);
                                panggil(Integer.parseInt(antri));
                                if(prop.getProperty("STATUSLOKET").equals("poly"))
                                {
                                 music=new BackgroundMusic("./suara/Dipoly.mp3");   
                                }
                                if(prop.getProperty("STATUSLOKET").equals("loket"))
                                {
                                 music=new BackgroundMusic("./suara/Diloket.mp3");   
                                }
                                if(prop.getProperty("STATUSLOKET").equals("counter"))
                                {
                                 music=new BackgroundMusic("./suara/Dicounter.mp3");   
                                }
                                music.start();
                                Thread.sleep(1400);
//                                if(prop.getProperty("LOKET").equals("1"))
//                                {
//                                music=new BackgroundMusic("./suara/A.mp3"); 
//                                }
//                                if(prop.getProperty("LOKET").equals("2"))
//                                {
//                                music=new BackgroundMusic("./suara/B.mp3"); 
//                                }
//                                if(prop.getProperty("LOKET").equals("3"))
//                                {
//                                music=new BackgroundMusic("./suara/C.mp3"); 
//                                }
//                                if(prop.getProperty("LOKET").equals("4"))
//                                {
//                                music=new BackgroundMusic("./suara/D.mp3"); 
//                                }
//                                music.start();
                                panggil(Integer.parseInt(loket));
                            } catch (InterruptedException ex) {
                               System.out.println(e);
                            }
                           
                        }                               

                        i=Integer.parseInt(antri);
                       // Antrian.setText(""+i);
                        
                        /*try {
                            pshapus.executeUpdate();
                        } catch (Exception ex) {
                            System.out.println(ex);
                        }*/
                        try {
            //pshapus.executeUpdate();
            psupdate.setString(1,"1");
            psupdate.setString(2,loket);
            psupdate.executeUpdate();
//            System.out.println("Loket : "+cmbloket.getSelectedItem().toString()+" Antrian : "+Antrian.getText());
        } catch (Exception ex) {
            System.out.println(ex);
        }
                    }  
                   }
                }
            }
        };
        // Timer
        new Timer(1000, taskPerformer).start();
    }

}

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

package simrskhanza;

/**
 *
 * @author perpustakaan
 */
public class DlgAbout extends javax.swing.JDialog {

    
    public DlgAbout(java.awt.Frame parent, boolean modal) {
        super(parent, modal);
        initComponents();
        this.setLocation(10,10);
        setSize(465,515);
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
        jLabel6 = new javax.swing.JLabel();
        panelGlass1 = new usu.widget.glass.PanelGlass();
        jLabel4 = new javax.swing.JLabel();
        jLabel7 = new javax.swing.JLabel();
        jLabel11 = new javax.swing.JLabel();
        jLabel12 = new javax.swing.JLabel();
        jLabel13 = new javax.swing.JLabel();
        jLabel14 = new javax.swing.JLabel();
        jLabel15 = new javax.swing.JLabel();
        jLabel16 = new javax.swing.JLabel();
        panelGlass4 = new usu.widget.glass.PanelGlass();
        jLabel19 = new javax.swing.JLabel();
        jLabel24 = new javax.swing.JLabel();
        jLabel20 = new javax.swing.JLabel();
        jLabel21 = new javax.swing.JLabel();
        jLabel22 = new javax.swing.JLabel();
        jLabel23 = new javax.swing.JLabel();
        jLabel25 = new javax.swing.JLabel();
        jLabel26 = new javax.swing.JLabel();
        panelGlass5 = new usu.widget.glass.PanelGlass();
        BtnKeluar = new widget.Button();
        jLabel27 = new javax.swing.JLabel();
        jLabel28 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setTitle("::[ About Program ]::");
        setUndecorated(true);
        setResizable(false);

        internalFrame1.setBorder(javax.swing.BorderFactory.createTitledBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(240, 245, 235)), "::[ About Program ]::", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 0, 11), new java.awt.Color(130, 100, 100))); // NOI18N
        internalFrame1.setName("internalFrame1"); // NOI18N
        internalFrame1.setLayout(null);

        jLabel6.setFont(new java.awt.Font("Tahoma", 2, 11)); // NOI18N
        jLabel6.setForeground(new java.awt.Color(130, 100, 100));
        jLabel6.setText(".: Aplikasi ");
        jLabel6.setName("jLabel6"); // NOI18N
        internalFrame1.add(jLabel6);
        jLabel6.setBounds(10, 18, 90, 20);

        panelGlass1.setBackground(new java.awt.Color(235, 255, 235));
        panelGlass1.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(241, 246, 236)));
        panelGlass1.setOpaqueImage(false);
        panelGlass1.setRound(false);
        panelGlass1.setLayout(null);

        jLabel4.setForeground(new java.awt.Color(130, 100, 100));
        jLabel4.setText("Server : MySQL Server");
        jLabel4.setName("jLabel4"); // NOI18N
        panelGlass1.add(jLabel4);
        jLabel4.setBounds(69, 22, 170, 14);

        jLabel7.setForeground(new java.awt.Color(130, 100, 100));
        jLabel7.setText("Nama Aplikasi : Khanza SIMKES 2018");
        jLabel7.setName("jLabel7"); // NOI18N
        panelGlass1.add(jLabel7);
        jLabel7.setBounds(36, 8, 200, 14);

        jLabel11.setForeground(new java.awt.Color(130, 100, 100));
        jLabel11.setText("Untuk mensetting aplikasi menjadi Client");
        jLabel11.setName("jLabel11"); // NOI18N
        panelGlass1.add(jLabel11);
        jLabel11.setBounds(230, 8, 210, 14);

        jLabel12.setForeground(new java.awt.Color(130, 100, 100));
        jLabel12.setText("Server, ganti HOST Localhost dengan");
        jLabel12.setName("jLabel12"); // NOI18N
        panelGlass1.add(jLabel12);
        jLabel12.setBounds(230, 22, 200, 14);

        jLabel13.setForeground(new java.awt.Color(130, 100, 100));
        jLabel13.setText("alamat/IP Address dari server yang di");
        jLabel13.setName("jLabel13"); // NOI18N
        panelGlass1.add(jLabel13);
        jLabel13.setBounds(230, 36, 200, 14);

        jLabel14.setForeground(new java.awt.Color(130, 100, 100));
        jLabel14.setText("gunakan. Jagan lupa untuk mengatur hak");
        jLabel14.setName("jLabel14"); // NOI18N
        panelGlass1.add(jLabel14);
        jLabel14.setBounds(230, 50, 220, 14);

        jLabel15.setForeground(new java.awt.Color(130, 100, 100));
        jLabel15.setText("akses di MySQL server agar terkoneksi");
        jLabel15.setName("jLabel15"); // NOI18N
        panelGlass1.add(jLabel15);
        jLabel15.setBounds(230, 64, 210, 14);

        internalFrame1.add(panelGlass1);
        panelGlass1.setBounds(7, 38, 454, 90);

        jLabel16.setFont(new java.awt.Font("Tahoma", 2, 11)); // NOI18N
        jLabel16.setForeground(new java.awt.Color(130, 100, 100));
        jLabel16.setText(".: Developer");
        jLabel16.setName("jLabel16"); // NOI18N
        internalFrame1.add(jLabel16);
        jLabel16.setBounds(10, 135, 110, 20);

        panelGlass4.setBackground(new java.awt.Color(235, 255, 235));
        panelGlass4.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(241, 246, 236)));
        panelGlass4.setOpaqueImage(false);
        panelGlass4.setRound(false);
        panelGlass4.setLayout(null);

        jLabel19.setForeground(new java.awt.Color(130, 100, 100));
        jLabel19.setText("RS Permata Medika Kebumen, RS Aviciena Martapura, dll");
        jLabel19.setName("jLabel19"); // NOI18N
        panelGlass4.add(jLabel19);
        jLabel19.setBounds(126, 160, 310, 14);

        jLabel24.setForeground(new java.awt.Color(130, 100, 100));
        jLabel24.setText("Blog : elkhanza.wordpress.com, simrskhanza.weebly.com, simrs-khanza.blogspot.com");
        jLabel24.setName("jLabel24"); // NOI18N
        panelGlass4.add(jLabel24);
        jLabel24.setBounds(22, 30, 430, 14);

        jLabel20.setForeground(new java.awt.Color(130, 100, 100));
        jLabel20.setText("Phone : 08562675039     Pengembang : Windiarto Nugroho, Dewi Ekawati, ASKI dll");
        jLabel20.setName("jLabel20"); // NOI18N
        panelGlass4.add(jLabel20);
        jLabel20.setBounds(12, 10, 420, 14);

        jLabel21.setForeground(new java.awt.Color(130, 100, 100));
        jLabel21.setText("Email : khanza_media@yahoo.com, khanzasoftmedia@gmail.com");
        jLabel21.setName("jLabel21"); // NOI18N
        panelGlass4.add(jLabel21);
        jLabel21.setBounds(18, 50, 420, 14);

        jLabel22.setForeground(new java.awt.Color(130, 100, 100));
        jLabel22.setText("Skype : khanza.media     Tweeter : KhanzaMedia");
        jLabel22.setName("jLabel22"); // NOI18N
        panelGlass4.add(jLabel22);
        jLabel22.setBounds(13, 70, 420, 14);

        jLabel23.setForeground(new java.awt.Color(130, 100, 100));
        jLabel23.setText("Kontributor & Donatur : RS Amal Sehat Wonogiri Jawa Tengah, RS Sadewa Yogyakarta");
        jLabel23.setName("jLabel23"); // NOI18N
        panelGlass4.add(jLabel23);
        jLabel23.setBounds(10, 100, 430, 14);

        jLabel25.setForeground(new java.awt.Color(130, 100, 100));
        jLabel25.setText("RS Mutiara Hati Pringsewu Lampung, RS Pelita Insani Martapura");
        jLabel25.setName("jLabel25"); // NOI18N
        panelGlass4.add(jLabel25);
        jLabel25.setBounds(126, 120, 310, 14);

        jLabel26.setForeground(new java.awt.Color(130, 100, 100));
        jLabel26.setText("RS Islam Magelang, RS Citra Husada Pangkalan Bun Kalteng");
        jLabel26.setName("jLabel26"); // NOI18N
        panelGlass4.add(jLabel26);
        jLabel26.setBounds(126, 140, 310, 14);

        panelGlass5.setBackground(new java.awt.Color(254, 254, 254));
        panelGlass5.setBackgroundImage(new javax.swing.ImageIcon(getClass().getResource("/picture/khanza.png"))); // NOI18N
        panelGlass5.setBackgroundImageType(usu.widget.constan.BackgroundConstan.BACKGROUND_IMAGE_STRECT);
        panelGlass5.setRound(false);
        panelGlass5.setWarna(new java.awt.Color(235, 255, 235));
        panelGlass5.setLayout(null);
        panelGlass4.add(panelGlass5);
        panelGlass5.setBounds(0, 230, 330, 70);

        BtnKeluar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/exit.png"))); // NOI18N
        BtnKeluar.setMnemonic('K');
        BtnKeluar.setText("Close");
        BtnKeluar.setToolTipText("Alt+K");
        BtnKeluar.setIconTextGap(3);
        BtnKeluar.setName("BtnKeluar"); // NOI18N
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
        panelGlass4.add(BtnKeluar);
        BtnKeluar.setBounds(340, 260, 100, 30);

        jLabel27.setForeground(new java.awt.Color(130, 100, 100));
        jLabel27.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel27.setText("Bagi yang ingin melakukan Donasi, bisa ke Rekening BRI Syariah 1015369872");
        jLabel27.setName("jLabel27"); // NOI18N
        panelGlass4.add(jLabel27);
        jLabel27.setBounds(16, 190, 420, 14);

        jLabel28.setForeground(new java.awt.Color(130, 100, 100));
        jLabel28.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel28.setText("atas nama Windiarto");
        jLabel28.setName("jLabel28"); // NOI18N
        panelGlass4.add(jLabel28);
        jLabel28.setBounds(16, 210, 420, 14);

        internalFrame1.add(panelGlass4);
        panelGlass4.setBounds(7, 155, 454, 340);

        getContentPane().add(internalFrame1, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void BtnKeluarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnKeluarActionPerformed
        dispose();
}//GEN-LAST:event_BtnKeluarActionPerformed

    private void BtnKeluarKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_BtnKeluarKeyPressed
        dispose();
}//GEN-LAST:event_BtnKeluarKeyPressed

    /**
    * @param args the command line arguments
    */
    public static void main(String args[]) {
        java.awt.EventQueue.invokeLater(() -> {
            DlgAbout dialog = new DlgAbout(new javax.swing.JFrame(), true);
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
    private widget.InternalFrame internalFrame1;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel13;
    private javax.swing.JLabel jLabel14;
    private javax.swing.JLabel jLabel15;
    private javax.swing.JLabel jLabel16;
    private javax.swing.JLabel jLabel19;
    private javax.swing.JLabel jLabel20;
    private javax.swing.JLabel jLabel21;
    private javax.swing.JLabel jLabel22;
    private javax.swing.JLabel jLabel23;
    private javax.swing.JLabel jLabel24;
    private javax.swing.JLabel jLabel25;
    private javax.swing.JLabel jLabel26;
    private javax.swing.JLabel jLabel27;
    private javax.swing.JLabel jLabel28;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private usu.widget.glass.PanelGlass panelGlass1;
    private usu.widget.glass.PanelGlass panelGlass4;
    private usu.widget.glass.PanelGlass panelGlass5;
    // End of variables declaration//GEN-END:variables

}

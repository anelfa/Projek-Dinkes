/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * DlgApotek.java
 *
 * Created on Jun 8, 2010, choose Tools | Templates
 * and open the template in10:28:56 PM
 */

package apotek;
import bridging.BPJSDataSEP;
import laporan.DlgDiagnosaPenyakit;
import laporan.DlgFrekuensiPenyakitRalan;
import keuangan.DlgBilingRalan;
import fungsi.WarnaTable;
import fungsi.batasInput;
import fungsi.grafikperiksaperagama;
import fungsi.grafikperiksaperbulan;
import fungsi.grafikperiksaperdokter;
import fungsi.grafikperiksaperhari;
import fungsi.grafikperiksaperjk;
import fungsi.grafikperiksaperpekerjaan;
import fungsi.grafikperiksaperpoli;
import fungsi.grafikperiksapertahun;
import fungsi.grafiksql;
import fungsi.koneksiDB;
import fungsi.sekuel;
import fungsi.validasi;
import fungsi.var;
import inventory.DlgCariObat;
import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import inventory.DlgPeresepanDokter;
import java.awt.event.KeyListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.Timer;
import javax.swing.event.DocumentEvent;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumn;
import keuangan.DlgLhtPiutang;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartFrame;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;
import simrskhanza.DlgCariDokter;
import apotek.DlgResepObat;
import apotek.DlgDaftarPermintaanResep;
/**
 *
 * @author dosen
 */
public final class DlgApotek extends javax.swing.JDialog {
     
    private final DefaultTableModel tabMode;
    private String getTanggal() {
        DateFormat dateFormat = new SimpleDateFormat("dd-mm-yyyy hh:mm:ss");
        Date date = new Date();
        return dateFormat.format(date);
    }
    public  DlgCariDokter dokter=new DlgCariDokter(null,false);
    public DlgCariObat dlgobt=new DlgCariObat(null,false);
    private sekuel Sequel=new sekuel();
    private validasi Valid=new validasi();
    private Connection koneksi=koneksiDB.condb();
     private PreparedStatement ps,ps2,ps3,pscaripiutang;
    private Properties prop = new Properties();
    private ResultSet rs;
    private int pilihan=0,i=0;
    private Date cal=new Date();
    private String TNoRM="", CmbJam="",CmbDetik="",CmbMenit="", kddokter="",TDokter="",TNoRw="", pengurutan="",username="",kode="",alamatperujuk="-",aktifjadwal="",IPPRINTERTRACER="",th_umur="0",bl_umur="0",hr_umur="0",sttsumur="Th",
            validasiregistrasi=Sequel.cariIsi("select wajib_closing_kasir from set_validasi_registrasi");
    private SimpleDateFormat dateformat = new SimpleDateFormat("yyyy/MM/dd");
    private char ESC = 27;
    // ganti kertas
    private char[] FORM_FEED = {12};
    // reset setting
    private char[] RESET = {ESC,'@'};
    // huruf tebal diaktifkan
    private char[] BOLD_ON = {ESC,'E'};
    // huruf tebal dimatikan
    private char[] BOLD_OFF = {ESC,'F'};
    // huruf miring diaktifkan
    private char[] ITALIC_ON = {ESC,'4'};
    // huruf miring dimatikan
    private char[] ITALIC_OFF = {ESC,'5'};
    // mode draft diaktifkan
    private char[] MODE_DRAFT = {ESC,'x',0};
    private char[] MODE_NLQ = {ESC,'x',1};
    // font Roman (halaman 47)
    private char[] FONT_ROMAN = {ESC,'k',0};
    // font Sans serif
    private char[] FONT_SANS_SERIF = {ESC,'k',1};
    // font size (halaman 49)
    private char[] SIZE_5_CPI = {ESC,'W','1',ESC,'P'};
    private char[] SIZE_6_CPI = {ESC,'W','1',ESC,'M'};
    private char[] SIZE_10_CPI = {ESC,'P'};
    private char[] SIZE_12_CPI = {ESC,'M'};
    //font height
    private char[] HEIGHT_NORMAL = {ESC,'w', '0'};
    private char[] HEIGHT_DOUBLE = {ESC,'w', '1'};
    // double strike (satu dot dicetak 2 kali)
    private char[] DOUBLE_STRIKE_ON = {ESC,'G'};
    private char[] DOUBLE_STRIKE_OFF = {ESC,'H'};
    // http://www.berklix.com/~jhs/standards/escapes.epson
    // condensed (huruf kurus)
    private char[] CONDENSED_ON = {15};
    private char[] CONDENSED_OFF = {18};
    // condensed (huruf gemuk)
    private char[] ENLARGED_ON = {(char) 14};
    private char[] ENLARGED_OFF = {(char) 20};
    // line spacing
    private char[] SPACING_9_72 = {ESC, '0'};
    private char[] SPACING_7_72 = {ESC, '1'};
    private char[] SPACING_12_72 = {ESC, '2'};
    // set unit for margin setting
    private char[] UNIT_1_360 = {ESC,40, 'U', '1', '0'};
    // move vertical print position
    private char[] VERTICAL_PRINT_POSITION = {ESC, 'J', '1'};
    

    /** Creates new form DlgReg
     * @param parent
     * @param modal */
    public DlgApotek(java.awt.Frame parent, boolean modal) {
        
        super(parent, modal);
        initComponents();

        this.setLocation(8,1);
        setSize(885,674);

        Object[] row={"P","No.Reg","No.Rawat","Tanggal","Jam","Kd.Dokter","Dokter Dituju","Poliklinik","Nomer RM",
            "Pasien","J.K.","Tgl.Lahir","Umur","Jenis Bayar","Penanggung Jawab","Alamat P.J.","Hubungan P.J.",
            "Biaya Regristrasi","Status","No.Poli"};
        tabMode=new DefaultTableModel(null,row){
             @Override public boolean isCellEditable(int rowIndex, int colIndex){
                boolean a = false;
                if (colIndex==0) {
                    a=true;
                }
                return a;
             }
             Class[] types = new Class[] {
                 java.lang.Boolean.class, java.lang.Object.class, java.lang.Object.class, java.lang.Object.class, 
                 java.lang.Object.class, java.lang.Object.class, java.lang.Object.class, java.lang.Object.class, 
                 java.lang.Object.class, java.lang.Object.class, java.lang.Object.class, java.lang.Object.class, 
                 java.lang.Object.class, java.lang.Object.class, java.lang.Object.class, java.lang.Object.class, 
                 java.lang.Object.class, java.lang.Object.class,java.lang.Object.class,java.lang.Object.class
             };
             @Override
             public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
             }
        };
        tbPetugas.setModel(tabMode);

        tbPetugas.setPreferredScrollableViewportSize(new Dimension(800,800));
        tbPetugas.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);

        for (i = 0; i < 20; i++) {
            TableColumn column = tbPetugas.getColumnModel().getColumn(i);
            if(i==0){
                column.setPreferredWidth(20);
            }else if(i==1){
                column.setPreferredWidth(50);
            }else if(i==2){
                column.setPreferredWidth(120);
            }else if(i==3){
                column.setPreferredWidth(70);
            }else if(i==4){
                column.setPreferredWidth(50);   
            }else if(i==5){
                column.setPreferredWidth(70);
            }else if(i==6){
                column.setPreferredWidth(110);
            }else if(i==7){
                column.setPreferredWidth(100);
            }else if(i==8){
                column.setPreferredWidth(80);
            }else if(i==9){
                column.setPreferredWidth(200);
            }else if(i==10){
                column.setPreferredWidth(30);
            }else if(i==11){
                column.setPreferredWidth(100);
            }else if(i==12){
                column.setPreferredWidth(140);
            }else if(i==13){
                column.setPreferredWidth(140);
            }else if(i==14){
                column.setPreferredWidth(200);
            }else if(i==15){
                column.setPreferredWidth(90);
            }else if(i==16){
                column.setPreferredWidth(90);
            }else if(i==17){
                column.setPreferredWidth(100);
            }else if(i==18){
                column.setPreferredWidth(80);
            }else if(i==19){
                column.setPreferredWidth(80);
            }
        }
        tbPetugas.setDefaultRenderer(Object.class, new WarnaTable());

       /* TNoReg.setDocument(new batasInput((byte)8).getKata(TNoReg));
        TNoRw.setDocument(new batasInput((byte)17).getKata(TNoRw));
        TNoRM.setDocument(new batasInput((byte)15).getKata(TNoRM));
        AsalRujukan.setDocument(new batasInput((byte)60).getKata(AsalRujukan));
        kddokter.setDocument(new batasInput((byte)20).getKata(kddokter));
        kdpnj.setDocument(new batasInput((byte)3).getKata(kdpnj));
        TPngJwb.setDocument(new batasInput((byte)30).getKata(TPngJwb));
        kdpoli.setDocument(new batasInput((byte)5).getKata(kdpoli));
        THbngn.setDocument(new batasInput((byte)20).getKata(THbngn));
        TAlmt.setDocument(new batasInput((byte)60).getKata(TAlmt));
        TBiaya.setDocument(new batasInput((byte)13).getOnlyAngka(TBiaya)); */
        TCari.setDocument(new batasInput((byte)100).getKata(TCari));
        CrPoli.setDocument(new batasInput((byte)100).getKata(CrPoli));
        CrDokter.setDocument(new batasInput((byte)100).getKata(CrDokter));
        if(koneksiDB.cariCepat().equals("aktif")){
            TCari.getDocument().addDocumentListener(new javax.swing.event.DocumentListener(){
                @Override
                public void insertUpdate(DocumentEvent e) {tampil();}
                @Override
                public void removeUpdate(DocumentEvent e) {tampil();}
                @Override
                public void changedUpdate(DocumentEvent e) {tampil();}
            });
        }  
        jam();               
         dokter.addWindowListener(new WindowListener() {
            @Override
            public void windowOpened(WindowEvent e) {;}
            @Override
            public void windowClosing(WindowEvent e) {}
            @Override
            public void windowClosed(WindowEvent e) {
                if(var.getform().equals("DlgApotek")){
                    if(dokter.getTable().getSelectedRow()!= -1){                    
                        if(pilihan==1){
                          //  kddokter.setText(dokter.getTable().getValueAt(dokter.getTable().getSelectedRow(),0).toString());
                          //  TDokter.setText(dokter.getTable().getValueAt(dokter.getTable().getSelectedRow(),1).toString());
                           // isNumber();
                          //  kddokter.requestFocus();
                        }else if(pilihan==2){
                            CrDokter.setText(dokter.getTable().getValueAt(dokter.getTable().getSelectedRow(),1).toString());
                            CrDokter.requestFocus();
                            tampil();
                        }else if(pilihan==3){
                            CrDokter3.setText(dokter.getTable().getValueAt(dokter.getTable().getSelectedRow(),1).toString());
                            CrDokter3.requestFocus();
                        }
                    }                
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
             
 
        
       
     
        
        
//        isForm(); 
    }
    

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        buttonGroup1 = new javax.swing.ButtonGroup();
        jPopupMenu1 = new javax.swing.JPopupMenu();
        MnPemberianObat = new javax.swing.JMenuItem();
        MnResepDOkter = new javax.swing.JMenuItem();
        MnNoResep = new javax.swing.JMenuItem();
        MnValidasiResep = new javax.swing.JMenuItem();
        Kd2 = new widget.TextBox();
        DlgSakit = new javax.swing.JDialog();
        internalFrame3 = new widget.InternalFrame();
        panelBiasa2 = new widget.PanelBiasa();
        TglSakit1 = new widget.Tanggal();
        jLabel31 = new widget.Label();
        BtnPrint2 = new widget.Button();
        BtnKeluar2 = new widget.Button();
        jLabel32 = new widget.Label();
        TglSakit2 = new widget.Tanggal();
        jLabel33 = new widget.Label();
        lmsakit = new widget.TextBox();
        DlgDemografi = new javax.swing.JDialog();
        internalFrame4 = new widget.InternalFrame();
        panelBiasa3 = new widget.PanelBiasa();
        BtnPrint3 = new widget.Button();
        BtnKeluar3 = new widget.Button();
        Kelurahan2 = new widget.TextBox();
        btnKel = new widget.Button();
        Kecamatan2 = new widget.TextBox();
        btnKec = new widget.Button();
        Kabupaten2 = new widget.TextBox();
        btnKab = new widget.Button();
        jLabel34 = new widget.Label();
        jLabel35 = new widget.Label();
        jLabel36 = new widget.Label();
        BtnPrint4 = new widget.Button();
        DlgSakit2 = new javax.swing.JDialog();
        internalFrame5 = new widget.InternalFrame();
        panelBiasa4 = new widget.PanelBiasa();
        jLabel37 = new widget.Label();
        BtnPrint5 = new widget.Button();
        BtnKeluar4 = new widget.Button();
        NomorSurat = new widget.TextBox();
        BtnSeek5 = new widget.Button();
        CrDokter3 = new widget.TextBox();
        jLabel24 = new widget.Label();
        internalFrame1 = new widget.InternalFrame();
        Scroll = new widget.ScrollPane();
        tbPetugas = new widget.Table();
        jPanel2 = new javax.swing.JPanel();
        panelGlass6 = new widget.panelisi();
        BtnAll = new widget.Button();
        jLabel10 = new widget.Label();
        LCount = new widget.Label();
        BtnKeluar = new widget.Button();
        panelGlass7 = new widget.panelisi();
        jLabel15 = new widget.Label();
        DTPCari1 = new widget.Tanggal();
        jLabel17 = new widget.Label();
        DTPCari2 = new widget.Tanggal();
        jLabel6 = new widget.Label();
        TCari = new widget.TextBox();
        BtnCari = new widget.Button();
        panelGlass8 = new widget.panelisi();
        jLabel14 = new widget.Label();
        CrDokter = new widget.TextBox();
        BtnSeek3 = new widget.Button();
        jLabel16 = new widget.Label();
        CrPoli = new widget.TextBox();
        BtnSeek4 = new widget.Button();
        PanelInput = new javax.swing.JPanel();

        jPopupMenu1.setName("jPopupMenu1"); // NOI18N

        MnPemberianObat.setFont(new java.awt.Font("Tahoma", 0, 11)); // NOI18N
        MnPemberianObat.setForeground(new java.awt.Color(60, 80, 50));
        MnPemberianObat.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/category.png"))); // NOI18N
        MnPemberianObat.setText("Pemberian Obat/BHP");
        MnPemberianObat.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
        MnPemberianObat.setHorizontalTextPosition(javax.swing.SwingConstants.RIGHT);
        MnPemberianObat.setName("MnPemberianObat"); // NOI18N
        MnPemberianObat.setPreferredSize(new java.awt.Dimension(250, 28));
        MnPemberianObat.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                MnPemberianObatActionPerformed(evt);
            }
        });
        jPopupMenu1.add(MnPemberianObat);

        MnResepDOkter.setFont(new java.awt.Font("Tahoma", 0, 11)); // NOI18N
        MnResepDOkter.setForeground(new java.awt.Color(60, 80, 50));
        MnResepDOkter.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/category.png"))); // NOI18N
        MnResepDOkter.setText("Input Resep Dokter");
        MnResepDOkter.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
        MnResepDOkter.setHorizontalTextPosition(javax.swing.SwingConstants.RIGHT);
        MnResepDOkter.setIconTextGap(5);
        MnResepDOkter.setName("MnResepDOkter"); // NOI18N
        MnResepDOkter.setPreferredSize(new java.awt.Dimension(220, 26));
        MnResepDOkter.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                MnResepDOkterActionPerformed(evt);
            }
        });
        jPopupMenu1.add(MnResepDOkter);

        MnNoResep.setFont(new java.awt.Font("Tahoma", 0, 11)); // NOI18N
        MnNoResep.setForeground(new java.awt.Color(60, 80, 50));
        MnNoResep.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/category.png"))); // NOI18N
        MnNoResep.setText("Daftar Resep");
        MnNoResep.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
        MnNoResep.setHorizontalTextPosition(javax.swing.SwingConstants.RIGHT);
        MnNoResep.setName("MnNoResep"); // NOI18N
        MnNoResep.setPreferredSize(new java.awt.Dimension(250, 28));
        MnNoResep.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                MnNoResepActionPerformed(evt);
            }
        });
        jPopupMenu1.add(MnNoResep);

        MnValidasiResep.setFont(new java.awt.Font("Tahoma", 0, 11)); // NOI18N
        MnValidasiResep.setForeground(new java.awt.Color(60, 80, 50));
        MnValidasiResep.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/category.png"))); // NOI18N
        MnValidasiResep.setText("Validasi Resep Dokter");
        MnValidasiResep.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
        MnValidasiResep.setHorizontalTextPosition(javax.swing.SwingConstants.RIGHT);
        MnValidasiResep.setName("MnValidasiResep"); // NOI18N
        MnValidasiResep.setPreferredSize(new java.awt.Dimension(250, 28));
        MnValidasiResep.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                MnValidasiResepActionPerformed(evt);
            }
        });
        jPopupMenu1.add(MnValidasiResep);

        Kd2.setName("Kd2"); // NOI18N
        Kd2.setPreferredSize(new java.awt.Dimension(207, 23));

        DlgSakit.setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        DlgSakit.setName("DlgSakit"); // NOI18N
        DlgSakit.setUndecorated(true);
        DlgSakit.setResizable(false);

        internalFrame3.setBorder(javax.swing.BorderFactory.createTitledBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(230, 235, 225)), "::[ Cetak Surat Cuti Sakit ]::", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 0, 11), new java.awt.Color(50, 70, 50))); // NOI18N
        internalFrame3.setName("internalFrame3"); // NOI18N
        internalFrame3.setLayout(new java.awt.BorderLayout(1, 1));

        panelBiasa2.setName("panelBiasa2"); // NOI18N
        panelBiasa2.setLayout(null);

        TglSakit1.setEditable(false);
        TglSakit1.setForeground(new java.awt.Color(50, 70, 50));
        TglSakit1.setModel(new javax.swing.DefaultComboBoxModel(new String[] { "28-11-2017" }));
        TglSakit1.setDisplayFormat("dd-MM-yyyy");
        TglSakit1.setName("TglSakit1"); // NOI18N
        TglSakit1.setOpaque(false);
        panelBiasa2.add(TglSakit1);
        TglSakit1.setBounds(70, 10, 100, 23);

        jLabel31.setText("Lama Sakit :");
        jLabel31.setName("jLabel31"); // NOI18N
        panelBiasa2.add(jLabel31);
        jLabel31.setBounds(297, 10, 110, 23);

        BtnPrint2.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/b_print.png"))); // NOI18N
        BtnPrint2.setMnemonic('T');
        BtnPrint2.setText("Cetak");
        BtnPrint2.setToolTipText("Alt+T");
        BtnPrint2.setName("BtnPrint2"); // NOI18N
        BtnPrint2.setPreferredSize(new java.awt.Dimension(100, 30));
        BtnPrint2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnPrint2ActionPerformed(evt);
            }
        });
        panelBiasa2.add(BtnPrint2);
        BtnPrint2.setBounds(10, 50, 100, 30);

        BtnKeluar2.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/exit.png"))); // NOI18N
        BtnKeluar2.setMnemonic('K');
        BtnKeluar2.setText("Keluar");
        BtnKeluar2.setToolTipText("Alt+K");
        BtnKeluar2.setName("BtnKeluar2"); // NOI18N
        BtnKeluar2.setPreferredSize(new java.awt.Dimension(100, 30));
        BtnKeluar2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnKeluar2ActionPerformed(evt);
            }
        });
        panelBiasa2.add(BtnKeluar2);
        BtnKeluar2.setBounds(430, 50, 100, 30);

        jLabel32.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel32.setText("s/d");
        jLabel32.setName("jLabel32"); // NOI18N
        panelBiasa2.add(jLabel32);
        jLabel32.setBounds(176, 10, 20, 23);

        TglSakit2.setEditable(false);
        TglSakit2.setForeground(new java.awt.Color(50, 70, 50));
        TglSakit2.setModel(new javax.swing.DefaultComboBoxModel(new String[] { "28-11-2017" }));
        TglSakit2.setDisplayFormat("dd-MM-yyyy");
        TglSakit2.setName("TglSakit2"); // NOI18N
        TglSakit2.setOpaque(false);
        panelBiasa2.add(TglSakit2);
        TglSakit2.setBounds(200, 10, 100, 23);

        jLabel33.setText("Tanggal :");
        jLabel33.setName("jLabel33"); // NOI18N
        panelBiasa2.add(jLabel33);
        jLabel33.setBounds(0, 10, 66, 23);

        lmsakit.setHighlighter(null);
        lmsakit.setName("lmsakit"); // NOI18N
        lmsakit.setSelectionColor(new java.awt.Color(255, 255, 255));
        panelBiasa2.add(lmsakit);
        lmsakit.setBounds(410, 10, 110, 23);

        internalFrame3.add(panelBiasa2, java.awt.BorderLayout.CENTER);

        DlgSakit.getContentPane().add(internalFrame3, java.awt.BorderLayout.CENTER);

        DlgDemografi.setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        DlgDemografi.setName("DlgDemografi"); // NOI18N
        DlgDemografi.setUndecorated(true);
        DlgDemografi.setResizable(false);

        internalFrame4.setBorder(javax.swing.BorderFactory.createTitledBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(230, 235, 225)), "::[ Demografi Pendaftar ]::", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 0, 11), new java.awt.Color(50, 70, 50))); // NOI18N
        internalFrame4.setName("internalFrame4"); // NOI18N
        internalFrame4.setLayout(new java.awt.BorderLayout(1, 1));

        panelBiasa3.setName("panelBiasa3"); // NOI18N
        panelBiasa3.setLayout(null);

        BtnPrint3.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/b_print.png"))); // NOI18N
        BtnPrint3.setMnemonic('G');
        BtnPrint3.setText("Grafik");
        BtnPrint3.setToolTipText("Alt+G");
        BtnPrint3.setName("BtnPrint3"); // NOI18N
        BtnPrint3.setPreferredSize(new java.awt.Dimension(100, 30));
        BtnPrint3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnPrint3ActionPerformed(evt);
            }
        });
        BtnPrint3.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                BtnPrint3KeyPressed(evt);
            }
        });
        panelBiasa3.add(BtnPrint3);
        BtnPrint3.setBounds(110, 110, 100, 30);

        BtnKeluar3.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/exit.png"))); // NOI18N
        BtnKeluar3.setMnemonic('K');
        BtnKeluar3.setText("Keluar");
        BtnKeluar3.setToolTipText("Alt+K");
        BtnKeluar3.setName("BtnKeluar3"); // NOI18N
        BtnKeluar3.setPreferredSize(new java.awt.Dimension(100, 30));
        BtnKeluar3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnKeluar3ActionPerformed(evt);
            }
        });
        BtnKeluar3.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                BtnKeluar3KeyPressed(evt);
            }
        });
        panelBiasa3.add(BtnKeluar3);
        BtnKeluar3.setBounds(430, 110, 100, 30);

        Kelurahan2.setHighlighter(null);
        Kelurahan2.setName("Kelurahan2"); // NOI18N
        Kelurahan2.setSelectionColor(new java.awt.Color(255, 255, 255));
        Kelurahan2.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                Kelurahan2KeyPressed(evt);
            }
        });
        panelBiasa3.add(Kelurahan2);
        Kelurahan2.setBounds(105, 70, 350, 23);

        btnKel.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/190.png"))); // NOI18N
        btnKel.setMnemonic('1');
        btnKel.setToolTipText("ALt+1");
        btnKel.setName("btnKel"); // NOI18N
        btnKel.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnKelActionPerformed(evt);
            }
        });
        panelBiasa3.add(btnKel);
        btnKel.setBounds(460, 70, 28, 23);

        Kecamatan2.setHighlighter(null);
        Kecamatan2.setName("Kecamatan2"); // NOI18N
        Kecamatan2.setSelectionColor(new java.awt.Color(255, 255, 255));
        Kecamatan2.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                Kecamatan2KeyPressed(evt);
            }
        });
        panelBiasa3.add(Kecamatan2);
        Kecamatan2.setBounds(105, 40, 350, 23);

        btnKec.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/190.png"))); // NOI18N
        btnKec.setMnemonic('1');
        btnKec.setToolTipText("ALt+1");
        btnKec.setName("btnKec"); // NOI18N
        btnKec.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnKecActionPerformed(evt);
            }
        });
        panelBiasa3.add(btnKec);
        btnKec.setBounds(460, 40, 28, 23);

        Kabupaten2.setHighlighter(null);
        Kabupaten2.setName("Kabupaten2"); // NOI18N
        Kabupaten2.setSelectionColor(new java.awt.Color(255, 255, 255));
        Kabupaten2.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                Kabupaten2KeyPressed(evt);
            }
        });
        panelBiasa3.add(Kabupaten2);
        Kabupaten2.setBounds(105, 10, 350, 23);

        btnKab.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/190.png"))); // NOI18N
        btnKab.setMnemonic('1');
        btnKab.setToolTipText("ALt+1");
        btnKab.setName("btnKab"); // NOI18N
        btnKab.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnKabActionPerformed(evt);
            }
        });
        panelBiasa3.add(btnKab);
        btnKab.setBounds(460, 10, 28, 23);

        jLabel34.setText("Kelurahan :");
        jLabel34.setName("jLabel34"); // NOI18N
        panelBiasa3.add(jLabel34);
        jLabel34.setBounds(0, 70, 100, 23);

        jLabel35.setText("Kabupaten :");
        jLabel35.setName("jLabel35"); // NOI18N
        panelBiasa3.add(jLabel35);
        jLabel35.setBounds(0, 10, 100, 23);

        jLabel36.setText("Kecamatan :");
        jLabel36.setName("jLabel36"); // NOI18N
        panelBiasa3.add(jLabel36);
        jLabel36.setBounds(0, 40, 100, 23);

        BtnPrint4.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/b_print.png"))); // NOI18N
        BtnPrint4.setMnemonic('T');
        BtnPrint4.setText("Cetak");
        BtnPrint4.setToolTipText("Alt+T");
        BtnPrint4.setName("BtnPrint4"); // NOI18N
        BtnPrint4.setPreferredSize(new java.awt.Dimension(100, 30));
        BtnPrint4.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnPrint4ActionPerformed(evt);
            }
        });
        BtnPrint4.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                BtnPrint4KeyPressed(evt);
            }
        });
        panelBiasa3.add(BtnPrint4);
        BtnPrint4.setBounds(10, 110, 100, 30);

        internalFrame4.add(panelBiasa3, java.awt.BorderLayout.CENTER);

        DlgDemografi.getContentPane().add(internalFrame4, java.awt.BorderLayout.CENTER);

        DlgSakit2.setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        DlgSakit2.setName("DlgSakit2"); // NOI18N
        DlgSakit2.setUndecorated(true);
        DlgSakit2.setResizable(false);

        internalFrame5.setBorder(javax.swing.BorderFactory.createTitledBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(230, 235, 225)), "::[ Cetak Surat Keterangan Rawat Inap ]::", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 0, 11), new java.awt.Color(50, 70, 50))); // NOI18N
        internalFrame5.setName("internalFrame5"); // NOI18N
        internalFrame5.setLayout(new java.awt.BorderLayout(1, 1));

        panelBiasa4.setName("panelBiasa4"); // NOI18N
        panelBiasa4.setLayout(null);

        jLabel37.setText("Nomor Surat Keterangan :");
        jLabel37.setName("jLabel37"); // NOI18N
        panelBiasa4.add(jLabel37);
        jLabel37.setBounds(7, 10, 140, 23);

        BtnPrint5.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/b_print.png"))); // NOI18N
        BtnPrint5.setMnemonic('T');
        BtnPrint5.setText("Cetak");
        BtnPrint5.setToolTipText("Alt+T");
        BtnPrint5.setName("BtnPrint5"); // NOI18N
        BtnPrint5.setPreferredSize(new java.awt.Dimension(100, 30));
        BtnPrint5.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnPrint5ActionPerformed(evt);
            }
        });
        panelBiasa4.add(BtnPrint5);
        BtnPrint5.setBounds(10, 80, 100, 30);

        BtnKeluar4.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/exit.png"))); // NOI18N
        BtnKeluar4.setMnemonic('K');
        BtnKeluar4.setText("Keluar");
        BtnKeluar4.setToolTipText("Alt+K");
        BtnKeluar4.setName("BtnKeluar4"); // NOI18N
        BtnKeluar4.setPreferredSize(new java.awt.Dimension(100, 30));
        BtnKeluar4.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnKeluar4ActionPerformed(evt);
            }
        });
        panelBiasa4.add(BtnKeluar4);
        BtnKeluar4.setBounds(430, 80, 100, 30);

        NomorSurat.setHighlighter(null);
        NomorSurat.setName("NomorSurat"); // NOI18N
        NomorSurat.setSelectionColor(new java.awt.Color(255, 255, 255));
        panelBiasa4.add(NomorSurat);
        NomorSurat.setBounds(150, 10, 370, 23);

        BtnSeek5.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/190.png"))); // NOI18N
        BtnSeek5.setMnemonic('6');
        BtnSeek5.setToolTipText("ALt+6");
        BtnSeek5.setName("BtnSeek5"); // NOI18N
        BtnSeek5.setPreferredSize(new java.awt.Dimension(28, 23));
        BtnSeek5.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnSeek5ActionPerformed(evt);
            }
        });
        panelBiasa4.add(BtnSeek5);
        BtnSeek5.setBounds(492, 40, 28, 23);

        CrDokter3.setEditable(false);
        CrDokter3.setName("CrDokter3"); // NOI18N
        CrDokter3.setPreferredSize(new java.awt.Dimension(300, 23));
        panelBiasa4.add(CrDokter3);
        CrDokter3.setBounds(150, 40, 340, 23);

        jLabel24.setText("Dokter Png. Jawab :");
        jLabel24.setName("jLabel24"); // NOI18N
        jLabel24.setPreferredSize(new java.awt.Dimension(60, 23));
        panelBiasa4.add(jLabel24);
        jLabel24.setBounds(7, 40, 140, 23);

        internalFrame5.add(panelBiasa4, java.awt.BorderLayout.CENTER);

        DlgSakit2.getContentPane().add(internalFrame5, java.awt.BorderLayout.CENTER);

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setUndecorated(true);
        setResizable(false);
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowOpened(java.awt.event.WindowEvent evt) {
                formWindowOpened(evt);
            }
        });

        internalFrame1.setBorder(javax.swing.BorderFactory.createTitledBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(240, 245, 235)), "::[ Registrasi Pasien Hari Ini ]::", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 0, 11), new java.awt.Color(50, 70, 40))); // NOI18N
        internalFrame1.setName("internalFrame1"); // NOI18N
        internalFrame1.setLayout(new java.awt.BorderLayout(1, 1));

        Scroll.setToolTipText("Klik data di table, kemudian klik kanan untuk memilih menu yang diinginkan");
        Scroll.setComponentPopupMenu(jPopupMenu1);
        Scroll.setName("Scroll"); // NOI18N
        Scroll.setOpaque(true);

        tbPetugas.setAutoCreateRowSorter(true);
        tbPetugas.setToolTipText("Klik data di table, kemudian klik kanan untuk memilih menu yang diinginkan");
        tbPetugas.setComponentPopupMenu(jPopupMenu1);
        tbPetugas.setName("tbPetugas"); // NOI18N
        tbPetugas.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                tbPetugasMouseClicked(evt);
            }
        });
        tbPetugas.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                tbPetugasKeyPressed(evt);
            }
        });
        Scroll.setViewportView(tbPetugas);

        internalFrame1.add(Scroll, java.awt.BorderLayout.CENTER);

        jPanel2.setName("jPanel2"); // NOI18N
        jPanel2.setOpaque(false);
        jPanel2.setLayout(new java.awt.BorderLayout(1, 1));

        panelGlass6.setName("panelGlass6"); // NOI18N
        panelGlass6.setPreferredSize(new java.awt.Dimension(55, 55));
        panelGlass6.setLayout(new java.awt.FlowLayout(java.awt.FlowLayout.LEFT, 5, 9));

        BtnAll.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/Search-16x16.png"))); // NOI18N
        BtnAll.setMnemonic('M');
        BtnAll.setText("Semua");
        BtnAll.setToolTipText("Alt+M");
        BtnAll.setName("BtnAll"); // NOI18N
        BtnAll.setPreferredSize(new java.awt.Dimension(100, 30));
        BtnAll.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnAllActionPerformed(evt);
            }
        });
        BtnAll.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                BtnAllKeyPressed(evt);
            }
        });
        panelGlass6.add(BtnAll);

        jLabel10.setText("Record :");
        jLabel10.setName("jLabel10"); // NOI18N
        jLabel10.setPreferredSize(new java.awt.Dimension(70, 30));
        panelGlass6.add(jLabel10);

        LCount.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
        LCount.setText("0");
        LCount.setName("LCount"); // NOI18N
        LCount.setPreferredSize(new java.awt.Dimension(72, 30));
        panelGlass6.add(LCount);

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

        jPanel2.add(panelGlass6, java.awt.BorderLayout.PAGE_END);

        panelGlass7.setName("panelGlass7"); // NOI18N
        panelGlass7.setPreferredSize(new java.awt.Dimension(44, 44));
        panelGlass7.setLayout(new java.awt.FlowLayout(java.awt.FlowLayout.LEFT, 5, 9));

        jLabel15.setText("Periode :");
        jLabel15.setName("jLabel15"); // NOI18N
        jLabel15.setPreferredSize(new java.awt.Dimension(60, 23));
        panelGlass7.add(jLabel15);

        DTPCari1.setEditable(false);
        DTPCari1.setForeground(new java.awt.Color(50, 70, 50));
        DTPCari1.setModel(new javax.swing.DefaultComboBoxModel(new String[] { "28-11-2017" }));
        DTPCari1.setDisplayFormat("dd-MM-yyyy");
        DTPCari1.setName("DTPCari1"); // NOI18N
        DTPCari1.setOpaque(false);
        DTPCari1.setPreferredSize(new java.awt.Dimension(133, 23));
        panelGlass7.add(DTPCari1);

        jLabel17.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel17.setText("s.d");
        jLabel17.setName("jLabel17"); // NOI18N
        jLabel17.setPreferredSize(new java.awt.Dimension(24, 23));
        panelGlass7.add(jLabel17);

        DTPCari2.setEditable(false);
        DTPCari2.setForeground(new java.awt.Color(50, 70, 50));
        DTPCari2.setModel(new javax.swing.DefaultComboBoxModel(new String[] { "28-11-2017" }));
        DTPCari2.setDisplayFormat("dd-MM-yyyy");
        DTPCari2.setName("DTPCari2"); // NOI18N
        DTPCari2.setOpaque(false);
        DTPCari2.setPreferredSize(new java.awt.Dimension(133, 23));
        panelGlass7.add(DTPCari2);

        jLabel6.setText("Key Word :");
        jLabel6.setName("jLabel6"); // NOI18N
        jLabel6.setPreferredSize(new java.awt.Dimension(158, 23));
        panelGlass7.add(jLabel6);

        TCari.setName("TCari"); // NOI18N
        TCari.setPreferredSize(new java.awt.Dimension(300, 23));
        TCari.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                TCariKeyPressed(evt);
            }
        });
        panelGlass7.add(TCari);

        BtnCari.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/accept.png"))); // NOI18N
        BtnCari.setMnemonic('7');
        BtnCari.setToolTipText("Alt+7");
        BtnCari.setName("BtnCari"); // NOI18N
        BtnCari.setPreferredSize(new java.awt.Dimension(28, 23));
        BtnCari.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnCariActionPerformed(evt);
            }
        });
        BtnCari.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                BtnCariKeyPressed(evt);
            }
        });
        panelGlass7.add(BtnCari);

        jPanel2.add(panelGlass7, java.awt.BorderLayout.CENTER);

        panelGlass8.setName("panelGlass8"); // NOI18N
        panelGlass8.setPreferredSize(new java.awt.Dimension(44, 44));
        panelGlass8.setLayout(new java.awt.FlowLayout(java.awt.FlowLayout.LEFT, 5, 9));

        jLabel14.setText("Dokter :");
        jLabel14.setName("jLabel14"); // NOI18N
        jLabel14.setPreferredSize(new java.awt.Dimension(60, 23));
        panelGlass8.add(jLabel14);

        CrDokter.setEditable(false);
        CrDokter.setName("CrDokter"); // NOI18N
        CrDokter.setPreferredSize(new java.awt.Dimension(300, 23));
        panelGlass8.add(CrDokter);

        BtnSeek3.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/190.png"))); // NOI18N
        BtnSeek3.setMnemonic('6');
        BtnSeek3.setToolTipText("ALt+6");
        BtnSeek3.setName("BtnSeek3"); // NOI18N
        BtnSeek3.setPreferredSize(new java.awt.Dimension(28, 23));
        BtnSeek3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnSeek3ActionPerformed(evt);
            }
        });
        panelGlass8.add(BtnSeek3);

        jLabel16.setText("Unit :");
        jLabel16.setName("jLabel16"); // NOI18N
        jLabel16.setPreferredSize(new java.awt.Dimension(125, 23));
        panelGlass8.add(jLabel16);

        CrPoli.setEditable(false);
        CrPoli.setName("CrPoli"); // NOI18N
        CrPoli.setPreferredSize(new java.awt.Dimension(300, 23));
        panelGlass8.add(CrPoli);

        BtnSeek4.setIcon(new javax.swing.ImageIcon(getClass().getResource("/picture/190.png"))); // NOI18N
        BtnSeek4.setMnemonic('5');
        BtnSeek4.setToolTipText("ALt+5");
        BtnSeek4.setName("BtnSeek4"); // NOI18N
        BtnSeek4.setPreferredSize(new java.awt.Dimension(28, 23));
        BtnSeek4.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnSeek4ActionPerformed(evt);
            }
        });
        panelGlass8.add(BtnSeek4);

        jPanel2.add(panelGlass8, java.awt.BorderLayout.PAGE_START);

        internalFrame1.add(jPanel2, java.awt.BorderLayout.PAGE_END);

        PanelInput.setName("PanelInput"); // NOI18N
        PanelInput.setOpaque(false);
        PanelInput.setLayout(new java.awt.BorderLayout(1, 1));
        internalFrame1.add(PanelInput, java.awt.BorderLayout.PAGE_START);

        getContentPane().add(internalFrame1, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void BtnKeluarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnKeluarActionPerformed
        dispose();
}//GEN-LAST:event_BtnKeluarActionPerformed

    private void BtnKeluarKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_BtnKeluarKeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_SPACE){
            dispose();
        }else{}
}//GEN-LAST:event_BtnKeluarKeyPressed

    private void BtnAllActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnAllActionPerformed
        CrPoli.setText("");
        CrDokter.setText("");
        TCari.setText("");
        tampil();
}//GEN-LAST:event_BtnAllActionPerformed

    private void BtnAllKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_BtnAllKeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_SPACE){
            tampil();
            TCari.setText("");
        }else{
          
        }
}//GEN-LAST:event_BtnAllKeyPressed

    private void TCariKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_TCariKeyPressed
         if(evt.getKeyCode()==KeyEvent.VK_ENTER){
            BtnCariActionPerformed(null);
        }else if(evt.getKeyCode()==KeyEvent.VK_PAGE_DOWN){
            BtnCari.requestFocus();
        }else if(evt.getKeyCode()==KeyEvent.VK_PAGE_UP){
            BtnKeluar.requestFocus();
        }
}//GEN-LAST:event_TCariKeyPressed

    private void BtnCariActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnCariActionPerformed
        tampil();
}//GEN-LAST:event_BtnCariActionPerformed

    private void BtnCariKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_BtnCariKeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_SPACE){
            BtnCariActionPerformed(null);
        }else{
            Valid.pindah(evt, TCari, BtnAll);
        }
}//GEN-LAST:event_BtnCariKeyPressed

    private void tbPetugasMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_tbPetugasMouseClicked
        if(tabMode.getRowCount()!=0){
            try {
                getData();
            } catch (java.lang.NullPointerException e) {
            }
            if(evt.getClickCount()==2){
                i=tbPetugas.getSelectedColumn();
                if(i==1){
                    if(var.getkamar_inap()==true){
                       // MnKamarInapActionPerformed(null);
                    }                    
                }else if(i==2){
                    if(var.gettindakan_ralan()==true){
                     //   MnRawatJalanActionPerformed(null);
                    }                    
                }else if(i==3){
                    if(var.getberi_obat()==true){
                        MnPemberianObatActionPerformed(null);
                    }                   
                }else if(i==4){
                    if(var.getperiksa_lab()==true){
                     //   MnPeriksaLabActionPerformed(null);
                    }                    
                }else if(i==5){
                    if(var.getrujukan_masuk()==true){
                      //  MnRujukMasukActionPerformed(null);
                    }                    
                }else if(i==6){
                  //  MnCetakRegisterActionPerformed(null);
                }
            }
            
        }
        
}//GEN-LAST:event_tbPetugasMouseClicked

    private void tbPetugasKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_tbPetugasKeyPressed
        if(tabMode.getRowCount()!=0){
            if((evt.getKeyCode()==KeyEvent.VK_ENTER)||(evt.getKeyCode()==KeyEvent.VK_UP)||(evt.getKeyCode()==KeyEvent.VK_DOWN)){
                try {
                    getData();
                } catch (java.lang.NullPointerException e) {
                }
            }else if(evt.getKeyCode()==KeyEvent.VK_SPACE){
                try {
                    getData();
                } catch (java.lang.NullPointerException e) {
                }
                i=tbPetugas.getSelectedColumn();
                if(i==1){
                    if(var.getkamar_inap()==true){
                     //   MnKamarInapActionPerformed(null);
                    }                    
                }else if(i==2){
                    if(var.gettindakan_ralan()==true){
                       // MnRawatJalanActionPerformed(null);
                    }                    
                }else if(i==3){
                    if(var.getberi_obat()==true){
                        MnPemberianObatActionPerformed(null);
                    }                   
                }else if(i==4){
                    if(var.getperiksa_lab()==true){
                      //  MnPeriksaLabActionPerformed(null);
                    }                    
                }else if(i==5){
                    if(var.getrujukan_masuk()==true){
                     //   MnRujukMasukActionPerformed(null);
                    }                    
                }else if(i==6){
                  //  MnCetakRegisterActionPerformed(null);
                }else if(i==7){
                  //  MnBuktiPelayananRalanActionPerformed(null);
                }
            }else if(evt.getKeyCode()==KeyEvent.VK_A){                
                for(i=0;i<tbPetugas.getRowCount();i++){ 
                    tbPetugas.setValueAt(true,i,0);
                }
            }
        }
}//GEN-LAST:event_tbPetugasKeyPressed

private void BtnSeek3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnSeek3ActionPerformed
        var.setform("DlgApotek");
        pilihan=2;
        dokter.isCek();
        dokter.TCari.requestFocus();
        dokter.setSize(internalFrame1.getWidth()-40,internalFrame1.getHeight()-40);
        dokter.setLocationRelativeTo(internalFrame1);
        dokter.setVisible(true);
}//GEN-LAST:event_BtnSeek3ActionPerformed

private void BtnSeek4ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnSeek4ActionPerformed
        var.setform("DlgReg");
        pilihan=2;
      /*  poli.isCek();
        poli.setSize(internalFrame1.getWidth()-40,internalFrame1.getHeight()-40);
        poli.setLocationRelativeTo(internalFrame1);
        poli.setVisible(true);*/
}//GEN-LAST:event_BtnSeek4ActionPerformed

private void MnPemberianObatActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_MnPemberianObatActionPerformed
  if(TNoRw.trim().equals("")){
            JOptionPane.showMessageDialog(null,"Maaf, Pasien belum dipilih...!!!");
            tbPetugas.requestFocus();
        }else{
            if(var.getkode().equals("Admin Utama")){
                dlgobt.emptTeksobat();
               dlgobt.isCek();
               dlgobt.setNoRm(TNoRw,Sequel.cariIsi("select tgl_registrasi from reg_periksa where no_rawat=?",TNoRw),
                Sequel.cariIsi("select jam_reg from reg_periksa where no_rawat=?",TNoRw));
                dlgobt.tampilobat();
                dlgobt.setSize(internalFrame1.getWidth(),internalFrame1.getHeight());
                dlgobt.setLocationRelativeTo(internalFrame1);
                dlgobt.setAlwaysOnTop(false);
                dlgobt.setVisible(true);            
            }else{
                if(Sequel.cariRegistrasi(TNoRw)>0){
                    JOptionPane.showMessageDialog(rootPane,"Data billing sudah terverifikasi ..!!");
                }else{ 
                   dlgobt.emptTeksobat();
                   dlgobt.isCek();
                   dlgobt.setNoRm(TNoRw,Sequel.cariIsi("select tgl_registrasi from reg_periksa where no_rawat=?",TNoRw),
                   Sequel.cariIsi("select jam_reg from reg_periksa where no_rawat=?",TNoRw));
                   dlgobt.tampilobat();
                   dlgobt.setSize(internalFrame1.getWidth(),internalFrame1.getHeight());
                   dlgobt.setLocationRelativeTo(internalFrame1);
                   dlgobt.setAlwaysOnTop(false);
                   dlgobt.setVisible(true);  
                }
            }
                
        }
}//GEN-LAST:event_MnPemberianObatActionPerformed

private void BtnPrint2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnPrint2ActionPerformed
     
          if(pilihan==1){
                this.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
                Map<String, Object> param = new HashMap<>();
                  param.put("hari",lmsakit.getText());
                  param.put("TanggalAwal",TglSakit1.getSelectedItem().toString());
                  param.put("TanggalAkhir",TglSakit2.getSelectedItem().toString());
                  param.put("namars",var.getnamars());
                      param.put("alamatrs",var.getalamatrs());
                      param.put("kotars",var.getkabupatenrs());
                      param.put("propinsirs",var.getpropinsirs());
                      param.put("kontakrs",var.getkontakrs());
                      param.put("emailrs",var.getemailrs());   
                      param.put("logo",Sequel.cariGambar("select logo from setting")); 
                Valid.MyReport("rptSuratSakit.jrxml","report","::[ Surat Sakit ]::",
                              "select reg_periksa.no_rawat,dokter.nm_dokter,pasien.keluarga,pasien.namakeluarga,pasien.tgl_lahir,pasien.jk," +
                              " pasien.nm_pasien,pasien.jk,concat(reg_periksa.thn_umur,' Th ',reg_periksa.bln_umur,' Bl ',reg_periksa.hr_umur,' Hr')as umur,pasien.pekerjaan,concat(pasien.alamat,', ',kelurahan.nm_kel,', ',kecamatan.nm_kec,', ',kabupaten.nm_kab) as alamat" +
                              " from reg_periksa inner join pasien inner join dokter inner join kelurahan inner join kecamatan inner join kabupaten" +
                              " on reg_periksa.no_rkm_medis=pasien.no_rkm_medis and reg_periksa.kd_dokter=dokter.kd_dokter and pasien.kd_kel=kelurahan.kd_kel "+
                         "and pasien.kd_kec=kecamatan.kd_kec and pasien.kd_kab=kabupaten.kd_kab "+
                              "where reg_periksa.no_rawat='"+TNoRw+"' ",param);
                this.setCursor(Cursor.getDefaultCursor());  
          }else if(pilihan==2){
                this.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
                Map<String, Object> param = new HashMap<>();
                  param.put("hari",lmsakit.getText());
                  param.put("TanggalAwal",TglSakit1.getSelectedItem().toString());
                  param.put("TanggalAkhir",TglSakit2.getSelectedItem().toString());
                  param.put("namars",var.getnamars());
                      param.put("alamatrs",var.getalamatrs());
                      param.put("kotars",var.getkabupatenrs());
                      param.put("propinsirs",var.getpropinsirs());
                      param.put("kontakrs",var.getkontakrs());
                      param.put("emailrs",var.getemailrs());   
                      param.put("logo",Sequel.cariGambar("select logo from setting")); 
                Valid.MyReport("rptSuratSakit3.jrxml","report","::[ Surat Sakit ]::",
                              "select reg_periksa.no_rawat,dokter.nm_dokter,pasien.keluarga,pasien.namakeluarga,pasien.tgl_lahir,pasien.jk," +
                              " pasien.nm_pasien,pasien.jk,concat(reg_periksa.thn_umur,' Th ',reg_periksa.bln_umur,' Bl ',reg_periksa.hr_umur,' Hr')as umur,pasien.pekerjaan,concat(pasien.alamat,', ',kelurahan.nm_kel,', ',kecamatan.nm_kec,', ',kabupaten.nm_kab) as alamat" +
                              " from reg_periksa inner join pasien inner join dokter inner join kelurahan inner join kecamatan inner join kabupaten" +
                              " on reg_periksa.no_rkm_medis=pasien.no_rkm_medis and reg_periksa.kd_dokter=dokter.kd_dokter and pasien.kd_kel=kelurahan.kd_kel "+
                         "and pasien.kd_kec=kecamatan.kd_kec and pasien.kd_kab=kabupaten.kd_kab "+
                              "where reg_periksa.no_rawat='"+TNoRw+"' ",param);
                this.setCursor(Cursor.getDefaultCursor());  
              
          }
            
      
}//GEN-LAST:event_BtnPrint2ActionPerformed

private void BtnKeluar2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnKeluar2ActionPerformed
   DlgSakit.dispose();
}//GEN-LAST:event_BtnKeluar2ActionPerformed

private void BtnPrint3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnPrint3ActionPerformed
                
            if(!Kelurahan2.getText().equals("")){
                DlgDemografi.dispose();   
                grafiksql kas=new grafiksql("::[ Data Demografi Per Area Kelurahan "+Kelurahan2.getText()+", Kecamatan "+Kecamatan2.getText()+", Kabupaten "+Kabupaten2.getText()+" ]::",
                        " reg_periksa inner join pasien inner join kabupaten inner join kecamatan inner join kelurahan on pasien.kd_kab=kabupaten.kd_kab and pasien.kd_kec=kecamatan.kd_kec and pasien.kd_kel=kelurahan.kd_kel "+
                        " and reg_periksa.no_rkm_medis=pasien.no_rkm_medis where kabupaten.nm_kab='"+Kabupaten2.getText()+"' and kecamatan.nm_kec='"+Kecamatan2.getText()+"' and kelurahan.nm_kel='"+Kelurahan2.getText()+"'  and reg_periksa.tgl_registrasi between '"+Valid.SetTgl(DTPCari1.getSelectedItem()+"")+"' and '"+Valid.SetTgl(DTPCari2.getSelectedItem()+"")+"'   ", 
                        "pasien.alamat","Area");
                kas.setSize(this.getWidth(), this.getHeight());        
                kas.setLocationRelativeTo(this);
                kas.setVisible(true);
            }else if(!Kecamatan2.getText().equals("")){
                DlgDemografi.dispose();   
                grafiksql kas=new grafiksql("::[ Data Demografi Per Kelurahan Kecamatan "+Kecamatan2.getText()+" Kabupaten "+Kabupaten2.getText()+" ]::",
                        " reg_periksa inner join pasien inner join kabupaten inner join kecamatan inner join kelurahan on pasien.kd_kab=kabupaten.kd_kab "+
                         "and pasien.kd_kec=kecamatan.kd_kec and pasien.kd_kel=kelurahan.kd_kel "+
                         "and reg_periksa.no_rkm_medis=pasien.no_rkm_medis where kabupaten.nm_kab='"+Kabupaten2.getText()+"' and kecamatan.nm_kec='"+Kecamatan2.getText()+"' and reg_periksa.tgl_registrasi between '"+Valid.SetTgl(DTPCari1.getSelectedItem()+"")+"' and '"+Valid.SetTgl(DTPCari2.getSelectedItem()+"")+"'  ", 
                         "kelurahan.nm_kel","Kelurahan");
                kas.setSize(this.getWidth(), this.getHeight());        
                kas.setLocationRelativeTo(this);
                kas.setVisible(true);
            }else if(!Kabupaten2.getText().equals("")){
                DlgDemografi.dispose();   
                grafiksql kas=new grafiksql("::[ Data Per Kecamatan Kabupaten "+Kabupaten2.getText()+" ]::",
                         " reg_periksa inner join pasien inner join kabupaten inner join kecamatan on pasien.kd_kab=kabupaten.kd_kab "+
                         "and pasien.kd_kec=kecamatan.kd_kec and reg_periksa.no_rkm_medis=pasien.no_rkm_medis where kabupaten.nm_kab='"+Kabupaten2.getText()+"'  and reg_periksa.tgl_registrasi between '"+Valid.SetTgl(DTPCari1.getSelectedItem()+"")+"' and '"+Valid.SetTgl(DTPCari2.getSelectedItem()+"")+"'  ", 
                         "kecamatan.nm_kec","Kecamatan");
                kas.setSize(this.getWidth(), this.getHeight());        
                kas.setLocationRelativeTo(this);
                kas.setVisible(true);
            }else if(Kabupaten2.getText().equals("")){
                DlgDemografi.dispose();   
                grafiksql kas=new grafiksql("::[ Data Demografi Per Kabupaten ]::",
                         " reg_periksa inner join pasien inner join kabupaten on pasien.kd_kab=kabupaten.kd_kab and reg_periksa.no_rkm_medis=pasien.no_rkm_medis where reg_periksa.tgl_registrasi between '"+Valid.SetTgl(DTPCari1.getSelectedItem()+"")+"' and '"+Valid.SetTgl(DTPCari2.getSelectedItem()+"")+"' ", 
                          "kabupaten.nm_kab","Kabupaten");
                kas.setSize(this.getWidth(), this.getHeight());        
                kas.setLocationRelativeTo(this);
                kas.setVisible(true);
            } 
}//GEN-LAST:event_BtnPrint3ActionPerformed

private void BtnKeluar3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnKeluar3ActionPerformed
   DlgDemografi.dispose();
}//GEN-LAST:event_BtnKeluar3ActionPerformed

private void btnKelActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnKelActionPerformed
      /*  var.setform("DlgReg");
        pasien.kel.emptTeks();
        pasien.kel.setSize(internalFrame1.getWidth()-40,internalFrame1.getHeight()-40);
        pasien.kel.setLocationRelativeTo(internalFrame1);
        pasien.kel.setVisible(true);
     */
}//GEN-LAST:event_btnKelActionPerformed

private void btnKecActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnKecActionPerformed
 /*  var.setform("DlgReg");
   pasien.kec.emptTeks();
        pasien.kec.setSize(internalFrame1.getWidth()-40,internalFrame1.getHeight()-40);
        pasien.kec.setLocationRelativeTo(internalFrame1);
        pasien.kec.setVisible(true);    */  
}//GEN-LAST:event_btnKecActionPerformed

private void btnKabActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnKabActionPerformed
    /*    var.setform("DlgReg");
        pasien.kab.emptTeks();
        pasien.kab.setSize(internalFrame1.getWidth()-40,internalFrame1.getHeight()-40);
        pasien.kab.setLocationRelativeTo(internalFrame1);
        pasien.kab.setVisible(true);    */
}//GEN-LAST:event_btnKabActionPerformed

private void BtnPrint4ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnPrint4ActionPerformed
        this.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
        if(tabMode.getRowCount()==0){
            JOptionPane.showMessageDialog(null,"Maaf, data sudah habis. Tidak ada data yang bisa anda print...!!!!");
//            BtnBatal.requestFocus();
        }else if(tabMode.getRowCount()!=0){            
            if(!Kelurahan2.getText().equals("")){
                DlgDemografi.dispose();   
                Map<String, Object> data = new HashMap<>();
                data.put("judul","Data Demografi Per Area Kelurahan "+Kelurahan2.getText()+", Kecamatan "+Kecamatan2.getText()+", Kabupaten "+Kabupaten2.getText());
                data.put("area","Area");
                data.put("namars",var.getnamars());
                data.put("alamatrs",var.getalamatrs());
                data.put("kotars",var.getkabupatenrs());
                data.put("propinsirs",var.getpropinsirs());
                data.put("kontakrs",var.getkontakrs());
                data.put("emailrs",var.getemailrs());
                data.put("logo",Sequel.cariGambar("select logo from setting")); 
                Valid.MyReport("rptDemografi.jrxml","report","::[ Data Demografi Per Area Kelurahan "+Kelurahan2.getText()+", Kecamatan "+Kecamatan2.getText()+", Kabupaten "+Kabupaten2.getText()+" ]::",
                   "select  pasien.alamat as area,count(pasien.alamat) as jumlah from reg_periksa inner join pasien "+
                   "inner join kabupaten inner join kecamatan inner join kelurahan on pasien.kd_kab=kabupaten.kd_kab "+
                   "and pasien.kd_kec=kecamatan.kd_kec and pasien.kd_kel=kelurahan.kd_kel and reg_periksa.no_rkm_medis=pasien.no_rkm_medis "+
                   "where kabupaten.nm_kab='"+Kabupaten2.getText()+"' and kecamatan.nm_kec='"+Kecamatan2.getText()+"' "+
                   "and kelurahan.nm_kel='"+Kelurahan2.getText()+"' and reg_periksa.tgl_registrasi between '"+Valid.SetTgl(DTPCari1.getSelectedItem()+"")+"' and '"+Valid.SetTgl(DTPCari2.getSelectedItem()+"")+"' group by pasien.alamat order by pasien.alamat",data);
            }else if(!Kecamatan2.getText().equals("")){
                DlgDemografi.dispose();   
                Map<String, Object> data = new HashMap<>();
                data.put("judul","Data Demografi Per Kelurahan Kecamatan "+Kecamatan2.getText()+", Kabupaten "+Kabupaten2.getText());
                data.put("area","Kelurahan");
                data.put("namars",var.getnamars());
                data.put("alamatrs",var.getalamatrs());
                data.put("kotars",var.getkabupatenrs());
                data.put("propinsirs",var.getpropinsirs());
                data.put("kontakrs",var.getkontakrs());
                data.put("emailrs",var.getemailrs());
                data.put("logo",Sequel.cariGambar("select logo from setting")); 
                Valid.MyReport("rptDemografi.jrxml","report","::[ Data Demografi Per Kelurahan Kecamatan "+Kecamatan2.getText()+" Kabupaten "+Kabupaten2.getText()+" ]::",
                   "select kelurahan.nm_kel as area,count(kelurahan.nm_kel) as jumlah from reg_periksa inner join pasien "+
                   "inner join kabupaten inner join kecamatan inner join kelurahan on pasien.kd_kab=kabupaten.kd_kab "+
                   "and pasien.kd_kec=kecamatan.kd_kec and pasien.kd_kel=kelurahan.kd_kel and reg_periksa.no_rkm_medis=pasien.no_rkm_medis "+
                   "where kabupaten.nm_kab='"+Kabupaten2.getText()+"' and kecamatan.nm_kec='"+Kecamatan2.getText()+"' and reg_periksa.tgl_registrasi between '"+Valid.SetTgl(DTPCari1.getSelectedItem()+"")+"' and '"+Valid.SetTgl(DTPCari2.getSelectedItem()+"")+"' group by kelurahan.nm_kel order by kelurahan.nm_kel",data);
            }else if(!Kabupaten2.getText().equals("")){
                DlgDemografi.dispose();   
                Map<String, Object> data = new HashMap<>();
                data.put("judul","Data Demografi Per Kecamatan Kabupaten "+Kabupaten2.getText());
                data.put("area","Kecamatan");
                data.put("namars",var.getnamars());
                data.put("alamatrs",var.getalamatrs());
                data.put("kotars",var.getkabupatenrs());
                data.put("propinsirs",var.getpropinsirs());
                data.put("kontakrs",var.getkontakrs());
                data.put("emailrs",var.getemailrs());
                data.put("logo",Sequel.cariGambar("select logo from setting")); 
                Valid.MyReport("rptDemografi.jrxml","report","::[ Data Per Kecamatan Kabupaten "+Kabupaten2.getText()+" ]::",
                   "select kecamatan.nm_kec as area,count(kecamatan.nm_kec) as jumlah from reg_periksa inner join pasien "+
                   "inner join kabupaten inner join kecamatan on pasien.kd_kab=kabupaten.kd_kab and reg_periksa.no_rkm_medis=pasien.no_rkm_medis "+
                   "and pasien.kd_kec=kecamatan.kd_kec where kabupaten.nm_kab='"+Kabupaten2.getText()+"' and reg_periksa.tgl_registrasi between '"+Valid.SetTgl(DTPCari1.getSelectedItem()+"")+"' and '"+Valid.SetTgl(DTPCari2.getSelectedItem()+"")+"' group by kecamatan.nm_kec order by kecamatan.nm_kec",data);
            }else if(Kabupaten2.getText().equals("")){
                DlgDemografi.dispose();   
                Map<String, Object> data = new HashMap<>();
                data.put("judul","Data Demografi Per Kabupaten");
                data.put("area","Kabupaten");
                data.put("namars",var.getnamars());
                data.put("alamatrs",var.getalamatrs());
                data.put("kotars",var.getkabupatenrs());
                data.put("propinsirs",var.getpropinsirs());
                data.put("kontakrs",var.getkontakrs());
                data.put("emailrs",var.getemailrs());
                data.put("logo",Sequel.cariGambar("select logo from setting")); 
                Valid.MyReport("rptDemografi.jrxml","report","::[ Data Demografi Per Kabupaten ]::","select kabupaten.nm_kab as area,count(kabupaten.nm_kab) as jumlah from reg_periksa inner join pasien "+
                   "inner join kabupaten on pasien.kd_kab=kabupaten.kd_kab and reg_periksa.no_rkm_medis=pasien.no_rkm_medis where reg_periksa.tgl_registrasi between '"+Valid.SetTgl(DTPCari1.getSelectedItem()+"")+"' and '"+Valid.SetTgl(DTPCari2.getSelectedItem()+"")+"' group by kabupaten.nm_kab order by kabupaten.nm_kab",data);
            }                        
        }
        this.setCursor(Cursor.getDefaultCursor());
}//GEN-LAST:event_BtnPrint4ActionPerformed

    private void MnNoResepActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_MnNoResepActionPerformed
        if(TNoRw.equals("")){
            JOptionPane.showMessageDialog(null,"Maaf, Silahkan anda pilih dulu pasien...!!!");
            tbPetugas.requestFocus();
        }else{ 
            if(Sequel.cariInteger("select count(no_rawat) from kamar_inap where no_rawat=?",TNoRw)>0){
                        JOptionPane.showMessageDialog(null,"Maaf, Pasien sudah masuk Kamar Inap. Gunakan billing Ranap..!!!");
            }else {
                this.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
                DlgResepObat resep=new DlgResepObat(null,false);
                resep.setSize(internalFrame1.getWidth(),internalFrame1.getHeight());
                resep.setLocationRelativeTo(internalFrame1);
                resep.emptTeks();
                resep.isCek();
                resep.setNoRm(TNoRw,DTPCari1.getDate(),DTPCari2.getDate(),CmbJam.toString(),CmbMenit.toString(),CmbDetik.toString());
                resep.tampil();
                resep.setVisible(true);
                this.setCursor(Cursor.getDefaultCursor());
            }                
        }
    }//GEN-LAST:event_MnNoResepActionPerformed

    private void Kabupaten2KeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_Kabupaten2KeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_UP){
            btnKabActionPerformed(null);
        }else{Valid.pindah(evt,BtnKeluar3,Kecamatan2);}
    }//GEN-LAST:event_Kabupaten2KeyPressed

    private void Kecamatan2KeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_Kecamatan2KeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_UP){
            btnKecActionPerformed(null);
        }else{Valid.pindah(evt,Kabupaten2,Kelurahan2);}
    }//GEN-LAST:event_Kecamatan2KeyPressed

    private void Kelurahan2KeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_Kelurahan2KeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_UP){
            btnKelActionPerformed(null);
        }else{Valid.pindah(evt,Kecamatan2,BtnPrint4);}
    }//GEN-LAST:event_Kelurahan2KeyPressed

    private void BtnPrint4KeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_BtnPrint4KeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_SPACE){
            BtnPrint4ActionPerformed(null);
        }else{Valid.pindah(evt,Kelurahan2,BtnPrint3);}
    }//GEN-LAST:event_BtnPrint4KeyPressed

    private void BtnPrint3KeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_BtnPrint3KeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_SPACE){
            BtnPrint3ActionPerformed(null);
        }else{Valid.pindah(evt,BtnPrint4,BtnKeluar3);}
    }//GEN-LAST:event_BtnPrint3KeyPressed

    private void BtnKeluar3KeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_BtnKeluar3KeyPressed
        if(evt.getKeyCode()==KeyEvent.VK_SPACE){
            BtnKeluar3ActionPerformed(null);
        }else{Valid.pindah(evt,BtnPrint3,Kabupaten2);}
    }//GEN-LAST:event_BtnKeluar3KeyPressed

    private void formWindowOpened(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowOpened
        tampil();
    }//GEN-LAST:event_formWindowOpened

    private void BtnPrint5ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnPrint5ActionPerformed
/*      if(TPasien.getText().trim().equals("")){
          JOptionPane.showMessageDialog(null,"Maaf, Silahkan anda pilih dulu pasien...!!!");                
      }else{
         this.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
         Map<String, Object> param = new HashMap<>();
            param.put("hari",lmsakit.getText());
            param.put("TanggalAwal",TglSakit1.getSelectedItem().toString());
            param.put("TanggalAkhir",TglSakit2.getSelectedItem().toString());
            param.put("namars",var.getnamars());
                param.put("alamatrs",var.getalamatrs());
                param.put("kotars",var.getkabupatenrs());
                param.put("propinsirs",var.getpropinsirs());
                param.put("kontakrs",var.getkontakrs());
                param.put("nomersurat",NomorSurat.getText());
                param.put("dokterpj",CrDokter3.getText());
                param.put("emailrs",var.getemailrs());   
                param.put("logo",Sequel.cariGambar("select logo from setting")); 
          Valid.MyReport("rptSuratSakit2.jrxml","report","::[ Surat Sakit ]::",
                        "select reg_periksa.no_rkm_medis,dokter.nm_dokter,pasien.keluarga,pasien.namakeluarga,pasien.tgl_lahir,pasien.jk," +
                        " pasien.nm_pasien,pasien.jk,concat(reg_periksa.thn_umur,' Th ',reg_periksa.bln_umur,' Bl ',reg_periksa.hr_umur,' Hr')as umur,pasien.pekerjaan,pasien.alamat" +
                        " from reg_periksa inner join pasien inner join dokter" +
                        " on reg_periksa.no_rkm_medis=pasien.no_rkm_medis and reg_periksa.kd_dokter=dokter.kd_dokter  "+
                        "where reg_periksa.no_rawat='"+TNoRw.getText()+"' ",param);
          this.setCursor(Cursor.getDefaultCursor());
      }*/
    }//GEN-LAST:event_BtnPrint5ActionPerformed

    private void BtnKeluar4ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnKeluar4ActionPerformed
        DlgSakit2.dispose();
    }//GEN-LAST:event_BtnKeluar4ActionPerformed

    private void BtnSeek5ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnSeek5ActionPerformed
   /*     var.setform("DlgReg");
        pilihan=3;
        dokter.isCek();
        dokter.TCari.requestFocus();
        dokter.setSize(internalFrame1.getWidth()-40,internalFrame1.getHeight()-40);
        dokter.setLocationRelativeTo(internalFrame1);
        dokter.setVisible(true);*/
    }//GEN-LAST:event_BtnSeek5ActionPerformed
   
    private void MnResepDOkterActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_MnResepDOkterActionPerformed
       if(TNoRw.equals("")){
            JOptionPane.showMessageDialog(null,"Maaf, Silahkan anda pilih dulu pasien...!!!");
            tbPetugas.requestFocus();
        }else{
            if(Sequel.cariInteger("select count(no_rawat) from kamar_inap where no_rawat=?",TNoRw)>0){
                JOptionPane.showMessageDialog(null,"Maaf, Pasien sudah masuk Kamar Inap. Gunakan billing Ranap..!!!");
            }else {
                DlgPeresepanDokter resep=new DlgPeresepanDokter(null,false);
                resep.setSize(internalFrame1.getWidth()-40,internalFrame1.getHeight()-40);
                resep.setLocationRelativeTo(internalFrame1);
                resep.isCek();
                resep.setNoRm(TNoRw,DTPCari1.getDate(),CmbJam.toString(),CmbMenit.toString(),CmbDetik.toString(),
                    kddokter,TDokter);
                resep.tampilobat();
                resep.setVisible(true);
            }
        } 
    }//GEN-LAST:event_MnResepDOkterActionPerformed

    private void MnValidasiResepActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_MnValidasiResepActionPerformed
 this.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
        DlgDaftarPermintaanResep daftar=new DlgDaftarPermintaanResep(null,false);
        daftar.emptTeks();
        daftar.isCek();
        daftar.setSize(internalFrame1.getWidth()-40,internalFrame1.getHeight()-40);
        daftar.setLocationRelativeTo(internalFrame1);
        daftar.setVisible(true);
       // DlgHome.dispose();
        this.setCursor(Cursor.getDefaultCursor());
    }//GEN-LAST:event_MnValidasiResepActionPerformed

    /**
    * @param args the command line arguments
    */
    public static void main(String args[]) {
        java.awt.EventQueue.invokeLater(() -> {
            DlgApotek dialog = new DlgApotek(new javax.swing.JFrame(), true);
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
    private widget.Button BtnAll;
    private widget.Button BtnCari;
    private widget.Button BtnKeluar;
    private widget.Button BtnKeluar2;
    private widget.Button BtnKeluar3;
    private widget.Button BtnKeluar4;
    private widget.Button BtnPrint2;
    private widget.Button BtnPrint3;
    private widget.Button BtnPrint4;
    private widget.Button BtnPrint5;
    private widget.Button BtnSeek3;
    private widget.Button BtnSeek4;
    private widget.Button BtnSeek5;
    private widget.TextBox CrDokter;
    private widget.TextBox CrDokter3;
    private widget.TextBox CrPoli;
    private widget.Tanggal DTPCari1;
    private widget.Tanggal DTPCari2;
    private javax.swing.JDialog DlgDemografi;
    private javax.swing.JDialog DlgSakit;
    private javax.swing.JDialog DlgSakit2;
    private widget.TextBox Kabupaten2;
    private widget.TextBox Kd2;
    private widget.TextBox Kecamatan2;
    private widget.TextBox Kelurahan2;
    private widget.Label LCount;
    private javax.swing.JMenuItem MnNoResep;
    private javax.swing.JMenuItem MnPemberianObat;
    private javax.swing.JMenuItem MnResepDOkter;
    private javax.swing.JMenuItem MnValidasiResep;
    private widget.TextBox NomorSurat;
    private javax.swing.JPanel PanelInput;
    private widget.ScrollPane Scroll;
    private widget.TextBox TCari;
    private widget.Tanggal TglSakit1;
    private widget.Tanggal TglSakit2;
    private widget.Button btnKab;
    private widget.Button btnKec;
    private widget.Button btnKel;
    private javax.swing.ButtonGroup buttonGroup1;
    private widget.InternalFrame internalFrame1;
    private widget.InternalFrame internalFrame3;
    private widget.InternalFrame internalFrame4;
    private widget.InternalFrame internalFrame5;
    private widget.Label jLabel10;
    private widget.Label jLabel14;
    private widget.Label jLabel15;
    private widget.Label jLabel16;
    private widget.Label jLabel17;
    private widget.Label jLabel24;
    private widget.Label jLabel31;
    private widget.Label jLabel32;
    private widget.Label jLabel33;
    private widget.Label jLabel34;
    private widget.Label jLabel35;
    private widget.Label jLabel36;
    private widget.Label jLabel37;
    private widget.Label jLabel6;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPopupMenu jPopupMenu1;
    private widget.TextBox lmsakit;
    private widget.PanelBiasa panelBiasa2;
    private widget.PanelBiasa panelBiasa3;
    private widget.PanelBiasa panelBiasa4;
    private widget.panelisi panelGlass6;
    private widget.panelisi panelGlass7;
    private widget.panelisi panelGlass8;
    private widget.Table tbPetugas;
    // End of variables declaration//GEN-END:variables

    public void tampil() {
        Valid.tabelKosong(tabMode);   
        try {
            ps=koneksi.prepareStatement("select reg_periksa.no_reg,reg_periksa.no_rawat,reg_periksa.tgl_registrasi,reg_periksa.jam_reg,"+
                       "reg_periksa.kd_dokter,dokter.nm_dokter,reg_periksa.no_rkm_medis,pasien.nm_pasien,pasien.jk,pasien.tgl_lahir,concat(reg_periksa.thn_umur,' Th ',reg_periksa.bln_umur,' Bl ',reg_periksa.hr_umur,' Hr')as umur,poliklinik.nm_poli,"+
                       "reg_periksa.p_jawab,reg_periksa.almt_pj,reg_periksa.hubunganpj,reg_periksa.biaya_reg,reg_periksa.stts_daftar,penjab.png_jawab,reg_periksa.no_poli "+
                       "from reg_periksa inner join dokter inner join pasien inner join poliklinik inner join penjab "+
                       "on reg_periksa.kd_dokter=dokter.kd_dokter and reg_periksa.no_rkm_medis=pasien.no_rkm_medis "+
                       "and reg_periksa.kd_pj=penjab.kd_pj and reg_periksa.kd_poli=poliklinik.kd_poli  where  "+
                    "  poliklinik.nm_poli like ? and  dokter.nm_dokter like ? and tgl_registrasi between ? and ? and  reg_periksa.no_reg like ? or "+
                    "  poliklinik.nm_poli like ? and  dokter.nm_dokter like ? and tgl_registrasi between ? and ? and  reg_periksa.no_rawat like ? or "+
                    "  poliklinik.nm_poli like ? and  dokter.nm_dokter like ? and tgl_registrasi between ? and ? and  reg_periksa.tgl_registrasi like ? or "+
                    "  poliklinik.nm_poli like ? and  dokter.nm_dokter like ? and tgl_registrasi between ? and ? and  reg_periksa.kd_dokter like ? or "+
                    "  poliklinik.nm_poli like ? and  dokter.nm_dokter like ? and tgl_registrasi between ? and ? and  dokter.nm_dokter like ? or "+
                    "  poliklinik.nm_poli like ? and  dokter.nm_dokter like ? and tgl_registrasi between ? and ? and  reg_periksa.no_rkm_medis like ? or "+
                    "  poliklinik.nm_poli like ? and  dokter.nm_dokter like ? and tgl_registrasi between ? and ? and  reg_periksa.stts_daftar like ? or "+
                    "  poliklinik.nm_poli like ? and  dokter.nm_dokter like ? and tgl_registrasi between ? and ? and  pasien.nm_pasien like ? or "+
                    "  poliklinik.nm_poli like ? and  dokter.nm_dokter like ? and tgl_registrasi between ? and ? and  poliklinik.nm_poli like ? or "+
                    "  poliklinik.nm_poli like ? and  dokter.nm_dokter like ? and tgl_registrasi between ? and ? and  reg_periksa.p_jawab like ? or "+
                    "  poliklinik.nm_poli like ? and  dokter.nm_dokter like ? and tgl_registrasi between ? and ? and  reg_periksa.almt_pj like ? or "+
                    "  poliklinik.nm_poli like ? and  dokter.nm_dokter like ? and tgl_registrasi between ? and ? and  reg_periksa.hubunganpj like ? or "+
                    "  poliklinik.nm_poli like ? and  dokter.nm_dokter like ? and tgl_registrasi between ? and ? and  penjab.png_jawab like ? order by reg_periksa.tgl_registrasi,reg_periksa.jam_reg desc "); 
            try{  
                ps.setString(1,"%"+CrPoli.getText()+"%");
                ps.setString(2,"%"+CrDokter.getText()+"%");
                ps.setString(3,Valid.SetTgl(DTPCari1.getSelectedItem()+""));
                ps.setString(4,Valid.SetTgl(DTPCari2.getSelectedItem()+""));
                ps.setString(5,"%"+TCari.getText().trim()+"%");
                ps.setString(6,"%"+CrPoli.getText()+"%");
                ps.setString(7,"%"+CrDokter.getText()+"%");
                ps.setString(8,Valid.SetTgl(DTPCari1.getSelectedItem()+""));
                ps.setString(9,Valid.SetTgl(DTPCari2.getSelectedItem()+""));
                ps.setString(10,"%"+TCari.getText().trim()+"%");
                ps.setString(11,"%"+CrPoli.getText()+"%");
                ps.setString(12,"%"+CrDokter.getText()+"%");
                ps.setString(13,Valid.SetTgl(DTPCari1.getSelectedItem()+""));
                ps.setString(14,Valid.SetTgl(DTPCari2.getSelectedItem()+""));
                ps.setString(15,"%"+TCari.getText().trim()+"%");
                ps.setString(16,"%"+CrPoli.getText()+"%");
                ps.setString(17,"%"+CrDokter.getText()+"%");
                ps.setString(18,Valid.SetTgl(DTPCari1.getSelectedItem()+""));
                ps.setString(19,Valid.SetTgl(DTPCari2.getSelectedItem()+""));
                ps.setString(20,"%"+TCari.getText().trim()+"%");
                ps.setString(21,"%"+CrPoli.getText()+"%");
                ps.setString(22,"%"+CrDokter.getText()+"%");
                ps.setString(23,Valid.SetTgl(DTPCari1.getSelectedItem()+""));
                ps.setString(24,Valid.SetTgl(DTPCari2.getSelectedItem()+""));
                ps.setString(25,"%"+TCari.getText().trim()+"%");
                ps.setString(26,"%"+CrPoli.getText()+"%");
                ps.setString(27,"%"+CrDokter.getText()+"%");
                ps.setString(28,Valid.SetTgl(DTPCari1.getSelectedItem()+""));
                ps.setString(29,Valid.SetTgl(DTPCari2.getSelectedItem()+""));
                ps.setString(30,"%"+TCari.getText().trim()+"%");
                ps.setString(31,"%"+CrPoli.getText()+"%");
                ps.setString(32,"%"+CrDokter.getText()+"%");
                ps.setString(33,Valid.SetTgl(DTPCari1.getSelectedItem()+""));
                ps.setString(34,Valid.SetTgl(DTPCari2.getSelectedItem()+""));
                ps.setString(35,"%"+TCari.getText().trim()+"%");
                ps.setString(36,"%"+CrPoli.getText()+"%");
                ps.setString(37,"%"+CrDokter.getText()+"%");
                ps.setString(38,Valid.SetTgl(DTPCari1.getSelectedItem()+""));
                ps.setString(39,Valid.SetTgl(DTPCari2.getSelectedItem()+""));
                ps.setString(40,"%"+TCari.getText().trim()+"%");
                ps.setString(41,"%"+CrPoli.getText()+"%");
                ps.setString(42,"%"+CrDokter.getText()+"%");
                ps.setString(43,Valid.SetTgl(DTPCari1.getSelectedItem()+""));
                ps.setString(44,Valid.SetTgl(DTPCari2.getSelectedItem()+""));
                ps.setString(45,"%"+TCari.getText().trim()+"%");
                ps.setString(46,"%"+CrPoli.getText()+"%");
                ps.setString(47,"%"+CrDokter.getText()+"%");
                ps.setString(48,Valid.SetTgl(DTPCari1.getSelectedItem()+""));
                ps.setString(49,Valid.SetTgl(DTPCari2.getSelectedItem()+""));
                ps.setString(50,"%"+TCari.getText().trim()+"%");
                ps.setString(51,"%"+CrPoli.getText()+"%");
                ps.setString(52,"%"+CrDokter.getText()+"%");
                ps.setString(53,Valid.SetTgl(DTPCari1.getSelectedItem()+""));
                ps.setString(54,Valid.SetTgl(DTPCari2.getSelectedItem()+""));
                ps.setString(55,"%"+TCari.getText().trim()+"%");
                ps.setString(56,"%"+CrPoli.getText()+"%");
                ps.setString(57,"%"+CrDokter.getText()+"%");
                ps.setString(58,Valid.SetTgl(DTPCari1.getSelectedItem()+""));
                ps.setString(59,Valid.SetTgl(DTPCari2.getSelectedItem()+""));
                ps.setString(60,"%"+TCari.getText().trim()+"%");
                ps.setString(61,"%"+CrPoli.getText()+"%");
                ps.setString(62,"%"+CrDokter.getText()+"%");
                ps.setString(63,Valid.SetTgl(DTPCari1.getSelectedItem()+""));
                ps.setString(64,Valid.SetTgl(DTPCari2.getSelectedItem()+""));
                ps.setString(65,"%"+TCari.getText().trim()+"%");
                rs=ps.executeQuery();
                while(rs.next()){
                    String tgl_lahir_pas ;
            if(  String.valueOf(rs.getString(10)).equalsIgnoreCase("")||String.valueOf(rs.getString(10)).equalsIgnoreCase(null)||String.valueOf(rs.getString(10)).equalsIgnoreCase("0000-00-00"))
                {
                  String[] tgllahir= rs.getString(10).split("-");   
               tgl_lahir_pas =tgllahir[2]+"-"+tgllahir[1]+"-"+tgllahir[0];
                
                }
                else
                {
                 
                tgl_lahir_pas = rs.getString(10);
                
                }
                    tabMode.addRow(new Object[] {false,rs.getString(1),
                                   rs.getString(2),
                                   rs.getString(3),
                                   rs.getString(4),
                                   
                                   rs.getString(5),
                                   rs.getString(6),
                                   rs.getString(12),
                                   rs.getString(7),
                                   rs.getString(8),
                                   rs.getString(9),
                                   tgl_lahir_pas,
                               
                                  rs.getString(11),
                                   
                                   rs.getString(18),
                                   rs.getString(13),
                                   rs.getString(14),
                                   rs.getString(15),
                                    rs.getString(16),
                                   rs.getString(17),
                                   rs.getString(19)});
                }                    
            }catch(Exception e){
                System.out.println("Notifikasi : "+e);
            }finally{
                if(rs != null){
                    rs.close();
                }
                
                if(ps != null){
                    ps.close();
                }
            }
        } catch (Exception e) {
            System.out.println("Notifikasi : "+e);
        }
    
        LCount.setText(""+tabMode.getRowCount());
    }

    public void emptTeks() {
     //   TNoReg.setText("");
     //   TNoRw.setText("");
        Kd2.setText("");
        //DTPReg.setDate(new Date());
    //    TNoRM.setText("");
    //    TPasien.setText("");
     //   TPngJwb.setText("");
      //  THbngn.setText("");
     // //  TAlmt.setText("");
     //   TStatus.setText("");
      //  AsalRujukan.setText("");        
        alamatperujuk="";
      //  kddokter.setText("");
      //  kdpoli.setText("");
      //  TDokter.setText("");
      //  TPoli.setText("");
      //  TBiaya.setText("");
      //  isNumber();       
      //  TNoRM.requestFocus();
      //  kdpnj.setText("");
      //  nmpnj.setText("");
       //  TNoReg.setText("");
    }

    private void getData() {
        if(tbPetugas.getSelectedRow()!= -1){
        //    TNoReg.setText(tbPetugas.getValueAt(tbPetugas.getSelectedRow(),1).toString());                        
            Kd2.setText(tbPetugas.getValueAt(tbPetugas.getSelectedRow(),2).toString());
        //    Valid.SetTgl(DTPReg,tbPetugas.getValueAt(tbPetugas.getSelectedRow(),3).toString());
           CmbJam=tbPetugas.getValueAt(tbPetugas.getSelectedRow(),4).toString().substring(0,2);
           CmbMenit=tbPetugas.getValueAt(tbPetugas.getSelectedRow(),4).toString().substring(3,5);
            CmbDetik=tbPetugas.getValueAt(tbPetugas.getSelectedRow(),4).toString().substring(6,8);
            kddokter=tbPetugas.getValueAt(tbPetugas.getSelectedRow(),5).toString();
            TDokter=tbPetugas.getValueAt(tbPetugas.getSelectedRow(),6).toString();
           TNoRM=tbPetugas.getValueAt(tbPetugas.getSelectedRow(),8).toString();            
            isPas();
        //    TPoli.setText(tbPetugas.getValueAt(tbPetugas.getSelectedRow(),7).toString());          
         //   nmpnj.setText(tbPetugas.getValueAt(tbPetugas.getSelectedRow(),13).toString());
         //   TPngJwb.setText(tbPetugas.getValueAt(tbPetugas.getSelectedRow(),14).toString());
          //  TAlmt.setText(tbPetugas.getValueAt(tbPetugas.getSelectedRow(),15).toString());
        //    THbngn.setText(tbPetugas.getValueAt(tbPetugas.getSelectedRow(),16).toString());
        //    TBiaya.setText(tbPetugas.getValueAt(tbPetugas.getSelectedRow(),17).toString());
        //    TStatus.setText(tbPetugas.getValueAt(tbPetugas.getSelectedRow(),18).toString()); 
        //     nopoli.setText(tbPetugas.getValueAt(tbPetugas.getSelectedRow(),19).toString()); 
         //   Sequel.cariIsi("select kd_pj from reg_periksa where no_rawat=?", kdpnj,tbPetugas.getValueAt(tbPetugas.getSelectedRow(),2).toString());
        //    Sequel.cariIsi("select kd_poli from reg_periksa where no_rawat=?", kdpoli,tbPetugas.getValueAt(tbPetugas.getSelectedRow(),2).toString());
        //    Sequel.cariIsi("select perujuk from rujuk_masuk where no_rawat=?", AsalRujukan,tbPetugas.getValueAt(tbPetugas.getSelectedRow(),2).toString());
            TNoRw=tbPetugas.getValueAt(tbPetugas.getSelectedRow(),2).toString();
        }
    }


    private void jam(){
        ActionListener taskPerformer = new ActionListener(){
            private int nilai_jam;
            private int nilai_menit;
            private int nilai_detik;
            public void actionPerformed(ActionEvent e) {
                String nol_jam = "";
                String nol_menit = "";
                String nol_detik = "";
                
                Date now = Calendar.getInstance().getTime();

                // Mengambil nilaj JAM, MENIT, dan DETIK Sekarang
              /*  if(ChkJln.isSelected()==true){
                    nilai_jam = now.getHours();
                    nilai_menit = now.getMinutes();
                    nilai_detik = now.getSeconds();
                }else if(ChkJln.isSelected()==false){
                    nilai_jam =CmbJam.getSelectedIndex();
                    nilai_menit =CmbMenit.getSelectedIndex();
                    nilai_detik =CmbDetik.getSelectedIndex();
                }
*/
                // Jika nilai JAM lebih kecil dari 10 (hanya 1 digit)
                if (nilai_jam <= 9) {
                    // Tambahkan "0" didepannya
                    nol_jam = "0";
                }
                // Jika nilai MENIT lebih kecil dari 10 (hanya 1 digit)
                if (nilai_menit <= 9) {
                    // Tambahkan "0" didepannya
                    nol_menit = "0";
                }
                // Jika nilai DETIK lebih kecil dari 10 (hanya 1 digit)
                if (nilai_detik <= 9) {
                    // Tambahkan "0" didepannya
                    nol_detik = "0";
                }
                // Membuat String JAM, MENIT, DETIK
                String jam = nol_jam + Integer.toString(nilai_jam);
                String menit = nol_menit + Integer.toString(nilai_menit);
                String detik = nol_detik + Integer.toString(nilai_detik);
                // Menampilkan pada Layar
                //tampil_jam.setText("  " + jam + " : " + menit + " : " + detik + "  ");
//                CmbJam.setSelectedItem(jam);
  //              CmbMenit.setSelectedItem(menit);
    //            CmbDetik.setSelectedItem(detik);
            }
        };
        // Timer
        new Timer(1000, taskPerformer).start();
    }

    private void isPas(){
        try {
            ps3=koneksi.prepareStatement("select nm_pasien,concat(pasien.alamat,', ',kelurahan.nm_kel,', ',kecamatan.nm_kec,', ',kabupaten.nm_kab) asal,"+
                        "namakeluarga,keluarga,pasien.kd_pj,penjab.png_jawab,if(tgl_daftar=?,'Baru','Lama') as daftar, "+
                        "year(from_days(datediff(now(), pasien.tgl_lahir))) as tahun, "+
                        "month(from_days(datediff(now(),pasien.tgl_lahir))) as bulan, "+
                        "day(from_days(datediff(now(),pasien.tgl_lahir))) as hari , pasien.tgl_lahir from pasien "+
                        "inner join kelurahan inner join kecamatan inner join kabupaten inner join penjab "+
                        "on pasien.kd_kel=kelurahan.kd_kel and pasien.kd_pj=penjab.kd_pj "+
                        "and pasien.kd_kec=kecamatan.kd_kec and pasien.kd_kab=kabupaten.kd_kab "+
                        "where pasien.no_rkm_medis=?");
            try {            
            ps3.setString(1,Valid.SetTgl(getTanggal()+""));
              ps3.setString(2,TNoRM);
                rs=ps3.executeQuery();
                while(rs.next()){
            //        TPasien.setText(rs.getString("nm_pasien"));
             //       TAlmt.setText(rs.getString("asal"));
               //     TPngJwb.setText(rs.getString("namakeluarga"));
               //     THbngn.setText(rs.getString("keluarga"));
                //    kdpnj.setText(rs.getString("kd_pj"));
                 //   nmpnj.setText(rs.getString("png_jawab"));
                //    TStatus.setText(rs.getString("daftar"));
                    String tanggal = rs.getString("tgl_lahir");
Date lahir = new SimpleDateFormat("yyyy-MM-dd").parse(tanggal);
                    
            Date kini = new Date();
            LocalDate today =LocalDate.now();
            LocalDate birthday = lahir.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            Period p = Period.between(birthday,today);
            long p2 =ChronoUnit.DAYS.between(birthday,today);
              th_umur=String.valueOf(p.getYears());
            bl_umur=String.valueOf(p.getMonths());
            hr_umur=String.valueOf(p.getDays());
                    /*
                    umur="0";
                    sttsumur="Th";
                    if(rs.getInt("tahun")>0){
                        umur=rs.getString("tahun");
                        sttsumur="Th";
                    }else if(rs.getInt("tahun")==0){
                        if(rs.getInt("bulan")>0){
                            umur=rs.getString("bulan");
                            sttsumur="Bl";
                        }else if(rs.getInt("bulan")==0){
                            umur=rs.getString("hari");
                            sttsumur="Hr";
                        }
                    }*/
            /*      switch (rs.getString("daftar")) {
                        case "Baru":
                            Sequel.cariIsi("select registrasi from poliklinik where kd_poli=?",TBiaya,kdpoli.getText());
                            break;
                        case "Lama":
                            Sequel.cariIsi("select registrasilama from poliklinik where kd_poli=?",TBiaya,kdpoli.getText());
                            break;
                        default:
                            Sequel.cariIsi("select registrasi from poliklinik where kd_poli=?",TBiaya,kdpoli.getText());
                            break;
                    } */
                }
            } catch (Exception ex) {
                System.out.println(ex);
            }finally{
                if(rs != null ){
                    rs.close();
                }
                
                if(ps3 != null ){
                    ps3.close();
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

/*
    public JTextField getTextField(){
        return TNoRw;
    }
*/
    public JButton getButton(){
        return BtnKeluar;
    }
 /*   
    private void isForm(){
        if(ChkInput.isSelected()==true){
            ChkInput.setVisible(false);
            PanelInput.setPreferredSize(new Dimension(WIDTH,188));
            
            FormInput.setVisible(true);      
            ChkInput.setVisible(true);
        }else if(ChkInput.isSelected()==false){           
            ChkInput.setVisible(false);            
            PanelInput.setPreferredSize(new Dimension(WIDTH,20));
            FormInput.setVisible(false);      
            ChkInput.setVisible(true);
        }
    }
    */
    public void isCek(){
       // DTPReg.setDate(new Date());
        DTPCari1.setDate(new Date());
        DTPCari2.setDate(new Date());
       // BtnSimpan.setEnabled(var.getregistrasi());
       // BtnHapus.setEnabled(var.getregistrasi());
       // BtnEdit.setEnabled(var.getregistrasi());
       // BtnPrint.setEnabled(var.getregistrasi());
       // MnOperasi.setEnabled(var.getoperasi());
       // MnKamarInap.setEnabled(var.getkamar_inap());
       // MnRawatJalan.setEnabled(var.gettindakan_ralan());
        MnPemberianObat.setEnabled(var.getberi_obat());
       // MnBilling.setEnabled(var.getbilling_ralan());
       // MnPeriksaLab.setEnabled(var.getperiksa_lab());
       // MnPeriksaRadiologi.setEnabled(var.getperiksa_radiologi());
        MnNoResep.setEnabled(var.getresep_obat());
       // MnRujuk.setEnabled(var.getrujukan_keluar());
        //MnRujukMasuk.setEnabled(var.getrujukan_masuk());
       // MnDiagnosa.setEnabled(var.getdiagnosa_pasien());
       // MnHapusTagihanOperasi.setEnabled(var.getoperasi());
       // MnHapusObatOperasi.setEnabled(var.getoperasi());  
       // MnSEP.setEnabled(var.getbpjs_sep());  
       // ppRiwayat.setEnabled(var.getresume_pasien());
    }
    
   
    
   
    
    
    
   
   
  
}

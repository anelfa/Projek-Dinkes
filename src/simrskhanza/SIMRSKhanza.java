/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package simrskhanza;

import AESsecurity.EnkripsiAES;
import fungsi.koneksiDB;
import java.io.FileInputStream;
import java.util.Properties;
import usu.widget.util.WidgetUtilities;

/**
 *
 * @author khanzasoft
 */
public class SIMRSKhanza {
private static final Properties propVer = new Properties();  
private static final Properties propDatabase = new Properties();  
public static String version;
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        try {
            propVer.loadFromXML(new FileInputStream("setting/version.xml"));
            propDatabase.loadFromXML(new FileInputStream("setting/database.xml"));
        } catch (Exception e) {
            System.out.println("Notif Setting : "+e);
        }
        version = propVer.getProperty("VERSION");
        if(propDatabase.getProperty("AUTOUPDATESISTEM").equals("aktif"))
         {
             
         
         try {
            if (!Updater.getLatestVersion().equals(version) ) {
                new UpdateInfo(Updater.getWhatsNew());
            }
            else
            {
                if(koneksiDB.condb() == null){
                String[] run = {"java","-jar","updater/SetKoneksiServer.jar"};
                    try {
                            Runtime.getRuntime().exec(run);
                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }
                    }else{
                            WidgetUtilities.invokeLater(() -> {
                            main utama=new main();
                            utama.setVisible(true);
                            });
                         }
            }
            } catch (Exception ex) {
                    ex.printStackTrace();
                }
         
         }  else  if(koneksiDB.condb() == null){
             String[] run = {"java","-jar","updater/SetKoneksiServer.jar"};
        try {
            Runtime.getRuntime().exec(run);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
         } 
        else {
             WidgetUtilities.invokeLater(() -> {
                            main utama=new main();
                            utama.setVisible(true);
                            });
        }
        
        
      
    }
    
}

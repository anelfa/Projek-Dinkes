/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package fungsi;

import java.awt.Color;
import java.awt.Component;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;

/**
 *
 * @author Owner
 */
public class TableKasir extends DefaultTableCellRenderer {
    private Color batal;
   

   
    @Override
    public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column){
        Component component = super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
         String status = table.getValueAt(row, 10).toString();
       if (row % 2 == 1){
            component.setBackground(new Color(250,240,230));
            
            
        }else{
            component.setBackground(new Color(255,255,255));
        } 
       if( status.equals("Batal")){component.setBackground(new Color(247,169,169));}
       if( status.equals("Bayar")){component.setBackground(new Color(152,221,242));}
      
        
  
           
           
            
           
                  
                
        return component;
    }
  

}


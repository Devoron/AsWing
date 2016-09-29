/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.table{
	
import devoron.aswing3d.error.ImpMissError;
import devoron.aswing3d.table.TableCell;
import devoron.aswing3d.JTable;
import devoron.aswing3d.Component;
	
/**
 * Abstract table cell.
 * @author senkay
 */
public class AbstractTableCell implements TableCell{
	
	protected var value:*;
	
	public function AbstractTableCell(){
	}
	
	public function setTableCellStatus(table:JTable, isSelected:Boolean, row:int, column:int):void {
		var com:Component = getCellComponent();
		if(isSelected){
			com.setBackground(table.getSelectionBackground());
			com.setForeground(table.getSelectionForeground());
		}else{
			com.setBackground(table.getBackground());
			com.setForeground(table.getForeground());
		}
		com.setFont(table.getFont());
	}

	public function setCellValue(value:*) : void {
		this.value = value;
	}

	public function getCellValue():* {
		return value;
	}
	
	/**
	 * Subclass should override this method
	 */
	public function getCellComponent() : Component {
		throw new ImpMissError();
		return null;
	}
}
}
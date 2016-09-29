/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.table{
	
import devoron.aswing3d.Component;
import devoron.aswing3d.geom.*;
import devoron.aswing3d.JLabel;
import devoron.aswing3d.JTable;

/**
 * Default table cell to render text
 * @author iiley
 */
public class DefaultTextCell extends JLabel implements TableCell{
	
	protected var value:*;
	
	public function DefaultTextCell(){
		super();
		setHorizontalAlignment(LEFT);
		setOpaque(true);
	}
	
	/**
	 * Simpler this method to speed up performance
	 */
	override public function setComBounds(b:IntRectangle):void{
		readyToPaint = true;
		if(!b.equals(compBounds)){
			if(b.width != compBounds.width || b.height != compBounds.height){
				repaint();
			}
			compBounds.setRect(b);
			locate();
			valid = false;
		}
	}
	
	/**
	 * Simpler this method to speed up performance
	 */
	override public function invalidate():void {
		valid = false;
	}
	
	/**
	 * Simpler this method to speed up performance
	 */
	override public function revalidate():void {
		valid = false;
	}
	
	//**********************************************************
	//				  Implementing TableCell
	//**********************************************************
	public function setCellValue(value:*) : void {
		this.value = value;
		setText(value + "");
	}
	
	public function getCellValue():*{
		return value;
	}
	
	public function setTableCellStatus(table:JTable, isSelected:Boolean, row:int, column:int):void{
		if(isSelected){
			setBackground(table.getSelectionBackground());
			setForeground(table.getSelectionForeground());
		}else{
			setBackground(table.getBackground());
			setForeground(table.getForeground());
		}
		setFont(table.getFont());
	}
	
	public function getCellComponent() : Component {
		return this;
	}
	
	override public function toString():String{
		return "TextCell[label:" + super.toString() + "]\n";
	}
}
}
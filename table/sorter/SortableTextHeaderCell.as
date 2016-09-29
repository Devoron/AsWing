/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.table.sorter{

import devoron.aswing3d.JTable;
import devoron.aswing3d.table.DefaultTextHeaderCell;
import devoron.aswing3d.UIManager;

/**
 * @author iiley
 */
public class SortableTextHeaderCell extends DefaultTextHeaderCell{
	
	private var tableSorter:TableSorter;
	
	public function SortableTextHeaderCell(tableSorter:TableSorter) {
		super();
		setBorder(UIManager.getBorder("TableHeader.sortableCellBorder"));
		setBackgroundDecorator(UIManager.getGroundDecorator("TableHeader.sortableCellBackground"));
		this.tableSorter = tableSorter;
		setHorizontalTextPosition(LEFT);
		setIconTextGap(6);
		//make it user parent property
		setMideground(null);
		setStyleTune(null);
	}
	
	override public function setTableCellStatus(table:JTable, isSelected:Boolean, row:int, column:int):void{
		super.setTableCellStatus(table, isSelected, row, column);
		var modelColumn:int = table.convertColumnIndexToModel(column);
		setIcon(tableSorter.getHeaderRendererIcon(modelColumn, getFont().getSize()-2));
	}
}
}
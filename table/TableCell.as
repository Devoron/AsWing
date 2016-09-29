/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.table{

import devoron.aswing3d.Cell;
import devoron.aswing3d.JTable;

/**
 * @author iiley
 */
public interface TableCell extends Cell{
	
	/**
	 * Sets the table cell status, include the owner-JTable isSelected, row position, column position.
	 * @param the cell's owner, a JTable
	 * @param isSelected true to set the cell selected, false to set not selected.
	 * @param row the row position
	 * @param column the column position
	 */
	function setTableCellStatus(table:JTable, isSelected:Boolean, row:int, column:int):void;
}

}
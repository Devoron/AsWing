/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.table{

/**
 * TableCellFactory for create cells for table
 * @author iiley
 */
public interface TableCellFactory{
	
	/**
	 * Creates a new table cell.
	 * @param isHeader is it a header cell
	 * @return the table cell
	 */
	function createNewCell(isHeader:Boolean):TableCell;
}

}
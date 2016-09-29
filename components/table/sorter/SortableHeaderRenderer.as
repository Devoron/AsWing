/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.table.sorter{

import devoron.aswing3d.table.TableCell;
import devoron.aswing3d.table.TableCellFactory;

/**
 * @author iiley
 */
public class SortableHeaderRenderer implements TableCellFactory{
	
	private var tableSorter:TableSorter;
	private var originalRenderer:TableCellFactory;
	
	public function SortableHeaderRenderer(originalRenderer:TableCellFactory, tableSorter:TableSorter){
		this.originalRenderer = originalRenderer;
		this.tableSorter = tableSorter;
	}
	
	public function createNewCell(isHeader : Boolean) : TableCell {
		return new SortableTextHeaderCell(tableSorter);
	}
	
	public function getTableCellFactory():TableCellFactory{
		return null;
	}
}
}
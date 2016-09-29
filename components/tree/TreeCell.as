/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.tree { 

import devoron.aswing3d.Cell;
import devoron.aswing3d.JTree;

/**
 * @author iiley
 */
public interface TreeCell extends Cell {
	/**
	 * Sets the table cell status, include the owner-JTable isSelected, row position, column position.
	 * @param the cell's owner, a JTable
	 * @param seleted true indicated the cell selected, false not selected.
	 * @param expanded true the node is currently expanded, false not.
	 * @param leaf true the node represets a leaf, false not.
	 * @param row the row position
	 */
	function setTreeCellStatus(tree:JTree, selected:Boolean, expanded:Boolean, leaf:Boolean, row:int):void;	
}
}
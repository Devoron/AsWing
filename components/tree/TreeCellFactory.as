package devoron.aswing3d.tree { 
/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import devoron.aswing3d.tree.TreeCell;

/**
 * TreeCellFactory for create cells for tree
 * @author iiley
 */
public interface TreeCellFactory {
	/**
	 * Creates a new tree cell.
	 * @return the tree cell
	 */
	function createNewCell():TreeCell;
}
}
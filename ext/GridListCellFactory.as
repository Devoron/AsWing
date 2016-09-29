/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.ext{

/**
 * The factory to generate grid list cell instances.
 */
public interface GridListCellFactory{
	
	/**
	 * Creates a new list cell.
	 */ 
	function createNewGridListCell():GridListCell;
	
}
}
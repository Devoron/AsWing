/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.tree { 

import devoron.aswing3d.plaf.UIResource;
import devoron.aswing3d.tree.GeneralTreeCellFactory;

/**
 * @author iiley
 */
public class GeneralTreeCellFactoryUIResource extends GeneralTreeCellFactory 
	implements UIResource{
	
	public function GeneralTreeCellFactoryUIResource(cellClass : Class) {
		super(cellClass);
	}

}
}
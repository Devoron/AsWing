/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.plaf.basic.tree{

import devoron.aswing3d.Component;
import devoron.aswing3d.graphics.Graphics2D;
import devoron.aswing3d.geom.IntRectangle;
import devoron.aswing3d.tree.TreePath;

/**
 * The tree expand control graphics
 * @private
 */
public interface ExpandControl{
	
	function paintExpandControl(c:Component, g:Graphics2D, bounds:IntRectangle, 
		totalChildIndent:int, path:TreePath, row:int, expanded:Boolean, leaf:Boolean):void;
}
}
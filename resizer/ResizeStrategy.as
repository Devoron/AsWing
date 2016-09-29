/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.resizer{

import devoron.aswing3d.geom.IntDimension;
import devoron.aswing3d.geom.IntRectangle;

/**
 * The strategy for DefaultResizer to count the new bounds of component would be resized to.
 * @author iiley
 */
public interface ResizeStrategy{
	
	/**
	 * Count and return the new bounds what the component would be resized to.
	 * @param origBounds the original bounds before resized
	 * @param minSize can be null, means (0, 1)
	 * @param maxSize can be null, means (very big)
	 * @param movedX 
	 * @param movedY 
	 */
	function getBounds(origBounds:IntRectangle, minSize:IntDimension, maxSize:IntDimension, movedX:int, movedY:int):IntRectangle;
}
}
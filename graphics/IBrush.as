/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.graphics{
	import starling.display.Graphics;
	

/**
 * Brush to fill a closed area.<br>
 * Use it with a devoron.aswing3d.graphics.Graphics2D instance
 * @author iiley
 */
public interface IBrush{
	
	/**
	 * 
	 * This method will be called by Graphics2D autumaticlly.<br>
	 * It applys the fill paramters to the instance of flash.display.Graphics
	 * 
	 * @param target the instance of a flash.display.Graphics
	 */
	 function beginFill(target:Graphics):void;
	
	/**
	 * 
	 * This method will be called by Graphics2D autumaticlly.<br>
	 * It marks the end of filling
	 * 
	 * @param target the instance of a flash.display.Graphics
	 */
	 function endFill(target:Graphics):void;
}

}

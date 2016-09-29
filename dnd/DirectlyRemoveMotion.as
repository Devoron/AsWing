/*
   Copyright aswing.org, see the LICENCE.txt.
 */

package org.aswing.dnd
{
	import org.aswing.dnd.DropMotion;
	import starling.display.Sprite;
	import org.aswing.Component;
	
	/**
	 * Remove the dragging movieclip directly.
	 * @author iiley
	 */
	public class DirectlyRemoveMotion implements DropMotion
	{
		
		public function startMotionAndLaterRemove(dragInitiator:Component, dragObject:Sprite):void
		{
			if (dragObject.parent != null)
			{
				dragObject.parent.removeChild(dragObject);
			}
		}
		
		public function forceStop():void
		{
		}
	}
}
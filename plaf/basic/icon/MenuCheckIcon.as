/*
   Copyright aswing.org, see the LICENCE.txt.
 */

package devoron.aswing3d.plaf.basic.icon
{
	import starling.display.DisplayObject;
	import devoron.aswing3d.graphics.Graphics2D;
	import org.aswing.Icon;
	import devoron.aswing3d.Component;
	import devoron.aswing3d.plaf.UIResource;
	
	/**
	 * @private
	 */
	public class MenuCheckIcon implements Icon, UIResource
	{
		
		public function MenuCheckIcon()
		{
		}
		
		public function updateIcon(c:Component, g:Graphics2D, x:int, y:int):void
		{
		}
		
		public function getIconHeight(c:Component):int
		{
			return 8;
		}
		
		public function getIconWidth(c:Component):int
		{
			return 8;
		}
		
		public function getDisplay(c:Component):DisplayObject
		{
			return null;
		}
	
	}
}
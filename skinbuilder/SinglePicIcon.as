/*
   Copyright aswing.org, see the LICENCE.txt.
 */

package devoron.aswing3d.skinbuilder
{
	import starling.display.DisplayObject;
	import devoron.aswing3d.Component;
	import org.aswing3d.Icon;
	import devoron.aswing3d.error.ImpMissError;
	import devoron.aswing3d.graphics.Graphics2D;
	import devoron.aswing3d.plaf.DefaultsDecoratorBase;
	import devoron.aswing3d.plaf.UIResource;
	
	public class SinglePicIcon extends DefaultsDecoratorBase implements Icon, UIResource
	{
		
		protected var image:DisplayObject;
		protected var loaded:Boolean;
		
		public function SinglePicIcon()
		{
			loaded = false;
		}
		
		protected function getDefaltsKey():String
		{
			throw new ImpMissError();
			return null;
		}
		
		protected function checkLoad(c:Component):void
		{
			if (!loaded)
			{
				image = getDefaultsOwner(c).getInstance(getDefaltsKey()) as DisplayObject;
				loaded = true;
			}
		}
		
		public function updateIcon(c:Component, g:Graphics2D, x:int, y:int):void
		{
			checkLoad(c);
			if (image)
			{
				//not use bounds, avoid border margin
				image.x = x;
				image.y = y;
			}
		}
		
		public function getIconHeight(c:Component):int
		{
			checkLoad(c);
			return image ? image.height : 0;
		}
		
		public function getIconWidth(c:Component):int
		{
			checkLoad(c);
			return image ? image.width : 0;
		}
		
		public function getDisplay(c:Component):DisplayObject
		{
			checkLoad(c);
			return image;
		}
	
	}
}
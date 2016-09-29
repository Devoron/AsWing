package devoron.aswing3d.skinbuilder
{
	import starling.display.DisplayObject;
	import org.aswing.GroundDecorator;
	import devoron.aswing3d.geom.IntRectangle;
	import devoron.aswing3d.graphics.Graphics2D;
	import devoron.aswing3d.plaf.UIResource;
	import devoron.aswing3d.Component;
	
	/**
	 * blank bg.
	 */
	public class SkinFrameTitleBarBG implements GroundDecorator, UIResource
	{
		public function SkinFrameTitleBarBG()
		{
			super();
		}
		
		public function getDisplay(c:Component):DisplayObject
		{
			return null;
		}
		
		public function updateDecorator(com:Component, g:Graphics2D, bounds:IntRectangle):void
		{
		}
	
	}
}
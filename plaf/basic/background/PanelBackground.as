package devoron.aswing3d.plaf.basic.background
{
	import starling.display.DisplayObject;
	import devoron.aswing3d.Component;
	import org.aswing.GroundDecorator;
	import devoron.aswing3d.geom.IntRectangle;
	import devoron.aswing3d.graphics.Graphics2D;
	import devoron.aswing3d.graphics.SolidBrush;
	import devoron.aswing3d.plaf.UIResource;
	
	public class PanelBackground implements GroundDecorator, UIResource
	{
		
		public function PanelBackground()
		{
		}
		
		public function getDisplay(c:Component):DisplayObject
		{
			return null;
		}
		
		public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void
		{
			if (c.isOpaque())
			{
				g.fillRectangle(new SolidBrush(c.getBackground()), b.x, b.y, b.width, b.height);
			}
		}
	
	}
}
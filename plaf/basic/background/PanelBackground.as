package devoron.aswing3d.plaf.basic.background
{
	import starling.display.DisplayObject;
	import org.aswing.Component;
	import org.aswing.GroundDecorator;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.plaf.UIResource;
	
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
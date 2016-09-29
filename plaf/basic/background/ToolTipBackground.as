/*
   Copyright aswing.org, see the LICENCE.txt.
 */

package devoron.aswing3d.plaf.basic.background
{
	import starling.display.Graphics;
	import starling.display.DisplayObject;
	import starling.display.Shape;
	import devoron.aswing3d.ASColor;
	import devoron.aswing3d.Component;
	import org.aswing.GroundDecorator;
	import devoron.aswing3d.StyleTune;
	import devoron.aswing3d.geom.IntRectangle;
	import devoron.aswing3d.graphics.Graphics2D;
	import devoron.aswing3d.graphics.SolidBrush;
	import devoron.aswing3d.plaf.UIResource;
	import devoron.aswing3d.plaf.basic.BasicGraphicsUtils;
	
	/**
	 * @private
	 */
	public class ToolTipBackground implements GroundDecorator, UIResource
	{
		
		protected var shape:Shape;
		
		public function ToolTipBackground()
		{
			shape = new Shape();
		}
		
		public function getDisplay(c:Component):DisplayObject
		{
			return shape;
		}
		
		public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void
		{
			shape.visible = c.isOpaque();
			if (c.isOpaque())
			{
				shape.graphics.clear();
				g = new Graphics2D(new Graphics(shape));
				var cc:ASColor = c.getBackground();
				var bc:ASColor = c.getMideground();
				var tune:StyleTune = c.getStyleTune();
				g.beginFill(new SolidBrush(bc));
				var r:Number = tune.round;
				b = new IntRectangle(0, 0, c.width, c.height);
				if (r < 1)
				{
					g.rectangle(b.x, b.y, b.width, b.height);
				}
				else
				{
					BasicGraphicsUtils.drawRoundRect(g, b.x, b.y, b.width, b.height, r);
				}
				g.endFill();
				g.beginFill(new SolidBrush(cc));
				r -= 0.5;
				b.grow(-1, -1);
				if (r < 1)
				{
					g.rectangle(b.x, b.y, b.width, b.height);
				}
				else
				{
					BasicGraphicsUtils.drawRoundRect(g, b.x, b.y, b.width, b.height, r);
				}
				g.endFill();
			}
		}
	
	}
}
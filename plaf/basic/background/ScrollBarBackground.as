/*
   Copyright aswing.org, see the LICENCE.txt.
 */

package devoron.aswing3d.plaf.basic.background
{
	import starling.display.Shape;
	import starling.display.DisplayObject;
	import devoron.aswing3d.AsWingConstants;
	import devoron.aswing3d.AsWingManager;
	import devoron.aswing3d.Component;
	import org.aswing3d.GroundDecorator;
	import devoron.aswing3d.Orientable;
	import devoron.aswing3d.StyleTune;
	import devoron.aswing3d.geom.IntRectangle;
	import devoron.aswing3d.graphics.Graphics2D;
	import devoron.aswing3d.graphics.SolidBrush;
	import devoron.aswing3d.plaf.UIResource;
	import starling.filters.BlurFilter;
	
	/**
	 * @private
	 */
	public class ScrollBarBackground implements GroundDecorator, UIResource
	{
		
		protected var shape:Shape;
		
		public function ScrollBarBackground()
		{
			shape = new Shape();
		}
		
		public function getDisplay(c:Component):DisplayObject
		{
			return shape;
		}
		
		public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void
		{
			if (c is Orientable && c.isOpaque())
			{
				var bar:Orientable = c as Orientable;
				var verticle:Boolean = (bar.getOrientation() == AsWingConstants.VERTICAL);
				shape.graphics.clear();
				var style:StyleTune = c.getStyleTune();
				g = new Graphics2D(shape.graphics);
				b = b.clone();
				g.fillRoundRect(new SolidBrush(c.getBackground().changeAlpha(1)), b.x, b.y, b.width, b.height, style.round);
				shape.filter = BlurFilter.createGlow(0x0, style.shadowAlpha, 5, 0.6);
				shape.alpha = c.getBackground().getAlpha();
			}
		}
	
	}
}
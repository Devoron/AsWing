/*
   Copyright aswing.org, see the LICENCE.txt.
 */

package devoron.aswing3d.plaf.basic.background
{
	import starling.display.DisplayObject;
	import starling.display.Graphics;
	import starling.display.Shape;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilterType;
	import flash.filters.GlowFilter;
	import starling.filters.BlurFilter;
	
	import devoron.aswing3d.ASColor;
	import devoron.aswing3d.AsWingManager;
	import devoron.aswing3d.Component;
	import org.aswing3d.GroundDecorator;
	import devoron.aswing3d.StyleResult;
	import devoron.aswing3d.StyleTune;
	import devoron.aswing3d.geom.IntRectangle;
	import devoron.aswing3d.graphics.Graphics2D;
	import devoron.aswing3d.plaf.UIResource;
	import devoron.aswing3d.plaf.basic.BasicGraphicsUtils;
	
	/**
	 * @private
	 */
	public class TableBackground implements GroundDecorator, UIResource
	{
		
		protected var shape:Shape;
		
		public function TableBackground()
		{
			shape = new Shape();
		}
		
		public function getDisplay(c:Component):DisplayObject
		{
			return shape;
		}
		
		public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void
		{
			//shape.graphics.clear();
			if (c.isOpaque())
			{
				g = new Graphics2D(shape.graphics);
				var tune:StyleTune = c.getStyleTune().mide;
				var cl:ASColor = c.getMideground();
				var style:StyleResult = new StyleResult(cl, tune);
				b = b.clone();
				style.cdark = style.cdark.changeAlpha(1);
				style.clight = style.clight.changeAlpha(1);
				BasicGraphicsUtils.fillGradientRoundRect(g, b, style, -Math.PI / 2);
				var bd:ASColor = style.bdark;
				//shape.filters = [new BevelFilter(1, 45, 0xFFFFFF, 0.4, 0x0, 0.4, 1, 1, 1, 1, BitmapFilterType.INNER), new GlowFilter(0xFFFFFF, 0.5, 2, 2, 20, 1, true), new GlowFilter(bd.getRGB(), 1, 2, 2, 20, 1)];
				//shape.filter = 
				shape.alpha = cl.getAlpha();
			}
			shape.visible = c.isOpaque();
		}
	
	}
}
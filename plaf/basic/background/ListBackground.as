package devoron.aswing3d.plaf.basic.background
{
	
	import devoron.aswing3d.ASColor;
	import devoron.aswing3d.StyleResult;
	import devoron.aswing3d.StyleTune;
	import devoron.aswing3d.Component;
	import org.aswing.GroundDecorator;
	import devoron.aswing3d.geom.IntRectangle;
	import devoron.aswing3d.graphics.Graphics2D;
	import devoron.aswing3d.plaf.UIResource;
	import devoron.aswing3d.plaf.basic.BasicGraphicsUtils;
	import starling.display.DisplayObject;
	
	public class ListBackground implements GroundDecorator, UIResource
	{
		
		public function ListBackground()
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
				var cl:ASColor = c.getMideground();
				var style:StyleResult;
				var adjuster:StyleTune = c.getStyleTune();
				if (!c.isEnabled())
				{
					adjuster = adjuster.sharpen(0.5);
					cl = cl.changeAlpha(0.6);
				}
				style = new StyleResult(cl, adjuster);
				BasicGraphicsUtils.fillGradientRoundRect(g, b, style, -Math.PI / 2);
			}
		}
	
	}
}
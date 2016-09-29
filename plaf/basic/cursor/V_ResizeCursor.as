/*
   Copyright aswing.org, see the LICENCE.txt.
 */

package devoron.aswing3d.plaf.basic.cursor
{
	import starling.display.Shape;
	import starling.display.Graphics;
	import devoron.aswing3d.graphics.*;
	import devoron.aswing3d.UIManager;
	import devoron.aswing3d.ASColor;
	
	/**
	 * @private
	 */
	public class V_ResizeCursor extends Shape
	{
		private var resizeArrowColor:ASColor;
		private var resizeArrowLightColor:ASColor;
		private var resizeArrowDarkColor:ASColor;
		
		public function V_ResizeCursor()
		{
			super();
			
			resizeArrowColor = UIManager.getColor("Frame.resizeArrow");
			resizeArrowLightColor = UIManager.getColor("Frame.resizeArrowLight");
			resizeArrowDarkColor = UIManager.getColor("Frame.resizeArrowDark");
			
			var w:Number = 1; //arrowAxisHalfWidth
			var r:Number = 4;
			var arrowPoints:Array;
			
			arrowPoints = [{y: -r * 2, x: 0}, {y: -r, x: -r}, {y: -r, x: -w}, {y: r, x: -w}, {y: r, x: -r}, {y: r * 2, x: 0}, {y: r, x: r}, {y: r, x: w}, {y: -r, x: w}, {y: -r, x: r}];
			var gdi:Graphics2D = new Graphics2D(new Graphics(this));
			gdi.drawPolygon(new Pen(resizeArrowColor.changeAlpha(0.4), 4), arrowPoints);
			gdi.fillPolygon(new SolidBrush(resizeArrowLightColor), arrowPoints);
			gdi.drawPolygon(new Pen(resizeArrowDarkColor, 1), arrowPoints);
		}
	}
}
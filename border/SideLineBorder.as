/*
   Copyright aswing.org, see the LICENCE.txt.
 */

package devoron.aswing3d.border
{
	
	import devoron.aswing3d.*;
	import devoron.aswing3d.geom.*;
	import devoron.aswing3d.graphics.*;
	import flash.display.BitmapData;
	import org.aswing3d.Insets;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.textures.Texture;
	
	/**
	 * A border that draw a line at one side of a component.
	 * @author iiley
	 */
	public class SideLineBorder extends DecorateBorder
	{
		
		/**
		 * The north side constraint (top of component).
		 */
		public static const NORTH:int = 0;
		
		/**
		 * The south side constraint (bottom of component).
		 */
		public static const SOUTH:int = 1;
		
		/**
		 * The east side constraint (right side of component).
		 */
		public static const EAST:int = 2;
		
		/**
		 * The west side constraint (left side of component).
		 */
		public static const WEST:int = 3;
		
		private var side:int;
		private var color:ASColor;
		private var thickness:Number;
		
		private var borderShape:Shape;
		
		/**
		 * SideLineBorder(interior:Border, side:Number, color:ASColor, thickness:Number) <br>
		 * SideLineBorder(interior:Border, side:Number, color:ASColor) <br>
		 * SideLineBorder(interior:Border, side:Number) <br>
		 * SideLineBorder(interior:Border) <br>
		 * SideLineBorder() <br>
		 * <p>
		 * @param interior interior border. Default is null;
		 * @param side the side of the line. Must be one of bottom value:
		 * <ul>
		 *   <li>#NORTH
		 *   <li>#SOUTH
		 *   <li>#EAST
		 *   <li>#WEST
		 * </ul>
		 * .Default is NORTH.
		 * @param color the color of the border. Default is ASColor.BLACK
		 * @param thickness the thickness of the border. Default is 1
		 */
		public function SideLineBorder(interior:Border = null, side:int = NORTH, color:ASColor = null, thickness:Number = 1)
		{
			super(interior);
			if (color == null)
				color = ASColor.BLACK;
			
			this.side = side;
			this.color = color;
			this.thickness = thickness;
			
			borderShape = new Shape();
		}
		
		override public function updateBorderImp(com:Component, g:Graphics2D, b:IntRectangle):void
		{
			borderShape.graphics.clear();
			g = new Graphics2D(borderShape.graphics);
			
			var pen:Pen = new Pen(color, thickness);
			var x1:Number, x2:Number, y1:Number, y2:Number;
			if (side == SOUTH)
			{
				x1 = b.x;
				y1 = b.y + b.height - thickness / 2;
				x2 = b.x + b.width;
				y2 = y1;
			}
			else if (side == EAST)
			{
				x1 = b.x + b.width - thickness / 2;
				y1 = b.y;
				x2 = x1;
				y2 = b.y + b.height;
			}
			else if (side == WEST)
			{
				x1 = b.x + thickness / 2;
				y1 = b.y;
				x2 = x1;
				y2 = b.y + b.height;
			}
			else
			{
				x1 = b.x;
				y1 = b.y + thickness / 2;
				x2 = b.x + b.width;
				y2 = y1;
			}
			g.drawLine(pen, x1, y1, x2, y2);
		}
		
		override public function getBorderInsetsImp(c:Component, bounds:IntRectangle):Insets
		{
			var i:Insets = new Insets();
			if (side == SOUTH)
			{
				i.bottom = thickness;
			}
			else if (side == EAST)
			{
				i.right = thickness;
			}
			else if (side == WEST)
			{
				i.left = thickness;
			}
			else
			{
				i.top = thickness;
			}
			return i;
		}
		
		override public function getDisplayImp():DisplayObject
		{
			return borderShape;
		}
		
		public function getColor():ASColor
		{
			return color;
		}
		
		public function setColor(color:ASColor):void
		{
			this.color = color;
		}
		
		public function getThickness():Number
		{
			return thickness;
		}
		
		public function setThickness(thickness:Number):void
		{
			this.thickness = thickness;
		}
		
		public function getSide():Number
		{
			return side;
		}
		
		public function setSide(side:Number):void
		{
			this.side = side;
		}
	}

}

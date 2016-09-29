package org.aswing.decorators
{
	import flash.display.Shape;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.BitmapBrush;
	import org.aswing.graphics.GradientBrush;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.GroundDecorator;
	import starling.textures.Texture;
	
	/**
	 * ColorDecorator
	 * @author DEVORON
	 */
	public class GradientDecorator implements GroundDecorator
	{
		public var radius:Number;
		protected var topRightRadius:Number = -1;
		protected var bottomLeftRadius:Number = -1;
		protected var bottomRightRadius:Number = -1;
		protected var colors:Array;
		protected var alphas:Array;
		protected var matrix:Matrix;
		protected var spreadMethod:String;
		protected var interpolationMethod:String;
		protected var focalPointRatio:Number;
		protected var fillType:String;
		protected var ratios:Array;
		public var borderColor:ASColor;
		public var backgroundShape:Sprite;
		public var comp:Component;
		public var graphics:Graphics2D;
		public var bounds:IntRectangle;
		public var rightGap:int;
		public var leftGap:int;
		public var topGap:int;
		public var bottomGap:int;
		public var image:BitmapData;
		
		public static const LINEAR:String = GradientType.LINEAR;
		public static const RADIAL:String = GradientType.RADIAL;
		
		public function GradientDecorator(fillType:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0, borderColor:ASColor = null, radius:Number = 0)
		{
			this.ratios = ratios;
			this.fillType = fillType;
			this.focalPointRatio = focalPointRatio;
			this.interpolationMethod = interpolationMethod;
			this.spreadMethod = spreadMethod;
			this.matrix = matrix;
			this.alphas = alphas;
			this.colors = colors;
			this.radius = radius;
			this.borderColor = borderColor ? borderColor : new ASColor(0, 0);
			//this.color = color;
			backgroundShape = new Shape();
		}
		
		public function setRadiuses(radius:Number, topRightRadius:Number = -1, bottomLeftRadius:Number = -1, bottomRightRadius:Number = -1):void
		{
			this.bottomRightRadius = bottomRightRadius;
			this.bottomLeftRadius = bottomLeftRadius;
			this.topRightRadius = topRightRadius;
			this.radius = radius;
		}
		
		public function setGaps(rightGap:int = 0, leftGap:int = 0, topGap:int = 0, bottomGap:int = 0):void
		{
			this.bottomGap = bottomGap;
			this.topGap = topGap;
			this.leftGap = leftGap;
			this.rightGap = rightGap;
		}
		
		
		/*public function clone():ColorDecorator
		{
			var decorator:ColorDecorator = new ColorDecorator(color, borderColor, radius);
			decorator.setGaps(rightGap, leftGap, topGap, bottomGap);
			if (image)
				decorator.setImage(image.clone());
			return decorator;
		}*/
		
		public function getColors():Array
		{
			return colors;
		}
		
		public function setColors(value:Array):void
		{
			colors = value;
			if (comp)
			{
				updateDecorator(comp, graphics, bounds);
					//c.updateUI();
			}
		}
		
		/* INTERFACE devoron.aswing3d.GroundDecorator */
		
		public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void
		{
			comp = c;
			graphics = g;
			bounds = b;
			backgroundSprite.graphics.clear();
			/*backgroundSprite.mouseChildren = true;
			backgroundSprite.mouseEnabled = false;*/
			
			
			var g2d:Graphics2D = new Graphics2D(backgroundShape.graphics);
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(b.width, b.height, 0, 0, 0);
			
			g2d.beginFill(new GradientBrush(fillType, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio));
			
			if (radius != 0)
			{
				var trR:Number = topRightRadius == -1 ? radius : topRightRadius;
				var blR:Number = bottomLeftRadius == -1 ? radius : bottomLeftRadius;
				var brR:Number = bottomRightRadius == -1 ? radius : bottomRightRadius;
				g2d.drawRoundRect(new Pen(borderColor, 0), b.x + leftGap, b.y + topGap, b.width + rightGap, b.height + bottomGap, radius, trR, blR, brR);
			}
			else
			{
				g2d.drawRectangle(new Pen(borderColor, 0), b.x + leftGap, b.y + topGap, b.width + rightGap, b.height + bottomGap);
			}
			
			g2d.endDraw();
			g2d.endFill();
		}
		
		public function getDisplay(c:Component):DisplayObject
		{
			return backgroundShape;
		}
	
	}

}
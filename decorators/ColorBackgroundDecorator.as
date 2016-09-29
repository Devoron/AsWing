package devoron.aswing3d.decorators
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import devoron.aswing3d.ASColor;
	import devoron.aswing3d.Component;
	import devoron.aswing3d.geom.IntRectangle;
	import devoron.aswing3d.graphics.BitmapBrush;
	import devoron.aswing3d.graphics.Graphics2D;
	import devoron.aswing3d.graphics.Pen;
	import devoron.aswing3d.graphics.SolidBrush;
	import org.aswing3d.GroundDecorator;
	
	/**
	 * ColorBackgroundDecorator
	 * @author DEVORON
	 */
	public class ColorBackgroundDecorator implements GroundDecorator
	{
		public var radius:Number;
		private var topRightRadius:Number=-1;
		private var bottomLeftRadius:Number=-1;
		private var bottomRightRadius:Number=-1;
		public var color:ASColor;
		public var borderColor:ASColor;
		public var backgroundSprite:Sprite;
		public var comp:Component;
		public var graphics:Graphics2D;
		public var bounds:IntRectangle;
		public var rightGap:int;
		public var leftGap:int;
		public var topGap:int;
		public var bottomGap:int;
		public var image:BitmapData;
		
		public function ColorBackgroundDecorator(color:ASColor, borderColor:ASColor = null, radius:Number = 0)
		{
			this.radius = radius;
			this.borderColor = borderColor ? borderColor : new ASColor(0, 0);
			this.color = color;
			backgroundSprite = new Sprite();
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
		
		public function clone():ColorBackgroundDecorator
		{
			var decorator:ColorBackgroundDecorator = new ColorBackgroundDecorator(color, borderColor, radius);
			decorator.setGaps(rightGap, leftGap, topGap, bottomGap);
			if (image)
				decorator.setImage(image.clone());
			return decorator;
		}
		
		public function setImage(bd:BitmapData):void
		{
			image = bd;
			if (comp)
			{
				updateDecorator(comp, graphics, bounds);
					//c.updateUI();
			}
		}
		
		public function getImage():BitmapData
		{
			return image;
		}
		
		public function getColor():ASColor
		{
			return color;
		}
		
		public function setColor(value:ASColor):void
		{
			color = value;
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
			backgroundSprite.mouseChildren = true;
			backgroundSprite.mouseEnabled = false;
			var g2d:Graphics2D = new Graphics2D(backgroundSprite.graphics);
			
			if (image)
				g2d.beginFill(new BitmapBrush(image));
			else
				g2d.beginFill(new SolidBrush(color));
			
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
			return backgroundSprite;
		}
	
	}

}
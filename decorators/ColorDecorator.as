package devoron.aswing3d.decorators
{
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.BitmapBrush;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.GroundDecorator;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import starling.textures.Texture;
	import flash.geom.Rectangle;
	
	/**
	 * ColorDecorator
	 * @author DEVORON
	 */
	public class ColorDecorator implements GroundDecorator
	{
		public var radius:Number;
		protected var topRightRadius:Number = -1;
		protected var bottomLeftRadius:Number = -1;
		protected var bottomRightRadius:Number = -1;
		public var color:ASColor;
		public var borderColor:ASColor;
		public var backgroundShape:Shape;
		public var comp:Component;
		public var graphics:Graphics2D;
		public var bounds:IntRectangle;
		public var rightGap:int;
		public var leftGap:int;
		public var topGap:int;
		public var bottomGap:int;
		public var image:BitmapData;
		protected var openingRect:Rectangle;
		protected var internalBorderColor:ASColor;
		
		public function ColorDecorator(color:ASColor, borderColor:ASColor = null, radius:Number = 0)
		{
			this.radius = radius;
			this.borderColor = borderColor ? borderColor : new ASColor(0, 0);
			this.color = color;
			backgroundShape = new Shape();
		}
		
		public function setOpeningRect(rectangle:Rectangle, internalBorderColor:ASColor = null):void
		{
			this.internalBorderColor = internalBorderColor;
			openingRect = rectangle;
			if (comp)
			{
				updateDecorator(comp, graphics, bounds);
					//c.updateUI();
			}
		}
		
		public function setRadiuses(radius:Number, topRightRadius:Number = -1, bottomLeftRadius:Number = -1, bottomRightRadius:Number = -1):void
		{
			this.bottomRightRadius = bottomRightRadius;
			this.bottomLeftRadius = bottomLeftRadius;
			this.topRightRadius = topRightRadius;
			this.radius = radius;
		}
		
		/**
		 *[radius, topRightRadius, bottomLeftRadius, bottomRightRadius]
		 * @return [radius, topRightRadius, bottomLeftRadius, bottomRightRadius]
		 */
		public function getRadiuses():Array
		{
			return [radius, topRightRadius, bottomLeftRadius, bottomRightRadius];
		}
		
		public function setGaps(rightGap:int = 0, leftGap:int = 0, topGap:int = 0, bottomGap:int = 0):void
		{
			this.bottomGap = bottomGap;
			this.topGap = topGap;
			this.leftGap = leftGap;
			this.rightGap = rightGap;
		}
		
		/**
		 * [rightGap, leftGap, topGap, bottomGap]
		 * @return
		 */
		public function getGaps():Array
		{
			return [rightGap, leftGap, topGap, bottomGap];
		}
		
		public function clone():ColorDecorator
		{
			var decorator:ColorDecorator = new ColorDecorator(color, borderColor, radius);
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
		
		public function getBorderColor():ASColor
		{
			return borderColor;
		}
		
		public function setBorderColor(value:ASColor):void
		{
			borderColor = value;
			if (comp)
			{
				updateDecorator(comp, graphics, bounds);
					//c.updateUI();
			}
		}
		
		public function getInternalBorderColor():ASColor
		{
			return internalBorderColor;
		}
		
		public function getInternalRect():Rectangle
		{
			return openingRect;
		}
		
		/* INTERFACE org.aswing.GroundDecorator */
		
		public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void
		{
			comp = c;
			graphics = g;
			bounds = b;
			backgroundShape.graphics.clear();
			//backgroundSprite.mouseChildren = true;
			//backgroundSprite.mouseEnabled = false;
			
			var g2d:Graphics2D = new Graphics2D(backgroundShape.graphics);
			
			if (image)
				g2d.beginFill(new BitmapBrush(image));
			else
				g2d.beginFill(new SolidBrush(color));
			
			if (radius != 0)
			{
				var trR:Number = topRightRadius == -1 ? radius : topRightRadius;
				var blR:Number = bottomLeftRadius == -1 ? radius : bottomLeftRadius;
				var brR:Number = bottomRightRadius == -1 ? radius : bottomRightRadius;
				
				if(radius < 10)
				g2d.drawRoundRect(new Pen(borderColor, 0, true, "none", CapsStyle.ROUND, JointStyle.ROUND, 9), b.x + leftGap, b.y + topGap, b.width + rightGap, b.height + bottomGap, radius, trR, blR, brR-0.3);
				else
				g2d.drawCircle(new Pen(borderColor, 0), b.x + leftGap, b.y + topGap, /*b.width + rightGap, b.height + bottomGap,*/ radius);
				
				if (openingRect)
					g2d.drawRectangle(new Pen((internalBorderColor || new ASColor(0, 0)), 0), openingRect.x, openingRect.y, openingRect.width, openingRect.height);
				
			}
			else
			{
				g2d.drawRectangle(new Pen(borderColor, 0), b.x + leftGap, b.y + topGap, b.width + rightGap, b.height + bottomGap);
				if (openingRect)
					g2d.drawRectangle(new Pen((internalBorderColor || new ASColor(0, 0)), 0), openingRect.x, openingRect.y, openingRect.width, openingRect.height);
			}
			
			g2d.endDraw();
			g2d.endFill();
			
			
			// отрисовать текстуру в спрайте
			/*var bmd:BitmapData = new BitmapData(drawingSprite.width, drawingSprite.height, true, 0x00000000);
			bmd.draw(drawingSprite);
			var tex:Texture = Texture.fromBitmapData(bmd);
			var img:Image = new Image(tex);
			backgroundShape.addChild(img);*/
		}
		
		public function getDisplay(c:Component):DisplayObject
		{
			return backgroundShape;
		}
	
	}

}
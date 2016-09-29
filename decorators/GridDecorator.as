package org.aswing.decorators
{
	import starling.display.Shape;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.BitmapBrush;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.GroundDecorator;
	
	/**
	 * ColorDecorator
	 * @author DEVORON
	 */
	public class GridDecorator implements GroundDecorator
	{
		private var gridColor:ASColor;
		public var radius:Number;
		protected var topRightRadius:Number = -1;
		protected var bottomLeftRadius:Number = -1;
		protected var bottomRightRadius:Number = -1;
		public var bgColor:ASColor;
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
		
		public function GridDecorator(gridColor:ASColor, bgColor:ASColor = null, borderColor:ASColor = null, radius:Number = 0)
		{
			this.gridColor = gridColor;
			this.radius = radius;
			this.borderColor = borderColor ? borderColor : new ASColor(0, 0);
			this.bgColor = bgColor;
			backgroundShape = new Sprite();
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
		
		public function setGaps(rightGap:int = 0, leftGap:int = 0, topGap:int = 0, bottomGap:int = 0):void
		{
			this.bottomGap = bottomGap;
			this.topGap = topGap;
			this.leftGap = leftGap;
			this.rightGap = rightGap;
		}
		
		public function clone():ColorDecorator
		{
			var decorator:ColorDecorator = new ColorDecorator(bgColor, borderColor, radius);
			decorator.setGaps(rightGap, leftGap, topGap, bottomGap);
			if (image)
				decorator.setImage(image.clone());
			return decorator;
		}
		
		public function getColor():ASColor
		{
			return bgColor;
		}
		
		public function setColor(value:ASColor):void
		{
			bgColor = value;
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
			backgroundShape.graphics.clear();
			/*backgroundSprite.mouseChildren = true;
			backgroundSprite.mouseEnabled = false;*/
			
			var g2d:Graphics2D = new Graphics2D(backgroundShape.graphics);
			
			var pen:Pen = new Pen(gridColor, 0.7);
			
			if (bgColor)
				g2d.beginFill(new SolidBrush(bgColor));
			
				var hOffset:Number = 20;
				var vOffset:Number = 20;
				
			for (var i:int = 0; i < 100; i++)
			{
				// vertical lines
				g2d.moveTo(i * 20, 0);
				g2d.drawLine(pen, i * vOffset, 0, i * vOffset, b.height);
				
				// horizontal lines
				g2d.moveTo(i * 20, 0);
				g2d.drawLine(pen, 0, i * hOffset, b.width, i * hOffset);
				
			}
			
			g2d.endDraw();
		
		/*if (radius != 0)
		   {
		   var trR:Number = topRightRadius == -1 ? radius : topRightRadius;
		   var blR:Number = bottomLeftRadius == -1 ? radius : bottomLeftRadius;
		   var brR:Number = bottomRightRadius == -1 ? radius : bottomRightRadius;
		   g2d.drawRoundRect(new Pen(borderColor, 0), b.x + leftGap, b.y + topGap, b.width + rightGap, b.height + bottomGap, radius, trR, blR, brR);
		
		   if (openingRect)
		   g2d.drawRectangle(new Pen( (internalBorderColor || new ASColor(0,0)), 0), openingRect.x, openingRect.y, openingRect.width, openingRect.height);
		
		   }
		   else
		 {*/ /*g2d.drawRectangle(new Pen(borderColor, 0), b.x + leftGap, b.y + topGap, b.width + rightGap, b.height + bottomGap);
		   if (openingRect)
		 g2d.drawRectangle(new Pen((internalBorderColor || new ASColor(0, 0)), 0), openingRect.x, openingRect.y, openingRect.width, openingRect.height);*/
			 //}
		
			//g2d.endDraw();
			//g2d.endFill();
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
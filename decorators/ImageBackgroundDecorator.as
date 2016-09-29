package devoron.aswing3d.decorators
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.DisplayObject;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.sampler.NewObjectSample;
	import org.aswing.ASColor;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.BitmapBrush;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.Component;
	import org.aswing.graphics.Pen;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.GroundDecorator;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author DEVORON
	 */
	public class ImageBackgroundDecorator implements GroundDecorator
	{
		protected var color:ASColor;
		private var backgroundSprite:Sprite;
		private var c:Component;
		private var g:Graphics2D;
		private var b:IntRectangle;
		private var borderColor:ASColor;
		private var rightGap:int;
		private var leftGap:int;
		private var topGap:int;
		private var bottomGap:int;
		private var radius:Number;
		
		//[Embed(source="D:/a.png")]
		//private var BMClass:Class;
		
		public function ImageBackgroundDecorator(color:ASColor, borderColor:ASColor = null, rightGap:int = 0, leftGap:int = 0, topGap:int = 0, bottomGap:int = 0, radius:Number = 0)
		{
			this.radius = radius;
			this.bottomGap = bottomGap;
			this.topGap = topGap;
			this.leftGap = leftGap;
			this.rightGap = rightGap;
			this.borderColor = borderColor ? borderColor : new ASColor(0, 0);
			this.color = color;
			backgroundSprite = new Sprite();
		}
		
		public function getColor():ASColor
		{
			return color;
		}
		
		public function setColor(value:ASColor):void
		{
			color = value;
			if (c)
				updateDecorator(c, g, b);
		}
		
		/* INTERFACE devoron.aswing3d.GroundDecorator */
		
		public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void
		{
			this.b = b;
			this.g = g;
			this.c = c;
			backgroundSprite.removeChildren();
		/*	backgroundSprite.graphics.clear();
			backgroundSprite.mouseChildren = true;
			backgroundSprite.mouseEnabled = false;*/
			
			var drawingSprite:flash.display.Sprite = new flash.display.Sprite();
			var g2d:Graphics2D = new Graphics2D(drawingSprite.graphics);
			g2d.beginFill(new SolidBrush(color));
			
			if (radius != 0)
				g2d.drawRoundRect(new Pen(borderColor, 0), b.x + leftGap, b.y + topGap, b.width + rightGap, b.height + bottomGap, radius);
			else
				g2d.drawRectangle(new Pen(borderColor, 0), b.x + leftGap, b.y + topGap, b.width + rightGap, b.height + bottomGap);
			
			g2d.endDraw();
			g2d.endFill();
			
			// отрисовать текстуру в спрайте
			var bmd:BitmapData = new BitmapData(drawingSprite.width, drawingSprite.height, true, 0x00000000);
			bmd.draw(drawingSprite);
			var tex:Texture = Texture.fromBitmapData(bmd);
			var img:Image = new Image(tex);
			backgroundSprite.addChild(img);
		}
		
		public function getDisplay(c:Component):DisplayObject
		{
			return backgroundSprite;
		}
	
	}

}
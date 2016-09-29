package devoron.aswing3d.decorators 
{
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.BitmapBrush;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	import org.aswing.graphics.SolidBrush;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author DEVORON
	 */
	public class SideLineDecorator extends ColorDecorator
	{
		protected var side:int;
		 public static const NORTH:int  = 0;

    /**
     * The south side constraint (bottom of component).
     */
    public static const SOUTH:int  = 1;

    /**
     * The east side constraint (right side of component).
     */
    public static const EAST :int  = 2;

    /**
     * The west side constraint (left side of component).
     */
    public static const WEST :int  = 3;
	
	
		public function SideLineDecorator(color:ASColor, borderColor:ASColor = null, radius:Number = 0, side:int=-1)
		{
			super(color, borderColor, radius);
			this.side = side;
		}
		
		public override function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void
		{
			comp = c;
			graphics = g;
			bounds = b;
			backgroundShape.graphics.clear();
			/*backgroundSprite.mouseChildren = true;
			backgroundSprite.mouseEnabled = false;*/
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
				//g2d.drawRectangle(new Pen(borderColor, 0), b.x + leftGap, b.y + topGap, b.width + rightGap, b.height + bottomGap);
				//side.
				//g2d.
				g2d.drawLine(new Pen(borderColor, 1), b.x + leftGap, b.y + b.height+ bottomGap, b.width + rightGap, b.y + b.height + bottomGap);
				
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
		
	}

}
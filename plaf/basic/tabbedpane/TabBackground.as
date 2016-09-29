package devoron.aswing3d.plaf.basic.tabbedpane{

import flash.display.DisplayObject;
import flash.display.Shape;

import devoron.aswing3d.ASColor;
import org.aswing3d.AbstractButton;
import devoron.aswing3d.ButtonModel;
import devoron.aswing3d.Component;
import org.aswing3d.GroundDecorator;
import devoron.aswing3d.JTabbedPane;
import devoron.aswing3d.StyleResult;
import devoron.aswing3d.StyleTune;
import devoron.aswing3d.geom.IntRectangle;
import devoron.aswing3d.graphics.Graphics2D;
import devoron.aswing3d.graphics.SolidBrush;
import devoron.aswing3d.plaf.UIResource;
import devoron.aswing3d.plaf.basic.BasicGraphicsUtils;

public class TabBackground implements GroundDecorator, UIResource{
	
	protected var shape:Shape;
	protected var tab:Tab;
	
	public function TabBackground(tab:Tab){
		this.tab = tab;
		shape = new Shape();
	}

	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void{
		shape.graphics.clear();
		var btn:AbstractButton = c as AbstractButton;
		if(btn){
			var model:ButtonModel = btn.getModel();
			var isPressing:Boolean = model.isPressed() || model.isSelected();
			g = new Graphics2D(shape.graphics);
			var cl:ASColor = c.getMideground();
			var style:StyleResult;
			var adjuster:StyleTune = c.getStyleTune().mide.clone();
			if(!c.isEnabled()){
				adjuster = adjuster.sharpen(0.4);
			}else if(isPressing){
				cl = cl.offsetHLS(0, 0.08, 0);
			}else if(model.isRollOver()){
				cl = cl.offsetHLS(-0.2, 0, 0.37);
				//cl = cl.offsetHLS(0, 0.08, 0);
			}
			style = new StyleResult(cl, adjuster);
			if(isPressing){
				style.cdark = style.cdark.changeAlpha(0);
			}
			var direction:Number = Math.PI/2;
			var matrixB:IntRectangle = b.clone();
			b = b.clone();
			
			var placement:int = tab.getTabPlacement();
			var highlightBrush:SolidBrush = new SolidBrush(style.clight.offsetHLS(0, 0.14, 0.1));
			if(placement == JTabbedPane.TOP){
				direction = Math.PI/2;
				b.height += style.round*2;
				BasicGraphicsUtils.fillGradientRoundRect(g, b, style, direction, false, matrixB);
				BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, style, direction, true, matrixB);
				if(b.width - style.round*2 > 0){
					g.fillRectangle(highlightBrush, b.x+style.round, b.y+1, b.width - style.round*2, 1);
				}
			}else if(placement == JTabbedPane.BOTTOM){
				direction = -Math.PI/2;
				b.height += style.round*2;
				b.y -= style.round*2;
				BasicGraphicsUtils.fillGradientRoundRect(g, b, style, direction, false, matrixB);
				BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, style, direction, true, matrixB);
				if(b.width - style.round*2 > 0){
					g.fillRectangle(highlightBrush, b.x+style.round, b.y+b.height-2, b.width - style.round*2, 1);
				}
			}else if(placement == JTabbedPane.LEFT){
				direction = 0;
				b.width += style.round*2;
				BasicGraphicsUtils.fillGradientRoundRect(g, b, style, direction, false, matrixB);
				BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, style, direction, true, matrixB);
				if(b.height - style.round*2 > 0){
					g.fillRectangle(highlightBrush, 
						b.x+1, b.y+style.round, 1, b.height - style.round*2);
				}
			}else{//right				
				direction = Math.PI;
				b.width += style.round*2;
				b.x -= style.round*2;
				BasicGraphicsUtils.fillGradientRoundRect(g, b, style, direction, false, matrixB);
				BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, style, direction, true, matrixB);
				if(b.height - style.round*2 > 0){
					g.fillRectangle(highlightBrush, 
						b.x+b.width-2, b.y+style.round, 1, b.height - style.round*2);
				}
			}
		}
	}
	
}
}
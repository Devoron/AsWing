/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.plaf.basic.background{
import starling.display.DisplayObject;
import starling.display.Graphics;
import starling.display.Shape;

import flash.filters.BevelFilter;
import flash.filters.BitmapFilterType;
import flash.geom.Matrix;

import devoron.aswing3d.ASColor;
import devoron.aswing3d.Component;
import org.aswing3d.GroundDecorator;
import devoron.aswing3d.StyleResult;
import devoron.aswing3d.StyleTune;
import devoron.aswing3d.geom.IntRectangle;
import devoron.aswing3d.graphics.GradientBrush;
import devoron.aswing3d.graphics.Graphics2D;
import devoron.aswing3d.plaf.UIResource;
import devoron.aswing3d.plaf.basic.BasicGraphicsUtils;

/**
 * @private
 */
public class TableHeaderBackground implements GroundDecorator, UIResource{
	
	protected var shape:Shape;
	
	public function TableHeaderBackground(){
		shape = new Shape();
	}

	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void{
		//shape.graphics.clear();
		if(c.isOpaque()){
			g = new Graphics2D(new Graphics(shape));
			var cl:ASColor = c.getBackground();
			var turn:StyleTune = c.getStyleTune();
			var style:StyleResult = new StyleResult(cl, turn);
			var matrixB:IntRectangle = b.clone();
			var graphicB:IntRectangle = b.clone();
			graphicB.height += style.round*2;
			BasicGraphicsUtils.fillGradientRoundRect(g, graphicB, style, Math.PI/2, false, matrixB);

			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(b.width, b.height, Math.PI/2, b.x, b.y);
			g.fillRoundRect(new GradientBrush(
					GradientBrush.LINEAR, 
					[0xFFFFFF, 0xFFFFFF], 
					[0.2, 0.04], 
					[0, 255], 
					matrix
				), 
				b.x, b.y, b.width, b.height/2-1, style.round, style.round, 0, 0);
			//shape.filters = [new BevelFilter(1, 90, 0xFFFFFF, style.shadow, 0x0, style.shadow, 1, 1, 1, 1, BitmapFilterType.INNER)];
			//EmbossFilter
		}
		shape.visible = c.isOpaque();
	}
	
}
}
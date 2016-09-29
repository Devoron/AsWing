/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.skinbuilder{

import devoron.aswing3d.graphics.Graphics2D;
import org.aswing3d.GroundDecorator;
import devoron.aswing3d.geom.IntRectangle;
import devoron.aswing3d.Component;
import flash.display.DisplayObject;
import devoron.aswing3d.plaf.UIResource;

public class SkinTableHeaderSortableCellBackground extends SelfHandleStateDecorator{
	
	override protected function getPropertyPrefix():String{
		return "TableHeader.cell.";
	}
	
}
}
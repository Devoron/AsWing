/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.plaf.basic.border{
	
import devoron.aswing3d.ASColor;
import devoron.aswing3d.border.LineBorder;
import devoron.aswing3d.plaf.UIResource;
import devoron.aswing3d.Component;
import devoron.aswing3d.graphics.Graphics2D;
import devoron.aswing3d.geom.IntRectangle;

/**
 * @private
 */
public class ToolTipBorder extends LineBorder implements UIResource
{
	private var color:ASColor;
	
	public function ToolTipBorder()
	{
		super();
	}
	
	override public function updateBorderImp(c:Component, g:Graphics2D, b:IntRectangle):void
	{
		if(color == null){
			color = c.getUI().getColor("ToolTip.borderColor");
			setColor(color);
		}
		super.updateBorderImp(c, g, b);
	}
}
}
/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.plaf.basic.border
{
	
import devoron.aswing3d.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.graphics.*;
import org.aswing.plaf.*;

/**
 * Discard in aswing 2.0(Background raped his job)
 * @private
 */
public class ProgressBarBorder extends LineBorder implements UIResource
{
	private var color:ASColor;
	public function ProgressBarBorder(){
		super();
	}
	
	override public function updateBorderImp(c:Component, g:Graphics2D, b:IntRectangle):void
	{
		if(color == null){
			color = c.getUI().getColor("ProgressBar.foreground");
			setColor(color);
		}
		super.updateBorderImp(c, g, b);
	}
}
}
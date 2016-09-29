/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.skinbuilder{

import devoron.aswing3d.AssetBackground;
import flash.display.DisplayObject;
import devoron.aswing3d.plaf.UIResource;

public class SkinToolTipBackground extends SinglePicBackground{
	
	public function SkinToolTipBackground(){
		super();
	}
	
	override protected function getDefaltsKey():String{
		return "ToolTip.bgImage";
	}
}
}
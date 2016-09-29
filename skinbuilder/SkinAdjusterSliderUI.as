/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.skinbuilder{

import devoron.aswing3d.*;

public class SkinAdjusterSliderUI extends SkinSliderUI{
	
	public function SkinAdjusterSliderUI(){
		super();
	}
	
	override protected function getPropertyPrefix():String{
		return "Adjuster.Slider.";
	}
}
}
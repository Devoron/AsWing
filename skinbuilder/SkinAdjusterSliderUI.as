/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{


public class SkinAdjusterSliderUI extends SkinSliderUI{
	
	public function SkinAdjusterSliderUI(){
		super();
	}
	
	override protected function getPropertyPrefix():String{
		return "Adjuster.Slider.";
	}
}
}
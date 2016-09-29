/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.skinbuilder{

public class SkinToggleButtonBackground extends SkinButtonBackground{
	
	public function SkinToggleButtonBackground(){
		super();
	}
	
	override protected function getPropertyPrefix():String {
        return "ToggleButton.";
    }
}
}
/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.skinbuilder{

public class SkinCheckBoxIcon extends SkinButtonIcon{
	
	public function SkinCheckBoxIcon(){
		super();
	}
	
	override protected function getPropertyPrefix():String {
        return "CheckBox.";
    }
}
}
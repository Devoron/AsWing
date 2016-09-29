/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.skinbuilder{
	
import devoron.aswing3d.*;

public class SkinComboBoxBackground extends SkinAbsEditorRolloverEnabledBackground{
	
	public function SkinComboBoxBackground(){
		super();
	}
	
	override protected function getPropertyPrefix():String {
        return "ComboBox.";
    }
}
}
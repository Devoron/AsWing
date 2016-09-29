/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.skinbuilder{

public class SkinTextAreaBackground extends SkinAbsEditorBackground{
	
	public function SkinTextAreaBackground(){
		super();
	}
	
	override protected function getPropertyPrefix():String {
        return "TextArea.";
    }
}
}
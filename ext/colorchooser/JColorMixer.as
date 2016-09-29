/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.colorchooser { 
import devoron.aswing3d.colorchooser.AbstractColorChooserPanel;
import devoron.aswing3d.UIManager;
import devoron.aswing3d.plaf.basic.BasicColorMixerUI;

/**
 * @author iiley
 */
public class JColorMixer extends AbstractColorChooserPanel {
	
	public function JColorMixer() {
		super();
		updateUI();
	}
	
	override public function updateUI():void{
		setUI(UIManager.getUI(this));
	}
	
	override public function getUIClassID():String{
		return "ColorMixerUI";
	}
	
    override public function getDefaultBasicUIClass():Class{
    	return devoron.aswing3d.plaf.basic.BasicColorMixerUI;
    }

}
}
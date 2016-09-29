/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.colorchooser {

import devoron.aswing3d.*;
import devoron.aswing3d.plaf.ColorSwatchesUI;
import devoron.aswing3d.plaf.basic.BasicColorSwatchesUI;

/**
 * @author iiley
 */
public class JColorSwatches extends AbstractColorChooserPanel {
		
	public function JColorSwatches() {
		super();
		updateUI();
	}
	
	override public function updateUI():void{
		setUI(UIManager.getUI(this));
	}
	
    override public function getDefaultBasicUIClass():Class{
    	return devoron.aswing3d.plaf.basic.BasicColorSwatchesUI;
    }
	
	override public function getUIClassID():String{
		return "ColorSwatchesUI";
	}
	
	/**
	 * Adds a component to this panel's sections bar
	 * @param com the component to be added
	 */
	public function addComponentColorSectionBar(com:Component):void{
		ColorSwatchesUI(getUI()).addComponentColorSectionBar(com);
	}
}
}
/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.plaf{

import devoron.aswing3d.*;
import devoron.aswing3d.plaf.ComponentUI;

/**
 * Pluginable ui for JAdjuster.
 * @see devoron.aswing3d.JAdjuster
 * @author iiley
 */
public interface AdjusterUI extends ComponentUI{
	
	function getInputText():JTextField;
	
	function getPopupSlider():JSlider;
}
}
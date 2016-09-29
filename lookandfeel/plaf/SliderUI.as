/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.lookandfeel.plaf{

import org.aswing.ComponentUI;
import org.aswing.Insets;

/**
 * Pluginable ui for Slider.
 * @see devoron.aswing3d.JSlider
 * @author iiley
 */
public interface SliderUI extends ComponentUI{
	
	function getTrackMargin():Insets;
	
}
}
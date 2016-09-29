/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.plaf{

import org.aswing3d.Insets;

/**
 * Pluginable ui for Slider.
 * @see devoron.aswing3d.JSlider
 * @author iiley
 */
public interface SliderUI extends ComponentUI{
	
	function getTrackMargin():Insets;
	
}
}
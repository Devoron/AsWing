/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.plaf{

import org.aswing3d.JComboBox;

/**
 * Pluginable ui for JComboBox.
 * @see devoron.aswing3d.JComboBox
 * @author iiley
 */
public interface ComboBoxUI extends ComponentUI{

	/**
     * Set the visiblity of the popup
     */
	function setPopupVisible(c:JComboBox, v:Boolean):void;
	
	/**
     * Determine the visibility of the popup
     */
	function isPopupVisible(c:JComboBox):Boolean;
}
}
/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.plaf.basic{
	
import devoron.aswing3d.*;
import devoron.aswing3d.graphics.Graphics2D;
import devoron.aswing3d.geom.IntRectangle;
import devoron.aswing3d.geom.IntDimension;
import devoron.aswing3d.plaf.*;	
import org.aswing.AbstractButton;
import org.aswing.Icon;
	
/**
 * Basic ToggleButton implementation.
 * @author iiley
 * @private
 */	
public class BasicToggleButtonUI extends BasicButtonUI{
	
	public function BasicToggleButtonUI(){
		super();
	}
	
    override protected function getPropertyPrefix():String {
        return "ToggleButton.";
    }
        
    override protected function paintIcon(b:AbstractButton, g:Graphics2D, iconRect:IntRectangle):void {
		var model:ButtonModel = b.getModel();
		var icon:Icon = null;
        
        var icons:Array = getIcons();
        for(var i:int=0; i<icons.length; i++){
        	var ico:Icon = icons[i];
			setIconVisible(ico, false);
        }
        
        if(!model.isEnabled()) {
			if(model.isSelected()) {
				icon = b.getDisabledSelectedIcon();
			} else {
				icon = b.getDisabledIcon();
			}
		} else if(model.isPressed() && model.isArmed()) {
			icon = b.getPressedIcon();
			if(icon == null) {
				// Use selected icon
				icon = b.getSelectedIcon();
			} 
		} else if(model.isSelected()) {
			if(b.isRollOverEnabled() && model.isRollOver()) {
				icon = b.getRollOverSelectedIcon();
				if (icon == null) {
					icon = b.getSelectedIcon();
				}
			} else {
				icon = b.getSelectedIcon();
			}
		} else if(b.isRollOverEnabled() && model.isRollOver()) {
			icon = b.getRollOverIcon();
		} 
        
		if(icon == null) {
			icon = b.getIcon();
		}
		if(icon == null){
			icon = getIconToLayout();
		}
        if(icon != null){
			setIconVisible(icon, true);
			icon.updateIcon(b, g, iconRect.x, iconRect.y);
        }
    }
}

}
/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.skinbuilder{

import flash.display.*;
import org.aswing.AbstractButton;
import org.aswing.GroundDecorator;
import org.aswing.JButton;

import devoron.aswing3d.*;
import devoron.aswing3d.geom.*;
import devoron.aswing3d.graphics.Graphics2D;
import devoron.aswing3d.plaf.*;
import devoron.aswing3d.plaf.basic.*;

public class SkinButtonBackground extends DefaultsDecoratorBase implements GroundDecorator, UIResource{
	
    protected var stateAsset:ButtonStateObject;
    protected var setuped:Boolean;
    protected var fixedPrefix:String;
    
	public function SkinButtonBackground(fixedPrefix:String=null){
		setuped = false;
		this.fixedPrefix = fixedPrefix;
		stateAsset = new ButtonStateObject();
	}
	
	public function getStateAsset():ButtonStateObject{
		return stateAsset;
	}
	
    protected function getPropertyPrefix():String {
    	if(fixedPrefix != null){
    		return fixedPrefix;
    	}
        return "Button.";
    }
	
	protected function setupAssets(ui:ComponentUI):void{
		stateAsset.setDefaultButtonImage(getAsset(ui, "DefaultButton.defaultImage"));
		stateAsset.setDefaultImage(getAsset(ui, "defaultImage"));
		stateAsset.setPressedImage(getAsset(ui, "pressedImage"));
		stateAsset.setPressedSelectedImage(getAsset(ui, "pressedSelectedImage"));
		stateAsset.setDisabledImage(getAsset(ui, "disabledImage"));
		stateAsset.setSelectedImage(getAsset(ui, "selectedImage"));
		stateAsset.setDisabledSelectedImage(getAsset(ui, "disabledSelectedImage"));
		stateAsset.setRolloverImage(getAsset(ui, "rolloverImage"));
		stateAsset.setRolloverSelectedImage(getAsset(ui, "rolloverSelectedImage"));
	}
	
	private function getAsset(ui:ComponentUI, extName:String):DisplayObject{
        var pp:String = getPropertyPrefix();
        return ui.getInstance(pp+extName) as DisplayObject;
	}
 	
 	public function getDisplay(c:Component):DisplayObject{
 		return stateAsset;
 	}
 	
 	public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):void{
 		if(!setuped){
 			setupAssets(getDefaultsOwner(c));
 			setuped = true;
 		}
 		
 		var button:AbstractButton = AbstractButton(c);
 		var model:ButtonModel = button.getModel();
 		stateAsset.setEnabled(model.isEnabled());
 		stateAsset.setPressed(model.isPressed() && model.isArmed());
 		stateAsset.setSelected(model.isSelected());
 		stateAsset.setRollovered(button.isRollOverEnabled() && model.isRollOver());
 		stateAsset.setDefaultButton(button is JButton && JButton(button).isDefaultButton());
 		stateAsset.updateRepresent(bounds);
 	}
}
}
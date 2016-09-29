/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.plaf.basic.border{

import devoron.aswing3d.Border;
import devoron.aswing3d.ASColor;
import devoron.aswing3d.border.BevelBorder;
import devoron.aswing3d.plaf.UIResource;
import devoron.aswing3d.Component;
import org.aswing3d.EditableComponent;
import devoron.aswing3d.graphics.Graphics2D;
import devoron.aswing3d.geom.IntRectangle;

/**
 * Discard in aswing 2.0(Background raped his job)
 * @private
 */
public class ComboBoxBorder extends BevelBorder implements UIResource{
	
	private var colorInited:Boolean;
	
	public function ComboBoxBorder(){
		super(null, BevelBorder.LOWERED);
		colorInited = false;
	}

	override public function updateBorderImp(c:Component, g:Graphics2D, b:IntRectangle):void{
		if(!colorInited){
			setHighlightOuterColor(c.getUI().getColor("ComboBox.light"));
			setHighlightInnerColor(c.getUI().getColor("ComboBox.highlight"));
			setShadowOuterColor(c.getUI().getColor("ComboBox.darkShadow"));
			setShadowInnerColor(c.getUI().getColor("ComboBox.shadow"));
		}
        
    	var box:EditableComponent = c as EditableComponent;
    	if(box != null){
	    	if(box.isEditable()){
	    		setBevelType(LOWERED);
	    	}else{
	    		setBevelType(RAISED);
	    	}
    	}
    	super.updateBorderImp(c, g, b);
    }	
	
}
}
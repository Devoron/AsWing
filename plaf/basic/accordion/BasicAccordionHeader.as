/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.plaf.basic.accordion{

import devoron.aswing3d.*;
import devoron.aswing3d.geom.IntRectangle;
import devoron.aswing3d.plaf.basic.tabbedpane.Tab;
import org.aswing.AbstractButton;
import org.aswing.ASFont;
import org.aswing.Icon;
import org.aswing.Insets;
import org.aswing.JButton;
	
/**
 * BasicAccordionHeader implemented with a JButton 
 * @author iiley
 * @private
 */
public class BasicAccordionHeader implements Tab{
	
	protected var button:AbstractButton;
	protected var owner:Component;
	protected var placement:int;
	
	public function BasicAccordionHeader(){
	}
	
	public function initTab(owner:Component):void{
		this.owner = owner;
		button = createHeaderButton();
	}
	
	public function setComBounds(b:IntRectangle):void{
		button.setComBounds(b);
	}
	
	public function setTabPlacement(tp:int):void{	
		placement = tp;
	}
	
	public function getTabPlacement():int{
		return placement;
	}
	
	protected function createHeaderButton():AbstractButton{
		return new JButton();
	}
	
	public function setTextAndIcon(text : String, icon : Icon) : void {
		button.setText(text);
		button.setIcon(icon);
	}
	
	public function setFont(font:ASFont):void{
		button.setFont(font);
	}
	
	public function setForeground(color:ASColor):void{
		button.setForeground(color);
	}
	
	public function setSelected(b:Boolean):void{
		//Do nothing here, if your header is selectable, you can set it here like
		//button.setSelected(b);
	}
	
    public function setVerticalAlignment(alignment:int):void {
    	button.setVerticalAlignment(alignment);
    }
    public function setHorizontalAlignment(alignment:int):void {
    	button.setHorizontalAlignment(alignment);
    }
    public function setVerticalTextPosition(textPosition:int):void {
    	button.setVerticalTextPosition(textPosition);
    }
    public function setHorizontalTextPosition(textPosition:int):void {
    	button.setHorizontalTextPosition(textPosition);
    }
    public function setIconTextGap(iconTextGap:int):void {
    	button.setIconTextGap(iconTextGap);
    }
    public function setMargin(m:Insets):void{
    	button.setMargin(m);
    }

	public function getTabComponent() : Component {
		return button;
	}

}
}
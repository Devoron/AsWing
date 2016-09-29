/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.plaf.basic{
	
import org.aswing.plaf.BaseComponentUI;
import devoron.aswing3d.*;
import org.aswing.graphics.*;
import org.aswing.geom.*;
import org.aswing.error.ImpMissError;

/**
 * The base class for text component UIs.
 * @author iiley
 * @private
 */
public class BasicTextComponentUI extends BaseComponentUI{
	
	protected var textComponent:JTextComponent;
	
	public function BasicTextComponentUI(){
		super();
	}

    protected function getPropertyPrefix():String {
    	throw new ImpMissError();
        return "";
    }
    
    override public function paint(c:Component, g:Graphics2D, r:IntRectangle):void{
    	super.paint(c, g, r);
    }
    
    override protected function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):void{
		//do not paint anything, the background decorator will paint
	}
    
	override public function installUI(c:Component):void{
		textComponent = JTextComponent(c);
		installDefaults();
		installComponents();
		installListeners();
	}
    
	override public function uninstallUI(c:Component):void{
		textComponent = JTextComponent(c);
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
 	}
	
	override public function getColor(key:String):ASColor 
	{
		switch(key) {
			case "TextField.background":
				return new ASColor(0xFAFCF8, 0.01);
			break;
			case "TextField.foreground":
				return new ASColor(0xE1E2D6, 0.4);
			break;
			case "TextField.mideground":
				return new ASColor(0x000000, 0.24);
			break;
		}
		return super.getColor(key);
	}
 	
 	protected function installDefaults():void{
        var pp:String = getPropertyPrefix();
        LookAndFeel.installColorsAndFont(textComponent, pp);
        LookAndFeel.installBorderAndBFDecorators(textComponent, pp);
        LookAndFeel.installBasicProperties(textComponent, pp);
 	}
	
 	protected function uninstallDefaults():void{
 		LookAndFeel.uninstallBorderAndBFDecorators(textComponent);
 	}
 	
 	protected function installComponents():void{
 	}
	
 	protected function uninstallComponents():void{
 	}
 	
 	protected function installListeners():void{
 	}
	
 	protected function uninstallListeners():void{
 	}
	
	override public function getMaximumSize(c:Component):IntDimension
	{
		return IntDimension.createBigDimension();
	}
	override public function getMinimumSize(c:Component):IntDimension
	{
		return c.getInsets().getOutsideSize();
	}    
}
}
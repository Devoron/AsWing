/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.plaf.basic{
	
import devoron.aswing3d.*;
import org.aswing.event.InteractiveEvent;
import org.aswing.geom.*;
import org.aswing.graphics.*;
import org.aswing.plaf.*;
import org.aswing.util.DepthManager;
import org.aswing.GroundDecorator;
import starling.text.TextField;

/**
 * @private
 */
public class BasicProgressBarUI extends BaseComponentUI{
	
	protected var iconDecorator:GroundDecorator;
	protected var stringText:TextField;
	protected var stateListener:Object;
	protected var progressBar:JProgressBar;
	protected var barSize:int;
	
	public function BasicProgressBarUI() {
		super();
		barSize = 12;//default
	}

    protected function getPropertyPrefix():String {
        return "ProgressBar.";
    }    	

	override public function installUI(c:Component):void{
		progressBar = JProgressBar(c);
		installDefaults();
		installComponents();
		installListeners();
	}
	
	override public function uninstallUI(c:Component):void{
		progressBar = JProgressBar(c);		
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
	}
	
	protected function installDefaults():void{
		var pp:String = getPropertyPrefix();
		LookAndFeel.installColorsAndFont(progressBar, pp);
		LookAndFeel.installBasicProperties(progressBar, pp);
		LookAndFeel.installBorderAndBFDecorators(progressBar, pp);
		
		barSize = getInt(pp+"barWidth");
		if(barSize == -1) barSize = 1000;
		if(!progressBar.isIndeterminateDelaySet()){
			progressBar.setIndeterminateDelay(getUint(pp + "indeterminateDelay"));
			progressBar.setIndeterminateDelaySet(false);
		}
	}
	
	protected function uninstallDefaults():void{
		LookAndFeel.uninstallBorderAndBFDecorators(progressBar);
	}
	
	protected function installComponents():void{
		stringText = new TextField();
		stringText.autoSize = TextFieldAutoSize.CENTER;
		stringText.mouseEnabled = false;
		stringText.tabEnabled = false;
		stringText.selectable = false;
		progressBar.addChild(stringText);
	}
	
	protected function uninstallComponents():void{
		if(stringText.parent != null) {
    		stringText.parent.removeChild(stringText);
		}
		stringText = null;
		iconDecorator = null;
	}
	
	protected function installListeners():void{
		progressBar.addEventListener(InteractiveEvent.STATE_CHANGED, __stateChanged);
	}
	protected function uninstallListeners():void{
		progressBar.removeEventListener(InteractiveEvent.STATE_CHANGED, __stateChanged);
	}
	
	protected function __stateChanged(source:JProgressBar):void{
		source.repaint();
	}
	
    override public function paint(c:Component, g:Graphics2D, b:IntRectangle):void{
		super.paint(c, g, b);
		var sp:JProgressBar = JProgressBar(c);
		if(sp.getString() != null && sp.getString().length>0){
			stringText.text = sp.getString();
	    	AsWingUtils.applyTextFontAndColor(stringText, sp.getFont(), sp.getForeground());
			
			if (sp.getOrientation() == JProgressBar.VERTICAL){
				//TODO use bitmap to achieve rotate
				stringText.rotation = -90;
				stringText.x = Math.round(b.x + (b.width - stringText.width)/2);
				stringText.y = Math.round(b.y + (b.height - stringText.height)/2 + stringText.height);
			}else{
				stringText.rotation = 0;
				stringText.x = Math.round(b.x + (b.width - stringText.width)/2);
				stringText.y = Math.round(b.y + (b.height - stringText.height)/2);
			}
			DepthManager.bringToTop(stringText);
		}else{
			stringText.text = "";
		}
	}
	
    override protected function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):void{
    	//do nothing, background decorator will paint it
    }	

    //--------------------------Dimensions----------------------------
    
	override public function getPreferredSize(c:Component):IntDimension{
		var sp:JProgressBar = JProgressBar(c);
		var size:IntDimension;
		if (sp.getOrientation() == JProgressBar.VERTICAL){
			size = getPreferredInnerVertical();
		}else{
			size = getPreferredInnerHorizontal();
		}
		
		if(sp.getString() != null){
			var textSize:IntDimension = c.getFont().computeTextSize(sp.getString(), false);
			if (sp.getOrientation() == JProgressBar.VERTICAL){
				size.width = Math.max(size.width, textSize.height);
				size.height = Math.max(size.height, textSize.width);
			}else{
				size.width = Math.max(size.width, textSize.width);
				size.height = Math.max(size.height, textSize.height);
			}
		}
		return sp.getInsets().getOutsideSize(size);
	}
    override public function getMaximumSize(c:Component):IntDimension{
		return IntDimension.createBigDimension();
    }
    override public function getMinimumSize(c:Component):IntDimension{
		return c.getInsets().getOutsideSize(new IntDimension(1, 1));
    }
    
    protected function getPreferredInnerHorizontal():IntDimension{
    	return new IntDimension(80, barSize);
    }
    protected function getPreferredInnerVertical():IntDimension{
    	return new IntDimension(barSize, 80);
    }	
	
}
}
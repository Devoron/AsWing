/*
   Copyright aswing.org, see the LICENCE.txt.
 */

package devoron.aswing3d.plaf.basic
{
	import org.aswing.AlternativeScrollPane;
	import org.aswing.lookandfeel.plaf.BaseComponentUI;
	import devoron.aswing3d.*;
	import org.aswing.event.*;
	import org.aswing.geom.*;
	import org.aswing.plaf.basic.icon.ArrowIcon;
	import org.aswing.Insets;
	import org.aswing.JButton;
	
	/**
	 * The basic scroll pane ui imp.
	 * @author iiley
	 * @private
	 */
	public class AlternativeScrollPaneUI extends BaseComponentUI
	{
		protected var scrollPane:AlternativeScrollPane;
		protected var lastViewport:Viewportable;
		protected var upButton:Component;
		protected var downButton:Component;
		
		public function AlternativeScrollPaneUI()
		{
		}
		
		override public function installUI(c:Component):void
		{
			scrollPane = AlternativeScrollPane(c);
			installDefaults();
			installComponents();
			installListeners();
		}
		
		override public function uninstallUI(c:Component):void
		{
			scrollPane = AlternativeScrollPane(c);
			uninstallDefaults();
			uninstallComponents();
			uninstallListeners();
		}
		
		protected function getPropertyPrefix():String
		{
			return "ScrollPane."; //AlternativeScrollPane
		}
		
		protected function installDefaults():void
		{
			var pp:String = getPropertyPrefix();
			LookAndFeel.installColorsAndFont(scrollPane, pp);
			LookAndFeel.installBorderAndBFDecorators(scrollPane, pp);
			LookAndFeel.installBasicProperties(scrollPane, pp);
		}
		
		protected function uninstallDefaults():void
		{
			LookAndFeel.uninstallBorderAndBFDecorators(scrollPane);
		}
		
		protected function installComponents():void
		{
			upButton = createButton(-Math.PI / 2);
			downButton = createButton(Math.PI / 2);
			
			upButton.setUIElement(true);
			downButton.setUIElement(true);
			
			upButton.setFocusable(false);
			downButton.setFocusable(false);
			
			//scrollPane.insert( -1, upButton);
			//scrollPane.insert( -1, downButton);
			
			//scrollPane.append(upButton);
			//scrollPane.append(downButton);
		}
		
		protected function uninstallComponents():void
		{
			
		}
		
		protected function installListeners():void
		{
			scrollPane.addAdjustmentListener(__adjustChanged);
			scrollPane.addEventListener(ScrollPaneEvent.VIEWPORT_CHANGED, __viewportChanged);
			__viewportChanged(null);
		}
		
		protected function uninstallListeners():void
		{
			scrollPane.removeAdjustmentListener(__adjustChanged);
			scrollPane.removeEventListener(ScrollPaneEvent.VIEWPORT_CHANGED, __viewportChanged);
			if (lastViewport != null)
			{
				lastViewport.removeStateListener(__viewportStateChanged);
			}
		}
		
		/**
		 * Just override this method if you want other LAF drop down buttons.
		 */
		protected function createButton(direction:Number):Component
		{
			var btn:JButton = new JButton("", new ArrowIcon(direction, 15));
			btn.buttonMode = true;
			btn.setFocusable(false);
			btn.setPreferredSize(new IntDimension(15, 15));
			btn.setBackgroundDecorator(null);
			btn.setMargin(new Insets());
			btn.setBorder(null);
			//make it proxy to the stepper
			btn.setMideground(null);
			btn.setStyleTune(null);
			return btn;
		}
		
		//-------------------------listeners--------------------------
		protected function syncScrollPaneWithViewport():void
		{
			var viewport:Viewportable = scrollPane.getViewport();
		/*	var vsb:JScrollBar = scrollPane.getVerticalScrollBar();
			var hsb:JScrollBar = scrollPane.getHorizontalScrollBar();*/
			
			if (viewport != null)
			{
				var extentSize:IntDimension = viewport.getExtentSize();
				if (extentSize.width <= 0 || extentSize.height <= 0)
				{
					//trace("/w/zero extent size");
					return;
				}
				var viewSize:IntDimension = viewport.getViewSize();
				var viewPosition:IntPoint = viewport.getViewPosition();
				var extent:int, max:int, value:int;
				//viewport.setViewPosition(new IntDi
				/*if (vsb != null)
				{
					extent = extentSize.height;
					max = viewSize.height;
					value = Math.max(0, Math.min(viewPosition.y, max - extent));
					vsb.setValues(value, extent, 0, max);
					vsb.setUnitIncrement(viewport.getVerticalUnitIncrement());
					vsb.setBlockIncrement(viewport.getVerticalBlockIncrement());
				}*/
				
				/*if (hsb != null)
				{
					extent = extentSize.width;
					max = viewSize.width;
					value = Math.max(0, Math.min(viewPosition.x, max - extent));
					hsb.setValues(value, extent, 0, max);
					hsb.setUnitIncrement(viewport.getHorizontalUnitIncrement());
					hsb.setBlockIncrement(viewport.getHorizontalBlockIncrement());
				}*/
			}
		}
		
		private function __viewportChanged(e:ScrollPaneEvent):void
		{
			if (lastViewport != null)
			{
				lastViewport.removeStateListener(__viewportStateChanged);
			}
			lastViewport = scrollPane.getViewport();
			lastViewport.addStateListener(__viewportStateChanged);
			__viewportStateChanged(null);
		}
		
		private function __viewportStateChanged(e:InteractiveEvent):void
		{
			syncScrollPaneWithViewport();
		}
		
		private function __adjustChanged(e:ScrollPaneEvent):void
		{
			var viewport:Viewportable = scrollPane.getViewport();
			viewport.scrollRectToVisible(scrollPane.getVisibleRect(), e.isProgrammatic());
		}
	
	}
}
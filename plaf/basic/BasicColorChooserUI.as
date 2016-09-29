/*
   Copyright aswing.org, see the LICENCE.txt.
 */

package devoron.aswing3d.plaf.basic
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.events.*;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.ui.MouseCursorData;
	import flash.utils.getDefinitionByName;
	import devoron.aswing3d.*;
	import org.aswing.colorchooser.AbstractColorChooserPanel;
	import org.aswing.colorchooser.JColorMixer;
	import org.aswing.colorchooser.JColorSwatches;
	import org.aswing.colorchooser.PreviewColorIcon;
	import org.aswing.event.AWEvent;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.geom.*;
	import org.aswing.graphics.*;
	import org.aswing.plaf.BaseComponentUI;
	import org.aswing.layout.CenterLayout;
	import org.aswing.layout.BorderLayout;
	import org.aswing.layout.SoftBoxLayout;
	import org.aswing.AbstractButton;
	import org.aswing.Insets;
	
	/**
	 * @author iiley
	 * @private
	 */
	public class BasicColorChooserUI extends BaseComponentUI
	{
		[Embed(source="sight_icon16.png")]
		private const SIGHT_MOUSE_ICON:Class;
		
		[Embed(source="sight2D_icon16.png")]
		private const SIGHT2D_ICON:Class;
		
		[Embed(source="sight3D_icon16.png")]
		private const SIGHT3D_ICON:Class;
		
		private var chooser:JColorChooser;
		private var previewColorLabel:JLabel;
		private var previewColorIcon:PreviewColorIcon;
		private var sightButtonGroup:ButtonGroup;
		
		public function BasicColorChooserUI()
		{
			super();
		}
		
		protected function getPropertyPrefix():String
		{
			return "ColorChooser.";
		}
		
		override public function installUI(c:Component):void
		{
			chooser = JColorChooser(c);
			installDefaults();
			installComponents();
			installListeners();
		}
		
		override public function uninstallUI(c:Component):void
		{
			chooser = JColorChooser(c);
			uninstallDefaults();
			uninstallComponents();
			uninstallListeners();
		}
		
		private function installDefaults():void
		{
			var pp:String = getPropertyPrefix();
			LookAndFeel.installColorsAndFont(chooser, pp);
			LookAndFeel.installBasicProperties(chooser, pp);
			LookAndFeel.installBorderAndBFDecorators(chooser, pp);
		}
		
		private function uninstallDefaults():void
		{
			LookAndFeel.uninstallBorderAndBFDecorators(chooser);
		}
		
		private function installComponents():void
		{
			sightButtonGroup = new ButtonGroup(true);
			sightButtonGroup.appendAll(chooser.getSight2DButton());
			sightButtonGroup.appendAll(chooser.getSight3DButton());
			previewColorLabel = createPreviewColorLabel();
			previewColorLabel.setUIElement(true);
			previewColorIcon = createPreviewColorIcon();
			previewColorLabel.setIcon(previewColorIcon);
			previewColorIcon.setColor(chooser.getSelectedColor());
			addChooserPanels();
			layoutComponents();
			updateSectionVisibles();
		}
		
		private function uninstallComponents():void
		{
			chooser.removeAllChooserPanels();
			sightButtonGroup.removeAll();
			sightButtonGroup = null;
		}
		
		private function installListeners():void
		{
			chooser.addEventListener(InteractiveEvent.STATE_CHANGED, __selectedColorChanged);
			chooser.getSight2DButton().addActionListener(sight2DButtonHandler);
			chooser.getSight3DButton().addActionListener(sight3DButtonHandler);
		}
		
		private function uninstallListeners():void
		{
			chooser.removeEventListener(InteractiveEvent.STATE_CHANGED, __selectedColorChanged);
			chooser.getSight2DButton().removeActionListener(sight2DButtonHandler);
			chooser.getSight3DButton().removeActionListener(sight3DButtonHandler);
		}
		
		private function sight2DButtonHandler(e:AWEvent):void
		{
			setSightMode(chooser.getSight2DButton().isSelected());
		}
		
		private function sight3DButtonHandler(e:AWEvent):void
		{
			setSightMode(chooser.getSight3DButton().isSelected());
		}
		
		private function setSightMode(b:Boolean):void
		{
			if (b)
			{
				var mcd:MouseCursorData = new MouseCursorData();
				mcd.hotSpot = new  flash.geom.Point(8, 8);
				var cursors:Vector.<BitmapData> = new Vector.<BitmapData>();
				cursors.push((new SIGHT_MOUSE_ICON as Bitmap).bitmapData);
				mcd.data = cursors;
				Mouse.registerCursor(MouseCursor.AUTO, mcd);
				chooser.stage.addEventListener(MouseEvent.CLICK, onStageMouseClick);
			}
			else
			{
				Mouse.unregisterCursor(MouseCursor.AUTO);
				chooser.stage.removeEventListener(MouseEvent.CLICK, onStageMouseClick);
			}
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		private function onStageMouseClick(e:MouseEvent):void
		{
			var stage:Stage = chooser.stage;
			
			var selectedBtn:AbstractButton = sightButtonGroup.getSelectedButton();
			var mode:int = sightButtonGroup.getSelectedIndex();
			
			if (selectedBtn.getBounds(stage).contains(e.stageX, e.stageY))
				return;
			
			switch (mode)
			{
				case 0: 
					var bd:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, false, stage.color);
					bd.draw(stage);
					var clr:uint = bd.getPixel(e.stageX, e.stageY);
					chooser.getModel().setSelectedColor(new ASColor(clr));
					bd.dispose();
					break;
				case 1: 
					var world:* = getDefinitionByName("World")
					if (world == null)
						return;
					var view:* = world.view;
					var stage3DBD:BitmapData = new BitmapData(view.width, view.height, true, 0xFFFFFF);
					view.renderer.queueSnapshot(stage3DBD);
					view.render();
					var clr2:uint = stage3DBD.getPixel(e.stageX - view.x, e.stageY - view.y);
					chooser.getModel().setSelectedColor(new ASColor(clr2));
					break;
				default: 
					break;
			}
		}
		
		//------------------------------------------------------------------------------
		
		private function __selectedColorChanged(e:Event):void
		{
			previewColorIcon.setPreviousColor(previewColorIcon.getCurrentColor());
			previewColorIcon.setCurrentColor(chooser.getSelectedColor());
			previewColorLabel.repaint();
		}
		
		override public function paint(c:Component, g:Graphics2D, b:IntRectangle):void
		{
			super.paint(c, g, b);
			previewColorIcon.setColor(chooser.getSelectedColor());
			previewColorLabel.repaint();
			updateSectionVisibles();
		}
		
		private function updateSectionVisibles():void
		{
			for (var i:Number = 0; i < chooser.getChooserPanelCount(); i++)
			{
				var pane:AbstractColorChooserPanel = chooser.getChooserPanelAt(i);
				pane.setAlphaSectionVisible(chooser.isAlphaSectionVisible());
				pane.setHexSectionVisible(chooser.isHexSectionVisible());
				pane.setNoColorSectionVisible(chooser.isNoColorSectionVisible());
			}
		}
		
		//*******************************************************************************
		//       Override these methods to easiy implement different look
		//*******************************************************************************
		
		private function layoutComponents():void
		{
			chooser.setLayout(new BorderLayout(6, 6));
			var rightPane:Container = SoftBox.createHorizontalBox(6, SoftBoxLayout.LEFT);
			chooser.getCancelButton().setMargin(new Insets(0, 5, 0, 5));
			
			var buttonsPanel:JPanel = new JPanel(new BorderLayout());
			buttonsPanel.setWidth(40);
			buttonsPanel.setPreferredWidth(80);
			buttonsPanel.append(chooser.getOkButton(), BorderLayout.NORTH);
			buttonsPanel.append(chooser.getCancelButton(), BorderLayout.SOUTH);
			rightPane.append(buttonsPanel);
			
			var buttonsPanel2:JPanel = new JPanel(new BorderLayout());
			buttonsPanel2.setWidth(48);
			buttonsPanel2.setPreferredWidth(48);
			
			var sigth2DBtn:JToggleButton = chooser.getSight2DButton();
			sigth2DBtn.setIcon(new AssetIcon(new SIGHT2D_ICON, 16, 19));
			buttonsPanel2.append(sigth2DBtn, BorderLayout.WEST);
			sigth2DBtn.setSize(new IntDimension(21, 24));
			sigth2DBtn.setMaximumSize(new IntDimension(21, 24));
			
			var sigth3DBtn:JToggleButton = chooser.getSight3DButton();
			sigth3DBtn.setIcon(new AssetIcon(new SIGHT3D_ICON, 16, 19));
			sigth3DBtn.setSize(new IntDimension(21, 24));
			sigth3DBtn.setMaximumSize(new IntDimension(21, 24));
			buttonsPanel2.append(sigth3DBtn, BorderLayout.EAST);
			rightPane.append(buttonsPanel2);
			
			var labelsPanel:JPanel = new JPanel(new BorderLayout());
			var oldLB:JLabel = new JLabel("Old");
			oldLB.setForeground(new ASColor(0xFFFFFF, 0.8));
			labelsPanel.append(oldLB, BorderLayout.NORTH);
			var currentLB:JLabel = new JLabel("Current");
			currentLB.setForeground(new ASColor(0xFFFFFF, 0.8));
			labelsPanel.append(currentLB, BorderLayout.SOUTH);
			rightPane.append(labelsPanel);
			
			rightPane.append(AsWingUtils.createPaneToHold(previewColorLabel, new CenterLayout()));
			
			chooser.append(rightPane, BorderLayout.NORTH);
			chooser.append(chooser.getTabbedPane(), BorderLayout.SOUTH);
		}
		
		private function addChooserPanels():void
		{
			var colorS:JColorSwatches = new JColorSwatches();
			var colorM:JColorMixer = new JColorMixer();
			colorS.setUIElement(true);
			colorM.setUIElement(true);
			chooser.addChooserPanel("Color Swatches", colorS);
			chooser.addChooserPanel("Color Mixer", colorM);
		}
		
		private function createPreviewColorIcon():PreviewColorIcon
		{
			return new PreviewColorIcon(60, 30, PreviewColorIcon.VERTICAL);
		}
		
		private function createPreviewColorLabel():JLabel
		{
			var label:JLabel = new JLabel();
			//var bb:BevelBorder = new BevelBorder(null, BevelBorder.LOWERED);
			//bb.setThickness(1);
			//label.setBorder(bb); 
			return label;
		}
	}
}
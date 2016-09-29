/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic{

import flash.display.*;
import flash.events.*;
import flash.geom.Matrix;
import flash.ui.Keyboard;
import org.aswing.layouts.SoftBoxLayout;
import org.aswing.AbstractButton;
import org.aswing.FocusManager;
import org.aswing.Icon;
import org.aswing.Insets;
import org.aswing.JButton;
import org.aswing.lookandfeel.plaf.BaseComponentUI;

import devoron.aswing3d.*;
import org.aswing.border.*;
import org.aswing.event.FocusKeyEvent;
import org.aswing.event.InteractiveEvent;
import org.aswing.geom.*;
import org.aswing.graphics.*;
import org.aswing.plaf.*;
import org.aswing.plaf.basic.icon.ArrowIcon;
import org.aswing.plaf.basic.tabbedpane.*;
import org.aswing.util.*;

/**
 * @private
 */
public class BasicTabbedPaneUI extends BaseComponentUI implements LayoutManager{
	
	protected var topBlankSpace:int = 4;
		
	protected var tabbedPane:JTabbedPane;
	protected var tabBarSize:IntDimension;
	protected var maxTabSize:IntDimension;
	protected var prefferedSize:IntDimension;
	protected var minimumSize:IntDimension;
	protected var tabBoundArray:Array;
	protected var drawnTabBoundArray:Array;
	protected var contentMargin:Insets = null;
	protected var maxTabWidth:int = -1;
	protected var tabGap:int = 1;
	//both the 3 values are just the values considering when placement is TOP
	protected var tabBorderInsets:Insets;
	protected var selectedTabExpandInsets:Insets;
	protected var contentRoundLineThickness:int;
	
	protected var tabs:Array;
	
	protected var firstIndex:int; //first viewed tab index
	protected var lastIndex:int;  //last perfectly viewed tab index
	protected var prevButton:AbstractButton;
	protected var nextButton:AbstractButton;
	protected var buttonMCPane:Container;
	
	protected var uiRootMC:Sprite;
	protected var tabBarMC:Sprite;
	protected var tabBarMaskMC:Shape;
	protected var buttonHolderMC:Sprite;
	protected var topTabCom:Component;
	
	public function BasicTabbedPaneUI() {
		super();
		tabBorderInsets = new Insets(2, 2, 0, 2);
		selectedTabExpandInsets = new Insets(2, 2, 0, 2);
		tabs = new Array();
		firstIndex = 0;
		lastIndex = 0;
	}

	override public function installUI(c:Component):void{
		tabbedPane = JTabbedPane(c);
		tabbedPane.setLayout(this);
		installDefaults();
		installComponents();
		installListeners();
	}
	
	override public function uninstallUI(c:Component):void{
		tabbedPane = JTabbedPane(c);
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
	}
	
    protected function getPropertyPrefix():String {
        return "TabbedPane.";
    }

	protected function installDefaults():void{
		var pp:String = getPropertyPrefix();
		LookAndFeel.installColorsAndFont(tabbedPane, pp);
		LookAndFeel.installBorderAndBFDecorators(tabbedPane, pp);
		LookAndFeel.installBasicProperties(tabbedPane, pp);
				
		contentMargin = getInsets(pp+"contentMargin");
		if(contentMargin == null) contentMargin = new Insets(8, 2, 2, 2);
		maxTabWidth = getInt(pp+"maxTabWidth");
		if(maxTabWidth == -1) maxTabWidth = 1000;
		
		contentRoundLineThickness = getInt(getPropertyPrefix() + "contentRoundLineThickness");
		
		var tabMargin:Insets = getInsets(pp+"tabMargin");
		if(tabMargin == null) tabMargin = new InsetsUIResource(1, 1, 1, 1);
		
		if(containsKey(pp+"topBlankSpace")){
			topBlankSpace = getInt(pp+"topBlankSpace");
		}
		if(containsKey(pp+"tabGap")){
			tabGap = getInt(pp+"tabGap");
		}
		if(containsKey(pp+"tabBorderInsets")){
			tabBorderInsets = getInsets(pp+"tabBorderInsets");
		}
		if(containsKey(pp+"selectedTabExpandInsets")){
			selectedTabExpandInsets = getInsets(pp+"selectedTabExpandInsets");
		}
		
		var i:Insets = tabbedPane.getMargin();
		if (i is UIResource) {
			tabbedPane.setMargin(tabMargin);
		}
	}
	
	protected function uninstallDefaults():void{
		LookAndFeel.uninstallBorderAndBFDecorators(tabbedPane);
	}
	
	protected function installComponents():void{
		prevButton = createPrevButton();
		nextButton = createNextButton();
		prevButton.setFocusable(false);
		nextButton.setFocusable(false);
		prevButton.setUIElement(true);
		nextButton.setUIElement(true);
		
		prevButton.addActionListener(__prevButtonReleased);
		nextButton.addActionListener(__nextButtonReleased);
		createUIAssets();
		synTabs();
	}
	
	protected function uninstallComponents():void{
		prevButton.removeActionListener(__prevButtonReleased);
		nextButton.removeActionListener(__nextButtonReleased);
		removeUIAssets();
	}
	
	protected function installListeners():void{
		tabbedPane.addStateListener(__onSelectionChanged);
		tabbedPane.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onNavKeyDown);
		tabbedPane.addEventListener(MouseEvent.MOUSE_DOWN, __onTabPanePressed);
	}
	
	protected function uninstallListeners():void{
		tabbedPane.removeStateListener(__onSelectionChanged);
		tabbedPane.removeEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onNavKeyDown);
		tabbedPane.removeEventListener(MouseEvent.MOUSE_DOWN, __onTabPanePressed);
	}
	
	//----------------------------------------------------------------
	
	protected function getMousedOnTabIndex():int{
		var p:IntPoint = tabbedPane.getMousePosition();
		var n:int = tabbedPane.getComponentCount();
		for(var i:int=firstIndex; i<n && i<=lastIndex+1; i++){
			var b:IntRectangle = getDrawnTabBounds(i);
			if(b && b.containsPoint(p)){
				return i;
			}
		}
		return -1;
	}
	
	protected function __onSelectionChanged(e:InteractiveEvent):void{
		tabbedPane.revalidate();
		tabbedPane.repaint();
	}
	
	protected function __onTabPanePressed(e:Event):void{
		if((prevButton.hitTestMouse() || nextButton.hitTestMouse())
			&& (prevButton.isShowing() && nextButton.isShowing())){
			return;
		}
		var index:int = getMousedOnTabIndex();
		if(index >= 0 && tabbedPane.isEnabledAt(index)){
			tabbedPane.setSelectedIndex(index, false);
		}
	}
	
	protected function __onNavKeyDown(e:FocusKeyEvent):void{
		if(!tabbedPane.isEnabled()){
			return;
		}
		var n:int = tabbedPane.getComponentCount();
		if(n > 0){
			var index:int = tabbedPane.getSelectedIndex();
			var code:uint = e.keyCode;
			var count:int = 1;
			if(code == Keyboard.DOWN || code == Keyboard.RIGHT){
				setTraversingTrue();
				index++;
				while((!tabbedPane.isEnabledAt(index) || !tabbedPane.isVisibleAt(index)) && index<n){
					index++;
					count++;
					if(index >= n){
						return;
					}
				}
				if(index >= n){
					return;
				}
				if(lastIndex < n-1){
					firstIndex = Math.min(firstIndex + count, n-1);
				}
			}else if(code == Keyboard.UP || code == Keyboard.LEFT){
				setTraversingTrue();
				index--;
				while((!tabbedPane.isEnabledAt(index) || !tabbedPane.isVisibleAt(index)) && index>=0){
					index--;
					count++;
					if(index < 0){
						return;
					}
				}
				if(index < 0){
					return;
				}
				if(firstIndex > 0){
					firstIndex = Math.max(0, firstIndex - count);
				}
			}
			tabbedPane.setSelectedIndex(index, false);
		}
	}
    
    protected function setTraversingTrue():void{
    	var fm:FocusManager = FocusManager.getManager(tabbedPane.stage);
    	if(fm){
    		fm.setTraversing(true);
    	}
    }
	
	protected function __prevButtonReleased(e:Event):void{
		if(firstIndex > 0){
			firstIndex--;
			tabbedPane.repaint();
		}
	}
	
	protected function __nextButtonReleased(e:Event):void{
		if(lastIndex < tabbedPane.getComponentCount()-1){
			firstIndex++;
			tabbedPane.repaint();
		}
	}
	
	//----------
	
	
	protected function isTabHorizontalPlacing():Boolean{
		return tabbedPane.getTabPlacement() == JTabbedPane.TOP || tabbedPane.getTabPlacement() == JTabbedPane.BOTTOM;
	}
	/**
	 * This is just the value when placement is TOP
	 */
	protected function getTabBorderInsets():Insets{
		return tabBorderInsets;
	}
	
	protected function createPrevButton():AbstractButton{
		return createArrowButton(Math.PI);
	}
	
	protected function createArrowButton(direction:Number):AbstractButton{
    	var btn:JButton = new JButton("", createArrowIcon(direction, true));
    	btn.setFocusable(false);
    	btn.setPreferredSize(new IntDimension(16, 16));
    	btn.setBackgroundDecorator(null);
    	btn.setMargin(new Insets());
    	btn.setBorder(null);
    	//make it proxy to the combobox
    	btn.setStyleProxy(tabbedPane);
    	btn.setMideground(null);
    	btn.setStyleTune(null);
    	return btn;				
	}
	
	protected function createNextButton():AbstractButton{
		return createArrowButton(0);
	}
	
	protected function createArrowIcon(direction:Number, enable:Boolean):Icon{
		return new ArrowIcon(direction, 16);
	}
		
	protected function getTabBarSize():IntDimension{
		if(tabBarSize != null){
			return tabBarSize;
		}
		var isHorizontalPlacing:Boolean = isTabHorizontalPlacing();
		tabBarSize = new IntDimension(0, 0);
		var n:int = tabbedPane.getComponentCount();
		tabBoundArray = new Array(n);
		var x:int = 0;
		var y:int = 0;
		for(var i:int=0; i<n; i++){
			var ts:IntDimension = countPreferredTabSizeAt(i);
			var tbounds:IntRectangle = new IntRectangle(x, y, ts.width, ts.height);
			tabBoundArray[i] = tbounds;
			var offset:int = i < (n+1) ? tabGap : 0;
			if(isHorizontalPlacing){
				tabBarSize.height = Math.max(tabBarSize.height, ts.height);
				tabBarSize.width += ts.width + offset;
				x += ts.width + offset;
			}else{
				tabBarSize.width = Math.max(tabBarSize.width, ts.width);
				tabBarSize.height += ts.height + offset;
				y += ts.height + offset;
			}
		}
		var leadOffset:int = tabbedPane.getLeadingOffset();
		maxTabSize = tabBarSize.clone();
		if(isHorizontalPlacing){
			tabBarSize.height += (topBlankSpace + contentMargin.top);
			//blank space at start and end for selected tab expanding
			tabBarSize.width += (tabBorderInsets.left + tabBorderInsets.right + leadOffset);
		}else{
			tabBarSize.width += (topBlankSpace + contentMargin.top);
			//blank space at start and end for selected tab expanding
			tabBarSize.height += (tabBorderInsets.left + tabBorderInsets.right + leadOffset);
		}
		return tabBarSize;
	}
	
	protected function getTabBoundArray():Array{
		//when tabBoundArray.lenght != tabbedPane.getComponentCount() then recalled the getTabBarSize()
		if(tabBoundArray != null && tabBoundArray.length == tabbedPane.getComponentCount()){
			return tabBoundArray;
		}else{
			invalidateLayout(tabbedPane);
			getTabBarSize();
			if(tabBoundArray == null){
				trace("Debug : Error tabBoundArray == null but tabBarSize = " + tabBarSize);
			}			
			return tabBoundArray;			
		}
	}
		
	protected function countPreferredTabSizeAt(index:int):IntDimension{
		var tab:Tab = getTab(index);
		var size:IntDimension = tab.getTabComponent().getPreferredSize();
		size.width = Math.min(size.width, maxTabWidth);
		return size;
	}
	
	protected function setDrawnTabBounds(index:int, b:IntRectangle, paneBounds:IntRectangle):void{
		b = b.clone();
		if(b.x < paneBounds.x){
			b.x = paneBounds.x;
		}
		if(b.y < paneBounds.y){
			b.y = paneBounds.y;
		}
		if(b.x + b.width > paneBounds.x + paneBounds.width){
			b.width = paneBounds.x + paneBounds.width - b.x;
		}
		if(b.y + b.height > paneBounds.y + paneBounds.height){
			b.height = paneBounds.y + paneBounds.height - b.y;
		}
		drawnTabBoundArray[index] = b;
	}
	
	protected function getDrawnTabBounds(index:int):IntRectangle{
		return drawnTabBoundArray[index];
	}	
	
	protected function createUIAssets():void{
		uiRootMC = AsWingUtils.createSprite(tabbedPane, "uiRootMC");
		tabBarMC = AsWingUtils.createSprite(uiRootMC, "tabBarMC");
		tabBarMaskMC = AsWingUtils.createShape(uiRootMC, "tabBarMaskMC");
		buttonHolderMC = AsWingUtils.createSprite(uiRootMC, "buttonHolderMC");
		
		tabBarMC.mask = tabBarMaskMC;
		var g:Graphics2D = new Graphics2D(tabBarMaskMC.graphics);
		g.fillRectangle(new SolidBrush(ASColor.BLACK), 0, 0, 1, 1);
		
		var p:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0));
		p.setOpaque(false);
		p.setFocusable(false);
		p.setSizeWH(100, 100);
		p.setUIElement(true);
		buttonHolderMC.addChild(p);
		buttonMCPane = p;
		var insets:Insets = new Insets(topBlankSpace, topBlankSpace, topBlankSpace, topBlankSpace);
		p.setBorder(new EmptyBorder(null, insets));
		p.append(prevButton);
		p.append(nextButton);
		//buttonMCPane.setVisible(false);
	}
	
	protected function removeUIAssets():void{
		tabbedPane.removeChild(uiRootMC);
		tabs = new Array();
	}
	
	protected function createTabBarGraphics():Graphics2D{
		tabBarMC.graphics.clear();
		var g:Graphics2D = new Graphics2D(tabBarMC.graphics);
		return g;
	}
	
	protected function getTab(i:int):Tab{
    	return Tab(tabs[i]);
	}
	
    protected function getSelectedTab():Tab{
    	if(tabbedPane.getSelectedIndex() >= 0){
    		return getTab(tabbedPane.getSelectedIndex());
    	}else{
    		return null;
    	}
    }
    
    protected function indexOfTabComponent(tab:Component):int{
    	for(var i:int=0; i<tabs.length; i++){
    		if(getTab(i).getTabComponent() == tab){
    			return i;
    		}
    	}
    	return -1;
    }
	
   	override public function paintFocus(c:Component, g:Graphics2D, b:IntRectangle):void{
    	var header:Tab = getSelectedTab();
    	if(header != null){
    		header.getTabComponent().paintFocusRect(true);
    	}else{
    		super.paintFocus(c, g, b);
    	}
    }
    

    /**
     * Just override this method if you want other LAF headers.
     */
    protected function createNewTab():Tab{
    	var tab:Tab = getInstance(getPropertyPrefix() + "tab") as Tab;
    	if(tab == null){
    		tab = new BasicTabbedPaneTab();
    	}
    	tab.initTab(tabbedPane);
    	topTabCom = tab.getTabComponent();
    	topTabCom.setFocusable(false);
    	
    	topTabCom.setStyleProxy(tabbedPane);
    	topTabCom.setStyleTune(null);
    	topTabCom.setForeground(null);
    	topTabCom.setBackground(null);
    	topTabCom.setMideground(null);
    	topTabCom.setFont(null);
    	return tab;
    }

    protected function synTabs():void{
    	var comCount:int = tabbedPane.getComponentCount();
    	if(comCount != tabs.length){
    		var i:int;
    		var header:Tab;
    		if(comCount > tabs.length){
    			for(i = tabs.length; i<comCount; i++){
    				header = createNewTab();
    				setTabProperties(header, i);
    				tabBarMC.addChild(header.getTabComponent());
    				tabs.push(header);
    			}
    		}else{
    			for(i = tabs.length-comCount; i>0; i--){
    				header = Tab(tabs.pop());
    				tabBarMC.removeChild(header.getTabComponent());
    			}
    		}
    	}
    }
        
    protected function synTabProperties():void{
    	for(var i:int=0; i<tabs.length; i++){
    		var header:Tab = getTab(i);
    		setTabProperties(header, i);
    	}
    }
    
    protected function setTabProperties(header:Tab, i:int):void{
		header.setTextAndIcon(tabbedPane.getTitleAt(i), tabbedPane.getIconAt(i));
		header.getTabComponent().setUIElement(true);
		header.getTabComponent().setEnabled(tabbedPane.isEnabledAt(i));
		header.getTabComponent().setVisible(tabbedPane.isVisibleAt(i));
		header.getTabComponent().setToolTipText(tabbedPane.getTipAt(i));
    	header.setHorizontalAlignment(tabbedPane.getHorizontalAlignment());
    	header.setHorizontalTextPosition(tabbedPane.getHorizontalTextPosition());
    	header.setIconTextGap(tabbedPane.getIconTextGap());
    	setTabMarginProperty(header, getTransformedMargin());
    	header.setVerticalAlignment(tabbedPane.getVerticalAlignment());
    	header.setVerticalTextPosition(tabbedPane.getVerticalTextPosition());
    	header.setFont(tabbedPane.getFont());
    	header.setForeground(tabbedPane.getForeground());
    }
    
    protected function setTabMarginProperty(tab:Tab, margin:Insets):void{
    	tab.setMargin(margin); //no need here, because drawTabAt and countPreferredTabSizeAt did this work
    }
    
    protected function getTransformedMargin():Insets{
    	return transformMargin(tabbedPane.getMargin());
    }
    
    protected function transformMargin(margin:Insets):Insets{
    	var placement:int = tabbedPane.getTabPlacement();
    	var transformedMargin:Insets = margin.clone();
		if(placement == JTabbedPane.LEFT){
			transformedMargin.left = margin.top;
			transformedMargin.right = margin.bottom;
			transformedMargin.top = margin.right;
			transformedMargin.bottom = margin.left;
		}else if(placement == JTabbedPane.RIGHT){
			transformedMargin.left = margin.bottom;
			transformedMargin.right = margin.top;
			transformedMargin.top = margin.left;
			transformedMargin.bottom = margin.right;
		}else if(placement == JTabbedPane.BOTTOM){
			transformedMargin.top = margin.bottom;
			transformedMargin.bottom = margin.top;
		}
		return transformedMargin;
    }
		
	override public function paint(c:Component, g:Graphics2D, b:IntRectangle):void{
		super.paint(c, g, b);
		synTabProperties();
		
		tabBarMaskMC.x = b.x;
		tabBarMaskMC.y = b.y;
		tabBarMaskMC.width = b.width;
		tabBarMaskMC.height = b.height;
		g = createTabBarGraphics();
		
		var horizontalPlacing:Boolean = isTabHorizontalPlacing();
	  	var contentBounds:IntRectangle = b.clone();
		var tabBarBounds:IntRectangle = getTabBarSize().getBounds(0, 0);
		tabBarBounds.x = b.x;
		tabBarBounds.y = b.y;
		tabBarBounds.width = Math.min(tabBarBounds.width, contentBounds.width);
		tabBarBounds.height = Math.min(tabBarBounds.height, contentBounds.height);
		var transformedTabMargin:Insets = getTransformedMargin();
		var placement:int = tabbedPane.getTabPlacement();
		var leadingOffset:int = tabbedPane.getLeadingOffset();
		if(placement == JTabbedPane.LEFT){
			tabBarBounds.y += tabBorderInsets.left + leadingOffset;//extra for expand 
			tabBarBounds.height -= (tabBorderInsets.getMarginWidth() + leadingOffset);
		}else if(placement == JTabbedPane.RIGHT){
			tabBarBounds.x = contentBounds.x + contentBounds.width - tabBarBounds.width;
			tabBarBounds.y += tabBorderInsets.left + leadingOffset;//extra for expand 
			tabBarBounds.height -= (tabBorderInsets.getMarginWidth() + leadingOffset);
		}else if(placement == JTabbedPane.BOTTOM){
			tabBarBounds.y = contentBounds.y + contentBounds.height - tabBarBounds.height;
			tabBarBounds.x += tabBorderInsets.left + leadingOffset;//extra for expand
			tabBarBounds.width -= (tabBorderInsets.getMarginWidth() + leadingOffset);
		}else{ //others value are all considered as TOP
			tabBarBounds.x += tabBorderInsets.left + leadingOffset;//extra for expand
			tabBarBounds.width -= (tabBorderInsets.getMarginWidth() + leadingOffset);
		}
		
		var i:int = 0;
		var n:int = tabbedPane.getComponentCount();
		var tba:Array = getTabBoundArray();
		drawnTabBoundArray = new Array(n);
		var selectedIndex:int = tabbedPane.getSelectedIndex();
		
		//count not viewed front tabs's width and invisible them
		var offsetPoint:IntPoint = new IntPoint();
		for(i=0; i<firstIndex; i++){
			if(horizontalPlacing){
				offsetPoint.x -= tba[i].width;
			}else{
				offsetPoint.y -= tba[i].height;
			}
			getTab(i).getTabComponent().setVisible(false);
		}
		//draw from firstIndex to last viewable tabs
		for(i=firstIndex; i<n; i++){
			if(i != selectedIndex){
				var viewedFlag:int = drawTabWithFullInfosAt(i, b, tba[i], g, tabBarBounds, offsetPoint, transformedTabMargin);
				if(viewedFlag < 0){
					lastIndex = i;
				}
				if(viewedFlag >= 0){
					break;
				}
			}
		}
		if(selectedIndex >= 0){
			if(drawTabWithFullInfosAt(selectedIndex, b, tba[selectedIndex], g, tabBarBounds, offsetPoint, transformedTabMargin) < 0){
				lastIndex = Math.max(lastIndex, selectedIndex);
			}
		}
		var selBounds:IntRectangle = null;
		if(selectedIndex >= 0){
			selBounds = getDrawnTabBounds(selectedIndex);
		}
		drawBaseLine(tabBarBounds, g, b, selBounds);
		//invisible tab after last
		for(i=lastIndex+2; i<n; i++){
			getTab(i).getTabComponent().setVisible(false);
		}
		
		//view prev and next buttons
		if(firstIndex > 0 || lastIndex < n-1){
			buttonMCPane.setVisible(true);
			prevButton.setEnabled(firstIndex > 0);
			nextButton.setEnabled(lastIndex < n-1);
			var bps:IntDimension = buttonMCPane.getPreferredSize();
			buttonMCPane.setSize(bps);
			var bpl:IntPoint = new IntPoint();
			if(placement == JTabbedPane.LEFT){
				bpl.x = contentBounds.x;
				bpl.y = contentBounds.y + contentBounds.height - bps.height;
			}else if(placement == JTabbedPane.RIGHT){
				bpl.x = contentBounds.x + contentBounds.width - bps.width;
				bpl.y = contentBounds.y + contentBounds.height - bps.height;
			}else if(placement == JTabbedPane.BOTTOM){
				bpl.x = contentBounds.x + contentBounds.width - bps.width;
				bpl.y = contentBounds.y + contentBounds.height - bps.height;
			}else{
				bpl.x = contentBounds.x + contentBounds.width - bps.width;
				bpl.y = contentBounds.y;
			}
			buttonMCPane.setLocation(bpl);
			buttonMCPane.revalidate();
		}else{
			buttonMCPane.setVisible(false);
		}
		tabbedPane.bringToTop(uiRootMC);//make it at top
	}
	
	/**
	 * Returns whether the tab painted out of tabbedPane bounds or not viewable or viewable.<br>
	 * @return -1 , viewable whole area;
	 *		 0, viewable but end out of bounds
	 *		 1, not viewable in the bounds. 
	 */
	protected function drawTabWithFullInfosAt(index:int, paneBounds:IntRectangle, bounds:IntRectangle,
	 g:Graphics2D, tabBarBounds:IntRectangle, offsetPoint:IntPoint, transformedTabMargin:Insets):int{
		var tb:IntRectangle = bounds.clone();
		tb.x += (tabBarBounds.x + offsetPoint.x);
		tb.y += (tabBarBounds.y + offsetPoint.y);
		var placement:int = tabbedPane.getTabPlacement();
		if(placement == JTabbedPane.LEFT){
			tb.width = maxTabSize.width;
			tb.x += topBlankSpace;
		}else if(placement == JTabbedPane.RIGHT){
			tb.width = maxTabSize.width;
			tb.x += contentMargin.top;
		}else if(placement == JTabbedPane.BOTTOM){
			tb.y += contentMargin.top;
			tb.height = maxTabSize.height;
		}else{
			tb.height = maxTabSize.height;
			tb.y += topBlankSpace;
		}
		if(isTabHorizontalPlacing()){
			if(tb.x > paneBounds.x + paneBounds.width){
				//do not need paint
				return 1;
			}
		}else{
			if(tb.y > paneBounds.y + paneBounds.height){
				//do not need paint
				return 1;
			}
		}
		drawTabAt(index, tb, paneBounds, g, transformedTabMargin);
		if(isTabHorizontalPlacing()){
			if(tb.x + tb.width > paneBounds.x + paneBounds.width){
				return 0;
			}
		}else{
			if(tb.y + tb.height > paneBounds.y + paneBounds.height){
				return 0;
			}
		}
		return -1;
	}

    /**
     * override this method to draw different tab base line for your LAF
     */
    protected function drawBaseLine(tabBarBounds:IntRectangle, g:Graphics2D, fullB:IntRectangle, selTabB:IntRectangle):void{
    	return;//dosn't draw line in this version
    	var b:IntRectangle = tabBarBounds.clone();
    	var placement:int = tabbedPane.getTabPlacement();
    	var pen:Pen;
    	var lineT:Number = 2;//contentRoundLineThickness;
    	if(selTabB == null){
    		selTabB = new IntRectangle(fullB.x + fullB.width/2, fullB.y + fullB.height/2, 0, 0);
    	}
    	selTabB = selTabB.clone();
		var cl:ASColor = tabbedPane.getMideground();
		var adjuster:StyleTune = tabbedPane.getStyleTune();
		var style:StyleResult = new StyleResult(cl, adjuster);
		var matrix:Matrix = new Matrix();
		var dark:ASColor = style.bdark;
		var light:ASColor = style.bdark.offsetHLS(0, 0.15, -0.1);
		var leadingOffset:int = tabbedPane.getLeadingOffset();
    	if(isTabHorizontalPlacing()){
    		var isTop:Boolean = (placement == JTabbedPane.TOP);
    		if(isTop){
    			b.y = b.y + b.height - contentMargin.top;
    		}else{
    			b.y += contentMargin.top - lineT/2;
    		}
    		b.width += tabBorderInsets.getMarginWidth();
    		b.x -= tabBorderInsets.left;
			var leftPart:IntRectangle = new IntRectangle(b.x, b.y, selTabB.x-b.x, 2);
			var rightPart:IntRectangle = new IntRectangle(selTabB.x+selTabB.width, b.y, b.x+b.width-(selTabB.x+selTabB.width), 2);
			
			matrix.createGradientBox(tabBorderInsets.left, 1, 0, leftPart.x, leftPart.y);
    		g.fillRectangle(new GradientBrush(
    				GradientBrush.LINEAR, 
    				[dark.getRGB(),dark.getRGB()], 
    				[0, 1], 
    				[0, 255], 
    				matrix
    			), 
    			leftPart.x, leftPart.y, leftPart.width, 1);
    		/*g.fillRectangle(new GradientBrush(
    				GradientBrush.LINEAR, 
    				[light.getRGB(), light.getRGB()], 
    				[0, 1], 
    				[0, 255], 
    				matrix
    			), 
    			leftPart.x, leftPart.y+1, leftPart.width, 1);
    		*/
			matrix.createGradientBox(tabBorderInsets.right, 1, Math.PI, 
				rightPart.x+rightPart.width-tabBorderInsets.right, rightPart.y);
    		g.fillRectangle(new GradientBrush(
    				GradientBrush.LINEAR, 
    				[dark.getRGB(),dark.getRGB()], 
    				[0, 1], 
    				[0, 255], 
    				matrix
    			), 
    			rightPart.x, rightPart.y, rightPart.width, 1);
    		/*g.fillRectangle(new GradientBrush(
    				GradientBrush.LINEAR, 
    				[light.getRGB(), light.getRGB()], 
    				[0, 1], 
    				[0, 255], 
    				matrix
    			), 
    			rightPart.x, rightPart.y+1, rightPart.width, 1);*/
    	}else{
    		var isLeft:Boolean = (placement == JTabbedPane.LEFT);
    		if(isLeft){
    			b.x = b.x + b.width - contentMargin.top;
    		}else{
    			b.x += contentMargin.top - lineT/2;
    		}
    		b.height += tabBorderInsets.getMarginWidth();
    		b.y -= tabBorderInsets.left;
    		    		
			var topPart:IntRectangle = new IntRectangle(b.x, b.y, 2, selTabB.y-b.y);
			var botPart:IntRectangle = new IntRectangle(b.x, selTabB.y+selTabB.height, 2, b.y+b.height-(selTabB.y+selTabB.height));
						
			matrix.createGradientBox(1, tabBorderInsets.left, Math.PI/2, topPart.x, topPart.y);
    		g.fillRectangle(new GradientBrush(
    				GradientBrush.LINEAR, 
    				[dark.getRGB(),dark.getRGB()], 
    				[0, 1], 
    				[0, 255], 
    				matrix
    			), 
    			topPart.x, topPart.y, 1, topPart.height);
    		/*g.fillRectangle(new GradientBrush(
    				GradientBrush.LINEAR, 
    				[light.getRGB(), light.getRGB()], 
    				[0, 1], 
    				[0, 255], 
    				matrix
    			), 
    			topPart.x+1, topPart.y, 1, topPart.height);
    			*/
			matrix.createGradientBox(1, tabBorderInsets.right, -Math.PI/2, 
				botPart.x, botPart.y+botPart.height-tabBorderInsets.right);
    		g.fillRectangle(new GradientBrush(
    				GradientBrush.LINEAR, 
    				[dark.getRGB(),dark.getRGB()], 
    				[0, 1], 
    				[0, 255], 
    				matrix
    			), 
    			botPart.x, botPart.y, 1, botPart.height);
    		/*g.fillRectangle(new GradientBrush(
    				GradientBrush.LINEAR, 
    				[light.getRGB(), light.getRGB()], 
    				[0, 1], 
    				[0, 255], 
    				matrix
    			), 
    			botPart.x+1, botPart.y, 1, botPart.height);*/
    	}
    }	
	
    /**
     * override this method to draw different tab border for your LAF.<br>
     * Note, you must call setDrawnTabBounds() to set the right bounds for each tab in this method
     */
    protected function drawTabBorderAt(index:int, b:IntRectangle, paneBounds:IntRectangle, g:Graphics2D):void{
    	var placement:int = tabbedPane.getTabPlacement();
    	b = b.clone();//make a clone to be safty modification
    	if(index == tabbedPane.getSelectedIndex()){
    		if(isTabHorizontalPlacing()){
    			b.x -= selectedTabExpandInsets.left;
    			b.width += (selectedTabExpandInsets.left + selectedTabExpandInsets.right);
	    		b.height += Math.round(topBlankSpace/2+contentRoundLineThickness);
    			if(placement == JTabbedPane.BOTTOM){
	    			b.y -= contentRoundLineThickness;
    			}else{
	    			b.y -= Math.round(topBlankSpace/2);
    			}
    		}else{
    			b.y -= selectedTabExpandInsets.left;
    			b.height += (selectedTabExpandInsets.left + selectedTabExpandInsets.right);
	    		b.width += Math.round(topBlankSpace/2+contentRoundLineThickness);
    			if(placement == JTabbedPane.RIGHT){
	    			b.x -= contentRoundLineThickness;
    			}else{
	    			b.x -= Math.round(topBlankSpace/2);
    			}
    		}
    	}
    	//This is important, should call this in sub-implemented drawTabBorderAt method
    	setDrawnTabBounds(index, b, paneBounds);
		getTab(index).setTabPlacement(placement);
    }
	
    /**
     * override this method to draw different tab border for your LAF.<br>
     * Note, you must call setDrawnTabBounds() to set the right bounds for each tab in this method
     */	
	protected function drawTabAt(index:int, bounds:IntRectangle, paneBounds:IntRectangle, g:Graphics2D, transformedTabMargin:Insets):void{
		//trace("drawTabAt : " + index + ", bounds : " + bounds + ", g : " + g);
		drawTabBorderAt(index, bounds, paneBounds, g);
		
		var tab:Tab = getTab(index);
		tab.setSelected(index == tabbedPane.getSelectedIndex());
		var tc:Component = tab.getTabComponent();
		tc.setComBounds(getDrawnTabBounds(index));
		if(index == tabbedPane.getSelectedIndex()){
			if (null != topTabCom && tc.parent.contains(topTabCom)){
				tc.parent.swapChildren(tc, topTabCom);
			}
			topTabCom = tc;
		}		
		
		//tab.getTabComponent().validate();
	}	
	
	protected function getTabColor(index:int):ASColor{
		return tabbedPane.getBackground();
	}
	
	//----------------------------LayoutManager Implementation-----------------------------
	
	public function addLayoutComponent(comp:Component, constraints:Object):void{
		tabbedPane.repaint();
		synTabs();
		synTabProperties();
	}
	
	public function removeLayoutComponent(comp:Component):void{
		tabbedPane.repaint();
		synTabs();
		synTabProperties();
	}
	
	public function preferredLayoutSize(target:Container):IntDimension{
		if(target != tabbedPane){
			trace("Error : BasicTabbedPaneUI Can't layout " + target);
			return null;
		}
		if(prefferedSize != null){
			return prefferedSize;
		}
		var insets:Insets = tabbedPane.getInsets();
		
		var w:int = 0;
		var h:int = 0;
		
		for(var i:int=tabbedPane.getComponentCount()-1; i>=0; i--){
			var size:IntDimension = tabbedPane.getComponent(i).getPreferredSize();
			w = Math.max(w, size.width);
			h = Math.max(h, size.height);
		}
		var cm:Insets = contentMargin.clone();
		cm.top = 0;//because tbs included top
		cm = transformMargin(cm);
		var csize:IntDimension = cm.getOutsideSize(new IntDimension(w, h));
		w = csize.width;
		h = csize.height;
		
		var tbs:IntDimension = getTabBarSize();
		if(isTabHorizontalPlacing()){
			w = Math.max(w, tbs.width);
			h += tbs.height;
		}else{
			h = Math.max(h, tbs.height);
			w += tbs.width;
		}
		
		prefferedSize = insets.getOutsideSize(new IntDimension(w, h));
		return prefferedSize;
	}

	public function minimumLayoutSize(target:Container):IntDimension{
		if(target != tabbedPane){
			trace("Error : BasicTabbedPaneUI Can't layout " + target);
			return null;
		}
		if(minimumSize != null){
			return minimumSize;
		}
		var insets:Insets = tabbedPane.getInsets();
		
		var w:int = 0;
		var h:int = 0;
		
		for(var i:int=tabbedPane.getComponentCount()-1; i>=0; i--){
			var size:IntDimension = tabbedPane.getComponent(i).getMinimumSize();
			w = Math.max(w, size.width);
			h = Math.max(h, size.height);
		}
		var cm:Insets = contentMargin.clone();
		cm.top = 0;//because tbs included top
		cm = transformMargin(cm);
		var csize:IntDimension = cm.getOutsideSize(new IntDimension(w, h));
		w = csize.width;
		h = csize.height;
		
		var tbs:IntDimension = getTabBarSize();
		if(isTabHorizontalPlacing()){
			h += tbs.height;
		}else{
			w += tbs.width;
		}
				
		minimumSize = insets.getOutsideSize(new IntDimension(w, h));
		return minimumSize;
	}

	public function maximumLayoutSize(target:Container):IntDimension{
		if(target != tabbedPane){
			trace("Error : BasicTabbedPaneUI Can't layout " + target);
			return null;
		}
		return IntDimension.createBigDimension();
	}
		
	public function layoutContainer(target:Container):void{
		if(target != tabbedPane){
			trace("Error : BasicTabbedPaneUI Can't layout " + target);
			return;
		}
		var n:int = tabbedPane.getComponentCount();
		var selectedIndex:int = tabbedPane.getSelectedIndex();
		
		var insets:Insets = tabbedPane.getInsets();
		var paneBounds:IntRectangle = insets.getInsideBounds(new IntRectangle(0, 0, tabbedPane.getWidth(), tabbedPane.getHeight()));
		var tbs:IntDimension = getTabBarSize();
		if(isTabHorizontalPlacing()){
			paneBounds.height -= (tbs.height + contentMargin.bottom);
			paneBounds.x += contentMargin.left;
			paneBounds.width -= (contentMargin.left + contentMargin.right);
		}else{
			paneBounds.width -= (tbs.width + contentMargin.bottom);
			paneBounds.y += contentMargin.right;
			paneBounds.height -= (contentMargin.left + contentMargin.right);
		}
		var placement:int = tabbedPane.getTabPlacement();
		if(placement == JTabbedPane.LEFT){
			paneBounds.x += tbs.width;
		}else if(placement == JTabbedPane.RIGHT){
			paneBounds.x += contentMargin.bottom;
		}else if(placement == JTabbedPane.BOTTOM){
			paneBounds.y += contentMargin.bottom;
		}else{ //others value are all considered as TOP
			paneBounds.y += tbs.height;
		}
		
		for(var i:int=0; i<n; i++){
			tabbedPane.getComponent(i).setBounds(paneBounds);
			tabbedPane.getComponent(i).setVisible(i == selectedIndex);
		}
	}
	
	public function invalidateLayout(target:Container):void{
		if(target != tabbedPane){
			trace("Error : BasicTabbedPaneUI Can't layout " + target);
			return;
		}
		prefferedSize = null;
		minimumSize = null;
		tabBarSize = null;
		tabBoundArray = null;
		synTabProperties();
	}
	
	public function getLayoutAlignmentX(target:Container):Number{
		return 0;
	}
	
	public function getLayoutAlignmentY(target:Container):Number{
		return 0;
	}	
}
}
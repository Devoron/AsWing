/*
   Copyright aswing.org, see the LICENCE.txt.
 */

package org.aswing.lookandfeel.plaf.basic
{
	import org.aswing.components.buttons.JButton;
	import org.aswing.values.Insets;
	import org.aswing.values.ASFont;
	import org.aswing.lookandfeel.plaf.BaseComponentUI;
	import starling.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.decorators.SideLineDecorator;
	import org.aswing.util.ASTimer;
	import starling.display.Shape;
	
	import devoron.aswing3d.*;
	import org.aswing.event.*;
	import org.aswing.geom.*;
	import org.aswing.graphics.*;
	import org.aswing.plaf.*;
	import org.aswing.plaf.basic.icon.ArrowIcon;
	
	/**
	 * Basic stepper ui imp.
	 * @private
	 */
	public class BasicNumberKnobUI extends BaseComponentUI
	{
		protected var inputText:JTextField;
		protected var stepper:JNumberStepper;
		
		private static var continueSpeedThrottle:int = 60; // delay in milli seconds
		private static var initialContinueSpeedThrottle:int = 500; // first delay in milli seconds
		private var continueTimer:ASTimer;
		
		private var _internalRadius:Number = 2;
		private var _radius:Number = 30;
		
		private var internalCircle:Shape;
		private var knobSprite:Shape;
		private var pointer:Shape;
		
		public function BasicNumberKnobUI()
		{
			super();
			inputText = new JTextField("100");
			inputText.setPreferredSize(new IntDimension(24, 24));
			inputText.setSize(new IntDimension(24, 24));
		/*inputText.doubleClickEnabled = true;
		   inputText.mouseChildren = false;
		   inputText.setEnabled(false);
		 inputText.buttonMode = true;*/
			 //inputText.setFont(();
		
			//inputText.setAlignmentX(AsWingConstants.CENTER);
		}
		
		override public function installUI(c:Component):void
		{
			stepper = JNumberStepper(c);
			//stepper.mouseChildren = true;
			//stepper.mouseEnabled = true;
			stepper.buttonMode = true;
			
			installDefaults();
			installComponents();
			installListeners();
		}
		
		override public function uninstallUI(c:Component):void
		{
			stepper = JNumberStepper(c);
			uninstallDefaults();
			uninstallComponents();
			uninstallListeners();
		}
		
		protected function getPropertyPrefix():String
		{
			return "Stepper.";
		}
		
		protected function installDefaults():void
		{
			var pp:String = getPropertyPrefix();
			LookAndFeel.installBorderAndBFDecorators(stepper, pp);
			LookAndFeel.installColorsAndFont(stepper, pp);
			LookAndFeel.installBasicProperties(stepper, pp);
		}
		
		protected function uninstallDefaults():void
		{
			LookAndFeel.uninstallBorderAndBFDecorators(stepper);
		}
		
		override public function getColor(key:String):ASColor
		{
			switch (key)
			{
				case "Stepper.background": 
					return new ASColor(0x000000, 0);
					break;
				case "Stepper.foreground": 
					return new ASColor(0xFFFFFF, 0.4);
					break;
				case "Stepper.mideground": 
					return new ASColor(0x000000, 0.24);
					break;
			}
			return super.getColor(key);
		}
		
		protected function installComponents():void
		{
			//downButton = createButton(Math.PI / 2);
			//inputText.setBackgroundDecorator(null);
			//inputText.setBackgroundDecorator(new ColorDecorator(new ASColor(0x00FF00, 0.1)));
			//(stepper.getUI() as BasicNumberStepperUI).getTe
			inputText = new JTextField();
			inputText.setPreferredSize(new IntDimension(20, 24));
			inputText.setSize(new IntDimension(20, 24));
			inputText.setBorder(null);
			inputText.setText("100");
			//inputText.setBackgroundDecorator(null);
			//make it proxy to the stepper
			//inputText.setForeground(null);
			inputText.setForeground(new ASColor(0xFFFFFF, 0.5));
			//inputText.setBackground(null);
			//inputText.setMideground(null);
			//inputText.setStyleTune(null);
			//inputText.setEditable(true);
			//inputText.setFont(inputText.getFont().changeSize(12));
			
			var sld:SideLineDecorator = new SideLineDecorator(new ASColor(0, 0), new ASColor(0xFFFFFF, 0.24), 0, SideLineDecorator.SOUTH);
			sld.setGaps(0, 0, 0, -2);
			inputText.setBackgroundDecorator(sld);
			//inputText.setOpaque(true);
			/*	upButton.setUIElement(true);
			 downButton.setUIElement(true);*/
			//inputText.setUIElement(true);
			
			/*upButton.setFocusable(false);
			 downButton.setFocusable(false);*/
			
			/*	stepper.addChild(upButton);
			   stepper.addChild(downButton);
			 */
			stepper.setValue(100);
			stepper.setForeground(new ASColor(0xFFFFFF, 0.5));
			stepper.setPreferredSize(new IntDimension(100, 20));
			stepper.setSize(new IntDimension(100, 20));
			knobSprite = new Shape();
			internalCircle = new Shape();
			pointer = new Shape();
			knobSprite.addChild(internalCircle);
			knobSprite.addChild(pointer);
			
			inputText.setFocusable(false);
			_radius = stepper.getSize().width * .5;
			inputText.setForeground(new ASColor(0xFFFFFF, 0.5));
			inputText.setText("100");
			//inputText.setPreferredSize(new IntDimension(_radius, _radius * .5));
			//inputText.setPreferredSize(new IntDimension(_radius, _radius * .5));
			
			var size:IntDimension = stepper.getSize();
			trace(size);
			drawKnob();
			stepper.addChild(knobSprite);
			stepper.addChild(inputText);
			inputText.setLocationXY(size.width * .5, size.width * .5);
			inputText.x = size.width * .5;
			inputText.y = size.width * .5;
			stepper.mouseChildren = false;
		}
		
		protected function drawKnob():void
		{
			knobSprite.graphics.clear();
			internalCircle.graphics.clear();
			pointer.graphics.clear();
			
			knobSprite.graphics.lineStyle(1, 0xFFFFFF, 0.14);
			//knobSprite.graphics.beginFill(0X000000, 0);
			knobSprite.graphics.drawCircle(_radius, _radius, _radius - 2);
			//knobSprite.graphics.endFill();
			
			internalCircle.graphics.lineStyle(0, 0, 0);
			internalCircle.graphics.beginFill(0XFFFFFF, 0.01);
			internalCircle.graphics.drawCircle(_radius, _radius, _radius - 2.5);
			internalCircle.graphics.endFill();
			
			pointer.graphics.beginFill(0XFFFFFF, 0.4);
			pointer.graphics.drawCircle(2 * _radius - 2 /*- _internalRadius*/, _radius, 2);
			pointer.graphics.endFill();
		/*pointer.graphics.beginFill(0XFFFFFF, 0.24);
		   pointer.graphics.drawCircle(2 * _radius - _internalRadius, _radius, 0.3);
		 pointer.graphics.endFill();*/
		
			//Point
		
			//inputText.setFont((inputText.getFont()).changeSize(_radius * .25));
			//var s:Number = _radius * .1;
			//knobSprite.graphics.beginFill(0x474747, 0.2);
			//knobSprite.graphics.drawRect(_radius, -s, s * 1.5, s * 2);
			//knobSprite.graphics.drawRect(_radius, -s, s * 1.5, s * 2);
			//knobSprite.graphics.endFill();
			//knobSprite.x = _radius;
			//knobSprite.y = _radius + 20;
			//knobSprite.filters = [new BlurFilter(0.5, 0.5, BitmapFilterQuality.HIGH)];
		}
		
		protected function uninstallComponents():void
		{
			/*stepper.removeChild(inputText);
			   stepper.removeChild(upButton);
			 stepper.removeChild(downButton);*/
			
			knobSprite.removeChild(internalCircle);
			knobSprite.removeChild(pointer);
			stepper.removeChild(knobSprite);
			//stepper.removeChild(inputText);
		}
		
		protected function installListeners():void
		{
			stepper.addStateListener(__onValueChanged);
			stepper.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onInputTextKeyDown);
			stepper.addEventListener(AWEvent.FOCUS_GAINED, __onFocusGained);
			stepper.addEventListener(AWEvent.FOCUS_LOST, __onFocusLost);
			stepper.addEventListener(MouseEvent.MOUSE_OVER, __onMouseOver);
			stepper.addEventListener(MouseEvent.MOUSE_OUT, __onMouseOut);
			stepper.addEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown);
			stepper.doubleClickEnabled = true;
			inputText.addEventListener(MouseEvent.MOUSE_WHEEL, __onInputTextMouseWheel);
			inputText.getTextField().addEventListener(Event.CHANGE, __textChanged);
			
			//inputText.doubleClickEnabled = true;
			stepper.addEventListener(MouseEvent.DOUBLE_CLICK, __onInputTextDoubleClick);
			/*upButton.addEventListener(MouseEvent.MOUSE_DOWN, __onUpButtonPressed);
			   upButton.addEventListener(ReleaseEvent.RELEASE, __onUpButtonReleased);
			   downButton.addEventListener(MouseEvent.MOUSE_DOWN, __onDownButtonPressed);
			 downButton.addEventListener(ReleaseEvent.RELEASE, __onDownButtonReleased);*/
			
			continueTimer = new ASTimer(continueSpeedThrottle);
			continueTimer.setInitialDelay(initialContinueSpeedThrottle);
			continueTimer.addActionListener(__continueTimerPerformed);
		}
		
		private var _knobAngleLast:Number = 0;
		private var _handAngleStart:Number;
		private const RAD:Number = Math.PI / 180;
		
		private function __onMouseDown(e:MouseEvent):void
		{
			/*stepper.addEventListener(MouseEvent.MOUSE_MOVE, __onMouseMove);
			 stepper.addEventListener(MouseEvent.MOUSE_UP, __onMouseUp);*/
			
			//_knobAngleLast = knobSprite.rotation;
			_handAngleStart = Math.atan2(knobSprite.mouseY, knobSprite.mouseX) / RAD;
			stepper.stage.addEventListener(MouseEvent.MOUSE_MOVE, __onMouseMove);
			stepper.stage.addEventListener(MouseEvent.MOUSE_UP, __onMouseUp);
		}
		
		private function __onMouseUp(event:MouseEvent):void
		{
			stepper.stage.removeEventListener(MouseEvent.MOUSE_MOVE, __onMouseMove);
			stepper.stage.removeEventListener(MouseEvent.MOUSE_UP, __onMouseUp);
		}
		
		private function __onMouseMove(event:MouseEvent):void
		{
			var handAngle:Number = Math.atan2(knobSprite.mouseY - _radius, knobSprite.mouseX - _radius) / RAD;
			var delta:Number = _handAngleStart - handAngle;
			_handAngleStart = handAngle;
			//stepper.rotation -= delta;
			rotateAroundPoint(pointer, -delta, new Point(_radius, _radius));
		/*if (_knob.rotation < 0 && _knob.rotation > -(360 - 240) )
		   {
		   _knob.rotation = _knobAngleLast;
		   }
		   else
		   {
		   _knobAngleLast = _knob.rotation;
		 }*/
		}
		
		private var oldAngle:Number = 0;
		
		private function __onKeyUp(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SHIFT)
				if (continueTimer.isRunning())
					continueTimer.stop();
		}
		
		private function __onInputTextDoubleClick(e:MouseEvent):void
		{
			inputText.mouseChildren = true;
			stepper.stage.focus = inputText.getTextField();
		}
		
		private function __onMouseOut(e:MouseEvent):void
		{
			internalCircle.filters = null;
			
			stepper.removeEventListener(MouseEvent.MOUSE_MOVE, __onMouseMove);
			stepper.removeEventListener(MouseEvent.MOUSE_UP, __onMouseUp);
			stepper.removeEventListener(MouseEvent.MOUSE_WHEEL, __onMouseWheel);
			
			if (continueTimer.isRunning())
			{
				continueTimer.stop();
			}
			//stepper.stage.addEventListener(KeyboardEvent.KEY_DOWN, __onKeyDown);
			stepper.stage.removeEventListener(KeyboardEvent.KEY_UP, __onKeyUp);
			//stepper.removeEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown);
			//stepper.addEventListener(MouseEvent.MOUSE_MOVE, __onMouseMove);
		}
		
		private function __onMouseOver(e:MouseEvent):void
		{
			internalCircle.filters = [new GlowFilter(0xFFFFFF, 1, 4, 4)];
			stepper.addEventListener(MouseEvent.MOUSE_WHEEL, __onMouseWheel);
			stepper.stage.addEventListener(KeyboardEvent.KEY_UP, __onKeyUp);
		}
		
		private function __onMouseWheel(e:MouseEvent):void
		{
			//e.sh
			/*if (knobSprite.rotation <= 0 && knobSprite.rotation >= -180)
			 {*/ /*if (knobSprite.rotation + e.delta * 6 < -180)
			   return;
			   if (knobSprite.rotation + e.delta * 6 > 0)
			 return;*/
			
			//knobSprite.rotation = knobSprite.rotation + e.delta * 6;
			rotateAroundPoint(knobSprite, e.delta * 6, new flash.geom.Point(_radius, _radius));
			
			stepper.setValue(stepper.getValue() + e.delta * stepper.getUnitIncrement(), false);
			inputText.setText(String(stepper.getValue() + e.delta * stepper.getUnitIncrement()));
			
			if (e.shiftKey && !continueTimer.isRunning())
			{
				continueTimer.restart();
				timerContinued = 0;
				timerIncrement = stepper.getUnitIncrement();
			}
		}
		
		private var timerIncrement:Number;
		private var timerContinued:int;
		
		/*private function __onUpButtonPressed(e:Event):void
		   {
		   timerIncrement = stepper.getUnitIncrement();
		   makeStepper(timerIncrement);
		   continueTimer.restart();
		   timerContinued = 0;
		   }
		
		   private function __onUpButtonReleased(e:Event):void
		   {
		   continueTimer.stop();
		   fireActionEvent();
		 }*/
		
		private function __continueTimerPerformed(e:AWEvent):void
		{
			makeStepper(timerIncrement);
			timerContinued++;
			
			if (timerContinued >= 5)
			{
				timerContinued = 0;
				timerIncrement *= 2;
			}
		}
		
		protected var rotateAngle:Number = 0;
		
		/**
		 *
		 * @param	target
		 * @param	angle Radians
		 * @param	transformationPoint
		 */
		private function rotateAroundPoint(target:DisplayObject, angle:Number, transformationPoint:flash.geom.Point):void
		{
			
			var m:Matrix = target.transform.matrix;
			
			//m.ro
			rotateAngle += angle;
			if (rotateAngle > 360)
			{
				rotateAngle = rotateAngle - 360;
			}
			else if (rotateAngle < 0)
			{
				rotateAngle = 360 + rotateAngle;
			}
			
			trace("3:angle " + rotateAngle);
			stepper.setValue(rotateAngle);
			
			transformationPoint = m.transformPoint(transformationPoint);
			
			m.tx -= transformationPoint.x;
			m.ty -= transformationPoint.y;
			m.rotate(angle * (Math.PI / 180));
			//m.tx += transformationPoint.x;
			//m.ty += transformationPoint.y;
			m.ty += _radius;
			m.tx += _radius;
			target.transform.matrix = m;
		}
		
		protected function uninstallListeners():void
		{
			stepper.removeStateListener(__onValueChanged);
			stepper.removeEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onInputTextKeyDown);
			stepper.removeEventListener(AWEvent.FOCUS_GAINED, __onFocusGained);
			stepper.removeEventListener(AWEvent.FOCUS_LOST, __onFocusLost);
			stepper.removeEventListener(MouseEvent.MOUSE_OVER, __onMouseOver);
			stepper.removeEventListener(MouseEvent.MOUSE_OUT, __onMouseOut);
			stepper.removeEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown);
			stepper.removeEventListener(MouseEvent.MOUSE_UP, __onMouseUp);
			
			//inputText.removeEventListener(MouseEvent.MOUSE_WHEEL, __onInputTextMouseWheel);
			inputText.getTextField().removeEventListener(Event.CHANGE, __textChanged);
			stepper.removeEventListener(MouseEvent.DOUBLE_CLICK, __onInputTextDoubleClick);
			/*upButton.removeEventListener(MouseEvent.MOUSE_DOWN, __onUpButtonPressed);
			   upButton.removeEventListener(ReleaseEvent.RELEASE, __onUpButtonReleased);
			   downButton.removeEventListener(MouseEvent.MOUSE_DOWN, __onDownButtonPressed);
			 downButton.removeEventListener(ReleaseEvent.RELEASE, __onDownButtonReleased);*/
			
			continueTimer.stop();
			continueTimer = null;
		}
		
		override public function paint(c:Component, g:Graphics2D, b:IntRectangle):void
		{
			super.paint(c, g, b);
			layoutStepper();
			
			/*var sizm:IntDimension = new IntDimension((_radius ) * 2 - _internalRadius * 2 - insets.left - insets.right, td.height * .25);
			 inputText.setMaximumSize(sizm);*/ /*upButton.setEnabled(stepper.isEnabled());
			 downButton.setEnabled(stepper.isEnabled());*/
			knobSprite.alpha = stepper.isEnabled() ? 1 : 0.5;
			internalCircle.alpha = stepper.isEnabled() ? 1 : 0.5;
			pointer.alpha = stepper.isEnabled() ? 1 : 0.5;
			
			//stepper.stage.focus = stepper;
			//stepper.setFont(stepper.getFont().changeSize(12));
			/*var font:ASFont = new ASFont("Tahoma", 14);
			 inputText.setFont(font);*/
			//inputText.setFont(inputText.getFont().changeSize(20));
			var advProp:ASFontAdvProperties = new ASFontAdvProperties(true, "advanced", "pixel");
			//var font:ASFont = new ASFont("Tahoma", b.height * .2, false, false, false, advProp);
			var font:ASFont = new ASFont("Tahoma", b.height * .2, false, false, false, advProp);
			var tf:TextFormat = font.getTextFormat();
			tf.align = TextFormatAlign.CENTER;
			font.setTextFormat(tf);
			inputText.setFont(font);
			//inputText.setEditable(false);
			//inputText
			//inputText.setEnabled(false);
			//inputText.setAlignmentY(AsWingConstants.TOP);
			//inputText.mouseChildren = false;
			//inputText.setBackgroundDecorator(new ColorDecorator(new ASColor(0x008080, 0.4)));
			//inputText.setForeground(stepper.getForeground());
			inputText.setForeground(new ASColor(0xFFFFFF, 0.5));
			//inputText.setMaxChars(stepper.getMaxChars());
			//inputText.setRestrict(stepper.getRestrict());
			//inputText.setEditable(stepper.isEditable());
			//inputText.setEnabled(stepper.isEnabled());
			fillInputTextWithCurrentValue();
		}
		
		override protected function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):void
		{
			//do nothing, background decorator will paint it
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
		
		/**
		 * Returns the input text to receive the focus for the component.
		 * @param c the component
		 * @return the object to receive the focus.
		 */
		override public function getInternalFocusObject(c:Component):InteractiveObject
		{
			return inputText.getTextField();
		}
		
		protected function fillInputTextWithCurrentValue():void
		{
			inputText.setText(getShouldFilledText());
		}
		
		protected function getShouldFilledText():String
		{
			var value:Number = stepper.getValue();
			var text:String = stepper.getValueTranslator()(value);
			return text;
		}
		
		//--------------------- handlers--------------------
		
		private function __onValueChanged(e:Event):void
		{
			if (!textInputing)
			{
				fillInputTextWithCurrentValue();
			}
		}
		
		private function __onInputTextMouseWheel(e:MouseEvent):void
		{
			stepper.setValue(stepper.getValue() + e.delta * stepper.getUnitIncrement(), false);
		}
		
		private var textInputing:Boolean = false;
		
		private function __textChanged(e:Event):void
		{
			textInputing = true;
			var text:String = inputText.getText();
			var value:int = stepper.getValueParser()(text);
			stepper.setValue(value, false);
			textInputing = false;
		}
		
		private function __inputTextAction(fireActOnlyIfChanged:Boolean = false):void
		{
			var text:String = inputText.getText();
			var value:Number = stepper.getValueParser()(text);
			stepper.setValue(value, false);
			
			//inputText.setEditable(false);
			inputText.mouseChildren = false;
			stepper.stage.focus = stepper;
			
			if (!fireActOnlyIfChanged)
			{
				fireActionEvent();
			}
			else if (value != startEditingValue)
			{
				fireActionEvent();
			}
		}
		
		protected var startEditingValue:int;
		
		protected function fireActionEvent():void
		{
			startEditingValue = stepper.getValue();
			fillInputTextWithCurrentValue();
			stepper.dispatchEvent(new AWEvent(AWEvent.ACT));
		}
		
		private function __onFocusGained(e:AWEvent):void
		{
			startEditingValue = stepper.getValue();
		}
		
		private function __onFocusLost(e:AWEvent):void
		{
			trace("focus lost");
			__inputTextAction(true);
		}
		
		private function __onInputTextKeyDown(e:FocusKeyEvent):void
		{
			var code:uint = e.keyCode;
			var unit:Number = stepper.getUnitIncrement();
			var delta:Number = 0;
			if (code == Keyboard.ENTER)
			{
				__inputTextAction(false);
				return;
			}
			if (code == Keyboard.HOME)
			{
				stepper.setValue(stepper.getMinimum(), false);
				return;
			}
			else if (code == Keyboard.END)
			{
				stepper.setValue(stepper.getMaximum() - stepper.getExtent(), false);
				return;
			}
			if (code == Keyboard.UP)
			{
				delta = unit;
			}
			else if (code == Keyboard.DOWN)
			{
				delta = -unit;
			}
			else if (code == Keyboard.PAGE_UP)
			{
				delta = unit;
			}
			else if (code == Keyboard.PAGE_DOWN)
			{
				delta = -unit;
			}
			makeStepper(delta);
		}
		
		private function makeStepper(step:Number):void
		{
			stepper.setValue(stepper.getValue() + step, false);
		}
		
		//---------------------Layout Implementation---------------------------
		protected function layoutStepper():void
		{
			//var td:IntDimension = new IntDimension(_radius * 2, _radius * 2);
			var td:IntDimension = stepper.getSize();
			_radius = td.width * .5;
			var insets:Insets = stepper.getInsets();
			var top:int = insets.top;
			var left:int = insets.left;
			var right:int = td.width - insets.right;
			
			var height:int = td.height - insets.top - insets.bottom;
			
			/*var sizm:IntDimension = new IntDimension((_radius ) * 2 - _internalRadius * 2 - insets.left - insets.right, td.height * .25);
			 inputText.setMaximumSize(sizm);*/
			//var buttonSize:IntDimension = new IntDimension(100, 100);
			/*upButton.setSizeWH(buttonSize.width, height / 2);
			   upButton.setLocationXY(right - buttonSize.width, top);
			   downButton.setSizeWH(buttonSize.width, height / 2);
			 downButton.setLocationXY(right - buttonSize.width, top + height / 2);*/
			drawKnob();
			
			inputText.setLocationXY(insets.left + _internalRadius, td.height * .5 - td.height * .25 * .5 - _internalRadius * .5);
			//inputText.setSizeWH(td.width - insets.left - insets.right - buttonSize.width, td.height * .25);
			inputText.setSizeWH((_radius) * 2 - _internalRadius * 2 - insets.left - insets.right, td.height * .25 + 2);
			
			//
			var font:ASFont = inputText.getFont();
			font = font.changeSize(20);
			inputText.setFont(font);
			//trace("inputText " + inputText.getFont());
		
			//inputText.app
			//inputText.setSizeWH(50, 100*.5);
		}
		
		override public function getPreferredSize(c:Component):IntDimension
		{
			var insets:Insets = stepper.getInsets();
			inputText.setColumns(stepper.getColumns());
			var inputSize:IntDimension = new IntDimension(_radius * 2, _radius * 2);
			/*var buttonSize:IntDimension = upButton.getPreferredSize();*/ /*var buttonSize:IntDimension = new IntDimension(100, 100);
			   inputSize.width += buttonSize.width;
			 inputSize.height += buttonSize.height;*/
			
			//return insets.getOutsideSize(inputSize);
			return inputSize;
		}
		
		override public function getMinimumSize(c:Component):IntDimension
		{
			var buttonSize:IntDimension = new IntDimension(10, 10);
			//var buttonSize:IntDimension = upButton.getPreferredSize();
			//buttonSize.height *= 2;
			return stepper.getInsets().getOutsideSize(buttonSize);
		}
		
		override public function getMaximumSize(c:Component):IntDimension
		{
			return IntDimension.createBigDimension();
		}
	
	}
}
/*
   Copyright aswing.org, see the LICENCE.txt.
 */

package org.aswing.components.buttons
{
	import org.aswing.models.ButtonModel;
	import org.aswing.util.ArrayUtils;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import org.aswing.event.AWEvent;
	
	/**
	 * This class is used to create a multiple-exclusion scope for a set of buttons.
	 * Creating a set of buttons with the same ButtonGroup object means that turning "on"
	 * one of those buttons turns off all other buttons in the group.
	 * <p>
	 * A ButtonGroup can be used with any set of objects that inherit from AbstractButton.
	 * Typically a button group contains instances of JRadioButton, JRadioButtonMenuItem,
	 * or JToggleButton. It wouldn't make sense to put an instance of JButton or JMenuItem in a button group because JButton and JMenuItem don't implement the selected state.
	 * </p>
	 * <p>
	 * Initially, all buttons in the group are unselected. Once any button is selected, one button is always selected in the group. There is no way to turn a button programmatically to "off", in order to clear the button group. To give the appearance of "none selected", add an invisible radio button to the group and then programmatically select that button to turn off all the displayed radio buttons. For example, a normal button with the label "none" could be wired to select the invisible radio button.
	 * </p>
	 * @author iiley
	 * @author Aron (added the allowUncheck feature)
	 */
	public class ButtonGroup implements IEventDispatcher
	{
		/**
		 * Only can select one most item at a time.
		 */
		public static const SINGLE_SELECTION:int = 0;
		/**
		 * Can select any item at a time.
		 */
		public static const MULTIPLE_SELECTION:int = 1;
		
		// the list of buttons participating in this group
		protected var buttons:Array;
		
		private var allowUncheck:Boolean;
		
		/**
		 * The current selection.
		 */
		private var selection:ButtonModel = null;
		private var selections:Vector.<ButtonModel>;
		private var mode:int;
		
		protected var dispatcher:EventDispatcher;
		
		/**
		 * Creates a new <code>ButtonGroup</code>.
		 */
		public function ButtonGroup(allowUncheck:Boolean = false, mode:int = ButtonGroup.SINGLE_SELECTION, useEventDispatcher:Boolean = false)
		{
			this.allowUncheck = allowUncheck;
			this.mode = mode;
			
			if (mode == ButtonGroup.MULTIPLE_SELECTION)
				selections = new Vector.<ButtonModel>();
			
			buttons = new Array();
			
			if (useEventDispatcher)
			{
				dispatcher = new EventDispatcher(this);
			}
		}
		
		/**
		 * Create a button group and append the buttons in, then return the group.
		 * @return the button group.
		 */
		public static function groupButtons(... buttons):ButtonGroup
		{
			var g:ButtonGroup = new ButtonGroup();
			for each (var i:AbstractButton in buttons)
			{
				g.append(i);
			}
			return g;
		}
		
		/**
		 * Adds the button to the group.
		 *
		 * @param b the button to be added
		 */
		public function append(b:AbstractButton):void
		{
			if (b == null)
			{
				return;
			}
			buttons.push(b);
			
			if (mode == ButtonGroup.SINGLE_SELECTION)
			{
				if (b.isSelected())
				{
					if (selection == null)
					{
						selection = b.getModel();
					}
					else
					{
						b.setSelected(false);
					}
				}
			}
			else
			{
				selections.push(b.getModel());
			}
			
			b.getModel().setGroup(this);
			
			if (dispatcher)
			{
				b.addActionListener(onButtonStateChange);
			}
		}
		
		/**
		 * Appends all buttons into this group.
		 */
		public function appendAll(... buttons):void
		{
			for each (var i:AbstractButton in buttons)
				append(i);
		}
		
		/**
		 * Removes the button from the group.
		 *
		 * @param b the button to be removed
		 */
		public function remove(b:AbstractButton):void
		{
			if (b == null)
			{
				return;
			}
			ArrayUtils.removeFromArray(buttons, b);
			
			if (mode == ButtonGroup.SINGLE_SELECTION)
			{
				if (b.getModel() == selection)
				{
					selection = null;
				}
			}
			else
			{
				var selId:int = selections.indexOf(b.getModel());
				if (selId > -1)
				{
					selections.splice(selId, 1);
				}
			}
			b.getModel().setGroup(null);
			
			if (dispatcher)
			{
				b.removeActionListener(onButtonStateChange);
			}
		}
		
		public function removeAll():void
		{
			for each (var button:AbstractButton in buttons)
				remove(button);
		}
		
		/**
		 * Returns whether the group contains the button.
		 * @return true if the group contains the button, false otherwise
		 */
		public function contains(b:AbstractButton):Boolean
		{
			for (var i:Number = 0; i < buttons.length; i++)
			{
				if (buttons[i] == b)
				{
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Returns all the buttons that are participating in this group.
		 *
		 * @return an <code>Array</code> of the buttons in this group
		 */
		public function getElements():Array
		{
			return ArrayUtils.cloneArray(buttons);
		}
		
		/**
		 * Returns the model of the selected button.
		 *
		 * @return the selected button model
		 */
		public function getSelection():ButtonModel
		{
			return selection;
		}
		
		public function getSelectedIndices():Array
		{
			var indices:Array = new Array();
			
			var index:int;
			for (var i:int = 0; i < buttons.length; i++)
			{
				index = selections.indexOf(AbstractButton(buttons[i]).getModel());
				if (index > -1)
					indices.push(i);
			}
			return indices;
		}
		
		public function getSelectedIndex():int
		{
			for (var i:int = 0; i < buttons.length; i++)
				if (AbstractButton(buttons[i]).getModel() == selection)
					return i;
			return -1;
		}
		
		public function getSelectedButtonText():String
		{
			var selId:int = getSelectedIndex();
			if (selId == -1)
				return "";
				
			return AbstractButton(buttons[selId]).getText();
		}
		
		public function setSelectedIndex(index:uint):void
		{
			setSelected(AbstractButton(buttons[index]).getModel(), true);
			//AbstractButton(buttons[index]).dispatchEvent(new AWEvent(AWEvent.ACT));
		}
		
		public function setSelectedIndices(indices:Array):void
		{
			var index:uint;
			for (var i:int = 0; i < indices.length; i++)
			{
				index = indices[i];
				if (index < buttons.length - 1)
				{
					setSelected(AbstractButton(buttons[index]).getModel(), true);
					//AbstractButton(buttons[index]).dispatchEvent(new AWEvent(AWEvent.ACT));
				}
			}
		}
		
		/**
		 * Return the first selected button, if none, return null.
		 */
		public function getSelectedButton():AbstractButton
		{
			for each (var b:AbstractButton in buttons)
				if (b.isSelected())
					return b;
			return null;
		}
		
		public function getSelectedButtons():Array
		{
			var selectedButtons:Array = new Array();
			
			for each (var b:AbstractButton in buttons)
				if (b.isSelected())
					selectedButtons.push(b);
			return selectedButtons;
		}
		
		/**
		 * Sets the selected value for the <code>ButtonModel</code>. Only one
		 * button in the group may be selected at a time.
		 *
		 * @param m the <code>ButtonModel</code>
		 * @param b <code>true</code> if this button is to be selected,
		 *            otherwise <code>false</code>
		 */
		public function setSelected(m:ButtonModel, b:Boolean):void
		{
			if (mode == ButtonGroup.SINGLE_SELECTION)
			{
				if (b && m != null && m != selection)
				{
					var oldSelection:ButtonModel = selection;
					selection = m;
					if (oldSelection != null)
					{
						oldSelection.setSelected(false);
					}
					m.setSelected(true);
				}
				else if (!b && m != null && allowUncheck)
				{
					selection = null;
						//m.setSelected(false);
				}
			}
			else
			{
				var selId:int = selections.indexOf(m);
				if (b)
				{
					if (selId == -1)
					{
						selections.push(m);
						m.setSelected(true);
					}
				}
				else
				{
					if (selId > -1)
						selections.splice(selId, 1);
				}
					//m.setSelected(b);
			}
		
		}
		
		private function onButtonStateChange(e:Event):void
		{
			dispatcher.dispatchEvent(new AWEvent(AWEvent.ACT));
		}
		
		public function addActionListener(listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			dispatcher.addEventListener(AWEvent.ACT, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeActionListener(listener:Function):void
		{
			dispatcher.removeEventListener(AWEvent.ACT, listener);
		}
		
		/**
		 * Returns whether a <code>ButtonModel</code> is selected.
		 *
		 * @return <code>true</code> if the button is selected, otherwise returns
		 *         <code>false</code>
		 */
		public function isSelected(m:ButtonModel):Boolean
		{
			if (mode == ButtonGroup.MULTIPLE_SELECTION)
			{
				return selections.indexOf(m) > -1;
			}
			return (m == selection);
		}
		
		/**
		 * Returns the number of buttons in the group.
		 *
		 * @return the button count
		 */
		public function getButtonCount():uint
		{
			return buttons.length;
		}
		
		public function setAllowUncheck(allowUncheck:Boolean):void
		{
			this.allowUncheck = allowUncheck;
		}
		
		/* INTERFACE flash.events.IEventDispatcher */
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return dispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return dispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return dispatcher.willTrigger(type);
		}
	
	}

}
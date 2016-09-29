/*
   Copyright aswing.org, see the LICENCE.txt.
 */

package org.aswing.plaf.basic.adjuster
{
	import org.aswing.components.Component;
	import org.aswing.plaf.basic.icon.SliderThumbIcon;
	
	/**
	 * @private
	 */
	public class PopupSliderThumbIcon extends SliderThumbIcon
	{
		
		public function PopupSliderThumbIcon()
		{
			super();
		}
		
		override protected function getPropertyPrefix():String
		{
			return "Adjuster.";
		}
		
		override public function getIconHeight(c:Component):int
		{
			return 12;
		}
		
		override public function getIconWidth(c:Component):int
		{
			return 12;
		}
	
	}
}
package org.aswing
{
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.JTextField;
	
	/**
	 * ...
	 * @author DEVORON
	 */
	public class JDateTextField extends JTextField
	{
		
		public function JDateTextField(text:String = "", columns:int = 0)
		{
			super(text, columns);
			var tfColor:ASColor = new ASColor(0x000000, 0.6);
			var clr1:ASColor = new ASColor(0X32484E, 0);
			var clr2:ASColor = new ASColor(0X000000, 0.14);
			
			super.setBackgroundDecorator(new ColorDecorator(clr1, clr2));
			super.setForeground(tfColor);
			
			super.setMinimumWidth(115);
			super.setPreferredWidth(115);
			super.setMaxChars(19);
			super.setRestrict("0-9,.,:, ");
		}
	
	}

}
package org.aswing 
{
	import org.aswing.decorators.ColorBackgroundDecorator;
	import org.aswing.JTextField;
	/**
	 * ...
	 * @author DEVORON
	 */
	public class JColorTextField extends JTextField
	{
		
		public function JColorTextField(text:String="", columns:int=0) 
		{
			super(text, columns);
			var tfColor:ASColor = new ASColor(0x000000, 0.6);
			var clr1:ASColor = new ASColor(0X32484E, 0);
			var clr2:ASColor = new ASColor(0X000000, 0.14);
			
			super.setBackgroundDecorator(new ColorBackgroundDecorator(clr1, clr2));
			super.setForeground(tfColor);
			
			super.setMinimumWidth(60);
			super.setPreferredWidth(60);
			super.setMaxChars(8);
			super.setRestrict("0-9,a-f,x");
		}
		
	}

}
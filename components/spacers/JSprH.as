package org.aswing 
{
	import org.aswing.ASColor;
	import org.aswing.geom.IntDimension;
	import org.aswing.JSeparator;
	
	/**
	 * ...
	 * @author DEVORON
	 */
	public class JSprH extends JSeparator 
	{
		
		public function JSprH(w:int = 260, h:int = 2) 
		{
			super(JSeparator.HORIZONTAL);
			super.setSize(new IntDimension(w, h));
			super.setBackground(ASColor.getASColor(255, 255, 255, 0.25));
			super.setPreferredWidth(w);
		}
		
	}

}
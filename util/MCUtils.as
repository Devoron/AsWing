package devoron.aswing3d.util
{
	
	/*
	   Copyright aswing.org, see the LICENCE.txt.
	 */
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.text.TextField;
	
	/**
	 * Utils functions about MovieClip
	 * @author iiley
	 */
	public class MCUtils
	{
		
		/**
		 * Transform the position in fromMC to toMC and return it.
		 */
		public static function locationTrans(fromMC:MovieClip, toMC:MovieClip, p:Point):Point
		{
			fromMC.localToGlobal(p);
			toMC.globalToLocal(p);
			return p;
		}
		
		/**
		 * Returns is the MovieClip is exist.
		 */
		public static function isMovieClipExist(mc:MovieClip):Boolean
		{
			if (mc == null)
				return false;
			if (mc.totalFrames > 0)
				return true;
			return true;
		}
		
		/**
		 * Returns is the MovieClip is exist.
		 */
		public static function isTextFieldExist(tf:TextField):Boolean
		{
			if (tf == null)
				return false;
			if (tf.height > 0)
				return true;
			return true;
		}
	}

}
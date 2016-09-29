package devoron.aswing3d.graphics{
	import flash.display.MovieClip;

/*
 Copyright aswing.org, see the LICENCE.txt.
*/

/**
 * Brush to draw filled drawing.
 * @author iiley
 */
public interface Brush{
	
	function beginFill(target:MovieClip):void;
	
	function endFill(target:MovieClip):void;
}

}
/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.table{

/**
 * @author iiley
 */
public interface Resizable2{
	
    function getElementCount():int;
    
    function getLowerBoundAt(i:int):int;
    
    function getUpperBoundAt(i:int):int;
    
    function setSizeAt(newSize:int, i:int):void;
    
}

}
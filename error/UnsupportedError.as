/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.error{


/**
 * This error indicates that a function/operation is not supported.
 */
public class UnsupportedError extends Error{
	
	public function UnsupportedError(type:String){
		super("This function/operation is not supported!!");
	}
	
}
}
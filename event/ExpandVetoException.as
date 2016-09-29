/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.event { 
	
/**
 * Exception used to stop and expand/collapse from happening.
 * @author iiley
 */
public class ExpandVetoException extends Error {
	
	public function ExpandVetoException(message : String) {
		super(message);
	}

}
}
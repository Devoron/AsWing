/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.skinbuilder{

import devoron.aswing3d.*;
import devoron.aswing3d.border.EmptyBorder;
import devoron.aswing3d.plaf.UIResource;
import devoron.aswing3d.error.ImpMissError;
import org.aswing.Insets;

public class SkinEmptyBorder extends EmptyBorder implements UIResource{
	
	public function SkinEmptyBorder(top:int=0, left:int=0, bottom:int=0, right:int=0){
		super(null, new Insets(top, left, bottom, right));
	}
	
}
}
/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.plaf.basic.border{

import org.aswing3d.Insets;
import devoron.aswing3d.Border;
import devoron.aswing3d.plaf.UIResource;
import devoron.aswing3d.border.EmptyBorder;

public class EmptyBorderResource extends EmptyBorder implements UIResource{
	
	public function EmptyBorderResource(interior:Border=null, margin:Insets=null){
		super(interior, margin);
	}
	
}
}
/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.skinbuilder{

import org.aswing.graphics.Graphics2D;
import org.aswing.geom.*;
import devoron.aswing3d.*;
import flash.display.*;
import org.aswing.plaf.*;
import flash.events.*;
import org.aswing.event.*;

public class SkinScrollBarThumb extends OrientableThumb{

    override protected function getPropertyPrefix():String{
    	return "ScrollBar.";
    }
}
}
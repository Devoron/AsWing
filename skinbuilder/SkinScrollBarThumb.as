/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.skinbuilder{

import devoron.aswing3d.graphics.Graphics2D;
import devoron.aswing3d.geom.*;
import devoron.aswing3d.*;
import flash.display.*;
import devoron.aswing3d.plaf.*;
import flash.events.*;
import devoron.aswing3d.event.*;

public class SkinScrollBarThumb extends OrientableThumb{

    override protected function getPropertyPrefix():String{
    	return "ScrollBar.";
    }
}
}
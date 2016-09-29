package devoron.aswing3d.skinbuilder{


/**
 * @author iiley (Burstyx Studio)
 */
public class SkinAdjusterBackground extends SkinAbsEditorBackground{
	
	public function SkinAdjusterBackground()
	{
		super();
	}
	
	override protected function getPropertyPrefix():String {
		return "Adjuster.";
	}
	
}
}
package devoron.aswing3d.skinbuilder{


/**
 * @author iiley (Burstyx Studio)
 */
public class SkinStepperBackground extends SkinAbsEditorBackground{
	
	public function SkinStepperBackground()
	{
		super();
	}
	
	override protected function getPropertyPrefix():String {
		return "Stepper.";
	}
}
}
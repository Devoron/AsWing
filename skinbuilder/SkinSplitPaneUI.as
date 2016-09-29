package devoron.aswing3d.skinbuilder{
	
import devoron.aswing3d.plaf.basic.BasicSplitPaneUI;
import devoron.aswing3d.plaf.basic.splitpane.Divider;

public class SkinSplitPaneUI extends BasicSplitPaneUI{

	override protected function createDivider():Divider{
		return new SkinSplitPaneDivider(sp);
	}
}
}
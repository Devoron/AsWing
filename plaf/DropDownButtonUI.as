
package devoron.aswing3d.plaf
{
	import devoron.aswing3d.plaf.ComponentUI;
	import devoron.aswing3d.JDropDownButton;

	public interface DropDownButtonUI extends ComponentUI
	{
		function isPopupVisible (c:JDropDownButton) : Boolean;

		function setPopupVisible (c:JDropDownButton, v:Boolean) : void;
	}
}

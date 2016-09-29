package devoron.aswing3d.util 
{
	import devoron.aswing3d.layout.FlowLayout;
	import devoron.aswing3d.Component;
	import devoron.aswing3d.ext.Form;
	import devoron.aswing3d.ext.FormRow;
	import devoron.aswing3d.JPanel;
	import devoron.aswing3d.JSp;
	
	/**
	 * Create form row flow left hold.
	 * Support int values as JSpacer.
	 * @author DEVORON
	 */
	public class LeftHoldRow 
	{
		
		public function LeftHoldRow() 
		{
			
		}
		
		public static function create(ownerForm:Form, gap:int, ...components):FormRow {
			
			
			for (var i:int = 0; i < components.length; i++) 
			{
				var obj:* = components[i];
				if (obj is int) 	components.splice(i, 1, new JSp(obj as int));
			}
			
			var p:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, gap, 0, false));
			for each(var c:Component in components) p.append(c);
			
			return ownerForm.addRow(p);
		}
		

	

		
	}

}
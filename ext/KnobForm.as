package devoron.aswing3d.ext
{
	import devoron.aswing3d.ASColor;
	import devoron.aswing3d.AsWingConstants;
	import devoron.aswing3d.ext.Form;
	import devoron.aswing3d.geom.IntDimension;
	import devoron.aswing3d.JLabel;
	import devoron.aswing3d.JNumberKnob;
	import devoron.aswing3d.JPanel;
	import devoron.aswing3d.layout.BorderLayout;
	import devoron.aswing3d.layout.BoxLayout;
	import devoron.aswing3d.layout.SoftBoxLayout;
	import devoron.aswing3d.NumberBoundedRangeModel;
	
	/**
	 * KnobForm
	 * @author DEVORON
	 */
	public class KnobForm extends JPanel
	{
		/**
		 * Specifies that components should be laid out left to right.
		 */
		public static const X_AXIS:int = AsWingConstants.HORIZONTAL;
		
		/**
		 * Specifies that components should be laid out top to bottom.
		 */
		public static const Y_AXIS:int = AsWingConstants.VERTICAL;
		
		/**
		 * This value indicates that each row of components
		 * should be left-justified(X_AXIS)/top-justified(Y_AXIS).
		 */
		public static const LEFT:int = AsWingConstants.LEFT;
		
		/**
		 * This value indicates that each row of components
		 * should be centered.
		 */
		public static const CENTER:int = AsWingConstants.CENTER;
		
		/**
		 * This value indicates that each row of components
		 * should be right-justified(X_AXIS)/bottom-justified(Y_AXIS).
		 */
		public static const RIGHT:int = AsWingConstants.RIGHT;
		
		/**
		 * This value indicates that each row of components
		 * should be left-justified(X_AXIS)/top-justified(Y_AXIS).
		 */
		public static const TOP:int = AsWingConstants.TOP;
		
		/**
		 * This value indicates that each row of components
		 * should be right-justified(X_AXIS)/bottom-justified(Y_AXIS).
		 */
		public static const BOTTOM:int = AsWingConstants.BOTTOM;
		
		private var titleLB:JLabel
		private var knob:JNumberKnob;
		
		/**
		 * @param title
		 * @param	position the position of the title(TOP or BOTTOM or LEFT or RIGHT), default is TOP
		 * @param align the align of the title(CENTER or LEFT or RIGHT), default is CENTER
		 * @see #setKnobRadius()
		 */
		public function KnobForm(title:String = "", axis:int = X_AXIS, gap:int = 0, position:int = AsWingConstants.LEFT)
		{
			super(new SoftBoxLayout(axis, gap, position));
			titleLB = new JLabel(title);
			knob = new JNumberKnob();
			titleLB.setForeground(new ASColor(0xFFFFFF, 0.8));
			
			appendAll(titleLB, knob);
			
			switch (position)
			{
				case TOP: 
					append(titleLB, TOP);
					append(knob, BOTTOM);
					break;
				case BOTTOM: 
					append(knob, TOP);
					append(titleLB, BOTTOM);
					break;
				case LEFT: 
					append(titleLB, LEFT);
					append(knob, RIGHT);
					break;
				case RIGHT: 
					append(knob, LEFT);
					append(titleLB, RIGHT);
					break;
			}
		
			//addLeftHoldRow(0, titleLB);
			//addLeftHoldRow(0, knob);
		}
		
		public function setModel(model:NumberBoundedRangeModel):void{
			knob.setModel(model);
		}
		
		public function getModel():NumberBoundedRangeModel{
			return knob.getModel();
		}

		
		public function getKnob():JNumberKnob {
			return knob;
		}
		
		public function setKnobRadius(r:uint):void
		{
			//knob.setSize(new IntDimension(r*2, r*2));	
			knob.setPreferredSize(new IntDimension(r * 2, r * 2));
		}
	
	}

}
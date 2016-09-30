/*
   Copyright aswing.org, see the LICENCE.txt.
 */

package org.aswing.lookandfeel.plaf
{
	import org.aswing.border.Border;
	import org.aswing.decorators.GroundDecorator;
	import org.aswing.decorators.Icon;
	
	import org.aswing.plaf.ASColorUIResource;
	import org.aswing.plaf.ASFontUIResource;
	import org.aswing.plaf.UIStyleTune;
	
	/**
	 * The default empty values for ui resources.
	 * A value defined in LAF with null or missing definition, it will be treat as these
	 * default values here.
	 * <p>
	 * For example, if you define button.border = null in the LAF class, then in fact the
	 * <code>UIDefaults</code> will return <code>EmptyUIResources.BORDER</code> to you.
	 * </p>
	 * @author iiley
	 */
	public class EmptyUIResources
	{
		/**
		 * The default empty value for border.
		 */
		public static const BORDER:Border = DefaultEmptyDecoraterResource.INSTANCE;
		
		/**
		 * The default empty value for icon.
		 */
		public static const ICON:Icon = DefaultEmptyDecoraterResource.INSTANCE;
		
		/**
		 * The default empty value for ground decorator.
		 */
		public static const DECORATOR:GroundDecorator = DefaultEmptyDecoraterResource.INSTANCE;
		
		/**
		 * The default empty value for insets.
		 */
		public static const INSETS:InsetsUIResource = new InsetsUIResource();
		
		/**
		 * The default empty value for font.
		 */
		public static const FONT:ASFontUIResource = new ASFontUIResource();
		
		/**
		 * The default empty value for color.
		 */
		public static const COLOR:ASColorUIResource = new ASColorUIResource();
		
		/**
		 * The default empty value for style tune.
		 */
		public static const STYLE_TUNE:UIStyleTune = new UIStyleTune();
	}

}
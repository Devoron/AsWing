package org.aswing 
{
	import org.aswing.Component;
	
	/**
	 * ...
	 * @author DEVORON
	 */
	public interface IContextMenu 
	{
		function addTargetComponent(comp:Component):void;
		function removeTargetComponent(comp:Component):void;
		function getTargetComponents():Array;
	}
	
}
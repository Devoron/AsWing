package devoron.aswing3d.plaf.basic.tabbedpane{

import devoron.aswing3d.Component;

/**
 * The closable tab has a close button.
 * @author iiley
 */
public interface ClosableTab extends Tab{
	
	function getCloseButton():Component;
	
}
}
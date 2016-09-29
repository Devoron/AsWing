/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.event { 

import devoron.aswing3d.CellEditor;

/**
 * CellEditorListener defines the interface for an object that listens
 * to changes in a CellEditor
 *
 * @author iiley
 */
public interface CellEditorListener {
	
    /** This tells the listeners the editor has ended editing */
    function editingStopped(source:CellEditor):void;

    /** This tells the listeners the editor has canceled editing */
    function editingCanceled(source:CellEditor):void;
}
}
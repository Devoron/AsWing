package devoron.aswing3d.tree { 
/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import devoron.aswing3d.tree.TreePath;

/**
 * @author iiley
 */
public class PathPlaceHolder {
    internal var isNew:Boolean;
    internal var path:TreePath;

    public function PathPlaceHolder(path:TreePath, isNew:Boolean) {
		this.path = path;
		this.isNew = isNew;
    }	
}
}
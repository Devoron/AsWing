package devoron.aswing3d.tree { 
/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import devoron.aswing3d.tree.AbstractLayoutCache;
import devoron.aswing3d.tree.FHTreeStateNode;
import devoron.aswing3d.tree.TreePath;

/**
 * @author iiley
 */
public class SearchInfo {
	public var node:FHTreeStateNode;
	public var isNodeParentNode:Boolean;
	public var childIndex:Number;
	private var layoutCatch:AbstractLayoutCache;
	
	public function SearchInfo(layoutCatch:AbstractLayoutCache){
		this.layoutCatch = layoutCatch;
	}

	public function getPath():TreePath {
	    if(node == null){
			return null;
	    }

	    if(isNodeParentNode){
			return node.getTreePath().pathByAddingChild(layoutCatch.getModel().getChild(node.getUserObject(),
						     childIndex));
	    }
	    return node.getTreePath();
	}	
}
}
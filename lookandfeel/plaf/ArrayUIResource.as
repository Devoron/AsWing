package org.aswing.lookandfeel.plaf{
	import org.aswing.lookandfeel.plaf.ArrayUIResource;

public dynamic class ArrayUIResource extends Array implements UIResource{
	
	public function ArrayUIResource(content:Array=null){
		if(content){
			for each(var obj:* in content){
				push(obj);
			}
		}
	}
	
}
}
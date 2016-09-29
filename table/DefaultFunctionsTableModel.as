package devoron.aswing3d.table
{
	import flash.display.Sprite;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import devoron.aswing3d.table.DefaultTableModel;
	import devoron.aswing3d.util.HashMap;
	
	public class DefaultFunctionsTableModel extends DefaultTableModel
	{
		protected var bindingsFunctionArguments:HashMap = new HashMap();
		protected var obj:*;
		
		public function DefaultFunctionsTableModel(properties:Array = null)
		{
		
		}
		
		protected function setBingingFunctionArgs(functionColumn:uint, argsColumn:uint):void
		{
			bindingsFunctionArguments.put(functionColumn, argsColumn);
		}
		
		override public function setValueAt(aValue:*, row:int, column:int):void
		{
			var agrumentsColumn:* = bindingsFunctionArguments.get(column);
			
			// если приходящее значение - имя функции для связанных значений
			// в хэше bindingsFunctionArguments, то считываются аргументы функции
			// и сразу же устанавливаются в ячейку аргументов
			if (agrumentsColumn != null && obj != null)
			{
				var describeClass:XML = describeType(obj);
				var method:XML;
				var args:Array = [];
				
				for each (method in describeClass.method)
				{
					if (method.@name == aValue)
					{
						for each (var element:XML in method.elements())
						{
							if (String(element.name()) == "parameter")
								args.push({value: "", type: String(element.@type), optional: String(element.@optional)});
						}
						break;
					}
				}
				
				//trace(method)
				//trace("args " + args);
				
				setValueAt(args, row, agrumentsColumn);
			}
		}
		
		public function setObject(obj:*):void
		{
			this.obj = obj;
		}
	
	}
}
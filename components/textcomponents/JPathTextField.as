package org.aswing.components.textcomponents
{
	//import devoron.utils.FilesObserver;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.net.SharedObject;
	import flash.system.System;
	import org.aswing.event.AWEvent;
	import org.aswing.JTextField;
	
	//import org.aswing.ext.DataContainerForm;
	
	public class JPathTextField extends JTextField
	{
		public static var maxPathCount:uint = 5;
		private static var lastPathsSO:SharedObject;
		public static var lastPaths:Array = new Array();
		
		protected var fileChangeListener:Function = null;
		protected var _path:String = null;
		
		public function JPathTextField(text:String = "", columns:int = 0)
		{
			super(text, columns);
			addActionListener(sdf);
			
			if (!lastPathsSO)
			{
				try
				{
					lastPathsSO = SharedObject.getLocal("JPathTextField");
					lastPaths = lastPathsSO.data["lastPathes"];
					if (!lastPaths)
						lastPaths = [];
						// здесь же получаем иконки всех файлов
				}
				catch (e:Error)
				{
				}
			}
		
		}
		
		private function sdf(e:AWEvent):void
		{
			//trace( getText());
			//FilesObserver.addFileToObserve( super.getText(), change);
			trace("обновление пути");
			var path:String = super.getText();
			
			if (path != "")
			{
				if (lastPaths.indexOf(path) == -1)
				{
					while (lastPaths.length >= maxPathCount)
						lastPaths.shift();
					lastPaths.push(path);
					
						// получить также иконку файла
				}
			}
			
			trace(lastPaths);
			try
			{
				lastPathsSO.data["lastPathes"] = lastPaths;
				lastPathsSO.flush();
			}
			catch (e:Error)
			{
			}
		
		}
		
		private function change(data:* = null):void
		{
			//trace("changed!!");
			super.dispatchEvent(new AWEvent(AWEvent.ACT));
		
			//if ( (this.getParent() is DataContainerForm)) super.setText( super.getText());
		}
		
		override public function getText():String
		{
			var text:String = super.getText();
			text = text.replace(/\\/g, '/');
			//text = text.replace( /\\/g, '\\\\');
			return text;
		}
		
		override public function setText(text:String):void
		{
			super.setText(text);
		}
	
	}

}
package 
{
	import com.bit101.components.Label;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.display.Sprite;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	
	/**
	 * ...
	 * @author Tommy Salomonsson
	 */
	public class Main extends Sprite 
	{
		private var _label:Label;
		
		public function Main():void 
		{
			_label = new Label(this, 0, 0 , "Drag and drop");
			_label.width = 400;
			
			this.addEventListener( NativeDragEvent.NATIVE_DRAG_ENTER, onDragEnter );
			this.addEventListener( NativeDragEvent.NATIVE_DRAG_DROP, onDragDrop );
		}
		
		private function onDragEnter(e:NativeDragEvent):void 
		{
			NativeDragManager.acceptDragDrop(this);
		}
		
		private function onDragDrop(e:NativeDragEvent):void 
		{
			var files:Array = e.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			for each(var f:File in files)
			{
				_label.text = f.name + ";";
			}
		}
	}
}
package parser 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Tommislav
	 */
	public class SaveData 
	{
		private static var _savedFilesWithKeys:Dictionary = new Dictionary();
		
		private var _askForSaveLocation:Boolean = true;
		private var _destinationFolder:String;
		
		private var _data:String;
		private var _title:String;
		private var _fileName:String;
		private var _key:String;
		private var _fullFileUri:String;
		
		private var _compileTimer:Timer;
		
		
		
		public function SaveData(title:String="Save As", fileName:String="", key:String="") 
		{
			_title = title;
			_fileName = fileName;
			_key = key;
		}
		
		public function saveWithoutBrowse(folder:String):void
		{
			_askForSaveLocation = false;
			_destinationFolder = folder;
		}
		
		public function setData(data:String):void 
		{
			_data = data;
		}
		
		public function execute():void
		{
			try
			{
				var fileUrl:String = (_askForSaveLocation) ? "app:/" : _destinationFolder;
				if (_savedFilesWithKeys[_key] != null)
				{
					fileUrl = _savedFilesWithKeys[_key];
					if (fileUrl.lastIndexOf("/") != fileUrl.length - 1)
						fileUrl += "/";
				}
				
				fileUrl += _fileName;
				
				var file:File = new File(fileUrl);
				if (_askForSaveLocation) {
					file.addEventListener( Event.SELECT, onSaveEvent );
					file.browseForSave( _title );
				}
				else
				{
					doSave(file);
				}
			}
			catch(e:Error)
			{
				throw new Error( "Failed to save data!!\n" + e.message );
			}
		}
		
		private function onSaveEvent( e:Event ):void
		{
			var file:File = e.target as File;
			file.removeEventListener( Event.SELECT, onSaveEvent );
			doSave(file);
		}
		
		private function doSave(file:File):void 
		{
			var stream:FileStream = new FileStream();
			stream.open(file, FileMode.WRITE);
			stream.writeUTFBytes(_data);
			stream.close();
		    
			// Save folder
			_fullFileUri = file.url;
			var uri:String = _fullFileUri.replace(_fileName, "");
			_savedFilesWithKeys[_key] = uri;
			
			_compileTimer = new Timer(500, 1);
			_compileTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			_compileTimer.start();
		}
		
		private function onTimerComplete(e:TimerEvent):void
		{
			_compileTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			
			var compile:CompileSwf = new CompileSwf( _fullFileUri );
			compile.execute();
		}
	}

}
package parser 
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Tommislav
	 */
	public class SaveData 
	{
		private static var _savedFilesWithKeys:Dictionary = new Dictionary();
		
		private var _data:String;
		private var _title:String;
		private var _fileName:String;
		private var _key:String;
		
		
		public function SaveData(data:String, title:String="Save As", fileName:String="", key:String="") 
		{
			_data = data;
			_title = title;
			_fileName = fileName;
			_key = key;
		}
		
		public function execute():void
		{
			try
			{
				var fileUrl:String = "app:/";
				if (_savedFilesWithKeys[_key] != null)
				{
					fileUrl = _savedFilesWithKeys[_key];
					if (fileUrl.lastIndexOf("/") != fileUrl.length - 1)
						fileUrl += "/";
				}
				
				fileUrl += _fileName;
				
				var file:File = new File(fileUrl);
				file.addEventListener( Event.SELECT, onSave );
				file.browseForSave( _title );
				
			}
			catch(e:Error)
			{
				throw new Error( "Failed to save data!!\n" + e.message );
			}
		}
		
		private function onSave( e:Event ):void
		{
			var file:File = e.target as File;
		    
			var stream:FileStream = new FileStream();
			stream.open(file, FileMode.WRITE);
			stream.writeUTFBytes(_data);
			stream.close();
		    
			// Save folder
			var uri:String = file.url;
			uri = uri.replace(_fileName, "");
			_savedFilesWithKeys[_key] = uri;
			
		    // Clean up!
		    file.removeEventListener( Event.SELECT, onSave );
			
			
			
			
		}
	}

}
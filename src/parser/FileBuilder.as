package parser 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	/**
	 * ...
	 * @author Tommislav
	 */
	public class FileBuilder 
	{
		public static function parseFromFile(f:File):RippleFile
		{
			var stream:FileStream = new FileStream();
			stream.open( f, FileMode.READ );
			
			var str:String = stream.readUTFBytes(stream.bytesAvailable);
			var xml:XML = new XML(str);
			var rf:RippleFile;
			
			
			if (xml != null)
			{
				rf = new RippleFile();
				rf.type = Type.UNKNOWN;
				rf.fileName = f.name;
				
				
				if (xml.tileSheets.length() > 0)
				{
					rf.type = Type.SHEET_XML;
					rf.rawData = xml;
				}
				else if (xml.layer.length() > 0 && xml.layer[0].tile.length() > 0)
				{
					rf.type = Type.LEVEL_XML;
					rf.rawData = xml;
				}
			}
			
			
			return rf;
		}
		
		
		public function FileBuilder() 
		{
			
		}
		
	}

}
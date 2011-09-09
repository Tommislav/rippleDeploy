package parser 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.getTimer;
	import parser.level.LevelData;
	import parser.sheet.SheetData;
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
				rf.path = f.url.replace("/" + f.name, "");
				
				if (rf.fileName.lastIndexOf(".xml") == rf.fileName.length - 4)
					rf.fileName = rf.fileName.substr(0, rf.fileName.length - 4);
				
				if (xml.tileSheets.length() > 0)
				{
					rf.type = Type.SHEET_XML;
					rf.rawData = xml;
					
					var start:int = getTimer();
					rf.parsedData = SheetData.fromXml( xml );
					trace("Parse sheet xml " + rf.fileName + " ("+ (getTimer() - start) +" ms)");
				}
				else if (xml.layer.length() > 0 && xml.layer[0].tile.length() > 0)
				{
					rf.type = Type.LEVEL_XML;
					rf.rawData = xml;
					var lstart:int = getTimer();
					rf.parsedData = LevelData.fromXml( xml );
					trace("Parse level xml " + rf.fileName + " ("+ (getTimer() - lstart) +" ms)");
				}
			}
			
			
			return rf;
		}
		
		
		public function FileBuilder() 
		{
			
		}
		
	}

}
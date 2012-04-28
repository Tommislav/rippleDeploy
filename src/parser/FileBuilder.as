package parser 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.getTimer;
	import parser.level.LevelData;
	import parser.log.GlobalLogDispatcher;
	import parser.sheet.SheetData;
	/**
	 * ...
	 * @author Tommislav
	 */
	public class FileBuilder 
	{
		public static function parseFromFile(f:File):RippleFile
		{
			try {
			var stream:FileStream = new FileStream();
			stream.open( f, FileMode.READ );
			}catch (e:Error) {
				throw new Error("Failed to open file: " + f.url + "\n"+e.message);
			}
			
			
			var str:String = stream.readUTFBytes(stream.bytesAvailable);
			var xml:XML = new XML(str);
			var rf:RippleFile;
			
			stream.close();
			
			if (xml != null)
			{
				rf = new RippleFile();
				rf.type = Type.UNKNOWN;
				rf.fileName = f.name;
				rf.path = f.url.replace("/" + f.name, "");
				
				if (rf.fileName.lastIndexOf(".xml") == rf.fileName.length - 4)
					rf.fileName = rf.fileName.substr(0, rf.fileName.length - 4);
				
				var msg:String = "";
				if (xml.tileSheets.length() > 0)
				{
					rf.type = Type.SHEET_XML;
					rf.rawData = xml;
					
					var start:int = getTimer();
					rf.parsedData = SheetData.fromXml( xml );
					SheetData(rf.parsedData).projectDir = rf.path;
					msg = "Parse sheet xml " + rf.fileName + " ("+ (getTimer() - start) +" ms)";
				}
				else if (xml.layer.length() > 0 && xml.layer[0].tile.length() > 0)
				{
					rf.type = Type.LEVEL_XML;
					rf.rawData = xml;
					var lstart:int = getTimer();
					rf.parsedData = LevelData.fromXml( xml );
					msg = "Parse level xml " + rf.fileName + " ("+ (getTimer() - lstart) +" ms)";
				}
			}
			
			GlobalLogDispatcher.log(msg);
			return rf;
		}
		
		
		public function FileBuilder() 
		{
			
		}
		
	}

}
package levelselectcompiler 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import parser.log.GlobalLogDispatcher;
	import parser.Parser;
	import parser.SaveData;
	/**
	 * ...
	 * @author ...
	 */
	public class BatchCompiler 
	{
		public static function isBatchCompilable(f:File):Boolean
		{
			return (readTextFromFile(f).indexOf("#batchCompile") > -1);
		}
		
		public static function batchCompile(f:File):void
		{
			var bc:BatchCompiler  = new BatchCompiler(f.parent.nativePath);
			var str:String = readTextFromFile(f);
			var xml:XML = new XML(str);
			bc.batchCompile(xml);
		}
		
		private static function readTextFromFile(f:File):String {
			var stream:FileStream = new FileStream();
			stream.open( f, FileMode.READ );
			var text:String = stream.readUTFBytes(stream.bytesAvailable);
			stream.close();
			return text;
		}
		
		
		
		
		private var _projectPath:String;
		private var _listOfLevelFiles:Vector.<LevelFiles>;
		private var _parser:Parser;
		private var _delay:int;
		
		
		public function BatchCompiler(projectPath:String) 
		{
			_projectPath = projectPath;
		}
		
		public function batchCompile(levelSelect:XML):void
		{
			_delay = 0;
			_listOfLevelFiles = parseLevelFiles(levelSelect);
			var cnt:int = 0;
			for each(var f:LevelFiles in _listOfLevelFiles)
			{
				populateWithActualFiles(f);
				runThroughParser(f);
				CallLater.log( "---- end of " + (++cnt) + " / " + _listOfLevelFiles.length + "----", (_delay+10));
				_delay += 5000;
			}
			
			CallLater.log("------------All files complete or under way -----------------", _delay);
		}
		
		private function parseLevelFiles(levelSelect:XML):Vector.<LevelFiles> 
		{
			//var dataParser:LevelSelectXmlParser = new LevelSelectXmlParser();
			var dataParser:BatchXmlParser = new BatchXmlParser();
			return dataParser.parse(levelSelect);
			
		}
		
		private function populateWithActualFiles(f:LevelFiles):void 
		{
			f.files.push( getFile(f.sheetXmlPath) );
			for each(var levelInfo:LevelInfo in f.levelData)
				f.files.push(getFile(levelInfo.path));
		}
		
		private function getFile(sheetXmlPath:String):File 
		{
			var path:String = _projectPath + "\\" + sheetXmlPath;
			var f:File = new File(path);
			return f;
		}
		
		
		
		private function runThroughParser(f:LevelFiles):void 
		{
			_parser = new Parser();
			
			for each (var xmlFile:File in f.files)
			{
				CallLater.parseNewFile(_parser, xmlFile, getDelay());
			}
			
			CallLater.saveSilent( _parser, _projectPath + "\\gen\\", getDelay() );
		}
		
		private function log(msg:String):void 
		{
			GlobalLogDispatcher.log(msg);
		}
		
		private function getDelay():int
		{
			var delay:int = _delay;
			_delay += 1000;
			return delay;
		}
	}

}
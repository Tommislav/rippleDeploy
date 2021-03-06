package parser 
{
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import parser.level.LevelData;
	import parser.sheet.SheetData;
	import parser.writer.EmbedMp3Writer;
	import parser.writer.EmbedTileSheetWriter;
	import parser.writer.EmbedTitlecardWriter;
	import parser.writer.ILevelWriter;
	import parser.writer.ISheetWriter;
	import parser.writer.LevelWriter;
	import parser.writer.SoundWriter;
	import parser.writer.SpriteDataWriter;
	import parser.writer.TileDataWriter;
	import parser.writer.TileSheetWriter;
	/**
	 * ...
	 * @author Tommy Salomonsson
	 */
	public class LevelPackWriter
	{
		
		private static var _writer:LevelPackWriter;
		public static function writeLevelPack(model:DataModel):void
		{
			var saveDataCmd:SaveData = new SaveData( "Save As", model.sheetXml.fileName + ".as", "rippleLevelDeploy" );
			writeDataAndSaveToCommand(model, saveDataCmd);
		}
		
		public static function writeSilentLevelPack(model:DataModel, destinationFolder:String):void
		{
			var saveDataCmd:SaveData = new SaveData( "Save As", model.sheetXml.fileName + ".as", "rippleLevelDeploy" );
			saveDataCmd.saveWithoutBrowse(destinationFolder);
			writeDataAndSaveToCommand(model, saveDataCmd);
		}
		
		private static function writeDataAndSaveToCommand(model:DataModel, cmd:SaveData):void
		{
			_writer = new LevelPackWriter();
			_writer.prepare();
			
			// Write sheet data
			var sheetData:Object = (model.sheetXml.isOptimized) ? model.sheetXml.optimizedData : model.sheetXml.parsedData;
			_writer.writeSheetData(SheetData(sheetData), model.sheetXml.fileName);
			
			if (model.levelXml != null)
			{
				// Write level data
				_writer.writeLevelData(model.sheetXml, model.levelXml);
			}
			
			// Final code
			var code:String = _writer.code;
			
			Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, code);
			cmd.setData(code);
			cmd.execute();
		}
		
		
		
		
		[Embed(source='SaveDataTemplate.txt' , mimeType = 'application/octet-stream')]
		private var SaveTemplate:Class;
		
		
		private var _template:String;
		
		private var _sheetWriters:Vector.<ISheetWriter>;
		private var _levelWriters:Vector.<ILevelWriter>;
		
		public function LevelPackWriter() 
		{
			
		}
		
		private function prepare():void
		{
			_template = new SaveTemplate();
		}
		
		
		protected function writeSheetData(data:SheetData, sheetName:String):String
		{
			var writers:Vector.<ISheetWriter> = new <ISheetWriter>[
							new EmbedTileSheetWriter(),
							new EmbedMp3Writer(),
							new TileSheetWriter(),
							new TileDataWriter(),
							new SpriteDataWriter(),
							new SoundWriter()
							];
			
			for (var i:int = 0; i < writers.length; i++ )
			{
				_template = writers[i].write(_template, data);
			}
			
			_template = _template.replace(/\[ClassName\]/g, sheetName);
			return _template;
		}
		
		protected function writeLevelData(sheetData:RippleFile, levels:Vector.<RippleFile>):String
		{
			var embedTitlecardWriter:EmbedTitlecardWriter = new EmbedTitlecardWriter();
			_template = embedTitlecardWriter.write( _template, SheetData(sheetData.parsedData), levels );
			
			
			var levelWriter:LevelWriter = new LevelWriter();
			
			for each( var levelFile:RippleFile in levels )
			{
				_template = _template.replace("[Levels]", "// ### LEVEL "+ levelFile.fileName +" ###\n[Level]\n\n[Levels]");
				
				// don't use optimized data, levels aren't optimized
				var levelData:LevelData = LevelData(levelFile.parsedData);
				_template = levelWriter.write( _template, levelData, levelFile.fileName );
			}
			return _template;
		}
		
		private function get code():String
		{
			var codeWithoutLevelMarker:String = _template.replace("[Levels]", "");
			return codeWithoutLevelMarker;
		}
		
	}

}
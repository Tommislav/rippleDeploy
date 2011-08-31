package parser 
{
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import parser.level.LevelData;
	import parser.sheet.SheetData;
	import parser.writer.EmbedMp3Writer;
	import parser.writer.EmbedTileSheetWriter;
	import parser.writer.ILevelWriter;
	import parser.writer.ISheetWriter;
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
			if (_writer == null)
				_writer = new LevelPackWriter();
			
			_writer.prepare();
			
			var code:String = "";
			code = _writer.writeSheetData(SheetData(model.sheetXml.optimizedData));
			
			Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, code);
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
		
		
		protected function writeSheetData(data:SheetData):String
		{
			var projectDir:String = data.projectDir;
			var writers:Vector.<ISheetWriter> = new <ISheetWriter>[
							new EmbedTileSheetWriter(projectDir),
							new EmbedMp3Writer(projectDir),
							new TileSheetWriter(),
							new TileDataWriter(),
							new SpriteDataWriter(),
							new SoundWriter()
							];
			
			for (var i:int = 0; i < writers.length; i++ )
			{
				_template = writers[i].write(_template, data);
			}
			return _template;
		}
		
		protected function writeLevelData(data:LevelData):String
		{
			return "";
		}
	}

}
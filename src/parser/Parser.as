package parser 
{
	import flash.filesystem.File;
	import flash.utils.getTimer;
	import parser.level.LevelData;
	import parser.sheet.SheetData;
	/**
	 * ...
	 * @author Tommislav
	 */
	public class Parser 
	{
		private var _model:DataModel;
		
		public function Parser() 
		{
			_model = new DataModel();
		}
		
		public function newFile( file:File ):String
		{
			var rf:RippleFile = FileBuilder.parseFromFile(file);
			if (rf != null)
			{
				if (rf.type == Type.SHEET_XML)
					_model.sheetXml = rf;
				else if (rf.type == Type.LEVEL_XML)
					_model.levelXml.push( rf );
					
				return "File: " + file.name + "; type: " + rf.type + "\n" + rf.parsedData + "\n-----------------------------------";
			}
			return "Unkown file";
		}
		
		public function getAllFiles():Vector.<RippleFile>
		{
			var v:Vector.<RippleFile> = _model.levelXml.slice();
			if ( _model.sheetXml )
				v.unshift( _model.sheetXml );
			
			return v;
		}
		
		public function canOptimize():Boolean
		{
			return (_model.levelXml.length > 0 && _model.sheetXml != null);
		}
		
		public function canSave():Boolean
		{
			if (canOptimize())
			{
				for each (var rf:RippleFile in _model.levelXml)
				{
					if (!rf.isOptimized)
						return false;
				}
				return _model.sheetXml.isOptimized;
			}
			
			return false;
		}
		
		public function optimize():String
		{
			var sheet:SheetData = SheetData(_model.sheetXml.parsedData);
			var levels:Vector.<LevelData> = new Vector.<LevelData>();
			for each(var lvl:RippleFile in _model.levelXml)
				levels.push(lvl.parsedData);
			
			var start:uint = getTimer();
			var optSheet:SheetData = SheetOptimizer.optimizeSheet(sheet, levels);
			var time:uint = getTimer() - start;
			
			
			// Write report
			
			var info:String = "";
			info += "Optimization took " + time + " ms\n";
			info +="Sheets|tiles|sprites\n";
			info += "Compressed:";
			info += optPer(sheet.tileSheets.length, optSheet.tileSheets.length) + "|";
			info += optPer(sheet.tileData.length, optSheet.tileData.length) + "|";
			info += optPer(sheet.sprites.length, optSheet.sprites.length) + "\n";
			
			info += "Old: " + sheet.tileSheets.length + "|" + sheet.tileData.length + "|" + sheet.sprites.length + "\n";
			info += "New: " + optSheet.tileSheets.length + "|" + optSheet.tileData.length + "|" + optSheet.sprites.length;
			return info;
		}
		
		private function optPer(oldVal:Number, newVal:Number):String
		{
			return Math.round(newVal / oldVal * 1000) / 10 + "%";
		}
		
		public function save():void
		{
			
		}
		
		public function reset():void
		{
			_model.levelXml = new Vector.<RippleFile>();
			_model.sheetXml = null;
		}
	}

}
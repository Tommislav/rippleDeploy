package parser 
{
	import flash.filesystem.File;
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
			
			var optSheet:SheetData = SheetOptimizer.optimizeSheet(sheet, levels);
			
			return "Old: " + sheet.tileSheets.length + "/" + sheet.tileData.length + "/" + sheet.sprites.length + ";  new: " + optSheet.tileSheets.length + "/" + optSheet.tileData.length + "/" + optSheet.sprites.length;
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
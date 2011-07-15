package parser 
{
	import flash.filesystem.File;
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
					
				return "File: " + file.name + "; type: " + rf.type;
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
			return "";
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
package parser.writer 
{
	import parser.sheet.SheetData;
	import parser.sheet.TileSheet;
	/**
	 * Will replace [EbmedTileSheets] with "[Embed (source..." - text
	 * All images are accessed as BitmapData through "sheet_" + id
	 * @author Tommy Salomonsson
	 */
	public class EmbedTileSheetWriter implements ISheetWriter
	{
		private var _projectDir:String;
		
		public function EmbedTileSheetWriter(projectDir:String) 
		{
			_projectDir = projectDir;
		}
		
		/* INTERFACE parser.writer.ISheetWriter */
		
		public function write(template:String, data:SheetData):String
		{
			var images:String = "";
			for each (var sheet:TileSheet in data.tileSheets)
			{
				
				var className:String = "Sheet_Class_" + sheet.id;
				var bitmapName:String = "sheet_" + sheet.id;
				
				var src:String = _projectDir + "/" + sheet.src;
				
				images += "[Embed(source='"+ src +"')]\n";
				images += "private var " + className +":Class;\n";
				images += "private var " + bitmapName + ":BitmapData = new " + className + "().bitmapData;\n\n";
			}
			
			return template.replace( /\[EmbedTileSheets\]/g, images );
		}
		
	}

}
package parser.writer 
{
	import parser.sheet.SheetData;
	import parser.sheet.TileSheet;
	/**
	 * will replace [TileSheets] with actionscript code
	 * @author Tommy Salomonsson
	 */
	public class TileSheetWriter implements ISheetWriter
	{
		/* INTERFACE parser.writer.ISheetWriter */
		
		public function write(template:String, data:SheetData):String
		{
			var s:String = "";
			s += "_sheet.tileSheets = {}\n";
			for each (var sheet:TileSheet in data.tileSheets)
			{
				s += "_sheet.tileSheets[" + sheet.id + "] = [";
				s += sheet.id + ",";
				s += "sheet_" + sheet.id + ",";
				s += getShortType(sheet.type) + ",";
				s += sheet.width + "," + sheet.height + "]\n";
			}
			
			return template.replace(/\[TileSheets\]/g, s);
		}
		
		private function getShortType(type:String):String
		{
			return (type == TileSheet.TYPE_TILE) ? "T" : "S";
		}
		
	}

}
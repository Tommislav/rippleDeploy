package parser.writer 
{
	import parser.sheet.SheetData;
	import parser.sheet.TileData;
	/**
	 * Replace [TileData] with real data
	 * @author Tommy Salomonsson
	 */
	public class TileDataWriter implements ISheetWriter
	{
		
		/* INTERFACE parser.writer.ISheetWriter */
		
		public function write(template:String, data:SheetData):String
		{
			var s:String = "";
			s = "_sheet.tileData = [];\n";
			
			for each (var td:TileData in data.tileData)
				s += "_sheet.tileData[" + td.id + "] = ["+td.id+","+td.sheetId+","+td.x+","+td.y+","+ prop(td.prop) +"];\n";
			
			return template.replace( "[TileData]", s );
		}
		
		private function prop(p:Array):String
		{
			if (p == null)
				return "'z'";
			
			var isZero:Boolean = true;
			for (var i:int = 0; i < p.length; i++ )
			{
				if (p[i] != "0")
				{
					isZero = false;
					break;
				}
			}
			if (isZero)
				return "'z'";
			else
				return "[" + p.join(",") + "]";
		}
		
	}

}
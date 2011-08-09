package unittest.parser.sheet 
{
	import parser.sheet.SheetData;
	/**
	 * ...
	 * @author Tommy Salomonsson
	 */
	public class FakeSheetData
	{
		[Embed(source='../../assets/sheet1.xml', mimeType='application/octet-stream')]
		private static var Sheet:Class;
		
		public static function getData():SheetData
		{
			var xml:XML = new XML( new String( new Sheet() ) );
			var sd:SheetData = SheetData.fromXml( xml );
			return sd;
		}
	}
}
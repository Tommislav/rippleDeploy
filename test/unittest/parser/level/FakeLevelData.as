package unittest.parser.level
{
	import parser.level.LevelData;
	/**
	 * ...
	 * @author Tommy Salomonsson
	 */
	public class FakeLevelData
	{
		[Embed(source = '../../assets/level1.xml', mimeType='application/octet-stream')]
		private static var Level:Class;
		
		public static function getData():LevelData
		{
			var xml:XML = new XML(new String(new Level()));
			var ld:LevelData = LevelData.fromXml(xml);
			return ld;
		}
	}

}
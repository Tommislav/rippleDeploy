package levelselectcompiler 
{
	/**
	 * ...
	 * @author ...
	 */
	public class LevelSelectXmlParser 
	{
		
		public function LevelSelectXmlParser() 
		{
			
		}
		
		public function parse(data:XML):Vector.<LevelFiles>
		{
			var list:Vector.<LevelFiles> = new Vector.<LevelFiles>();
			for each(var lvl:XML in data.level)
			{
				var f:LevelFiles = new LevelFiles();
				f.id = lvl.@id;
				f.sheetXmlPath = lvl.@sheet;
				f.levelXmlPath.push(lvl.@level);
				list.push(f);
			}
			return list;
		}
	}

}
package levelselectcompiler 
{
	/**
	 * ...
	 * @author ...
	 */
	public class BatchXmlParser 
	{
		
		public function BatchXmlParser() 
		{
			
		}
		
		public function parse(data:XML):Vector.<LevelFiles>
		{
			var list:Vector.<LevelFiles> = new Vector.<LevelFiles>();
			for each(var sheet:XML in data.level)
			{
				var f:LevelFiles = new LevelFiles();
				f.sheetXmlPath = sheet.@sheet;
				
				for each(var lvl:XML in sheet.lvl)
				{
					var levelInfo:LevelInfo = new LevelInfo();
					levelInfo.id = lvl.@id;
					levelInfo.path = lvl.@level;
					f.levelData.push(levelInfo);
				}
				
				list.push(f);
			}
			return list;
		}
	}

}
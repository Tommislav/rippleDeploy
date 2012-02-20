package parser.writer 
{
	import parser.level.LevelData;
	import parser.RippleFile;
	import parser.sheet.SheetData;
	/**
	 * ...
	 * @author Tommislav
	 */
	public class EmbedTitlecardWriter
	{
		
		public function EmbedTitlecardWriter() 
		{
			
		}
		
		/* INTERFACE parser.writer.ILevelWriter */
		
		public function write(template:String, sheetData:SheetData, data:Vector.<RippleFile>):String 
		{
			var baseUrl:String = sheetData.projectDir;
			var embedCode:String = "";
			for each(var rf:RippleFile in data)
			{
				var level:LevelData = rf.parsedData as LevelData;
				
				var titleCardSrc:Array = [level.titleCard1, level.titleCard2, level.titleCardNum];
				var titleCardName:Array = ["title01", "title02", "titleNum"];
				var levelId:String = String(level.levelId);
				
				for (var i:int = 0; i < 3; i++)
				{
					var src:String = sheetData.projectDir + "/" + titleCardSrc[i];
					src = src.replace(/\%20/g, " ");
					
					var className:String = "Class_" + titleCardName[i] + "_" + levelId;
					var bitmapName:String = titleCardName[i] + "_" + levelId;
					
					embedCode += "[Embed(source='"+ src +"')]\n";
					embedCode += "private var " + className +":Class;\n";
					embedCode += "private var " + bitmapName + ":BitmapData = new " + className + "().bitmapData;\n\n";
				}
				embedCode += "\n";
			}
			
			template = template.replace("[EmbedTitleCards]", embedCode);
			return template;
		}
		
	}

}
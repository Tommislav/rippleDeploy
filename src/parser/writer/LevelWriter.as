package parser.writer 
{
	import flash.geom.Point;
	import parser.level.Layer;
	import parser.level.LevelData;
	import parser.level.Tile;
	/**
	 * ...
	 * @author Tommy Salomonsson
	 */
	public class LevelWriter implements ILevelWriter
	{
		
		/* INTERFACE parser.writer.ILevelWriter */
		
		public function write(template:String, data:LevelData, levelName:String):String
		{
			var levelTemplate:String = "_levels['%name%']={name:'%name%',levelInfo:'%info%',startPos:[%start%],titlecards:[%titleCards%],layers:[%layers%]}\n";
			levelTemplate = levelTemplate.replace(/%name%/g, parseName(levelName));
			levelTemplate = levelTemplate.replace(/%info%/g, data.levelInfo);
			levelTemplate = levelTemplate.replace(/%start%/g, parsePos(data.startPos));
			levelTemplate = levelTemplate.replace(/%titleCards%/g, parseTitleCards(data));
			levelTemplate = levelTemplate.replace(/%layers%/g, parseLayers(data.layers));
			
			return template.replace("[Level]",levelTemplate);
		}
		
		private function parseTitleCards(data:LevelData):String
		{
			var levelId:String = String(data.levelId);
			var title01:String = "title01_%id%".replace(/%id%/, levelId);
			var title02:String = "title02_%id%".replace(/%id%/, levelId);
			var title03:String = "titleNum_%id%".replace(/%id%/, levelId);
			return title01 + "," + title02 + "," + title03;
		}
		
		private function parseName(name:String):String
		{
			name = name.replace(".xml", "");
			return name;
		}
		
		private function parsePos(startPos:Point):String
		{
			return startPos.x + "," + startPos.y;
		}
		
		private function parseLayers(layers:Vector.<Layer>):String
		{
			if (layers == null || layers.length == 0)
				return "";
			
			//var template:String = "[\n{id:%id%,pos:%pos%,obj:%obj%,t:[%tiles%]}\n]";
			var template:String = "{id:'%id%',pos:[%pos%],obj:%obj%,width:%width%,t:[%tiles%]}";
			var a:Array = new Array();
			for each (var lay:Layer in layers)
			{
				a.push(parseLayer(lay, template));
			}
			
			return "\n" + a.join(",\n") + "\n";
		}
		private function parseLayer(lay:Layer, template:String):String
		{
			template = template.replace(/%id%/g, lay.id);
			template = template.replace(/%pos%/g, lay.x + "," + lay.y + "," + lay.d);
			template = template.replace(/%obj%/g, lay.obj);
			template = template.replace(/%width%/g, lay.width);
			template = template.replace(/%tiles%/g, parseTiles(lay.tiles));
			return template;
		}
		
		private function parseTiles(tiles:Vector.<Tile>):String
		{
			var a:Array = new Array();
			for each(var tile:Tile in tiles)
			{
				var s:String = tile.id + "," + tile.x + "," + tile.y;
				if (tile.extra != "")
					s += ",\"" + tile.extra + "\"";
				a.push( "[" + s + "]" );
			}
			return a.join(",");
		}
	}

}
package parser.level 
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import parser.sheet.SheetData;
	/**
	 * ...
	 * @author Tommislav
	 */
	public class LevelData 
	{
		public var levelInfo:String;
		public var startPos:Point = new Point();
		public var layers:Vector.<Layer> = new Vector.<Layer>();
		
		public var levelId:int;
		public var titleCard1:String;
		public var titleCard2:String;
		public var titleCardNum:String;
		
		
		private static var cnt:int;
		
		public static function fromXml(xml:XML):LevelData
		{
			var ld:LevelData = new LevelData();
			ld.levelInfo = xml.levelInfo.text();
			ld.startPos = getPoint(xml.startPos);
			
			var obj:Object = objectify(ld.levelInfo);
			ld.titleCard1 = (obj.title01 == null) ? "tommy/titlecard_bice.png" : obj.title01;
			ld.titleCard2 = (obj.title02 == null) ? "tommy/titlecard_bice.png" : obj.title02;
			ld.titleCardNum = (obj.titleNumber == null) ? "tommy/titlecard_bice.png" : obj.titleNumber;
			ld.levelId = cnt++;
			
			var xmlLayers:XMLList = xml.layer;
			for each( var lay:XML in xmlLayers )
			{
				ld.layers.push( Layer.fromXml(lay) );
			}
			
			return ld;
		}
		
		private static function getPoint(xml:XMLList):Point
		{
			var x:String = xml[0].@x;
			var y:String = xml[0].@y;
			return new Point( parseInt(x), parseInt(y) );
		}
		
		private static function objectify(str:String):Object
		{
			var o:Object = new Object();
			
			var split:Array = str.split("|");
			for each(var pair:String in split)
			{
				var val:Array = pair.split("=");
				o[val[0]] = val[1];
			}
			
			return o;
		}
		
		public function toString():String
		{
			var s:String = "LevelData, layers:\n";
			for (var i:int = 0; i < layers.length; i++ )
			{
				s += "    " + layers[i].toString() + "\n";
			}
			return s;
		}
	}

}
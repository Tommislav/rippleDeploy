package parser.level 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Tommislav
	 */
	public class LevelData 
	{
		public var levelInfo:String;
		public var startPos:Point = new Point();
		public var layers:Vector.<Layer> = new Vector.<Layer>();
		
		public static function fromXml(xml:XML):LevelData
		{
			var ld:LevelData = new LevelData();
			ld.levelInfo = xml.levelInfo.text();
			ld.startPos = getPoint(xml.startPos);
			
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
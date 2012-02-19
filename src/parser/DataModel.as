package parser 
{
	import parser.level.ObjectLayerWidthAdjustment;
	/**
	 * ...
	 * @author Tommislav
	 */
	public class DataModel 
	{
		public var sheetXml:RippleFile;
		public var levelXml:Vector.<RippleFile>;
		
		private var _objectLayerWidthAdjustment:ObjectLayerWidthAdjustment = new ObjectLayerWidthAdjustment();
		
		public function DataModel() 
		{
			levelXml = new Vector.<RippleFile>();
		}
		
		public function adjustObjectLayerWidth():void
		{
			if (sheetXml == null || levelXml.length == 0)
				return;
			
			// to determine the width of a objectLayer we must get the width of the sprite, which we only get through tiledata->tilesheet, for which we need to sync sheet and level files
			_objectLayerWidthAdjustment.adjust(sheetXml, levelXml);
		}
	}

}
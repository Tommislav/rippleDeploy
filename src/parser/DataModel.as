package parser 
{
	/**
	 * ...
	 * @author Tommislav
	 */
	public class DataModel 
	{
		public var sheetXml:RippleFile;
		public var levelXml:Vector.<RippleFile>;
		
		
		public function DataModel() 
		{
			levelXml = new Vector.<RippleFile>();
		}
		
	}

}
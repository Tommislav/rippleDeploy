package parser.writer 
{
	import parser.sheet.SheetData;
	
	/**
	 * ...
	 * @author Tommy Salomonsson
	 */
	public interface ISheetWriter 
	{
		function write( template:String, data:SheetData ):String;
	}
	
}
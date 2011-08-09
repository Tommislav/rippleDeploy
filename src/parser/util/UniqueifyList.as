package parser.util 
{
	/**
	 * Takes one (or several) arrays and returns a new array with
	 * only the unique values
	 * @author Tommy Salomonsson
	 */
	public class UniqueifyList
	{
		/**
		 * Pass an empty array or typed vector, and a number of arrays (or vectors)
		 * this will transfer the unique values to the empty list
		 * @param	emptyList
		 * @param	...arrays
		 */
		public static function getUnique(emptyList:*, ...arrays):void
		{
			for (var i:int = 0; i < arrays.length; i++ )
			{
				var a:* = arrays[i];
				for (var j:int = 0; j < a.length; j++ )
				{
					if (emptyList.indexOf(a[j]) == -1)
						emptyList.push( a[j] );
				}
			}
		}
	}

}
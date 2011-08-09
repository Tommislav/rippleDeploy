package unittest.parser.util
{
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.array;
	import parser.util.UniqueifyList;
	/**
	 * ...
	 * @author Tommy Salomonsson
	 */
	public class TestUniqueifyList
	{
		private var _a1:Array = ["a", "a", "b", "c"];
		private var _a2:Array = ["c", "d"];
		
		[Test]
		public function testArrays():void
		{
			var empty:Array = new Array();
			UniqueifyList.getUnique( empty, _a1, _a2 );
			
			assertThat( empty, array("a", "b", "c", "d") );
			assertThat( empty.length, 4 );
		}
		
		[Test]
		public function testArrayToVector():void
		{
			var empty:Vector.<String> = new Vector.<String>();
			UniqueifyList.getUnique( empty, _a1 );
			UniqueifyList.getUnique( empty, _a2 ); // use two pass
			
			assertThat( empty.join(","), "a,b,c,d" );
			assertThat( empty.length, 4 );
		}
	}

}
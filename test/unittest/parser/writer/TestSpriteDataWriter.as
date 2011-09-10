package unittest.parser.writer 
{
	import flash.geom.Rectangle;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.text.containsString;
	import parser.sheet.SheetData;
	import parser.sheet.Sprite;
	import parser.sheet.SpriteState;
	import parser.sheet.SpriteTypes;
	import parser.writer.SpriteDataWriter;
	/**
	 * The most complex writer to test
	 * @author Tommy Salomonsson
	 */
	public class TestSpriteDataWriter
	{
		[Test]
		public function testSpriteWriter():void
		{
			var writer:SpriteDataWriter = new SpriteDataWriter();
			
			var data:SheetData = new SheetData();
			
			var sprite:Sprite = new Sprite();
			sprite.id = "1";
			sprite.name = "sprite";
			sprite.type = SpriteTypes.TYPE_SPRITE;
			sprite.bb = new Rectangle(0, 1, 32, 64);
			sprite.p = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			sprite.spriteStates = new Vector.<SpriteState>();
			
			data.sprites.push(sprite);
			
			
			var expected:String = "";
			expected += "BEFORE";
			expected += "_sheet.sprites=[];\n";
			expected += "_sheet.sprites[1]=[1,'sprite',[0,1,32,64],'s','z',[]];\n";
			expected += "AFTER";
			
			var template:String = "BEFORE[Sprites]AFTER";
			assertThat( writer.write(template, data), equalTo(expected));
		}
		
		[Test]
		public function testSpriteWriterWithManualProperties():void
		{
			var writer:SpriteDataWriter = new SpriteDataWriter();
			
			var data:SheetData = new SheetData();
			
			var sprite:Sprite = new Sprite();
			sprite.id = "1";
			sprite.name = "sprite";
			sprite.type = SpriteTypes.TYPE_SPRITE;
			sprite.bb = new Rectangle(0, 1, 32, 64);
			sprite.p = ["str=4", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			sprite.spriteStates = new Vector.<SpriteState>();
			
			data.sprites.push(sprite);
			
			
			var expected:String = "";
			expected += "BEFORE";
			expected += "_sheet.sprites=[];\n";
			expected += "_sheet.sprites[1]=[1,'sprite',[0,1,32,64],'s',[\"str=4\",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],[]];\n";
			expected += "AFTER";
			
			var template:String = "BEFORE[Sprites]AFTER";
			assertThat( writer.write(template, data), equalTo(expected));
		}
		
		[Test]
		public function testRegex():void
		{
			var s:String = new String("hej%a%").replace(/%a%/g, "då");
			assertThat(s, equalTo("hejdå") );
		}
		
		[Test]
		public function testSpriteStatesFromWriter():void
		{
			var writer:SpriteDataWriter = new SpriteDataWriter();
			var data:SheetData = new SheetData();
			var sprite:Sprite = new Sprite();
			sprite.bb = new Rectangle(); // needed to avoid null pointer exc
			sprite.type = SpriteTypes.TYPE_SPRITE;
			sprite.p = [];
			
			
			var state:SpriteState = new SpriteState();
			state.id = "2";
			state.name = "state";
			state.type = SpriteTypes.TYPE_SPRITE_STATE;
			state.p = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			state.frames = [1, 2, 3, 4];
			
			sprite.spriteStates.push(state);
			data.sprites.push(sprite);
			
			var expectedSubString:String = "\t[2,'state','ss','z',[1,2,3,4]]\n";
			
			assertThat(writer.write("[Sprites]", data), containsString(expectedSubString) );
		}
	}

}
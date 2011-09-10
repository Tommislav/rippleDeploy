package parser.writer 
{
	import flash.geom.Rectangle;
	import parser.sheet.SheetData;
	import parser.sheet.Sprite;
	import parser.sheet.SpriteState;
	import parser.sheet.SpriteTypes;
	/**
	 * Replace [Sprites] with the sprite data as code
	 * @author Tommy Salomonsson
	 */
	public class SpriteDataWriter implements ISheetWriter
	{
		
		/* INTERFACE parser.writer.ISheetWriter */
		
		public function write(template:String, data:SheetData):String
		{
			var s:String = "";
			s += "_sheet.sprites=[];\n";
			
			var spriteTemplate:String = "_sheet.sprites[%id%]=[%id%,'%name%',[%bb%],'%type%',%p%,[%states%]];\n";
			
			for each(var sp:Sprite in data.sprites)
			{
				s += parseSprite(spriteTemplate, sp);
			}
			
			return template.replace("[Sprites]", s);
		}
		
		private function parseSprite(template:String, sp:Sprite):String
		{
			template = template.replace(/%id%/g, sp.id);
			template = template.replace(/%name%/g, sp.name);
			template = template.replace(/%bb%/g, parseBB(sp.bb));
			template = template.replace(/%type%/g, parseType(sp.type));
			template = template.replace(/%p%/g, parseProp(sp.p));
			template = template.replace(/%states%/g, parseStates(sp.spriteStates));
			return template;
		}
		
		private function parseBB(bb:Rectangle):String
		{
			return bb.x + "," + bb.y + "," + bb.width + "," + bb.height;
		}
		private function parseType(type:String):String
		{
			if ( type == SpriteTypes.TYPE_SPRITE )
				return "s";
			else if (type == SpriteTypes.TYPE_SPRITE_STATE)
				return "ss";
			else if (type == SpriteTypes.TYPE_ANIMATED_TILE)
				return "at";
			throw new Error("Invalid sprite type found: " + type);
		}
		private function parseProp(p:Array):String
		{
			var isZero:Boolean = true;
			for (var i:int = 0; i < p.length; i++ )
			{
				if (p[i] != 0)
				{
					isZero = false;
					break;
				}
			}
			if (isZero)
				return "'z'";
			
			if (p[0].indexOf("=") > -1)
				p[0] = "\"" + p[0] + "\"";
			
			return "[" + p.join(",") + "]";
		}
		private function parseStates(states:Vector.<SpriteState>):String
		{
			if (states.length == 0)
				return "";
			
			var a:Array = new Array();
			var template:String = "\t[%id%,'%name%','%type%',%p%,[%frames%]]\n";
			
			for each(var ss:SpriteState in states)
			{
				a.push(parseSpriteState(template, ss));
			}
			return "\n" + a.join(",");
		}
		private function parseSpriteState(template:String, ss:SpriteState):String
		{
			template = template.replace(/%id%/g, ss.id);
			template = template.replace(/%name%/g, ss.name);
			template = template.replace(/%type%/g, parseType(ss.type));
			template = template.replace(/%p%/g, parseProp(ss.p));
			template = template.replace(/%frames%/g, ss.frames.join(","));
			return template;
		}
	}

}
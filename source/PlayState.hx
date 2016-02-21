package;

import flash.filters.BitmapFilter;
import flash.filters.BlurFilter;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.geom.Point;
import flixel.effects.FlxSpriteFilter;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxRandom;
import openfl.Assets;
import flixel.system.FlxAssets;

#if flash
import flash.filters.BevelFilter;
import flash.filters.DisplacementMapFilter;
import flash.filters.DisplacementMapFilterMode;
#end

class PlayState extends FlxState
{
	var original:FlxSprite;
	var rotate30:FlxSprite;
	var rotate60:FlxSprite;
	var rotate90:FlxSprite;
	var rotate120:FlxSprite;
	var rotate150:FlxSprite;

	override public function create():Void
	{
		original =  make(50, 100, 0);
		rotate30 =  make(300, 100, 1);
		rotate60 =  make(550, 100, 2);
		rotate90 =  make(50, 350, 3);
		rotate120 = make(300, 350, 4);
		rotate150 = make(550, 350, 5);
	}

	private function make(x:Int, y:Int, hueRotation:Int) : FlxSprite
	{
		var sprite:FlxSprite = new FlxSprite();
		sprite.loadGraphic('assets/wrgb.png');
		add(sprite);

		// set x/y
		sprite.x = x;
		sprite.y = y;

		// rotate hue
		rotateHue(sprite, hueRotation);

		return sprite;
	}

	private function rotateHue(sprite:FlxSprite, hueRotation:Int)
	{
		var u:Float = Math.cos(hueRotation * Math.PI / 180);
    var w:Float = Math.sin(hueRotation * Math.PI / 180);

		var data = sprite.pixels.clone();
		sprite.pixels = data;

		for (x in 0 ... data.width) {
			for (y in 0 ... data.height) {
				var input = data.getPixel(x, y);

				var r:Int = (input >> 16) & 0xFF;
				var g:Int = (input >> 8) & 0xFF;
				var b:Int = input & 0xFF;

				if (r > 255) throw 'R';
				if (g > 255) throw 'G';
				if (b > 255) throw 'B';

				var red:Float = (.299 + .701 * u + .168 * w) * r
						+  (.587 - .587 * u + .330 * w) * g
						+  (.114 - .114 * u - .497 * w) * b;

				var green:Float = (.299 - .299 * u - .328 * w) * r
						+  (.587 + .413 * u + .035 * w) * g
						+  (.114 - .114 * u + .292 * w) * b;

				var blue:Float = (.299 - .3 * u + 1.25 * w) * r
						+  (.587 - .588 * u - 1.05 * w) * g
						+  (.114 + .886 * u - .203 * w) * b;

				/*red = r;
				green = g;
				blue = b;*/

				var output:Int = Math.round(blue+ (256 * green) + (256 * 256 * red));

				data.setPixel(x, y, output);
			}
		}

		//sprite.setColorTransform(r, g, b);
	}

	override public function update():Void
	{
		super.update();
	}
}

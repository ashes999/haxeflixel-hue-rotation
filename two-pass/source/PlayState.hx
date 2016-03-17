package;

import flash.filters.BitmapFilter;
import flash.filters.BlurFilter;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import openfl.Assets;
import flixel.system.FlxAssets;
import flash.filters.ColorMatrixFilter;


class PlayState extends FlxState
{
	private static inline var HUE_INCREMENT:Int = 45;
	private static var next:Int = 0;

	override public function create():Void
	{
		var hueRotation:Int = 0;
		while (hueRotation < 360) {
			make(hueRotation);
			hueRotation += HUE_INCREMENT;
		}
	}

	private function make(hueRotation:Int) : FlxSprite
	{
		var original = addImage("assets/pixel-test.png");
		var sprite = addImage('assets/pixel-test-overlay.png');

		// rotate hue
		rotateHue(sprite, hueRotation);

		next++;

		return sprite;
	}

	private function addImage(fileName:String) : FlxSprite
	{
		var sprite:FlxSprite = new FlxSprite();
		sprite.loadGraphic(fileName);
		add(sprite);

		// set x/y
		sprite.x = (next % 4) * 200;
		sprite.y = Math.floor(next / 4) * 200;
		return sprite;
	}

	private function rotateHue(sprite:FlxSprite, hueRotation:Int)
	{
		// Since we're reusing the same image, clone it so that pixel data changes
		// for each copy of the sprite
		var data = sprite.pixels.clone();
		sprite.pixels = data;

		// http://stackoverflow.com/questions/8507885/shift-hue-of-an-rgb-color
		// -hueRotation to match GIMP's direction of rotation
		var cosA:Float = Math.cos(-hueRotation * Math.PI / 180);
		var sinA:Float = Math.sin(-hueRotation * Math.PI / 180);

		var a1:Float =	cosA + (1.0 - cosA) / 3.0;
		var a2:Float =	1.0/3.0 * (1.0 - cosA) - Math.sqrt(1.0/3.0) * sinA;
		var a3:Float =	1.0/3.0 * (1.0 - cosA) + Math.sqrt(1.0/3.0) * sinA;

		var b1:Float =	a3;
		var b2:Float = 	cosA + 1.0/3.0 * (1.0 - cosA);
		var b3:Float =	a2;

		var c1:Float =	a2;
		var c2:Float =	a3;
		var c3:Float = 	b2;

		sprite.pixels.applyFilter(sprite.pixels, sprite.pixels.rect, new Point(), new ColorMatrixFilter(
			[a1, b1, c1, 0, 0,
			a2, b2, c2, 0, 0,
			a3, b3, c3, 0, 0,
			0, 0, 0, 1, 0])); // identity row

		#if flash
			sprite.dirty = true; // make this work on Flash, too
		#end
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}

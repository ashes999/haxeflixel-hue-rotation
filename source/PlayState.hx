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
import flash.filters.ColorMatrixFilter;


class PlayState extends FlxState
{

	override public function create():Void
	{
		make(0, 0, 0);
		make(200, 100, 30);
		make(400, 100, 60);
		make(600, 100, 90);
		make(200, 300, 120);
		make(400, 300, 150);
		make(600, 300, 180);
	}

	private function make(x:Int, y:Int, hueRotation:Int) : FlxSprite
	{
		var sprite:FlxSprite = new FlxSprite();
		sprite.loadGraphic('assets/axolotl.png');
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
		// Since we're reusing the same image, clone it so that pixel data changes
		// for each copy of the sprite
		var data = sprite.pixels.clone();
		sprite.pixels = data;

		// http://stackoverflow.com/questions/8507885/shift-hue-of-an-rgb-color

		var cosA = Math.cos(hueRotation * Math.PI / 180);
		var sinA = Math.sin(hueRotation * Math.PI / 180);

		sprite.pixels.applyFilter(sprite.pixels, sprite.pixels.rect, new Point(), new ColorMatrixFilter(
			[cosA + (1.0 - cosA) / 3.0, 1.0/3.0 * (1.0 - cosA) - Math.sqrt(1.0/3.0) * sinA, 1.0/3.0 * (1.0 - cosA) + Math.sqrt(1.0/3.0) * sinA, 0, 0,
			1.0/3.0 * (1.0 - cosA) + Math.sqrt(1.0/3.0) * sinA, cosA + 1.0/3.0*(1.0 - cosA), 1.0/3.0 * (1.0 - cosA) - Math.sqrt(1.0/3.0) * sinA, 0, 0,
			1.0/3.0 * (1.0 - cosA) - Math.sqrt(1.0/3.0) * sinA, 1.0/3.0 * (1.0 - cosA) + Math.sqrt(1.0/3.0) * sinA, cosA + 1.0/3.0 * (1.0 - cosA), 0, 0,
			0, 0, 0, 1, 0])); // identity row
	}

	override public function update():Void
	{
		super.update();
	}
}

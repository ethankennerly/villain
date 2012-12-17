package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class Fire extends FlxSprite
    {
        public var sounds:Object;
        public static var idleVelocity:Number = -256;
        public static var origin:FlxPoint;

        /**
         * While offscreen, keep in order.
         */
        public function Fire(X:int = 0, Y:int = 0, MovieClipClass:Class = null) 
        {
            super(X, Y);
            sounds = {};
            PlayState.constructSprite(this, FireSpritesheet);
        }

        override public function update():void
        {
            if (alive) {
                velocity.x = idleVelocity;
            }
            if (alive && !onScreen()) {
                kill();
            }
            if (onScreen() && _curIndex.toString() in sounds) {
                FlxG.play(Sounds[sounds[_curIndex.toString()]]);
            }
            super.update();
        }
    }
}


import com.noorhakim.FlxMovieClip;

/**
 * Hold the pixels of a sprite sheet in this.bitmapData.
 */
class FireSpritesheet extends FlxMovieClip
{
    public function FireSpritesheet() 
    {
        super(FireClip);
    }
}

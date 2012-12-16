package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class Poison extends FlxSprite
    {
        public var sounds:Object;

        /**
         * While offscreen, keep in order.
         */
        public function Poison(X:int = 0, Y:int = 0, MovieClipClass:Class = null) 
        {
            super(X, Y);
            sounds = {};
            PlayState.constructSprite(this, PoisonSpritesheet);
            velocity.x = 128;
        }

        override public function update():void
        {
            if (0 <= x && alive && !onScreen()) {
                kill();
            }
            else if (onScreen() && velocity.x < 64) {
                velocity.x = 64;
            }
            if (_curIndex.toString() in sounds) {
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
class PoisonSpritesheet extends FlxMovieClip
{
    public function PoisonSpritesheet() 
    {
        super(PoisonClip);
    }
}

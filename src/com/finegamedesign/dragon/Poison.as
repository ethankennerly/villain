package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class Poison extends FlxSprite
    {
        public var sounds:Object;
        public static var idleVelocity:Number = 64;

        /**
         * While offscreen, keep in order.
         */
        public function Poison(X:int = 0, Y:int = 0, MovieClipClass:Class = null) 
        {
            super(X, Y);
            sounds = {};
            PlayState.constructSprite(this, PoisonSpritesheet);
            velocity.x = PlayState.offScreenMaxVelocityX;
        }

        override public function update():void
        {
            if (velocity.x == PlayState.offScreenMaxVelocityX && onScreen()) {
                velocity.x = idleVelocity;
            }
            if (0 <= x && alive && !onScreen()) {
                FlxG.score ++;
                kill();
            }
            else if (onScreen() && velocity.x != idleVelocity) {
                velocity.x = idleVelocity;
            }
            play("idling");
            if (onScreen() && _curIndex.toString() in sounds) {
                FlxG.play(Sounds[sounds[_curIndex.toString()]]);
            }
            super.update();
        }
    }
}


import com.noorhakim.FlxMovieClip;
import com.finegamedesign.dragon.Swc;

/**
 * Hold the pixels of a sprite sheet in this.bitmapData.
 */
class PoisonSpritesheet extends FlxMovieClip
{
    public function PoisonSpritesheet() 
    {
        super(Swc.PoisonClip);
    }
}

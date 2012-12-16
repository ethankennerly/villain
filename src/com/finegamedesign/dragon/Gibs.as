package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class Gibs extends FlxSprite
    {
        public var sounds:Object;

        public function Gibs(X:int = 0, Y:int = 0, MovieClipClass:Class = null) 
        {
            super(X, Y);
            sounds = {};
            PlayState.constructSprite(this, GibsSpritesheet);
        }

        override public function update():void
        {
            if (null != _curAnim && "kill" == _curAnim.name) {
                if (_curAnim.frames.length - 1 <= _curFrame) {
                    play("idling");
                }
            }
        }
    }
}


import com.noorhakim.FlxMovieClip;

/**
 * Hold the pixels of a sprite sheet in this.bitmapData.
 */
class GibsSpritesheet extends FlxMovieClip
{
    public function GibsSpritesheet() 
    {
        super(GibsClip);
    }
    
}

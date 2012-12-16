package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class Head extends FlxSprite
    {
        public function Head(X:int = 0, Y:int = 0, MovieClipClass:Class = null) 
        {
            super(X, Y);
            PlayState.constructSprite(this, HeadSpritesheet);
        }

        public function mayEat():Boolean
        {
            if (null != _curAnim && "bite" == _curAnim.name) {
                if (_curAnim.frames.length - 1 <= _curFrame) {
                    return true;
                }
            }
            return false;
        }
    }
}


import com.noorhakim.FlxMovieClip;

/**
 * Hold the pixels of a sprite sheet in this.bitmapData.
 */
class HeadSpritesheet extends FlxMovieClip
{
    public function HeadSpritesheet() 
    {
        super(HeadClip);
    }
    
}

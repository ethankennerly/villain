package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class PeasantKill extends FlxSprite
    {
        public var sounds:Object;

        public function PeasantKill(X:int = 0, Y:int = 0, MovieClipClass:Class = null) 
        {
            super(X, Y);
            sounds = {};
            PlayState.constructSprite(this, PeasantKillSpritesheet);
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
import com.finegamedesign.dragon.Swc;

/**
 * Hold the pixels of a sprite sheet in this.bitmapData.
 */
class PeasantKillSpritesheet extends FlxMovieClip
{
    public function PeasantKillSpritesheet() 
    {
        super(Swc.PeasantKillClip);
    }
}

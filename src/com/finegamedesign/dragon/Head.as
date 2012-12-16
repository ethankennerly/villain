package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class Head extends FlxSprite
    {
        public var sounds:Object;
        private var poisonTimer:FlxTimer;

        public function Head(X:int = 0, Y:int = 0, MovieClipClass:Class = null) 
        {
            super(X, Y);
            sounds = {};
            PlayState.constructSprite(this, HeadSpritesheet);
            poisonTimer = new FlxTimer();
        }

        /**
         * Release space bar to bite.
         * Play the sound associated with this frame index.
         */
        override public function update():void
        {
            if (0.0 < poisonTimer.timeLeft && !poisonTimer.finished) {
            }
            else if (FlxG.keys.justReleased("SPACE") || FlxG.mouse.justReleased()) {
                play("bite", true);
            }
            else if (finished) {
                play("idling");
            }

            if (_curIndex.toString() in sounds) {
                FlxG.play(Sounds[sounds[_curIndex.toString()]]);
            }
            super.update();
        }

        public function poison(mouth:FlxObject, poison:FlxObject):void
        {
            poison.hurt(1);
            FlxG.play(Sounds.biteClass);
            play("poisoning");
            poisonTimer.start(3.0, 1, recover);
        }

        private function recover(timer:FlxTimer):void
        {
            play("idling");
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

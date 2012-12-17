package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class Head extends FlxSprite
    {
        public var sounds:Object;
        public var sounding:int;
        public var state:PlayState;
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
         * Slow down fire animation.
         */
        override public function update():void
        {
            if (null != _curAnim) {
                _curAnim.delay = 1.0 / 6;
            }
            if (0.0 < poisonTimer.timeLeft && !poisonTimer.finished) {
            }
            else if (FlxG.keys.pressed("SPACE") || FlxG.mouse.pressed()) {
                play("inhale");
            }
            else if (FlxG.keys.justReleased("SPACE") || FlxG.mouse.justReleased()) {
                if (null != _curAnim && "inhale" == _curAnim.name && _curAnim.frames.length - 2 <= _curFrame) {
                    play("fire", true);
                    FlxG.play(Sounds.biteClass);
                    state.fire.reset(Fire.origin.x, Fire.origin.y);
                    state.add(state.fire);
                }
                else {
                    play("bite", true);
                }
            }
            else if (finished) {
                play("idling");
            }

            if (_curIndex.toString() in sounds) {
                if (sounding != _curIndex) {
                    FlxG.play(Sounds[sounds[_curIndex.toString()]]);
                    sounding = _curIndex;
                }
            }
            else {
                sounding = -1;
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
                    trace("mayEat", _curAnim.name);
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

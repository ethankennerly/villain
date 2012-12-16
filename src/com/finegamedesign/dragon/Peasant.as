package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class Peasant extends FlxSprite
    {
        public static var carryVelocity:Number = -64;
        public static var retreatVelocity:Number = -128;
        public var gold:Gold;

        public function Peasant(X:int = 0, Y:int = 0, MovieClipClass:Class = null) 
        {
            super(X, Y);
            PlayState.constructSprite(this, PeasantSpritesheet);
            velocity.x = 128;
        }

        override public function kill():void
        {
            trace(this, "kill");
            if (null != gold) {
                gold.play("idling");
                gold.velocity.x = 0;
                gold = null;
            }
            super.kill();
        }

        override public function update():void
        {
            if (velocity.x < 0 && alive && !onScreen()) {
                kill();
            }
        }

        public function carry(gold:Gold):void
        {
            if (null == gold.curAnim || "carrying" != gold.curAnim.name || this.gold == gold) {
                if (onScreen()) {
                    velocity.x = carryVelocity;
                }
                play("carrying");
                if (gold.onScreen()) {
                    this.gold = gold;
                    gold.play("carrying");
                    gold.x = x;
                    gold.velocity.x = velocity.x;
                }
                else if (gold.alive) {
                    gold.kill();
                }
            }
        }

        public function retreat():void
        {
            if (onScreen()) {
                if (null == gold) {
                    play("retreating");
                    velocity.x = retreatVelocity;
                }
            }
            else if (alive) {
                kill();
            }
        }
    }
}


import com.noorhakim.FlxMovieClip;

/**
 * Hold the pixels of a sprite sheet in this.bitmapData.
 */
class PeasantSpritesheet extends FlxMovieClip
{
    public function PeasantSpritesheet() 
    {
        super(PeasantClip);
    }
    
}

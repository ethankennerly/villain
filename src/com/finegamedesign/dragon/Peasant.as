package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class Peasant extends FlxSprite
    {
        public static var carryVelocity:Number = -32;
        public static var retreatVelocity:Number = -64;
        public var gold:Gold;

        public function Peasant(X:int = 0, Y:int = 0, MovieClipClass:Class = null) 
        {
            super(X, Y);
            PlayState.constructSprite(this, PeasantSpritesheet);
            velocity.x = 64;
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

        public function carry(gold:Gold):void
        {
            if (null == gold.curAnim || "carrying" != gold.curAnim.name || this.gold == gold) {
                if (onScreen()) {
                    play("carrying");
                    velocity.x = carryVelocity;
                }
                else if (alive) {
                    kill();
                }
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

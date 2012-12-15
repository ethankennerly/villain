package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class Peasant extends FlxSprite
    {
        public static var carryVelocity:Number = -32;

        public function Peasant(X:int = 0, Y:int = 0, SimpleGraphic:Class = null) 
        {
            var place:PeasantClip = PlayState.getChildByClass(PeasantClip);
            X = place.x;
            Y = place.y;
            super(X, Y);
            var sheet:PeasantSpritesheet = new PeasantSpritesheet();
            this.loadGraphic(PeasantSpritesheet, true, true, sheet.frameWidth, sheet.frameHeight);
            PlayState.addAnimation(this, place);
            velocity.x = 64;
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

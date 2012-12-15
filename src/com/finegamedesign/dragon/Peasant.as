package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class Peasant extends FlxSprite
    {
        public function Peasant(X:int = 0, Y:int = 0, SimpleGraphic:Class = null) 
        {
            var place:PeasantClip = PlayState.getChildByClass(PeasantClip);
            X = place.x;
            Y = place.y;
            super(X, Y);
            var sheet:PeasantSpritesheet = new PeasantSpritesheet();
            FlxG.log("Peasant:  width = " + sheet.frameWidth.toString() + " height = " + sheet.frameHeight.toString());
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
    // AS3 Embedded MovieClip Gotcha:  Need two frames to declare movieclip.
    // http://www.airtightinteractive.com/2008/05/as3-embedded-movieclip-gotcha/
    public function PeasantSpritesheet() 
    {
        super(PeasantClip);
    }
    
}

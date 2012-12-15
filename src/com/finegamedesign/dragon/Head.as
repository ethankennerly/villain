package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class Head extends FlxSprite
    {
        public function Head(X:int = 0, Y:int = 0, SimpleGraphic:Class = null) 
        {
            var place:HeadClip = PlayState.getChildByClass(HeadClip);
            X = place.x;
            Y = place.y;
            super(X, Y);
            var sheet:HeadSpritesheet = new HeadSpritesheet();
            FlxG.log("Head:  width = " + sheet.frameWidth.toString() + " height = " + sheet.frameHeight.toString());
            this.loadGraphic(HeadSpritesheet, true, true, sheet.frameWidth, sheet.frameHeight);
            
            this.addAnimation("idle", [0], 12);
        }
    }
}


import com.noorhakim.FlxMovieClip;

/**
 * Hold the pixels of a sprite sheet in this.bitmapData.
 */
class HeadSpritesheet extends FlxMovieClip
{
    // AS3 Embedded MovieClip Gotcha:  Need two frames to declare movieclip.
    // http://www.airtightinteractive.com/2008/05/as3-embedded-movieclip-gotcha/
    public function HeadSpritesheet() 
    {
        super(HeadClip);
    }
    
}

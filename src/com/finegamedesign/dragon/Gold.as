package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class Gold extends FlxSprite
    {
        public function Gold(X:int = 0, Y:int = 0, SimpleGraphic:Class = null) 
        {
            var place:GoldClip = PlayState.getChildByClass(GoldClip);
            X = place.x;
            Y = place.y;
            super(X, Y);
            var sheet:GoldSpritesheet = new GoldSpritesheet();
            this.loadGraphic(GoldSpritesheet, true, true, sheet.frameWidth, sheet.frameHeight);
            PlayState.addAnimation(this, place);
        }
    }
}


import com.noorhakim.FlxMovieClip;

/**
 * Hold the pixels of a sprite sheet in this.bitmapData.
 */
class GoldSpritesheet extends FlxMovieClip
{
    public function GoldSpritesheet() 
    {
        super(GoldClip);
    }
    
}

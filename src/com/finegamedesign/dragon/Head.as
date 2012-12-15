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
            this.loadGraphic(HeadSpritesheet, true, true, sheet.frameWidth, sheet.frameHeight);
            PlayState.addAnimation(this, place);
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

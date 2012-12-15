package com.finegamedesign.dragon
{
    import org.flixel.*;
    [SWF(width="640", height="240", backgroundColor="#000000")]
    [Frame(factoryClass="Preloader")]

    public class Dragon extends FlxGame
    {
        public function Dragon()
        {
            super(640, 240, MenuState, 1);
        }
    }
}

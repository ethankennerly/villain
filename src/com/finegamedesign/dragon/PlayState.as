package com.finegamedesign.dragon
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.utils.getQualifiedClassName;
    import flash.utils.getDefinitionByName;

    import org.flixel.*;
    import com.noorhakim.FlxMovieClip;
   
    public class PlayState extends FlxState
    {
        private static var scene:Scene;
        public static var offScreenMaxVelocityX:Number = 8.0;
        public static var onScreenMaxVelocityX:Number = 800.0;

        public static function endsWith(name:String, ending:String):Boolean
        {
            return ending.length <= name.length &&
                name.indexOf(ending) == name.length - ending.length;
        }

        /**
         * Every labeled frame in the movie clip at Flixel frame index (frame - 1).
         * If label ends with "ing", then loop, otherwise stop.
         * Unless label ends with ".mp3", then remember to play sound on that frame index.
         */
        public static function addAnimation(flxSprite:FlxSprite, mc:MovieClip, soundEndsWith:String=".mp3"):void
        {
            for (var i:int = 0; i < mc.currentLabels.length; i++) {
                var name:String = mc.currentLabels[i].name;
                var start:int = mc.currentLabels[i].frame - 1;
                if (endsWith(name, soundEndsWith)) {
                    // trace(flxSprite, start, name);
                    flxSprite["sounds"][start.toString()] = name.substr(0, 
                        name.length - soundEndsWith.length) + "Class";
                }
                else {
                    var end:int = -1;
                    if (i < mc.currentLabels.length - 1) {
                        for (var j:int = i+1; end <= -1 && j < mc.currentLabels.length; j++) {
                            if (!endsWith(mc.currentLabels[j].name, soundEndsWith)) {
                                end = mc.currentLabels[j].frame - 2;
                            }
                        }
                        if (mc.currentLabels.length <= j && end <= -1) {
                            end = mc.totalFrames - 1;
                        }
                    }
                    else {
                        end = mc.totalFrames - 1;
                    }
                    var frames:Array = [];
                    for (var f:int = start; f <= end; f++) {
                        frames.push(f);
                    }
                    var looped:Boolean = endsWith(name, "ing");
                    // trace(flxSprite, "addAnimation", name, frames, FlxG.stage.frameRate, looped);
                    flxSprite.addAnimation(name, frames, FlxG.stage.frameRate, looped);
                }
            }
        }

        /**
         * Parse animations from movie clip.
         * Flixel expects unique graphic class name.
         */
        public static function constructSprite(flxSprite:FlxSprite, SpritesheetClass:Class):void
        {
            var sheet:* = new SpritesheetClass();
            flxSprite.loadGraphic(SpritesheetClass, true, true, sheet.frameWidth, sheet.frameHeight);
        }

        public static function constructChild(FlxSpriteClass:Class, child:MovieClip):*
        {
            var flxSprite:FlxSprite = new FlxSpriteClass(child.x, child.y);
            addAnimation(flxSprite, child);
            return flxSprite;
        }

        public var fire:Fire;
        private var instructionText:FlxText;
        private var waveText:FlxText;
        private var goldText:FlxText;
        private var head:Head;
        private var mouth:MouthCollision;
        private var golds:FlxGroup;
        private var peasants:FlxGroup;
        private var poisons:FlxGroup;
        private var state:String;
        private var gibs:FlxEmitter;
        private var floor:Floor;

        private function addChildren(scene:MovieClip):void
        {
            golds = new FlxGroup();
            peasants = new FlxGroup();
            poisons = new FlxGroup();
            for (var c:int=0; c < scene.numChildren; c++) {
                var child:* = scene.getChildAt(c);
                if (child is HeadClip) {
                    head = constructChild(Head, child);
                    head.state = this;
                    add(head);
                }
                else if (child is PeasantClip) {
                    peasants.add(constructChild(Peasant, child));
                    add(peasants);
                }
                else if (child is KnightClip) {
                    peasants.add(constructChild(Knight, child));
                    add(peasants);
                }
                else if (child is PoisonClip) {
                    poisons.add(constructChild(Poison, child));
                    add(poisons);
                }
                else if (child is FireClip) {
                    fire = constructChild(Fire, child);
                    Fire.origin = new FlxPoint(child.x, child.y);
                    fire.kill();
                }
                else if (child is GoldClip) {
                    golds.add(constructChild(Gold, child));
                    add(golds);
                }
                else if (child is BackgroundClip) {
                    add(constructChild(Background, child));
                }
                else if (child is BodyClip) {
                    add(constructChild(Body, child));
                }
                else if (child is MouthCollisionClip) {
                    mouth = constructChild(MouthCollision, child);
                    add(mouth);
                }
                else if (child is GibsClip) {
                    addGibs();
                }
                else if (child is FloorClip) {
                    floor = Floor(add(constructChild(Floor, child)));
                }
            }
        }

        private function addGibs():void
        {
            gibs = new FlxEmitter();
		    gibs.makeParticles(Gibs, 50, 32, false, 0.5);
            gibs.gravity = 376;
            gibs.setRotation(0, 0);
            gibs.bounce = 0.25;
		    gibs.setXSpeed(-150, 150);
            gibs.particleDrag = new FlxPoint(50, 0);
            gibs.setSize(2, 2);
            add(gibs);
        }

        override public function create():void
        {
            FlxG.score = 0;
            // FlxG.visualDebug = true;
            super.create();
            scene = new Scene();
            addChildren(scene);
            addHud();
            state = "play";
        }

        private function addHud():void
        {
            instructionText = new FlxText(0, 0, FlxG.width, 
                "RELEASE SPACEBAR TO EAT");
            instructionText.alignment = "center";
            add(instructionText);
            waveText = new FlxText(0, 0, 100, "");
            add(waveText);
            goldText = new FlxText(FlxG.width - 40, 0, 100, "");
            add(goldText);
        }

		override public function update():void 
        {
            updateInput();
            if (head.mayEat()) {
                FlxG.overlap(mouth, peasants, eat);
                FlxG.overlap(mouth, poisons, head.poison);
            }
            if (fire.alive) {
                FlxG.overlap(fire, peasants, burn);
                FlxG.overlap(fire, poisons, burn);
            }
            FlxG.collide(floor, gibs, crunch);
            updateGold();
            updateHud(peasants.countLiving(), golds.countLiving());
            super.update();
        }

        private function crunch(floor:FlxObject, gib:FlxObject):void
        {
            if (0.5 < gib.health) {
                // trace("crunch", gib);
                gib.health -= 0.25;
                FlxG.play(Sounds.eatClass);
            }
        }

        private function updateHud(peasantsLiving:int, goldsLiving:int):void
        {
            if ("play" == state) {
                waveText.text = "PEASANTS " + peasantsLiving.toString();
                goldText.text = "GOLD " + goldsLiving.toString();
                if (goldsLiving <= 0) {
                    FlxG.score = int(Math.pow(FlxG.score, 3));
                    FlxG.score = int(FlxG.score / 50) * 50;
                    state = "lose";
                    instructionText.text = "THEY STOLE ALL YOUR GOLD!";
                    FlxG.fade(0xFF000000, 3.0, lose);
                }
                else if (peasantsLiving <= 0) {
                    FlxG.score += goldsLiving;
                    FlxG.score = int(Math.pow(FlxG.score, 3));
                    FlxG.score = int(FlxG.score / 50) * 50;
                    if (goldsLiving < golds.length) {
                        instructionText.text = "YOU KEPT SOME GOLD";
                    }
                    else {
                        instructionText.text = "YOU KEPT ALL YOUR GOLD";
                    }
                    state = "win";
                    FlxG.fade(0xFFFFFFFF, 3.0, win);
                }
            }
        }

        private function lose():void
        {
            FlxG.switchState(new MenuState());
        }

        private function win():void
        {
            FlxG.switchState(new MenuState());
        }
   
        private function eat(mouth:FlxObject, peasant:FlxObject):void
        {
            head.play("eat", peasant);
            hurt(mouth, peasant);
        }

        private function burn(fire:FlxObject, peasant:FlxObject):void
        {
            fire.kill();
            hurt(fire, peasant);
            FlxG.play(Sounds.biteClass);
        }

        /**
         * Spawn gibs at peasant.
         */
        private function hurt(mouth:FlxObject, peasant:FlxObject):void
        {
            var isRight:Boolean = 0 <= peasant.velocity.x;
            if (!peasant.flickering) {
                peasant.hurt(1);
                peasant.flicker(0.25);
            }
            if (!peasant.alive) {
                FlxG.score++;
                if (peasant is Peasant) {
                    var gibsClip:PeasantKillClip = new PeasantKillClip();
                    gibsClip.x = peasant.x + (isRight ? -80.0 : -80.0);
                    gibsClip.y = peasant.y;
                    var peasantKill:PeasantKill = PeasantKill(add(constructChild(PeasantKill, gibsClip)));
                    peasantKill.facing = isRight ? FlxObject.RIGHT : FlxObject.LEFT;
                    peasantKill.play("kill");
                }
                gibs.x = peasant.x;
                gibs.y = peasant.y;
                gibs.start(true, 0, 0.1, 1);
                add(gibs);
            }
        }

        /**
         * Or you can release mouse button.
         * To make it harder, play 2x speed: press Shift+2.  
         * To make it normal again, play 1x speed: press Shift+1.  
         */ 
        private function updateInput():void
        {
            if (FlxG.keys.pressed("SHIFT")) {
                if (FlxG.keys.justPressed("ONE")) {
                    FlxG.timeScale = 1.0;
                }
                else if (FlxG.keys.justPressed("TWO")) {
                    FlxG.timeScale = 2.0;
                }
                else if (FlxG.keys.justPressed("THREE")) {
                    FlxG.timeScale = 8.0;
                }
            }
        }

        /**
         * If peasant touches gold, carry.  Otherwise gold sits.
         * If peasants carry all gold away, lose.
         * If no gold idling on screen, then peasants on screen retreat.
         */
        private function updateGold():void
        {
            FlxG.overlap(golds, peasants, carry);
            Gold.sum = 0;
            golds.callAll("count");
        }

        /**
         * If gold being carried, do not transfer to another.
         */
        private function carry(me:FlxObject, you:FlxObject):void
        {
            var peasant:Peasant = Peasant(you);
            var gold:Gold = Gold(me);
            peasant.carry(gold);
        }
    }
}

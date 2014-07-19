package  
{
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import net.flashpunk.*;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.*;
	import GameWorld;
//	import PlayerShadow;
	
	/**
	 * ...
	 * @author Jinx
	 */
	public class Player extends Entity
	{
		private var gravity:int = 0;
		private var chargeTimer:Timer;
		private var dashTimer:Timer;
		private var dashChargeTimer:Timer;
		private var onGround:Boolean = false;
		public  var canDash:Boolean = true;
		public  var currentAnim:String;
		private var playerSpeed:Number = 5;
		private	var dir:Number;
		public  var canMove:Boolean;
		public	var healthTotal:Number = 50;
		public 	var healthCurrent:Number = healthTotal;
		//private var sprShooter:Spritemap = new Spritemap(Assets.GphxHunter, 70, 70);
		
		private var sprGabriel:Spritemap = new Spritemap(Assets.Gphx_Gabriel, 29, 32);
		private var sprGabrielCopy:Spritemap = new Spritemap(Assets.Gphx_Gabriel, 29, 32);
		
		//sound
		private var regularShot:Sfx = new Sfx(Assets.GUNSHOT);
//		private var chargedShot:Sfx = new Sfx(Assets.SndChargeShot);
//		private var chargeComplete:Sfx = new Sfx(Assets.SndCharging);
		
		public  var charge:Boolean = false;
		
		public function Player() 
		{
			graphic = sprGabriel;
			layer = 0;
			
			/* Code for gphxHunter
			 * sprShooter.add("charge", [2, 3, 4, 5], 20, false); 
			sprShooter.add("loose", [6], 20, false);*/
			
/*			sprShooter.add("walk up", 	[0, 1, 2, 3, 4, 5], 10, true);
			sprShooter.add("walk down", [6, 7, 8, 9, 10, 11], 10, true);
			sprShooter.add("walk left", [12, 13, 14, 15, 16, 17], 10, true);
			sprShooter.add("walk right", [18, 19, 20, 21, 22, 23], 10, true);
			sprShooter.add("face up", 	[0], 0, false);
			sprShooter.add("face down", [6], 0, false);
			sprShooter.add("face left", [12], 0, false);
			sprShooter.add("face right", [18], 0, false);*/
			createSpriteFromSpritemap(sprGabriel);
			createSpriteFromSpritemap(sprGabrielCopy);
			currentAnim = "face right";
			
/*			Input.define("Left", 	Key.A, Key.LEFT);
			Input.define("Right", 	Key.D, Key.RIGHT);
			Input.define("Up", 		Key.W, Key.UP);
			Input.define("Down", 	Key.S, Key.DOWN);
			Input.define("Shoot", 	Key.SPACE);
			Input.define("Dash", 	Key.SHIFT);*/
			sprGabriel.centerOO();
			setHitbox(24, 25, 12, 0);
			
			//charge timer
			chargeTimer = new Timer (1000);
			chargeTimer.addEventListener(TimerEvent.TIMER, chargeCheck);
			
			//dash timer
			dashTimer = new Timer (100);
			dashTimer.addEventListener(TimerEvent.TIMER, dashDone);
			
			//dash recharge timer
			dashChargeTimer = new Timer (00);
			dashChargeTimer.addEventListener(TimerEvent.TIMER, dashChargeCheck);
		}
		
		override public function update():void
		{	
			sprGabriel.alpha = 1;
			var horizontalMovement:Boolean = true;
			var verticalMovement:Boolean = true;
			sprGabriel.play(currentAnim);
			sprGabrielCopy.play(currentAnim);
			
			//Set the copy to the same index as the original
			sprGabrielCopy.setAnimFrame(currentAnim, sprGabriel.index);
			
			layer = 0;
//			playerSpeed = 2;
			
			//inputs for motion and moving animations
			
/*				if (Input.check("Left"))  { 
					if (collide("level", x - width, y)) x -= playerSpeed;
					currentAnim = "walk left";
				}
				else if (Input.check("Right")) { 
					if (collide("level", x + width, y))	x += playerSpeed; 
					currentAnim = "walk right";
				}
				else horizontalMovement = false;
				
				if (Input.check("Up"))    { 
					if (collide("level", x, y - height)) y -= playerSpeed; 
					currentAnim = "walk left";
				}
				else if (Input.check("Down"))  { 
					if (collide("level", x, y + height)) y += playerSpeed;
					currentAnim = "walk right"; */
					
				if (Input.check("Left"))  { 
					x -= playerSpeed;
					currentAnim = "walk left";
				}
				else if (Input.check("Right")) { 
					x += playerSpeed; 
					currentAnim = "walk right";
				}
				else horizontalMovement = false;
				
				if (Input.check("Up"))    { 
					y -= playerSpeed; 
					currentAnim = "walk left";
				}
				else if (Input.check("Down"))  { 
					y += playerSpeed;
					currentAnim = "walk right"; 
				}
				else verticalMovement = false;
				
				if (Input.pressed("Dash") && canDash && (verticalMovement||horizontalMovement))  {
					playerSpeed = 15;
					//world.add(new Dash(x, y, dir));
//					world.add(new Shadow(x, y));
					dashTimer.start();
				}
				
				if (!verticalMovement && !horizontalMovement) {
					switch (currentAnim) {
						case "walk left": currentAnim = "face left"; break;
						case "walk right": currentAnim = "face right"; break;
						case "walk down": currentAnim = "face down"; break;
						case "walk up": currentAnim = "face up"; break;
					}
				}
			
			setDirection();
			
			//stuff for shootin'
			if (Input.pressed("Shoot")) 
			{
				chargeTimer.start();
				//sprShooter.play("charge", true);
			}
			
			if (Input.released("Shoot"))
			{
				//Initialize shadow
				sprGabrielCopy.clear();
//				world.add(new PlayerShadow(sprGabrielCopy, dir));
				
				chargeTimer.stop();
				//sprShooter.play("loose", true);
				fireBullet();
				healthCurrent = healthCurrent - 10;
			}
			updateCollision();
			
		}
		
		private function updateCollision():void
		{
			if (collide("level", x, y)) {
				onGround = true;
			}
			else onGround = false;
		}
		
		private function setDirection():void
		{
//			dir = Math.atan2(world.mouseY-y, world.mouseX-x); //follow the mouse
			switch(currentAnim) {
				case "walk right"	: dir = 0; break;
				case "walk up"		: dir = (3.14 * 1.5); break;
				case "walk left" 	: dir = (3.14); break;
				case "walk down" 	: dir = (3.14 * .5); break;
				case "face right"	: dir = 0; break;
				case "face up"		: dir = (3.14 * 1.5); break;
				case "face left" 	: dir = 3.14; break;
				case "face down" 	: dir = (3.14 * .5); break;
			}
		}
		
		private function fireBullet():void
		{
			sprGabriel.color = 0xffffff;
			world.add(new Bullet(x, y, dir, charge));
			if (charge) {
//				chargedShot.play();
				charge = false;
			}
			else regularShot.play();
		}		
		
		public final function createExplosion(bullet_x:Number, bullet_y:Number):void
		{
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////FAGGOTS
//FAGGOTS
//FAGGOTS
//FAGGOTS
//FAGGOTS
//FAGGOTS
//FAGGOTS
//FAGGOTS
//FAGGOTS
//FAGGOTS
//FAGGOTS

		}

		private function chargeCheck( timerEvent:TimerEvent ):void
		{
			charge = true;
//			chargeComplete.play();
			chargeTimer.stop();
			sprGabriel.color = 0x66ffff;
		}
		
		private function dashDone( timerEvent:TimerEvent ):void
		{
			dashTimer.stop();
			sprGabriel.color = 0xffffff;
			playerSpeed = 5;
			dashChargeTimer.start();
			canDash = false;
		}
		
		private function dashChargeCheck ( timerEvent:TimerEvent ):void
		{
			dashChargeTimer.stop();
			canDash = true;
		}
		
		private function createSpriteFromSpritemap (sm:Spritemap):void
		{
			sm.add("walk left", [5, 4, 5, 3], 10, true);
			sm.add("walk right", [0, 1, 0, 2], 10, true);
			sm.add("face left", [5], 0, false);
			sm.add("face right", [0], 0, false);
			
			Input.define("Left", 	Key.A, Key.LEFT);
			Input.define("Right", 	Key.D, Key.RIGHT);
			Input.define("Up", 		Key.W, Key.UP);
			Input.define("Down", 	Key.S, Key.DOWN);
			Input.define("Shoot", 	Key.X);
			Input.define("Dash", 	Key.Z);
			Input.define("Jump",	Key.C);
		}
		
		public function playerCanMove(isAllowed:Boolean):void
		{
			canMove = isAllowed;
		}
	}
}
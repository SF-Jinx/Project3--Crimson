package  
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
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
		private var sprLucas:Spritemap = new Spritemap(Assets.Gphx_Lucas, 24, 24);
		private var sprLucasSword:Spritemap = new Spritemap(Assets.Gphx_Lucas, 24, 24);
		
		//sound
		private var regularShot:Sfx = new Sfx(Assets.GUNSHOT);
//		private var chargedShot:Sfx = new Sfx(Assets.SndChargeShot);
//		private var chargeComplete:Sfx = new Sfx(Assets.SndCharging);
		
		public  var charge:Boolean = false;
		
		public function Player() 
		{
			graphic = sprLucas;
			layer = 0;
			
//			createSpriteFromSpritemap(sprGabriel);
//			createSpriteFromSpritemap(sprGabrielCopy);
			createSimpleCharSprite(sprLucas);
			createSimpleCharAttack(sprLucasSword);
			
			addGraphic(sprLucasSword);
			
			currentAnim = "face right";
			
			sprLucas.centerOO();
			sprLucas.scale = 3;
			sprLucasSword.scale = 3;
			sprLucasSword.centerOO();
			setHitbox(24, 24, 12, 0);
			
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
		
		
		private var attacking:Boolean = false;
		
		override public function update():void
		{	
			var horizontalMovement:Boolean = true;
			var verticalMovement:Boolean = true;
			
			sprLucas.play(currentAnim);
			sprLucasSword.play(currentAnim);
			
			//Set the copy to the same index as the original
//			sprGabrielCopy.setAnimFrame(currentAnim, sprGabriel.index);
			
			layer = 0;
//			playerSpeed = 2;
			
			//inputs for motion and moving animations
				if (Input.check("Left"))  { 
					x -= playerSpeed; 
					dir = 3.14;
				}
				else if (Input.check("Right")) { 
					x += playerSpeed; 
					dir = 0;
				}
				else horizontalMovement = false;
				
				if (Input.check("Up"))    { 
					y -= playerSpeed; 
					dir = 3.14 * 1.5;
				}
				else if (Input.check("Down"))  { 
					y += playerSpeed;
					dir = 3.14 * .5;
				}
				else verticalMovement = false;
				
				if (Input.pressed("Dash") && canDash && (verticalMovement||horizontalMovement))  {
					playerSpeed = 15;
					//world.add(new Dash(x, y, dir));
//					world.add(new Shadow(x, y));
					dashTimer.start();
				}
				
			setAnimation(verticalMovement, horizontalMovement);
//			setDirection();
			
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
			
			if (Input.pressed("Attack")) {
				attacking = true;
			}
			
			if (sprLucas.complete) {
				attacking = false;
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
		
		private var action:String = "face ";
		
		private function setAnimation(verticalMovement:Boolean, horizontalMovement:Boolean):void
		{
			if (attacking) 										action = "attack ";
			else if (!verticalMovement && !horizontalMovement) 	action = "face ";
			else if (verticalMovement || horizontalMovement) 	action = "walk ";
			
			switch (dir) {
				case 0			:	currentAnim = action + "right"; break;
				case 3.14 * 1.5	:	currentAnim = action + "up"; 	break;
				case 3.14		:	currentAnim = action + "left"; 	break;
				case 3.14 * .5	:	currentAnim = action + "down";	break;
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
			sm.add("walk left", 	[5, 4, 5, 3], 10, true);
			sm.add("walk right", 	[0, 1, 0, 2], 10, true);
			sm.add("face left", 	[5], 0, false);
			sm.add("face right", 	[0], 0, false);
			
			Input.define("Left", 	Key.A, Key.LEFT);
			Input.define("Right", 	Key.D, Key.RIGHT);
			Input.define("Up", 		Key.W, Key.UP);
			Input.define("Down", 	Key.S, Key.DOWN);
			Input.define("Shoot", 	Key.X);
			Input.define("Dash", 	Key.Z);
			Input.define("Jump",	Key.C);
		}
		
		private function createSimpleCharSprite (sm:Spritemap):void
		{
			sm.add("walk down", 	[1, 2, 3, 4], 10, true);
			sm.add("walk up", 		[7, 8, 9, 10], 10, true);
			sm.add("walk left", 	[13, 14, 15, 16], 10, true);
			sm.add("walk right", 	[19, 20, 21, 22], 10, true);
			sm.add("face down", 	[0], 0, false);
			sm.add("face up", 		[6], 0, false);
			sm.add("face left", 	[12], 0, false);
			sm.add("face right", 	[18], 0, false);
			sm.add("attack down", 	[24, 25, 26], 10, false);
			sm.add("attack up", 	[30, 31, 32], 10, false);
			sm.add("attack left", 	[36, 37, 38], 10, false);
			sm.add("attack right", 	[42, 43, 44], 10, false);
			
			Input.define("Left", 	Key.A, Key.LEFT);
			Input.define("Right", 	Key.D, Key.RIGHT);
			Input.define("Up", 		Key.W, Key.UP);
			Input.define("Down", 	Key.S, Key.DOWN);
			Input.define("Shoot", 	Key.X);
			Input.define("Dash", 	Key.Z);
			Input.define("Jump",	Key.C);
			Input.define("Attack",	Key.V);
		}
		
		private function createSimpleCharAttack(sm:Spritemap):void
		{
			sm.add("walk down", [5], 0, false);
			sm.add("walk up", 	[5], 0, false);
			sm.add("walk left", [5], 0, false);
			sm.add("walk right",[5], 0, false);
			sm.add("face down", [5], 0, false);
			sm.add("face up", 	[5], 0, false);
			sm.add("face left",	[5], 0, false);
			sm.add("face right",[5], 0, false);
			
			sm.add("attack down", 	[27, 28, 29], 10, false);
			sm.add("attack up", 	[33, 34, 35], 10, false);
			sm.add("attack left", 	[39, 40, 41], 10, false);
			sm.add("attack right", 	[45, 46, 47], 10, false);
			
			Input.define("Attack",	Key.V);
		}
		
		public function playerCanMove(isAllowed:Boolean):void
		{
			canMove = isAllowed;
		}
	}
}
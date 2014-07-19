package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Jinx
	 */
	public class Bullet extends Entity 
	{
		public static var bullet:Image;
		private var angle :Number;
		private var speed :Number = 700;
		private var counter: Number = 0;
		private var range: Number = 300;
		private var charged: Boolean = false;
		
		protected var _bulletTrail:Emitter;
		protected var _chargedTrail:Emitter;
		protected var _bulletPOP:Emitter;
		
		public function Bullet(x:Number = 0, y:Number = 0, angle:Number = 0, charge:Boolean = false)
		{
			bullet = new Image(Assets.Gphx_BULLET);
			graphic = bullet;
			bullet.smooth;
			bullet.centerOO();
			bullet.scale = 2;
			
			this.x = x;
			this.y = y;			
			this.angle = angle;
			bullet.angle = -angle * (180 / 3.14);
			
			createTrails(charge);
			
			//need multiple graphics so use addgraphic instead of graphic =
			addGraphic(bullet);
		}
		
		override public function update():void 
		{
			go();
			if (_chargedTrail != null) {
				_chargedTrail.emit("chargedTrail", bullet.x, bullet.y);
				range = 3000;
				speed = 1000;
			}
			else if (_bulletTrail != null) {
				_bulletTrail.emit("trail", bullet.x, bullet.y);
				range = 300;
				speed = 700;
			}
			counter += 1 * FP.elapsed;
			if (dead() || collide("walls", x, y)) {
				speed = 0;
				if (_bulletTrail != null) { _bulletTrail.visible = false; }
				else if (_chargedTrail != null) { _chargedTrail.visible = false; }
				world.add(new Explosion(x, y));
				this.visible = false;
				world.remove(this);
			}
			super.update();
		}
		
		private function createTrails(charge:Boolean = false):void
		{	
			if (charge){
			_chargedTrail = new Emitter(new BitmapData(12, 12, false, 0xffffffff), 8, 8);
			_chargedTrail.newType	("chargedTrail", [0]);
			_chargedTrail.setMotion	("chargedTrail", bullet.angle-180, 200, .5, 20, 200, 2);
			_chargedTrail.setGravity("chargedTrail", -200);
			_chargedTrail.setAlpha	("chargedTrail", 1, 0);
			addGraphic(_chargedTrail);
			_chargedTrail.visible = true;
			}
			
			else{
			_bulletTrail = new Emitter(Assets.Gphx_BULLET, 4, 2);
			_bulletTrail.newType	("trail", [0]);
			_bulletTrail.setMotion	("trail", bullet.angle-180, 200, .5, 0, 500, 3);
			_bulletTrail.setColor	("trail", 0xFFFFFFFF, 0x00000000);
			_bulletTrail.setAlpha	("trail", .5, 0, Ease.cubeOut);
			_bulletTrail.setGravity	("trail", -60);
			addGraphic(_bulletTrail);
			_bulletTrail.visible = true;			
			}
		}
		
		protected function go():void 
		{
			x += Math.cos(angle) * speed * FP.elapsed;
			y += Math.sin(angle) * speed * FP.elapsed;
		}
		
		protected function dead():Boolean 
		{
			if (counter * speed > range) {
				graphic.visible = false;
				return true;
			}
			return false;
		}
	}
}
package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Jinx
	 * 
	 */
	public class Explosion extends Entity
	{
		protected var _bulletPOP:Emitter;
		private var bullet2:Image;
		
		public function Explosion(x:Number = 0, y:Number = 0, explosionImage:Class = null) 
		{
//			bullet2 = new Image(Assets.Gphx_BULLET);
			bullet2 = new Image(explosionImage);
			graphic = bullet2;
			bullet2.smooth;
			bullet2.centerOO();
			
			this.x = x;
			this.y = y;			
			
//			_bulletPOP = new Emitter(Assets.Gphx_BULLET, 1, 1);
			_bulletPOP = new Emitter(explosionImage, 1, 1);
			_bulletPOP.newType	("pop", [0]);
			_bulletPOP.setMotion("pop", 0, 30, 0, 360, 150, .4);
			_bulletPOP.setAlpha	("pop", 1, .6);
			addGraphic(_bulletPOP);
			
			//need multiple graphics so use addgraphic instead of graphic =
			addGraphic(bullet2);
			bullet2.visible = false;
		}
		
		private var sploded:Boolean = false;
		
		private function createExplosion():void
		{	
			if (!sploded) 
			{	
				while (_bulletPOP.particleCount < 1000) 
				{
					_bulletPOP.emit("pop", bullet2.x, bullet2.y);
					sploded = true;
				}
			}
			if (_bulletPOP.particleCount == 0) 
			{
				world.remove(this);
			}
		}
		
		override public function update():void
		{
			createExplosion();
		}
		
	}

}
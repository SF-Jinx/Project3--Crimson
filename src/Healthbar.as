package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Draw;
	/**
	 * ...
	 * @author Jinx
	 */
	public class Healthbar extends Entity 
	{
		private var ent:Entity;
		private var healthCurrent:String;
		private var healthTotal:String;
		private var color:uint;
		
		public function Healthbar(x:Number, y:Number, w:Number, h:Number, ent:Entity, healthCurrent:String, healthTotal:String) 
		{
			this.x = x;
			this.y = y;
			setHitbox(w, h);
			this.ent = ent;
			this.healthCurrent = healthCurrent;
			this.healthTotal = healthTotal;
			layer = -10000;
		}
		
		override public function render():void 
		{			
			//Draw.rect(world.camera.x+x, world.camera.y+y, width, height, 0xFF0000);
			Draw.rect(world.camera.x + x, world.camera.y + y, width * ent[healthCurrent], height, color);
			
			if (ent[healthCurrent] > (ent[healthTotal] / 2))
			{
				//if higher than 50% health, make bar green
				color = 0x00FF00;	//green
			}
			
			if (ent[healthCurrent] <= (ent[healthTotal] / 2))
			{
				color = 0xFFFF00;	//yellow
			}
			
			if (ent[healthCurrent] < (ent[healthTotal] / 4))
			{
				color = 0xFF0000;	//red
			}
			
		}
	}

}
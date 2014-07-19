package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jinx
	 */
	public class Main extends Engine
	{
		
		public function Main():void 
		{
			super(800, 600, 60, false);
			FP.world = new GameWorld();
			FP.console.enable();
//			FP.screen.scale = 2;
		}
	}	
}
	
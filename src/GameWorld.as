package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.World;

	/**
	 * ...
	 * @author Jinx
	 */
	public class GameWorld extends World
	{		
		private var cameraOffset:int = 50;
		private var cameraSpeed: int = 2;
		private var levelName: String = "Isle";
		public static var player:Player = new Player();
		private var background:Backdrop;
		private var footpath:Backdrop;
		private var blocker:Backdrop;
		private var e_backdrop:Entity = new Entity;
		private var e_blocker:Entity = new Entity;
		private var goal:Entity = new Entity;
		private var spawnX:int = 0;
		private var spawnY:int = 0;
		
		private var cameraTweenX:VarTween = new VarTween();
		private var cameraTweenY:VarTween = new VarTween();
		
		public function GameWorld() 
		{
			goal.type = "goal";
			levelLoader();
			
			add(new Healthbar(5, 50, 5, 10, player, "healthCurrent", "healthTotal"));
			
			//create dem tweens fo' da camera handla
			addTween(cameraTweenX, true);
			addTween(cameraTweenY, true);
		}
		
		override public function update():void
		{
			super.update();
			goalCheck();
			Camera.cameraHandler2(footpath, cameraTweenX, cameraTweenY, camera);
//			cameraHandler();
//			DEBUG_CAMERAFOLLOWONLY();
		}
		
		private function DEBUG_CAMERAFOLLOWONLY():void
		{
			camera.x = player.x - (FP.screen.width / 2);
			camera.y = player.y - (FP.screen.height / 2);
		}
		
		private function backGroundLoader(drop:Class, path:Class, block:Class):void
		{
			//Create backdrop elements to so they can be added to a list
			background 	= new Backdrop (drop, true, true);
			footpath 	= new Backdrop (path, false, false);
			blocker 	= new Backdrop (block, false, false);
			
			//Reduce scroll factor for backgrounds which are further recessed
			//to create parallax effect
			background.scrollX = .3;
			background.scrollY = .3;
			
			//Shift the unwalkable stuff so that it matches - fix this graphically
			//in the future
//			blocker.y = -85;
			
			//Create backgrop GraphicList, put on bottom layer, and add to GameWorld
			e_backdrop.graphic = new Graphiclist(background, footpath);
			add(e_backdrop);
			e_backdrop.layer = 10;
			
			//Add second entity to handle miscellaneous backdrop stuff, adjust the layers separately, etc.
			e_blocker.graphic = blocker;
			add(e_blocker);
			e_blocker.layer = -10;
		}
		
		private var goalLocation:String;
		
		private function levelLoader():void
		{	
			switch(levelName) {
				case "Isle": {
//					add(new Level(Assets.L_ISLE_FG)); 
//					add(new LevelWalls(Assets.L_AARTHMORE_UT));
					backGroundLoader(Assets.L_ISLE_BG, Assets.L_ISLE_FG, null);
					goal.x = 1160//180;
					goal.y = 1000//375;
					levelName = "Shrine";
					spawnX = 400;
					spawnY = 400;
					break;
				}
				case "Shrine": {
					goal.x = 110;
					goal.y = 125;
					levelName = "Aarthmore";
					spawnX = 20;
					spawnY = 145;
					break;
				}
			}
			camera.y = footpath.height + 50;
			camera.x = (spawnX - cameraOffset) - (FP.width / 2);
			playerAdd(spawnX, spawnY);
			add(goal);
		}
		
		private function goalCheck():void
		{
			if (player.collide("goal", player.x, player.y)) {
				levelCleanup();
				levelLoader();
			}
		}
		
		public function levelCleanup():void
		{	
			this.removeAll();
		}
		
		private function playerAdd(spawnX:int = 0, spawnY:int = 0):void
		{
			//Player's start location
			add(player);
			player.x = spawnX;
			player.y = spawnY;
		}
	}
}
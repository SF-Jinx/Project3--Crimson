package  
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author Jinx
	 */
	public class Camera extends World
	{
		private var footpath:Backdrop;	
		
		public function Camera() 
		{
		}
		
		public static function cameraHandler2(footpath:Backdrop, cameraTweenX:VarTween, cameraTweenY:VarTween, camera:Point):void
		{
			var camX:int = 0;
			var camY:int = 0;
			var cameraOffset:int = 50;
			var cameraSpeed: int = 2;
			
			//create variables to monitor the camera position for the player
			camX = GameWorld.player.x - (FP.width / 2);
			camY = GameWorld.player.y;
			
			//HORIZONTAL CAMERA CONTROLS
			//if the camera should move no further to sides, stop it
			if (camX < (footpath.width - FP.width / 2) - cameraOffset && camX > 0) { 
				//camera.x = (player.x - cameraOffset) - (FP.width / 2); 
				cameraTweenX.tween(camera, "x", (GameWorld.player.x - cameraOffset) - (FP.width / 2), .25);
				} 
			else if (camX > footpath.width) { cameraTweenX.tween(camera, "x", (footpath.width - FP.width / 2), .25); }
			else if (camX < 0) cameraTweenX.tween(camera, "x", -cameraOffset, .25);
			
			//VERTICAL CAMERA CONTROLS
			//Repeat camX for camY
			if (camY > 0 && camY < footpath.height) 
			{ 
				//camera.y = (player.y + cameraOffset) - (FP.height / 2);
				cameraTweenY.tween(camera, "y", (GameWorld.player.y + cameraOffset) - (FP.height / 2), .25);
			}
			else if (camY > footpath.height) { camera.y = (footpath.height + cameraOffset) - (FP.height / 2); }
		}
		
	}

}
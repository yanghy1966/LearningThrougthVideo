package com.efg.games.driveshesaid 
{
	import flash.display.Sprite
	/**
	 * ...
	 * @author Jeff Fulton
	 */
	public class RadianDemo extends Sprite
	{
		
		public function RadianDemo() 
		{
			var velocity:Number = 2;
			var rotation:Number = 30;
			var carRadians:Number = (rotation / 360) * (2.0 * Math.PI);
				trace("rotation=" + rotation);
				trace("carRadians=" +carRadians);
				trace("Math.cos(carRadians)=" + Math.cos(carRadians));
				trace("Math.sin(carRadians)=" + Math.sin(carRadians));
				
			var dx:Number=Math.cos(carRadians)*velocity;
			var dy:Number= Math.sin(carRadians) * velocity;
			
			trace("dx=" + dx);
			trace("dy=" + dy);
		}
		
		
	}

}
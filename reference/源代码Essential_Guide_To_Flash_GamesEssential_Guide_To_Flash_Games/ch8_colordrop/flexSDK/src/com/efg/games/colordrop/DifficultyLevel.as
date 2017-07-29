package com.efg.games.colordrop 
{

	public class DifficultyLevel { //changed
		
		public var allowedColors:Array; //changed
		public var startPlays:Number; //changed
		public var scoreThreshold:Number; //changed
		
		public function DifficultyLevel(allowedColors:Array, startPlays:Number, scoreThreshold:Number) {  //changed
			this.allowedColors = allowedColors;
			this.startPlays = startPlays;
			this.scoreThreshold = scoreThreshold;			
		}
		
	}
	
}
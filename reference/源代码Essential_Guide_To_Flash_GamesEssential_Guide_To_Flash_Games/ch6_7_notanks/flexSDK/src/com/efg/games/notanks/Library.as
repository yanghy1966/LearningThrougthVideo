package com.efg.games.notanks 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Library 
	{
		[Embed(source='../../../../../assets/tanks_sheet.png')]
		public static const TankSheetPng:Class;
		
		[Embed(source = "../../../../../assets/noTanks_assets.swf", symbol="soundEnemyFire")]
		public static const SoundEnemyFire:Class;
		
		[Embed(source = "../../../../../assets/noTanks_assets.swf", symbol="soundExplode")]
		public static const SoundExplode:Class;
		
		[Embed(source = "../../../../../assets/noTanks_assets.swf", symbol="soundPlayerExplode")]
		public static const SoundPlayerExplode:Class;
		
		[Embed(source = "../../../../../assets/noTanks_assets.swf", symbol="soundPlayerFire")]
		public static const SoundPlayerFire:Class;
		
		[Embed(source = "../../../../../assets/noTanks_assets.swf", symbol="soundPlayerMove")]
		public static const SoundPlayerMove:Class;
		
		[Embed(source = "../../../../../assets/noTanks_assets.swf", symbol="soundPickUp")]
		public static const SoundPickUp:Class;
		
		[Embed(source = "../../../../../assets/noTanks_assets.swf", symbol="soundGoal")]
		public static const SoundGoal:Class;
		
		[Embed(source = "../../../../../assets/noTanks_assets.swf", symbol="soundHit")]
		public static const SoundHit:Class;
		
		[Embed(source = "../../../../../assets/noTanks_assets.swf", symbol="soundMusic")]
		public static const SoundMusic:Class;
		
		[Embed(source = "../../../../../assets/noTanks_assets.swf", symbol="soundHitWall")]
		public static const SoundHitWall:Class;
		
		[Embed(source = "../../../../../assets/noTanks_assets.swf", symbol="soundLife")]
		public static const SoundLife:Class;
		
	}
	
}
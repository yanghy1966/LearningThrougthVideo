﻿package com.efg.games.blastermines 
{
	import flash.display.BitmapData;
	import com.efg.framework.BlitArrayAsset;
	import com.efg.framework.BasicBiltArrayProjectile;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author ...
	 */
	public class ProjectileManager 
	{
		public var projectileBitmapData:BitmapData = new BitmapData(8, 8, true, 0x00000000);
		public var projectileAnimationFrames:Array = [];
		public var projectiles:Array=[]; 
		public var lastProjectileShot:Number = 0;
		public var projectileCount:int;
		public var tempProjectile:BasicBiltArrayProjectile;
		public var projectilePool:Array = [];
		public var projectilePoolCount:int;
		
		private var drawingCanvas:Shape = new Shape();
		private var point0:Point = new Point(0, 0);
		
		public function ProjectileManager() 
		{
			
		}
		
		
		public function createProjectiles(spriteGlowFilter:GlowFilter):void {
			//projectileManager.projectiles 
			var tempBlitArrayAsset:BlitArrayAsset = new BlitArrayAsset();
			
			drawingCanvas.graphics.clear();
			drawingCanvas.graphics.lineStyle(1, 0xffffff);
			
			
			drawingCanvas.graphics.drawRect(3, 3, 2, 2);
			
			projectileBitmapData.draw(drawingCanvas);
			projectileBitmapData.applyFilter(projectileBitmapData, projectileBitmapData.rect, point0, spriteGlowFilter);
			tempBlitArrayAsset= new BlitArrayAsset();
			projectileAnimationFrames=tempBlitArrayAsset.createRotationBlitArrayFromBD(projectileBitmapData, 10,0);
			
			
		}
		
		public function createProjectilePool(maxProjectiles:int):void {
			
			for (var projetcileCtr:int = 0; projetcileCtr < maxProjectiles; projetcileCtr++) {
				var tempProjectile:BasicBiltArrayProjectile=new BasicBiltArrayProjectile(0,799,0,799);
				tempProjectile.animationList=projectileAnimationFrames;
				tempProjectile.bitmapData = tempProjectile.animationList[0];
				projectilePool.push(tempProjectile);
			}
		}
	}
	
}
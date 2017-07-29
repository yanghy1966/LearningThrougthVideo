package com.efg.games.tunnelpanic
{

	/**
	 * ...
	 * @author ...
	 */
	public class Library 
	{
		
		[Embed(source = '../../../../../assets/startmusic.mp3')]
		public static const SoundMusicInGame:Class;
		
		[Embed(source = '../../../../../assets/ingamemusic.mp3')]
		public static const SoundMusicTitle:Class;
		
		[Embed(source='../../../../../assets/explode.mp3')]
		public static const SoundExplode:Class;
	}
	
}
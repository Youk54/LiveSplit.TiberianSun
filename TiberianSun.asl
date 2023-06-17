state("game")
{

	byte isPlaying : "game.exe", 0x3E48FC;
	byte mainMenuIdx : "game.exe", 0x408C4C;
	byte gameState : "game.exe", 0x3E224C;

	//technically first byte of splash text. 0 makes it hidden
	byte splashVisible : "game.exe", 0x34C5F4, 0x14;
	string20 splashText : "game.exe", 0x34C5f4, 0x14;

}

isLoading
{
	if(current.isPlaying == 0)
		return true;
	if(current.isPlaying == 1)
		return false;
}

start
{
	//game state in main menu: 0 in vanilla, 30 in firestorm
	if(old.mainMenuIdx != 0 && current.mainMenuIdx == 0 && (old.gameState == 0 || old.gameState == 30) && current.gameState == 255)		
		return true;
}

split
{

	if(old.splashVisible == 0 && current.splashVisible > 0)
	{
		string text = current.splashText.ToLower();

		//common pattern for EN/DE/FR 'mission accomplished' text
		if(text[7] == ' ' && text[11] == 'o')
			return true;
		//Pattern for spanish localisation
		if (text[7] == 'c')
			return true;
	}

}

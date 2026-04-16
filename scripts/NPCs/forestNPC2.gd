extends npc

func onDeath():
	deathCollisions()
	player_near=false
	player.changeRating(killValue)
	player.addKeyword("forest_clear")
	saveData()

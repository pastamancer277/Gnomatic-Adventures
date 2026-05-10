extends npc

func onDeath():
	$Dialogue.startChase()
	super.onDeath()

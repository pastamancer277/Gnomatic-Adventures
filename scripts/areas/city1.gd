extends area

func change_scene():
	if(Global.scene_transit):
		if(Global.cur_area=="Forest3"):
			Global.finish_scene_change("Forest2")
			visible=false

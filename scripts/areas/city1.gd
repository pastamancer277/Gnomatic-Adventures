extends area

var locationChange

func change_scene():
	if(Global.scene_transit):
		if(Global.cur_area=="City1"):
			Global.finish_scene_change(locationChange)
			visible=false

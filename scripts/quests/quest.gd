@abstract extends Node

class_name quest

var active=false
var complete=false

@abstract func tryComplete()

func isActive() -> bool:
	return active
func isComplete() -> bool:
	return complete

func activate():
	active=true

func reset():
	active=false
	complete=false

func saveData():
	$/root/SaveManager.addSaveData("Quests", name, {"active" = active, "complete" = complete})

func loadData():
	var data = $/root/SaveManager.getData("Quests", name)
	active = data.get("active", false)
	complete = data.get("complete", false)

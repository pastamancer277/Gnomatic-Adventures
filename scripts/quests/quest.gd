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

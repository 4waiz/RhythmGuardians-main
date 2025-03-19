extends Node
class_name State

signal transitioned(state: State, new_state_name: String)



func Enter():
	pass

func Exit():
	pass

func Update(_delta: float): #called in process function
	pass

func Physics_Update(_delta: float): #called in the _physics_process
	pass

extends Node2D
var topicn = []
var stage = Global.stage
var topic = Global.topic
var csv = "res://Q1.csv"

func _ready():
	for button in $VBoxContainer/Navigation/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
#	for button in $VBoxContainer/Main/questionAnswer/Answers.get_children():
#		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	load_csv()
	
	# Update the UI with the current Score
	$VBoxContainer/Navigation/Label.text = str(Global.playerScore)

func _on_Button_pressed(scene_to_load):
	get_tree().change_scene(scene_to_load)


func _on_Incorrect_Answer():
	pass # Replace with function body.

func load_csv():
		var file = File.new()
		file.open(csv, file.READ)
		while !file.eof_reached():
			var q = file.get_csv_line()
#if the scene is called Quiz, edits the button and labels in that scene using different coloumns
# from the csv file.
			if get_tree().get_current_scene().get_name() == "Quiz":
#check if the first coloumn is same as the topic provided from the main menu scene
#and if the stage is the same as the glboal script, which updates when next button is pressed (WIP)
				if (q[0] == topic and int(q[1]) == stage):
					topicn.append(q)
#edits the nodes using the specified coloumns from the csv file
					$VBoxContainer/Main/questionAnswer/Example_Question.text = String(topicn[0][2])
					$VBoxContainer/Main/questionAnswer/Answers/Button.text = String(topicn[0][3])
					$VBoxContainer/Main/questionAnswer/Answers/Button2.text = String(topicn[0][4])
					$VBoxContainer/Main/questionAnswer/Answers/Button3.text = String(topicn[0][5])
					$VBoxContainer/Main/questionAnswer/Answers/Button4.text = String(topicn[0][6])
					$VBoxContainer/Main/CenterContainer/Example_image.texture = load(str(topicn[0][8]))

#similar to above, but this changes the Information scene
			if get_tree().get_current_scene().get_name() == "Information":
#check if the first coloumn is same as the topic provided from the main menu scene
#and if the stage is the same as the glboal script, which updates when next button is pressed (WIP)
				if (q[0] == topic and int(q[1]) == stage):
					topicn.append(q)
					$VBoxContainer/Main/Example_text.text = String(topicn[0][7])
#edits the image, by getting the file provided in the 9th coloumn (I) of the csv file
					$VBoxContainer/Main/CenterContainer/Example_image.texture = load(str(topicn[0][8]))
		print(stage)
		file.close()
#	print(get_tree().get_current_scene().get_name())



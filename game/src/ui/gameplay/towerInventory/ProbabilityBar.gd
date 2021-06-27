extends Node2D


func update_prob(prob: float):
	var prob_of_red = prob * 100
	var prob_of_blue = 100 - prob_of_red
	
	var red_prob_display = self.get_node("Red")
	var blue_prob_display = self.get_node("Blue")
	
	#Update the actual probabilities
	red_prob_display.value = prob_of_red
	blue_prob_display.value = prob_of_blue

extends Control


var refrigerante_tipo
var refrigerante_quantidade
var gelo_quantidade
var rum_quantidade
var refrigerante_forte
var refrigerante_suave
var refrigerante_fraco
var rum_forte
var rum_suave
var rum_fraco
var gelo
var drink_fraco
var drink_suave
var drink_forte
var cuba_livre = false
onready var option_button = get_node("refrigerante_slider/OptionButton")
onready var rum_slider = get_node("rum_slider")
onready var gelo_slider = get_node("gelo_slider")
onready var refrigerante_slider = get_node("refrigerante_slider")
onready var gelo_label = get_node("gelo_slider/Label")
onready var rum_label = get_node("rum_slider/Label")
onready var refrigerante_label = get_node("refrigerante_slider/Label")

func get_min(value1, value2, value3):
	var min_value
	min_value = value1
	if value2<min_value:
		min_value = value2
	if value3<min_value:
		min_value = value3
	return(min_value)

func get_max(value1, value2, value3):
	var max_value
	max_value = value1
	if value2>max_value:
		max_value = value2
	if value3>max_value:
		max_value = value3
	return(max_value)

func _ready():
	#interface de usuario
	option_button.add_item("coca-cola", 0)
	option_button.add_item("pepsi", 1)
	#interface de usuario

func _process(delta):
	#interface de usuario
	refrigerante_tipo = option_button.get_selected_id()
	refrigerante_quantidade = refrigerante_slider.value
	rum_quantidade = rum_slider.value
	gelo_quantidade = gelo_slider.value
	refrigerante_label.text = str(refrigerante_quantidade)+" ml"
	gelo_label.text = str(gelo_quantidade)+" ml"
	rum_label.text = str(rum_quantidade)+" ml"
	#interface de usuario
	
	#calculo de grau de pertinencia
	#rum
	if rum_quantidade<10:
		rum_fraco = 0
	if  rum_quantidade>=10 and rum_quantidade<15:
		rum_fraco = 1
	if rum_quantidade>=15 and rum_quantidade<=20:
		rum_fraco = (20-rum_quantidade)/(20-15)
	if rum_quantidade>20:
		rum_fraco = 0
	if rum_quantidade<15:
		rum_suave = 0
	if rum_quantidade>=15 and rum_quantidade<=20:
		rum_suave = (15-rum_quantidade)/(15-20)
	if rum_quantidade>20 and rum_quantidade<25:
		rum_suave = 1
	if rum_quantidade>=25 and rum_quantidade<=27:
		rum_suave = (27-rum_quantidade)/(27-25)
	if rum_quantidade>27:
		rum_suave = 0
	if rum_quantidade<23:
		rum_forte = 0
	if rum_quantidade>=23 and rum_quantidade<=28:
		rum_forte = (23-rum_quantidade)/(23-28)
	if rum_quantidade>28 and rum_quantidade<30:
		rum_forte = 1
	if rum_quantidade>30:
		rum_forte = 0
	#rum
	#gelo
	if gelo_quantidade<20:
		gelo = 0
	if gelo_quantidade == 20:
		gelo = 1
	if gelo_quantidade>20:
		gelo = 0
	#gelo
	#refrigerante
	#coca-cola
	if option_button.get_selected_id() == 0:
		if refrigerante_quantidade<50:
			refrigerante_forte = 0
		if refrigerante_quantidade>=50 and refrigerante_quantidade<52:
			refrigerante_forte = 1
		if refrigerante_quantidade>=52 and refrigerante_quantidade<=54:
			refrigerante_forte = (54-refrigerante_quantidade)/(54-52)
		if refrigerante_quantidade>54:
			refrigerante_forte = 0
		if refrigerante_quantidade<52:
			refrigerante_suave = 0
		if refrigerante_quantidade>=52 and refrigerante_quantidade<=54:
			refrigerante_suave = (52-refrigerante_quantidade)/(52-54)
		if refrigerante_quantidade>54 and refrigerante_quantidade<56:
			refrigerante_suave = 1
		if refrigerante_quantidade>=56 and refrigerante_quantidade<=58:
			refrigerante_suave = (58-refrigerante_quantidade)/(58-56)
		if refrigerante_quantidade>58:
			refrigerante_suave = 0
		if refrigerante_quantidade<56:
			refrigerante_fraco = 0
		if refrigerante_quantidade>=56 and refrigerante_quantidade<=58:
			refrigerante_fraco = (56-refrigerante_quantidade)/(56-58)
		if refrigerante_quantidade>58 and refrigerante_quantidade<=60:
			refrigerante_fraco = 1
		if refrigerante_quantidade>60:
			refrigerante_fraco = 0
	#coca-cola
	#pepsi
	if option_button.get_selected_id() == 1:
		if refrigerante_quantidade<60:
			refrigerante_forte = 0
		if refrigerante_quantidade>=60 and refrigerante_quantidade<62:
			refrigerante_forte = 1
		if refrigerante_quantidade>=62 and refrigerante_quantidade<=64:
			refrigerante_forte = (64-refrigerante_quantidade)/(64-62)
		if refrigerante_quantidade>64:
			refrigerante_forte = 0
		if refrigerante_quantidade<62:
			refrigerante_suave = 0
		if refrigerante_quantidade>=62 and refrigerante_quantidade<=64:
			refrigerante_suave = (62-refrigerante_quantidade)/(62-64)
		if refrigerante_quantidade>64 and refrigerante_quantidade<66:
			refrigerante_suave = 1
		if refrigerante_quantidade>=66 and refrigerante_quantidade<=68:
			refrigerante_suave = (68-refrigerante_quantidade)/(68-66)
		if refrigerante_quantidade>68:
			refrigerante_suave = 0
		if refrigerante_quantidade<66:
			refrigerante_fraco = 0
		if refrigerante_quantidade>=66 and refrigerante_quantidade<=68:
			refrigerante_fraco = (66-refrigerante_quantidade)/(66-68)
		if refrigerante_quantidade>68 and refrigerante_quantidade<=70:
			refrigerante_fraco = 1
		if refrigerante_quantidade>70:
			refrigerante_fraco = 0
	#pepsi
	#refrigerante
	#calculo de grau de pertinencia
	
	#defuzzificacao
	drink_fraco = get_max(get_min(refrigerante_fraco, rum_fraco, gelo),get_min(refrigerante_fraco, rum_suave, gelo), get_min(refrigerante_suave, rum_fraco, gelo))
	drink_suave = get_max(get_min(refrigerante_forte, rum_fraco, gelo), get_min(refrigerante_suave, rum_suave, gelo), get_min(refrigerante_fraco, rum_forte, gelo))
	drink_forte = get_max(get_min(refrigerante_forte, rum_suave, gelo), get_min(refrigerante_forte, rum_forte, gelo), get_min(refrigerante_suave, rum_forte, gelo))
	$Label2.text = str(drink_fraco)+", "+str(drink_suave)+", "+str(drink_forte)
	if(drink_fraco>=drink_forte and drink_fraco>=drink_suave):
		$Label.text = "drink fraco"
		cuba_livre = true
	if(drink_suave>=drink_forte and drink_suave>=drink_fraco):
		$Label.text = "drink suave"
		cuba_livre = true
	if(drink_forte>=drink_fraco and drink_forte>=drink_suave):
		$Label.text = "drink forte"
		cuba_livre = true
	if(drink_forte<=0 and drink_suave<=0 and drink_fraco<=0):
		$Label.text = "nao e cuba livre"
		cuba_livre = false
	#defuzzificacao
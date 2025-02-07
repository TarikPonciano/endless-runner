extends Node2D


var fase1 = preload("res://Fases/fase1.tscn")
var fase2 = preload("res://Fases/fase2.tscn")
var fase3 = preload("res://Fases/fase3.tscn")
var fase4 = preload("res://Fases/fase4.tscn")
var rng = RandomNumberGenerator.new()
var contador = 1

func _process(delta: float) -> void:
	#Lembrar de remover o timer
	#Lembrar de renomear a função on_timer_timeout.... para criar_bloco
	#Usar a posição do jogador como gatilho para rodar a função criar_bloco
	var jogador = get_node("../Player")
	if (jogador != null):
		if (jogador.position.x > 176 + (1344*(contador-1))):
			criar_bloco()
	
	

func criar_bloco ()-> void:
	""" Lógica alternativa
	if (contador % 4) == 1:
		fase_temp = fase1.instantiate()
	elif (contador % 4) == 2:
		fase_temp = fase2.instantiate()
	elif (contador % 4) == 3:
		fase_temp = fase3.instantiate()
	elif (contador % 4) == 0:
		fase_temp = fase4.instantiate()
	"""
	
	var fase_temp 
	
	var numero_fase = rng.randi_range(1,4)
	
	if (numero_fase == 1):
		fase_temp = fase1.instantiate()
	elif (numero_fase == 2):
		fase_temp = fase2.instantiate()		
	elif (numero_fase == 3):
		fase_temp = fase3.instantiate()
	elif (numero_fase == 4):
		fase_temp = fase4.instantiate()
	else:
		print("Houve um erro na geração de números aleatórios")
	
	fase_temp.position = Vector2(1344*contador, 0)
	contador += 1
	add_child(fase_temp)

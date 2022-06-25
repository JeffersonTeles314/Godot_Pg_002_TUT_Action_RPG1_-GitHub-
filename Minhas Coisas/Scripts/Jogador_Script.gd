extends KinematicBody2D
var velocidade = Vector2.ZERO
var max_vel = 100
var aceleracao = 200
var friccao = 500

onready var animationtree = $AnimationTree
onready var estado_de_animation = animationtree.get("parameters/playback")

func _physics_process(delta):
	
	var vetor_input = Vector2.ZERO
	vetor_input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	vetor_input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	
	if vetor_input != Vector2.ZERO:
		
		#Programação da Animação
		animationtree.set("parameters/Correndo/blend_position", vetor_input)
		animationtree.set("parameters/Parado/blend_position", vetor_input)
		estado_de_animation.travel("Correndo")
		#Programação da Aceleração
		velocidade = velocidade.move_toward(vetor_input.normalized() * max_vel, aceleracao * delta)
		
	#Programação da Fricção
	if vetor_input == Vector2.ZERO:
		velocidade = velocidade.move_toward(Vector2.ZERO, friccao * delta) 
		estado_de_animation.travel("Parado")
	
	velocidade = move_and_slide(velocidade)

extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var morrendo = false
@onready var camera_man = get_node("../CameraMan")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if morrendo == false:
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = (direction * 200) + SPEED
		else:
			velocity.x = SPEED
		

		#Criar as condicionais de animação do jogador
		#Se a velocidade vertical(y) for negativa deve rodar a animação jump
		#Se a velocidade vertical(y) for positiva deve rodar a animação fall
		#Se a velocidade horizontal(x) for diferente de 0 deve rodar a animação run
		#$AnimatedSprite2D.play("")
		if velocity.y < 0:
			$AnimatedSprite2D.play("Jump")
		elif velocity.y > 0:
			$AnimatedSprite2D.play("Fall")
		elif velocity.x != 0:
			$AnimatedSprite2D.play("Run")
		
		#Ajustar limite inferior da câmera para 670
		#Ajustar posição horizontal (offset) para 400
		
		if position.y >= 670 or camera_man.position.x > position.x :
			morrendo = true
			camera_man.SPEED = 0
			
	if morrendo == true:
		
		
		velocity.x = 0
		
		if position.y >= 400:
			velocity.y = -300
			$AnimatedSprite2D.play("Death")
		else:
			velocity.y = 0
			$AnimatedSprite2D.play("Explode")
			await $AnimatedSprite2D.animation_finished
			queue_free()
		
	
	
	move_and_slide()


func _on_timer_timeout() -> void:
	Global.pontuacao = round(position.x/5) # Replace with function body.
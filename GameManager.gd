extends Node

var prompts = ["Win a million dollars but you give it to me", "Get a pet parrot but it will die in a week",
"Free taco but piano falls somewhere randomly in the world", "Go to the zoo but you will trip and fall in front of a group of people",
"3 free lottery tickets but a mosquito bites you", "You grow 3 inches but you lose 15 IQ", "See a celebrity but no more clouds for 2 weeks",
"$10,000 but 20% chance someone dies", "Fight a boxer for $1,000,000 but 15% chance of winning",
"You find the truth about the universe but you won't be able to tell anyone else", "Everything blue is free but you can no longer buy anything white",
"Talk to animals but they also talk to you", "Electricity bill is free but gas is doubled", "You can see through walls but you can't see through glass",
"Infinite knowledge but you lose 2 random senses", "Free 1 week vacation but you live in the woods for 2 days afterwards",
"Learn everything about Greece but forget everything about Rome", "Free coffee but it can only be black", "You become amazing at art but all colors you see switch",
"Your legs are big but your arms are small", "Cancer is solved but everyone who doesn't have cancer gets cancer", "Be fireproof but water is always cold"]

var numPlayers = 0;
@onready var gameTypeText = $"game type text" # text will change from discussion time to voting times
@onready var prompt = $"X but Y text"

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_discussion_timer_timeout() -> void:
	# go to voting
	$"vote timer".start()
	$"Vote yes".visible = true;
	$"Vote yes2".visible = true;


func _on_vote_timer_timeout() -> void:
	# skip to next person because player did not vote
	
	# once everyone has voted go to discussion
		$"discussion timer".start()
		gameTypeText.text = "Discussion Time"
		prompt.text = "choose random"

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

var numPlayers = 2;
var numVoted = 0;
var votes = [] # list of 0 or 1, 0 means yes, 1 means no

# game object variables except for timers just to read easier
@onready var progressBar = $ProgressBar
@onready var gameText = $"gameText" # text will change from "discussion time" to "voting time"
@onready var prompt = $prompt
@onready var playerName = $"player name"
@onready var yesButton = $YesButton
@onready var noButton = $NoButton

func _ready() -> void:
	# ask number of players
	begin_discussion()
	
func _process(delta: float) -> void:
	if ($"discussion timer".time_left > 0):
		progressBar.value = ($"discussion timer".time_left / $"discussion timer".wait_time) * 100
	elif ($"vote timer".time_left > 0):
		progressBar.value = ($"vote timer".time_left / $"vote timer".wait_time) * 100

func begin_discussion():
	gameText.text = "Discussion time"
	prompt.text = prompts[randi() % prompts.size()]
	$"discussion timer".start()
	playerName.visible = false
	yesButton.visible = false;
	noButton.visible = false;

func begin_voting():
	gameText.text = "Voting time"
	playerName.visible = true;
	playerName.text = "player " + str(numVoted)
	$"vote timer".start()
	yesButton.visible = true;
	noButton.visible = true;
	numVoted = 0
	votes = []

func continue_voting():
	$"vote timer".start()
	playerName.text = "player " + str(numVoted)

func _on_discussion_timer_timeout() -> void:
	begin_voting()

func _on_vote_timer_timeout() -> void:
	numVoted += 1
	if(numVoted < numPlayers): # skip to next person because player did not vote
		continue_voting()
	else: # once everyone has voted
		# check the "votes" array variable to see who is in majority
		begin_discussion()


func _on_vote_yes_button_down() -> void:
	votes.push_back(0)
	numVoted += 1
	continue_voting()

func _on_vote_no_button_down() -> void:
	votes.push_back(1)
	numVoted += 1
	continue_voting()

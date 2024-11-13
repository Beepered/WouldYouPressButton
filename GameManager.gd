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
var votes = [] # list of 0, 1, or 999, 0 means yes, 1 means no, 999 means no vote

# game object variables except for timers just to read easier
@onready var progressBar = $"Game voting stuff/ProgressBar"
@onready var gameText = $"Game voting stuff/gameText" # text will change from "discussion time" to "voting time"
@onready var prompt = $"Game voting stuff/prompt"
@onready var playerName = $"Game voting stuff/player name"
@onready var yesButton = $"Game voting stuff/YesButton"
@onready var noButton = $"Game voting stuff/NoButton"
@onready var discussTimer = $"Game voting stuff/discussion timer"
@onready var voteTimer = $"Game voting stuff/vote timer"
@onready var clicked = $"Voting Results/Click"
@onready var not_clicked = $"Voting Results/Dont Click"
@onready var display_votes_timer = $"Voting Results/Timer"

func _ready() -> void:
	# ask number of players
	begin_discussion()
	
func _process(delta: float) -> void:
	if (discussTimer.time_left > 0):
		progressBar.value = (discussTimer.time_left / discussTimer.wait_time) * 100
	elif (voteTimer.time_left > 0):
		progressBar.value = (voteTimer.time_left / voteTimer.wait_time) * 100

func begin_discussion():
	$"Voting Results".visible = false;
	$"Game voting stuff".visible = true;
	discussTimer.start()
	gameText.text = "Discussion time"
	prompt.text = prompts[randi() % prompts.size()]
	playerName.visible = false
	yesButton.visible = false;
	noButton.visible = false;

func begin_voting():
	voteTimer.start()
	numVoted = 0
	votes = []
	gameText.text = "Voting time"
	playerName.visible = true;
	playerName.text = "player " + str(numVoted + 1)
	yesButton.visible = true;
	noButton.visible = true;

func _on_discussion_timer_timeout() -> void:
	begin_voting()

func _on_vote_timer_timeout() -> void:
	voted(999)

func _on_vote_yes_button_down() -> void:
	voted(0)

func _on_vote_no_button_down() -> void:
	voted(1)

func voted(voteNum):
	numVoted += 1
	votes.push_back(voteNum)
	if(numVoted < numPlayers): # skip to next person because player did not vote
		voteTimer.start()
		playerName.text = "player " + str(numVoted + 1)
	else: # once everyone has voted
		voteTimer.stop()
		# check the "votes" array variable to see who is in majority
		show_vote_percentages()

func show_vote_percentages():
	$"Game voting stuff".visible = false;
	$"Voting Results".visible = true;
	display_votes_timer.start()
	var num_yes:float = 0;
	var num_no:float = 0;
	for vote in votes:
		if(vote == 1):
			num_yes+= 1;
		if(vote == 0):
			num_no+= 1;
	prompt.text = "Percentages:";
	clicked.text = "Clicked: " + str((num_yes/numVoted)*100) + "%";
	not_clicked.text = "Not clicked: " + str((num_no/numVoted)*100) + "%";
	
	


func _on_timer_timeout() -> void:
	begin_discussion()

extends "res://assets/scenes/npcs/monster.gd"
const PUZZLE = preload("res://assets/scenes/npcs/resources/puzzle.tscn")

@onready var monster_animation = $"../PathFollowArea2D/AnimatedSprite2D"

# Called when the node enters the scene tree for the first time.
const wasd_puzzle_objects = [
	{
		"text_puzzle": "↑ ← →",
		"regex_answers": ["^wad$"]
	},
	{
		"text_puzzle": "↑ → ↑",
		"regex_answers": ["^wdw$"]
	},
	{
		"text_puzzle": "↑ ← → ←",
		"regex_answers": ["^wada$"]
	},
	{
		"text_puzzle": "↑ → ←",
		"regex_answers": ["^wda$"]
	},
	{
		"text_puzzle": "↑ → ← ↑",
		"regex_answers": ["^wdaw$"]
	},
	{
		"text_puzzle": "↑ ← → ←",
		"regex_answers": ["^wada$"]
	},
	{
		"text_puzzle": "↑ → ← →",
		"regex_answers": ["^wdad$"]
	},
	{
		"text_puzzle": "↑ → ← → ↑",
		"regex_answers": ["^wdadw$"]
	},
];

const command_word_puzzle_objects = [
	{
		"text_puzzle": "Say the word 'hello'",
		"regex_answers": ["^hello$"]
	},
	{
		"text_puzzle": "Say the word 'goodbye'",
		"regex_answers": ["^goodbye$"]
	},
	{
		"text_puzzle": "Say the word 'please'",
		"regex_answers": ["^please$"]
	},
	{
		"text_puzzle": "Say the word 'thank you'",
		"regex_answers": ["^thank you$"]
	},
	{
		"text_puzzle": "Say the word 'sorry'",
		"regex_answers": ["^sorry$"]
	},
	{
		"text_puzzle": "Say the word 'excuse me'",
		"regex_answers": ["^excuse me$"]
	},
	{
		"text_puzzle": "Say the word 'yes'",
		"regex_answers": ["^yes$"]
	},
	{
		"text_puzzle": "Say the word 'no'",
		"regex_answers": ["^no$"]
	},
]

const complex_word_puzzles = [
	{
		"text_puzzle": "Greet Cerberus",
		"regex_answers": ["^hello cerberus$", "^hi cerberus$", "^good day cerberus$", "^howdy cerberus$"]
	},
	{
		"text_puzzle": "Where do fish keep their money?",
		"regex_answers": ["^in the riverbank$", "^in the river bank$", "^by the riverbank$", "^by the river bank$"]
	},
	{
		"text_puzzle": "I speak without a mouth and hear without ears. I have no body, but I come alive with the wind. What am I?",
		"regex_answers": ["^an echo$", "^a voice$", "^sound$", "^an echo in the wind$"]
	},
	{
		"text_puzzle": "What starts with 'e' and ends with 'e', but only contains one letter?",
		"regex_answers": ["^envelope$", "^eye$", "^example$", "^eve$"]
	},
	{
		"text_puzzle": "The more you take, the more you leave behind. What am I?",
		"regex_answers": ["^footsteps$", "^time$", "^memories$", "^a trail$"]
	},
	{
		"text_puzzle": "What has keys but can't open locks?",
		"regex_answers": ["^a piano$", "^a keyboard$", "^a typewriter$", "^a calculator$"]
	},
	{
		"text_puzzle": "What has a head, a tail, is brown, and has no legs?",
		"regex_answers": ["^a penny$", "^a coin$", "^a chocolate bar$", "^a snake$"]
	}
];
const backword_word_puzzles = [
	{
		"text_puzzle": "Repeat the term 'Ares' backwards",
		"regex_answers": ["^sera$"]
	},
	{
		"text_puzzle": "Repeat the term 'Hermes' backwards",
		"regex_answers": ["^semreh$"]
	},
	{
		"text_puzzle": "Repeat the term 'Athena' backwards",
		"regex_answers": ["^anehta$"]
	},
	{
		"text_puzzle": "Repeat the term 'Zeus' backwards",
		"regex_answers": ["^suez$"]
	},
	{
		"text_puzzle": "Repeat the term 'Poseidon' backwards",
		"regex_answers": ["^nodiesop$"]
	},
	{
		"text_puzzle": "Repeat the term 'Hades' backwards",
		"regex_answers": ["^sedah$"]
	}
];
const greek_word_puzzles = [
	{
		"text_puzzle": "Who is the king of the Greek gods?",
		"regex_answers": ["^zeus$"]
	},
	{
		"text_puzzle": "Who is the goddess of wisdom?",
		"regex_answers": ["^athena$"]
	},
	{
		"text_puzzle": "Who is the god of the underworld?",
		"regex_answers": ["^hades$", "^me$"]
	},
	{
		"text_puzzle": "Who is the messenger of the gods?",
		"regex_answers": ["^hermes$"]
	},
	{
		"text_puzzle": "Who is the god of the sea?",
		"regex_answers": ["^poseidon$"]
	},
	{
		"text_puzzle": "Who is the goddess of love and beauty?",
		"regex_answers": ["^aphrodite$"]
	},
	{
		"text_puzzle": "Who is the god of war?",
		"regex_answers": ["^ares$"]
	},
	{
		"text_puzzle": "Who is the goddess of the hunt?",
		"regex_answers": ["^artemis$"]
	}
];
const long_summoning_incantations = [
	{
		"text_puzzle": "Repeat after me: 'By the power of the ancient ones, awaken!'",
		"regex_answers": ["^by the power of the ancient ones, awaken!$"]
	},
	{
		"text_puzzle": "Say: 'From the depths of the abyss, come forth!'",
		"regex_answers": ["^from the depths of the abyss, come forth!$"]
	},
	{
		"text_puzzle": "Recite: 'With the rising of the moon, be summoned!'",
		"regex_answers": ["^with the rising of the moon, be summoned!$"]
	},
	{
		"text_puzzle": "Chant: 'By the light of the stars, I command thee!'",
		"regex_answers": ["^by the light of the stars, i command thee!$"]
	},
	{
		"text_puzzle": "Repeat: 'In the name of magic, arise!'",
		"regex_answers": ["^in the name of magic, arise!$"]
	}
];
const summoning_incantations = [
	{
		"text_puzzle": "Say: 'Awaken!'",
		"regex_answers": ["^awaken!$"]
	},
	{
		"text_puzzle": "Repeat: 'Arise!'",
		"regex_answers": ["^arise!$"]
	},
	{
		"text_puzzle": "Chant: 'Come forth!'",
		"regex_answers": ["^come forth!$"]
	},
	{
		"text_puzzle": "Recite: 'By my command!'",
		"regex_answers": ["^by my command!$"]
	},
	{
		"text_puzzle": "Say: 'Rise!'",
		"regex_answers": ["^rise!$"]
	}
];
const latin_chants = [
	{
		"text_puzzle": "Repeat after me: 'Spiritus Sanctus'",
		"regex_answers": ["^spiritus sanctus$"]
	},
	{
		"text_puzzle": "Chant along: 'Ave Maria'",
		"regex_answers": ["^ave maria$"]
	},
	{
		"text_puzzle": "Say after me: 'Pax Vobiscum'",
		"regex_answers": ["^pax vobiscum$"]
	},
	{
		"text_puzzle": "Repeat: 'Ad Astra Per Aspera'",
		"regex_answers": ["^ad astra per aspera$"]
	},
	{
		"text_puzzle": "Recite with me: 'Deus Ex Machina'",
		"regex_answers": ["^deus ex machina$"]
	},
	{
		"text_puzzle": "Say it: 'Veni, Vidi, Vici'",
		"regex_answers": ["^veni, vidi, vici$"]
	},
	{
		"text_puzzle": "Repeat: 'Semper Fidelis'",
		"regex_answers": ["^semper fidelis$"]
	},
	{
		"text_puzzle": "Chant after me: 'E Pluribus Unum'",
		"regex_answers": ["^e pluribus unum$"]
	},
	{
		"text_puzzle": "Say it: 'Cogito, Ergo Sum'",
		"regex_answers": ["^cogito, ergo sum$"]
	},
	{
		"text_puzzle": "Recite with me: 'Alea Iacta Est'",
		"regex_answers": ["^alea iacta est$"]
	}
];

const puzzle_objects = command_word_puzzle_objects + backword_word_puzzles + latin_chants + summoning_incantations + long_summoning_incantations

func _ready():
	print("Summoning Lost Soul")
	add_puzzles()


func add_puzzle(puzzle: String, regex_answers: Array):
	var puzzle_node = PUZZLE.instantiate()
	puzzle_node.text_puzzle = puzzle
	for regex_answer in regex_answers:
		puzzle_node.regex_answers.append(regex_answer)
	get_tree().root.add_child(puzzle_node)
	puzzles.append(puzzle_node)

func add_puzzles():
	for puzzle in puzzle_objects:
		add_puzzle(puzzle["text_puzzle"], puzzle["regex_answers"])

func desummon():
	monster_animation.play("desummoning")

func _on_animated_sprite_2d_animation_finished():
	print("Lost Soul Animation finished: " + monster_animation.animation)
	if monster_animation.animation == "summoning":
		monster_animation.play("idle")
		print("Playing idle Soul")
	elif monster_animation.animation == "desummoning":
		destroy()

extends CustomAudioPlayer

const prefix = "res://assets/audio/"

const paths = [
	"Musical Box/BGM OGG/Theme_-_Music_Box_-_Dream_Dance.ogg",
  "Musical Box/BGM OGG/Theme_-_Music_Box_-_Enchanted_Entrance.ogg",
  "Musical Box/BGM OGG/Theme_-_Music_Box_-_Innocent_Interlude.ogg",
  "Musical Box/BGM OGG/Theme_-_Music_Box_-_Lilting_Lullaby.ogg",
  "Musical Box/BGM OGG/Theme_-_Music_Box_-_Melancholy_Memory.ogg",
  "Musical Box/BGM OGG/Theme_-_Music_Box_-_Nursery_Nightmare.ogg",
  "Musical Box/BGM OGG/Theme_-_Music_Box_-_Nursery_Nighttime.ogg",
  "Musical Box/BGM OGG/Theme_-_Music_Box_-_Spooky_Spells.ogg",
  "Musical Box/BGM OGG/Theme_-_Music_Box_-_Wandering_Wizard.ogg",
  "Musical Box/ME OGG/ME_-_Music_Box_-_mysterious_01.ogg",
  "Musical Box/ME OGG/ME_-_Music_Box_-_mysterious_02.ogg",
  "Musical Box/ME OGG/ME_-_Music_Box_-_mysterious_03.ogg",
  "Musical Box/ME OGG/ME_-_Music_Box_-_positive_01.ogg",
  "Musical Box/ME OGG/ME_-_Music_Box_-_positive_02.ogg",
  "Musical Box/ME OGG/ME_-_Music_Box_-_positive_03.ogg",
  "Musical Box/ME OGG/ME_-_Music_Box_-_positive_04.ogg",
  "background-music/Battle Loop #3.ogg",
  "background-music/Battle Loop #5.ogg",
  "background-music/Medieval Theme #2.ogg",
  "background-music/Stay Strong (Unbreakable).ogg",
  "background-music/Steel Enemy.ogg",
  "background-music/Time of Heroes.ogg",
]

enum MUSIC {
	dream_dance,
  enchanted_entrance,
  innocent_interlude,
  lilting_lullaby,
  melancholy_memory,
  nursery_nightmare,
  nursery_nighttime,
  spooky_spells,
  wandering_wizard,
  mysterious1,
  mysterious2,
  mysterious3,
  positive1,
  positive2,
  positive3,
  positive4,
  batlleloop3,
  battleloop5,
  medieval2,
  stay_strong,
  steel_enemy,
  time_of_heroes,
}

export (MUSIC) var choice = MUSIC.battleloop5

func _ready() -> void:
	take_file(prefix + paths[choice], true)
	play()

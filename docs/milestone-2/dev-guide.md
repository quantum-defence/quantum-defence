# Getting Started

1. Download godot. Godot is an open source game development engine that can be downloaded [here](https://https://godotengine.org/download/windows).
1. Clone the repo into your local folder by using the following command:

```shell
git clone https://github.com/bharathcs/quantum-defence.git
```

1. Open the godot game engine and select the clone repo to import. Edit as you please. All tscn files are automatically updated by godot when you change the scenes. Godot is the only dependancy and you should be able to run everything.

## Contributing

If you would like to help [report bugs](https://github.com/bharathcs/quantum-defence/issues) or [write code](https://github.com/bharathcs/quantum-defence/pulls) for this project, you can reach out to us through these links. We don't have any formal submission guidelines (just be civil please) and we welcome any input.

# Program Flow

## Overview of Game Source Code

Programming in our code is largely split into 2:

- Arena: in charge of dealing with all the tiles, enemy, home base and towers
- Build Tool UI: takes in user interaction to build / upgrade / destroy and passes it on to the Arena to execute

The Arena itself has multiple important nodes, but here are some clarifications on the most inscrutable parts:

**Navigation**

- When requested by an enemy instance, plots a valid path across navigable tiles (see Skeleton Tile Map)
- Is not aware of other future enemy positions when calculating for a particular enemy, so it cannot plot around non tile obstacles. Depends on enemy to manage collisions itself.

**Tower & Enemy & Home**

- Enemies will ask navigator for map and proceed along the route, barring any collisions. For every collision it will stagger randomly for a predetermined period of time and then request a new path.
- As enemies enter / leave tower range, the tower will add to memory / forget these instances. Towers will continuously fire at the nearest enemy in memory.
- Enemies and home have specific behaviour and animation for different behaviours to show satisfying feedback and for game mechanics (taking damage takes priority over all other behaviour, attacks require a brief cool down, etc)

**Internal Representation**

- `tower_at` - an array of Tower [WeakRefs](https://docs.godotengine.org/en/stable/classes/class_weakref.html) for use when upgrading / building / dismantling towers and used when Arena is updated by / updates Build Tool UI
- `tile_at` - an array of enum values representing the content of the tile

**TileSelector**

- Square that flashes Green / Red based on if the tile is a valid position for user action (based on whether they are in build mode)
- follows user interaction and is continually updated by `tower_at` and `tile_at`.
- On the user taking action, the TileSelector provides the BuildTool the tile location or the tower if applicable for further action (building / dismantling / inspection / upgrade by user)

**Tile Map**

- Tile Map (Pretty): 32x32 and 16x16 tiled pixel art to show a nice user friendly depiction. Does not have any responsibility other than display
- Tile Map (Skeleton): 64x64 bare tiles that provides an easy way for level designer to communicate the position of paths to the map's internal representation

**Build Tool**

- Primarily contains build and inspect buttons that set user mode.
- In build mode, shows an otherwise hidden list of tower buttons to set type of tower to be built
- (Disabled in v0.7-alpha release) In inspect mode, selecting a tower will show a tower inspector window that displays attributes and items as well as provide upgrade and dismantle options
- (Disabled in v0.7-alpha release) Contains an item pack that can be consumed by towers to upgrade their attributes

A diagram summarising these interactions can be seen below:

![Arena and UI](./arena-and-ui-interaction.png)

## Overview of Enemy Quantum Logic

In quantum computing, qubits replace the traditional 0s or 1s of bits in classical computing.
Where a bit can only be 0 or 1, qubits appear to be in a coherent superposition (in _both_ states of 0 and 1 simultaneously).
Qubits will however collapse to just holding 1 bit of information (turn into a typical bit in either 0 or 1 state) when measured.
Our enemies can be either blue or red, but their state is represented as a qubit.

As such, quantum powered (tensor) weapons or classical (quodite) weapons can be employed against them:

- Tensor: change change the state of their qubit without measurement (applying qubits through the quantum logic circuits in the weapons, changing their probabilities in the red and blue dimensions)
- Quodite: can be dealt direct typical damage, which would also measure them (collapsing them to red or blue dimensions)

Quodite and Tensor effects can be combined, resulting in many unique possibilities for our game users to experiment with quantum computing.
Currently in the milestone 1 submission, all that is being explored is collapsing an enemy that initially is in a superposition of blue and red states.
Upon first contact with a classical tower projectile each of these enemies will collapse to be only in either blue or red dimension.

In the future, specialised quantum missiles (Tensor in our game lore), will be able to apply quantum computation on the enemies in superposition.
This requires quite specialised code from MicroQiskit, which we have rewritten into GDScript (Godot's coding language)

![Enemy, Tower Projectile and API Service](./enemy-projectile-api.png)

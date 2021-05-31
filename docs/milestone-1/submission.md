# Milestone 1 README

Try out the current version of "The Architect" v0.7 alpha at [this link](https://github.com/bharathcs/quantum-defence/releases/tag/v0.7-alpha)! Comments and feedback are welcomed and much appreciated.

Here are some additional materials made for orbital:

- [Video Link](https://bit.ly/3i31g5d)
- [Poster Link](https://raw.githubusercontent.com/bharathcs/quantum-defence/main/docs/milestone-1/poster.png)

## Motivation:

From Google’s claim of already achieving quantum supremacy to IBM’s Qiskit offering to one day give companies API access to their own quantum computing runtimes, there is a lot of exciting news and headlines that still seems almost mystical. However, a lot of the material online is either difficult to digest and not for those without a physics background or they are fluffy pop science articles. We want to take the time to really understand how this works, and try our hand at some quantum computing concepts.

## Aim

Our aim is to make a game that both explains quantum principles, is fun to play, and gets us (as developers) familiar with game development and quantum computing.

## Core features

Defend the base against waves of attacks by enemies with turrets, gates, borders and strategy. This tower defence game will have enemies, defences and structures in superposition or in their measured state. The enemies and items can be in one of 2 states, visually coded as red or blue. When they spawn, they appear in superposition until their state is measured, which happens when they take damage. These basic tower defence functionality is the first set of core feature, and this part is functionally similar to coding for multiple types of damages / enemies in our tower defence game (imagine a tower defence game with elements)

Towers need to be upgradeable, and can potentially be imbued with quantum logic to impact enemies without collapsing the superposition. This is our second set of core feature, to write quantum circuitry and deploy it on our upgraded towers to impact enemies and move them from one state of superposition to another. This moves it well beyond the realm of traditional tower defence game and requires Qiskit integration.

Some of the structures and game mechanics will be simplifications of techniques used in real life quantum computing, such as entanglement and quantum state manipulation (e.g. with Hadamard gates). Over the course of the gameplay, gamers should be able to learn these concepts and be more comfortable with them, even if they do not understand quantum mechanics. This may involve additional educational info in pop ups.

## Features & Timeline

| Features                           | Release date | Comments                                                              |
| :--------------------------------- | :----------: | :-------------------------------------------------------------------- |
| Items and Inventory                |  2021-06-7   | Upgrade your towers with items                                        |
| Enemy waves and kill counter       |  2021-06-12  | Track your success and be rewarded with items                         |
| Resource class for towers          |  2021-06-12  | Resource class will be implemented and integrated into tower building |
| TensorProjectiles                  |  2021-06-19  | Weapons that can keep enemy in superposition and alter their states   |
| Music and sound effects            |  2021-06-23  | -                                                                     |
| HomeScreen                         |  2021-06-23  | -                                                                     |
| Prep for release of official alpha |  2021-06-23  | -                                                                     |

## User Stories

This is the broad overview of how we see users employing our game:

- Epic 1: As a student interested in learning the basics of quantum mechanics and quantum computing, I can play the game and understand how concepts such as superposition and quantum computing or entanglement work. These concepts would also be more digestable as they are intrinsic in the gameplay of the game.

  - User Story 1.1: I want the game to have logical in-game narratives that use quantum principles in gameplay Present option to use typical projectiles collapse superposition or use quantum logic in tensor projectiles can act on the qubit states without collapsing superposition
    - There must be typical tower defence elements that collapse quantum superposition to classical systems (Quodite projectiles just turn enemies in superposition to just red or blue)
    - Each 'quantum powered' item / projectile / game mechanic must refer to only a single real life quantum principle, mechanism, effect or concept.
  - User Story 1.2: I want to have educational resources within reach
    - Each 'quantum powered' item / projectile / game mechanic could have some sort of 'Read More' button to show more information on how this parallels quantum circuitry in real life.
    - Good documentation for those with a more technical background to be able to understand or use our work if they wish (MIT LICENSE)

- Epic 2: As a gamer, I can enjoy a different take on a tower defence game. A new element that has yet to exist in any other commercial game in the market.

  - User Story 2.1: I want all basic tower defence mechanisms and features to be familiar and accessible (core features must be very much like typical tower defence game)
    - Building and picking Tower emplacements
    - Natural basic enemy behaviours are take damage, attack or move towards target
    - Towers automatically track closest enemies and fire when in range
    - Home base takes damage, has a health bar and signals when game is over
  - User Story 2.2: I want the in-game lore, soundtrack, sound effects and visual displays to be entertaining
    - Requires cohesive design language across the game
    - Soundtrack, tilemaps, sound fx to be used carefully
    - Storyline and cutscenes used judiciously
  - User Story 2.3: I want the game mechanisms using quantum logic to be explained simply.
    - Avoid requiring anything beyond layman understanding for the basic levels.
    - Hide away more technical explanations behind a 'More Info' / 'Read More' button or similar.

- Epic 3: (Less critical) As a more competitve gamer, I want to see statistics relating to my play

  - User story 3.1: I want to be able to record the score (kill count / rounds) of the game or somehow keep track of all the achievements etc. E.g a personal high score record.
  - User story 3.2: I want to track the time it takes to complete the entire game and a display for that

# Project Log

| Start Date |  End Date  |  Member  | Task                                      | Comments                                       | Hours |
| :--------: | :--------: | :------: | :---------------------------------------- | :--------------------------------------------- | :---: |
| 2021-05-01 | 2021-05-10 | Tee Chin | Learning godot and game design principles | Made a Pong clone                              |  12   |
| 2021-05-01 | 2021-05-10 | Bharath  | Learning godot and game design principles | Made a Pong clone                              |  12   |
| 2021-05-10 | 2021-05-14 | Tee Chin | Make Basic TD Mechanics                   | Turrets Timers Homing Projectiles              |   4   |
| 2021-05-10 | 2021-05-14 | Bharath  | Basic TD: Enemy and Home                  | Sprites and Enemy attacking behaviour          |   4   |
| 2021-05-14 | 2021-05-15 | Bharath  | Basic TD: Enemy Spawning                  | Enemy Spawn Points and creation logic          |   3   |
| 2021-05-14 | 2021-05-16 | Bharath  | Basic TD: Enemy Mechanics (Attempt 1)     | Physics Layer and enemy path testing           |   7   |
| 2021-05-14 | 2021-05-16 | Tee Chin | Basic TD: Tower mechanics                 | Tower sprite, watching for enemy, firing       |   7   |
| 2021-05-16 | 2021-05-18 | Tee Chin | Basic TD: Design                          | Redesigned and choose assets for the game      |   3   |
| 2021-05-17 | 2021-05-17 | Bharath  | Team meeting                              | Discussing how to integrate or split           |   2   |
| 2021-05-18 | 2021-05-19 | Bharath  | Managing new assets and reorganising work | Bulk of time on learning dev practices         |   3   |
| 2021-05-18 | 2021-05-20 | Tee Chin | BuildUI (First attempt)                   | Made the BuildUI (First attempt)               |   7   |
| 2021-05-19 | 2021-05-22 | Bharath  | Enemy collision (Attempt 2)               | Tried nav poly based logic, ended up too laggy |   4   |
| 2021-05-19 | 2021-05-22 | Bharath  | Enemy collision (Attempt 3)               | Bulk on time on learning godot physics         |   6   |
| 2021-05-17 | 2021-05-22 | Tee Chin | Build UI (Second attempt)                 | Remade the BuildUI using built-in nodes        |   7   |
| 2021-05-20 | 2021-05-24 | Tee Chin | Made an item and tower inventory class    | squash tower inventory bugs                    |   7   |
| 2021-05-23 | 2021-05-29 | Bharath  | Tile Selector (UI for Maps)               | Detecting tile content & displaying overlay    |   4   |
| 2021-05-23 | 2021-05-29 | Bharath  | Working on PR and Merges and cleaning up  | And integrating tee chin UI work to main       |   1   |
| 2021-05-24 | 2021-05-30 | Tee Chin | Debugged and redesign inventory class     | Add inventory, drag and drop system to buildUI |   7   |
| 2021-05-29 | 2021-05-30 | Bharath  | Create new tile map (lava world)          | Some code logic, mostly design work            |   4   |
| 2021-05-29 | 2021-05-30 | Bharath  | Make basic API on localhost               | Build basic Express app to return 0 or 1       |   3   |
| 2021-05-29 | 2021-05-30 | Bharath  | Deploy API on heroku                      | Use Heroku documentation                       |   2   |
| 2021-05-29 | 2021-05-30 | Bharath  | Connecting Enemy to the API               | On taking damage, choose red / blue            |   2   |
| 2021-05-29 | 2021-05-30 | Bharath  | Personal Milestone 1 Tasks                | Meeting, Documentation, Exporting              |   3   |
| 2021-05-31 | 2021-05-31 | Bharath  | Milestone 1 Team Meeting and Submission   | Submission Documents                           |   2   |
| 2021-05-31 | 2021-05-31 | Tee Chin | Milestone 1 Team Meeting and Submission   | Submission Documents                           |   2   |

|  Member  | Hours |
| :------: | :---: |
| Bharath  |  62   |
| Tee Chin |  56   |

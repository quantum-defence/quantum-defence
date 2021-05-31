# Milestone 1 README

## Motivation:

From Google’s claim of already achieving quantum supremacy to IBM’s Qiskit offering to one day give companies API access to their own quantum computing runtimes, there is a lot of exciting news and headlines that still seems almost mystical. However, a lot of the material online is either difficult to digest and not for those without a physics background or they are fluffy pop science articles. We want to take the time to really understand how this works, and try our hand at some quantum computing concepts.

## Aim
Our aim is to make a game that both explains quantum principles, is fun to play, and gets us (as developers) familiar with game development and quantum computing.

## Core features

Defend the base against waves of attacks by enemies with turrets, gates, borders and strategy. This tower defence game will have enemies, defences and structures in superposition or in their measured state. The enemies and items can be in one of 2 states, visually coded as red or blue. When they spawn, they appear in superposition until their state is measured, which happens when they take damage. These basic tower defence functionality is the first set of core feature, and this part is functionally similar to coding for multiple types of damages / enemies in our tower defence game (imagine a tower defence game with elements)

Towers need to be upgradeable, and can potentially be imbued with quantum logic to impact enemies without collapsing the superposition. This is our second set of core feature, to write quantum circuitry and deploy it on our upgraded towers to impact enemies and move them from one state of superposition to another. This moves it well beyond the realm of traditional tower defence game and requires Qiskit integration.

Some of the structures and game mechanics will be simplifications of techniques used in real life quantum computing, such as entanglement and quantum state manipulation (e.g. with Hadamard gates). Over the course of the gameplay, gamers should be able to learn these concepts and be more comfortable with them, even if they do not understand quantum mechanics. This may involve additional educational info in pop ups.


# Features

|   Features  |  Release date  | Comments     | 
| :--------:  |   :--------:   | :--------:   | 
| TensorProjectiles | 2021-06-7 | :--------:  |
| Items and Inventory | 2021-06-7 | :--------:  |
| Enemy waves and kill counter | 2021-06-12| :--------:  |
| Resource class for towers | 2021-06-12 | Resource class will be implemented and integrated into tower building |
| Quantum backend funcitons | 2021-06-19 | :--------:  |
| Music and sound effects   | 2021-06-23 | :--------:  |
| HomeScreen  | 2021-06-23 | :--------:  |
| Prep for release of official alpha | 2021-06-23 | :--------:  |




# UserStories
US01 : As a student interested in learning the basics of quantum mechanics and quantum computing, I can play the game and understand how concepts such as superposition and quantum computing or entanglement work. These concepts would also be more digestable as they are intrinsic in the gameplay of the game.

US02 : As a teacher that wants to teach the bare minimum of quantum mechanics, he can introduce the game as a teaser for students to have a first taste of quantum mechanics

US03 : As a gamer, I can enjoy a different take on a tower defence game. A new element that has yet to exist in any other commercial game in the market.

US04 : As a speed runner of games, I can track the time it takes to complete the entire game and compete with others if a leadership board is implemented.



# Project Log

| Start Date  | End Date    | Member    | Task                                      | Comments                                        | Hours |
| :--------:  | :--------:  | :------:  | :---------------------------------------- | :-----------------------------------------------| :---: |
| 2021-05-01  | 2021-05-10  | Tee Chin  | Learning godot and game design principles | Made a Pong clone                               | 12    |
| 2021-05-10  | 2021-05-14  | Tee Chin  | Make Basic TD Mechanics                   | Turrets Timers Homing Projectiles               | 4     |
| 2021-05-01  | 2021-05-10  | Bharath   | Learning godot and game design principles | Made a Pong clone                               | 12    |
| 2021-05-10  | 2021-05-14  | Bharath   | Make Basic TD Mechanics                   | TileMap Home and Enemy behaviour and state      | 4     |
| 2021-05-14  | 2021-05-15  | Bharath   | Make Basic TD Mechanics                   | Enemy Spawning and Spawn Points                 | 3     |
| 2021-05-14  | 2021-05-16  | Bharath   | Make Basic TD Mechanics                   | Physics Layer and enemy path testing            | 7     |
| 2021-05-14  | 2021-05-16  | TeeChin   | Make Basic TD Mechanics                   | Made Towers for the game                        | 7     |
| 2021-05-14  | 2021-05-16  | TeeChin   | Make Basic TD Mechanics                   | Redesigned and choose assets for the game       | 3     |
| 2021-05-14  | 2021-05-16  | TeeChin   | Make Basic TD Mechanics                   | Made the BuildUI(First attempt)                 | 7     |
| 2021-05-17  | 2021-05-17  | Bharath   | Team meeting                              | Discussing how to integrate or split            | 2     |
| 2021-05-18  | 2021-05-19  | Bharath   | Managing new assets and reorganising work | Bulk of time on learning dev practices          | 3     |
| 2021-05-19  | 2021-05-22  | Bharath   | Enemy collision (Attempt 1)               | Rolled back commits entirely, unusable here     | 4     |
| 2021-05-19  | 2021-05-22  | Bharath   | Enemy collision and pathfinding mechanics | Bulk on time on learning godot physics          | 6     |
| 2021-05-14  | 2021-05-16  | TeeChin   | Redesigned Build UI                       | Made the BuildUI using the inbuilt nodes give(Second attempt)| 7 |
| 2021-05-14  | 2021-05-16  | TeeChin   | Made an item and tower inventory class    | First implementation of tower inventory face abit of bugs | 7     |
| 2021-05-23  | 2021-05-29  | Bharath   | Tile Selector (UI for Maps)               | Detecting tile content & displaying overlay     | 4     |
| 2021-05-23  | 2021-05-29  | Bharath   | Working on PR and Merges and cleaning up  | And integrating tee chin UI work to main        | 1     |
| 2021-05-29  | 2021-05-30  | Bharath   | Create new tile map (lava world)          | Some code logic, mostly design work             | 4     |
| 2021-05-29  | 2021-05-30  | Bharath   | Make basic API on localhost               | Build basic Express app to return 0 or 1        | 3     |
| 2021-05-29  | 2021-05-30  | Bharath   | Deploy API on heroku                      | Use Heroku documentation                        | 2     |
| 2021-05-29  | 2021-05-30  | Bharath   | Connecting Enemy to the API               | On taking damage, choose red / blue             | 2     |
| 2021-05-29  | 2021-05-30  | Bharath   | Personal Milestone 1 Tasks                | Meeting, Documentation, Exporting               | 3     |
| 2021-05-14  | 2021-05-16  | TeeChin   | Debugged and redesign inventory class     | Attempting to integrate the buildUI with the tower inventory and implement drag and drop system | 7 |
| 2021-05-31  | 2021-05-31  | Bharath   | Milestone 1 Team Meeting and Submission   | Submission Documents                            | 2     |
| 2021-05-31  | 2021-05-31  | Tee Chin  | Milestone 1 Team Meeting and Submission   | Submission Documents                            | 2     |


| Member    | Hours |
| :------:  | :---: |
| Bharath   |  62   |
| Tee Chin  |  56   |

# Video Link

[https://bit.ly/3i31g5d](https://bit.ly/3i31g5d)

# Poster Link

[https://raw.githubusercontent.com/bharathcs/quantum-defence/main/docs/milestone-1/poster.png](https://raw.githubusercontent.com/bharathcs/quantum-defence/main/docs/milestone-1/poster.png)

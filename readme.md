Game Controls:  
	1. MOVE: WASD (keyboard) / Left Stick or D-Pad to move (Controller)  
	2. ATTACK: Spacebar or 1 (keyboard) / Right trigger (Controller) 
	3. Hold Player: Shift hold / Left Trigger or bumper (Controller)  
- The player can attack using his companion, who will fly in the direction of movement
- The player can be held still, moving only his companion
- Attacking with the companion will reset it's location back to the player  
  
Refactors:  
	1. Ghost probably should have been an area2D: physics interactions not ideal.  
	- Maybe we use old ghost code for Golem?  
	2. Owl likely should have been part of Player scene  
	- Could treat similar to gun with instanced bullet for attacking vs separate entity  

Bounty Board TODO:  
	0. Add player_hold to player
	1. Address after HURT, mob can move player if player has not moved out of hitbox range  
		- potentially turn off/on hitboxes?  
	2. Cleanup Sprite knockback testing  
		- Seems to be some interplay where ghost returns to origin for floating tween  

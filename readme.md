Refactors:
	1. Ghost probably should have been an area2D: physics interactions not ideal.
	- Maybe we use old ghost code for Golem?
	2. Owl likely should have been part of Player scene
	- Could treat similar to gun with instanced bullet for attacking vs separate entity

Bounty Board TODO:  
	1. Address after HURT, mob can move player if player has not moved out of hitbox range
		- potentially turn off/on hitboxes?
	2. Cleanup Sprite knockback testing
		- Seems to be some interplay where ghost returns to origin for floating tween

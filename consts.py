
import introcs
import sys

### WINDOW CONSTANTS (all coordinates are in pixels) ###

#: the width of the game display
GAME_WIDTH  = 800
#: the height of the game display
GAME_HEIGHT = 700

### SHIP CONSTANTS ###

# the width of the ship
SHIP_WIDTH    = 44
# the height of the ship
SHIP_HEIGHT   = 44
# the distance of the (bottom of the) ship from the bottom of the screen
SHIP_BOTTOM   = 32
# The number of pixels to move the ship per update
SHIP_MOVEMENT = 5
# The number of lives a ship has
SHIP_LIVES    = 3
#How many seconds a death animation takes
DEATH_SPEED= .3
# The y-coordinate of the defensive line the ship is protecting
DEFENSE_LINE = 100


### ALIEN CONSTANTS ###

# the width of an alien
ALIEN_WIDTH   = 33
# the height of an alien
ALIEN_HEIGHT  = 33
# the horizontal separation between aliens
ALIEN_H_SEP   = 16
# the vertical separation between aliens
ALIEN_V_SEP   = 16
# the number of horizontal pixels to move an alien
ALIEN_H_WALK  = ALIEN_WIDTH // 4
# the number of vertical pixels to move an alien
ALIEN_V_WALK  = ALIEN_HEIGHT // 2
# The distance of the top alien from the top of the window
ALIEN_CEILING = 100
# the number of rows of aliens, in range 1..10
ALIEN_ROWS = 5
# the number of aliens per row
ALIENS_IN_ROW  = 12
# the image files for the aliens (bottom to top)
ALIEN_IMAGES   = ('alien-strip1.png','alien-strip2.png','alien-strip3.png')
# the number of seconds (0 < float <= 1) between alien steps
ALIEN_SPEED = 0.5


### BOLT CONSTANTS ###

# the width of a laser bolt
BOLT_WIDTH2  = 16 #player
BOLT_WIDTH = 4
BOLT_FIRE_WIDTH = 40
# the height of a laser bolt
BOLT_FIRE_HEIGHT = 20
BOLT_HEIGHT = 16
# the number of pixels to move the bolt per update
BOLT_SPEED  = 10
# the number of ALIEN STEPS (not frames) between bolts
BOLT_RATE   = 5


### GAME CONSTANTS ###

# state before the game has started
STATE_INACTIVE = 0
# state when we are initializing a new wave
STATE_NEWWAVE  = 1
# state when the wave is activated and in play
STATE_ACTIVE   = 2
# state when we are paused between lives
STATE_PAUSED   = 3
# state when we restoring a destroyed ship
STATE_CONTINUE = 4
#: state when the game is complete (won or lost)
STATE_COMPLETE = 5

try:
    rows = int(sys.argv[1])
    if rows >= 1 and rows <= 10:
        ALIEN_ROWS = rows
except:
    pass # Use original value

try:
    perrow = int(sys.argv[2])
    if perrow >= 1 and perrow <= 15:
        ALIENS_IN_ROW = perrow
except:
    pass # Use original value

try:
    speed = float(sys.argv[3])
    if speed > 0 and speed <= 3:
        ALIEN_SPEED = speed
except:
    pass # Use original value

#: font size adjustment factor
FONT_SIZE_ADJUST= 1/11200
#: font size adjustment factor for font size 64 with these dimensions
FONT_SIZE_ADJUST_64 = 1/8750
#: font size adjustment factor for font size 50 with these dimensions
FONT_SIZE_ADJUST_50 = 1/11200
#: font size adjustment factor for font size 30 with these dimensions
FONT_SIZE_ADJUST_30 = 1/18667

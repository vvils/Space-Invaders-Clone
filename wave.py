
from game2d import *
from consts import *
from models import *
import random

class Wave(object):

    def getAliens(self):
        """
        return the wave of aliens
        """
        return self._aliens

    def getShipAlive(self):
        """
        return the status of the ship (alive or destroyed)
        """
        return self._ship_alive

    def setShipAlive(self, respawn):
        """
        set the status of the ship (alive or destroyed)
        """
        self._ship_alive=respawn

    def getLives(self):
        """
        return the number of lives left
        """
        return self._lives

    def setShip(self):
        """
        create the ship object
        """
        self._ship=Ship()

    def setAlien(self):
        """
        create the wave of aliens
        """
        y_pos=GAME_HEIGHT-ALIEN_CEILING-(ALIEN_ROWS)\
        *(ALIEN_HEIGHT+ALIEN_V_SEP)-ALIEN_HEIGHT/2
        self._aliens=[]
        select, image_count=0,0
        for num_row in range(ALIEN_ROWS):
            y_pos, x_pos, add_row =(y_pos+ALIEN_V_SEP+ALIEN_HEIGHT), 0, []
            for aliens in range(ALIENS_IN_ROW):
                x_pos=x_pos+ALIEN_H_SEP+ALIEN_WIDTH
                add_row.append(Alien(x_pos, y_pos, ALIEN_IMAGES[select]))
            self._aliens.append(add_row)
            image_count+=1
            if image_count==2 and select==(len(ALIEN_IMAGES)-1):
                select, image_count=0, 0
            elif image_count==2:
                select, image_count= select+1, 0

    def __init__(self):

        self.setAlien()
        self.setShip()
        self._dline= GPath(points=[0,DEFENSE_LINE,GAME_WIDTH,DEFENSE_LINE],\
         linewidth=1, linecolor='grey')
        self._time=0
        self._left=False
        self._bolts=[]
        self._alien_step=random.randint(1,BOLT_RATE)
        self._steps_til_bolt=0
        self._animator=None
        self.setShipAlive(True)
        self._lives=SHIP_LIVES
        self._deadalienA=()
        self._deadalienB=()
        self._deadalienC=()
        self._deadalienD=()
        self._deadalienE=()
        self._animateA=None
        self._animateB=None
        self._animateC=None
        self._animateD=None
        self._animateE=None
        self._alienSound=Sound('pop1.wav')
        self._shipSound=Sound('pew2.wav')
        self._shipExplode=Sound('blast1.wav')
        self._alreadyHit=[]
        self.transform_delay=0

    def update(self,hold_left,hold_right, dt, shoot, cheats,space):
        if not self._animator is None:
            self._runShipAnimator(dt)
        else:

            if self._animateA is not None: 
                self._runAnimatorA(dt)
            if self._animateB is not None:
                self._runAnimatorB(dt)
            if self._animateC is not None:
                self._runAnimatorC(dt)
            if self._animateD is not None:
                self._runAnimatorD(dt)
            if self._animateE is not None:
                self._runAnimatorE(dt)
                
            self.transform(space) #########
            self._cheats(cheats)
            self._move_ship(hold_left, hold_right) #manual ship control
            self._animate_aliens(dt) #alien movement
            self._ship_bolt(shoot)    #ship fire
            self._alien_bolt() #alien fire
            self._lastalien()
            #COLLISION
            for pew in self._bolts: #pew is a bolt
                self._alien_collision(pew) #alien collision
                self._ship_collision(pew) #ship collision
            
            self.transform_delay += dt

    # DRAW METHOD TO DRAW THE SHIP, ALIENS, DEFENSIVE LINE AND BOLTS
    def draw(self,view):
        """
        Draws the game objects to the view.

        Parameter view: the window to draw on
        Precondition: view is GView object
        """
        for row in self.getAliens():
            for alien in row:
                if alien is not None:
                    alien.draw(view)
        if self._ship is not None:
            self._ship.draw(view)
        self._dline.draw(view)
        for bolts in self._bolts:
            bolts.draw(view)

    # HELPER METHODS FOR COLLISION DETECTION
    def alienCrossed(self):
        """
        return True when alien cross the defense line else False
        """
        for row_pos in range(ALIEN_ROWS):
            for column_pos in range(ALIENS_IN_ROW):
                if self._aliens[row_pos][column_pos] is not None and\
                 (row_pos, column_pos) not in self._alreadyHit:
                 #check if alien is already hit in the case that we hit the
                 #alien when it super close to the line and not yet cross it
                 #we will consider that dying alien as dead
                 #and ignore it when it cross the line
                    alien=self._aliens[row_pos][column_pos]
                    if (alien.y-alien.height/2) < DEFENSE_LINE:
                        return True
        return False

    def gamewin(self):
        """
        return True if all aliens die; False otherwise
        """
        for row in self._aliens:
            for alien in row:
                if alien is not None:
                    return False
        return True

    def _runShipAnimator(self,dt):
        try:
            self._animator.send(dt)
        except StopIteration:
            self._animator=None
            self._ship=None
            self._bolts=[]
            self.setShipAlive(False)
            self._lives-=1

    def _runAnimatorA(self,dt):

        try:
            self._animateA.send(dt)
        except:
            self._animateA = None
            self._aliens[self._deadalienA[0]][self._deadalienA[1]] = None
            self._deadalienA = ()

    def _runAnimatorB(self,dt):
    
        try:
            self._animateB.send(dt)
        except:
            self._animateB = None
            self._aliens[self._deadalienB[0]][self._deadalienB[1]] = None
            self._deadalienB = ()

    def _runAnimatorC(self,dt):

        try:
            self._animateC.send(dt)
        except:
            self._animateC = None
            self._aliens[self._deadalienC[0]][self._deadalienC[1]] = None
            self._deadalienC = ()

    def _runAnimatorD(self,dt):

        try:
            self._animateD.send(dt)
        except:
            self._animateD = None
            self._aliens[self._deadalienD[0]][self._deadalienD[1]] = None
            self._deadalienD = ()

    def _runAnimatorE(self,dt):

        try:
            self._animateE.send(dt)
        except:
            self._animateE = None
            self._aliens[self._deadalienE[0]][self._deadalienE[1]] = None
            self._deadalienE = ()

    def _move_ship(self, hold_left, hold_right):

        if hold_left and self._ship.x >= min(SHIP_WIDTH/2,GAME_WIDTH):
            self._ship.x-=SHIP_MOVEMENT
        if hold_right and self._ship.x <= \
        max(SHIP_WIDTH/2,GAME_WIDTH-SHIP_WIDTH/2):
            self._ship.x+=SHIP_MOVEMENT

    def _alien_collision(self, pew):
        """
        Deletes the alien when the alien collides with bolt

        Paramter pew: a bolt
        Precondition: pew is a Bolt Object
        """
        if pew._velocity > 0:
            for row_pos in range(ALIEN_ROWS):
                for column_pos in range(ALIENS_IN_ROW):
                    if self._aliens[row_pos][column_pos] is not None and\
                     (row_pos, column_pos) not in self._alreadyHit:
                        if self._aliens[row_pos][column_pos].collides(pew):
                            self._alienSound.play()
                            try:
                                self._bolts.remove(pew)
                                self._alreadyHit.append( (row_pos,column_pos) )
                            except:
                                pass
                            self._popAlien(row_pos,column_pos)

    def _popAlien(self, row_pos, column_pos):
        """
        animate the alien popping using coroutine

        Paramter row_pos: the position of a row of alien
        Precondition: row_pos is an integer

        Paramter coloumn_pos: the position of a column of alien
        Precondition: column_pos is an integer
        """
        if self._animateA is None:
            self._deadalienA=(row_pos,column_pos)
            self._animateA=self._aliens[row_pos][column_pos].animatealiens()
            next(self._animateA)
        elif self._animateB is None:
            self._deadalienB=(row_pos,column_pos)
            self._animateB=self._aliens[row_pos][column_pos].animatealiens()
            next(self._animateB)
        elif self._animateC is None:
            self._deadalienC=(row_pos,column_pos)
            self._animateC=self._aliens[row_pos][column_pos].animatealiens()
            next(self._animateC)
        elif self._animateD is None:
            self._deadalienD=(row_pos,column_pos)
            self._animateD=self._aliens[row_pos][column_pos].animatealiens()
            next(self._animateD)
        elif self._animateE is None:
            self._deadalienE=(row_pos,column_pos)
            self._animateE=self._aliens[row_pos][column_pos].animatealiens()
            next(self._animateE)
        else: #special case: if we are animating too many aliens
            #then delete the anien w/o popping
            #This only happens if bolt is too fast or death speed is too long
            self._aliens[row_pos][column_pos]=None

    def _ship_collision(self, pew):
        """
        delete the ship when ship is hit

        Paramter pew: a bolt
        Precondition: pew is a Bolt Object
        """
        if pew._velocity < 0:
            if self._ship is not None:
                if self._ship.collides(pew):
                    self._shipExplode.play()
                    self._bolts.remove(pew)
                    self._animator=self._ship.animate_ship()
                    next(self._animator)

    def _ship_bolt(self, shoot):
        """
        create player bolt and animate the bolt

        Parameter shoot: up arrow is held
        Precondition: shoot is a bool
        """
        if shoot and not self._playerBoltExist():
            if type(self._ship) == Ship:
                self._bolts.append(Bolt2(BOLT_SPEED,self._ship.x,\
            SHIP_HEIGHT+SHIP_BOTTOM))
            elif type(self._ship) == Ship2:
                self._bolts.append(Bolt3(BOLT_SPEED,self._ship.x,\
            SHIP_HEIGHT+SHIP_BOTTOM))  
            else:
                self._bolts.append(Bolt4(BOLT_SPEED,self._ship.x,\
            SHIP_HEIGHT+SHIP_BOTTOM))

            self._shipSound.play()

        if self._playerBoltExist():

            bolt = self._playerBolt()
            if type(bolt) != Bolt4 and bolt.y<GAME_HEIGHT+BOLT_HEIGHT/2:
                bolt.y+=bolt.getVelocity()
            elif type(bolt) == Bolt4 and bolt.y<GAME_HEIGHT/3+BOLT_HEIGHT/4:
                bolt.y+=bolt.getVelocity()
            else:
                self._bolts.remove(bolt)

    def _alien_bolt(self):
        """
        create alien bolt and animate it
        """
        if self._steps_til_bolt == self._alien_step:
            shooter = self._alienshooter() #the alien the bolt is from
            self._bolts.append(Bolt(-BOLT_SPEED,shooter.x,shooter.y))
            self._steps_til_bolt = 0
            self._alien_step = random.randint(1,BOLT_RATE)

        if self._alienBoltExists():
            for bolts in self._bolts:
                if bolts.getVelocity() < 0:
                    if bolts.y>-BOLT_HEIGHT/2:
                        bolts.y += bolts.getVelocity() #animate the alien bolt
                    else:
                        self._bolts.remove(bolts)
                        #remove the bolt when it leaves screen

    def _edgeAliens(self,left=False,right=False):
        """
        return the computed distance of the right or left most alien

        helper method to determine the alien closest to the left and right edge

        Parameter left: left is true if aliens are moving left else False
        Precondition: left is a bool

        Parameter right: right is true if aliens are moving right
        Precondition: right is a bool
        """
        if left is True:
            left_most = GAME_WIDTH
            for row in self._aliens:
                for alien in row:
                    if alien is not None:
                        if alien.x - ALIEN_WIDTH // 2 < left_most:
                            left_most = alien.x - ALIEN_WIDTH // 2
            return left_most

        if right is True:
            right_most = 0
            for row in self._aliens:
                for alien in row:
                    if alien is not None:
                        if alien.x + ALIEN_WIDTH // 2 > right_most:
                            right_most = alien.x + ALIEN_WIDTH // 2
            return right_most

    def _moveAllH(self, left=False,right=False):
        """
        Move all aliens horizontally

        Parameter left: the direction aliens are walking
        Precondition: left is a bool

        Parameter right: the direction aliens are walking
        Precondition: right is a bool
        """
        if right is True:
            for row in self._aliens:
                for alien in row:
                    if alien is not None:
                        alien.x += ALIEN_H_WALK

        if left is True:
            for row in self._aliens:
                for alien in row:
                    if alien is not None:
                        alien.x -= ALIEN_H_WALK

    def _moveAllV(self):
        """
        Move all aliens vertically down
        """
        for row in self._aliens:
            for alien in row:
                if alien is not None:
                    alien.y -= ALIEN_V_WALK

    def _animate_aliens(self,dt):
        """
        animate the movement of the wave of aliens

        Parameter dt: The time since the last animation frame.
        Precondition: dt is a float.
        """
        self._time += dt
        if self._time >= ALIEN_SPEED:
            self._steps_til_bolt+=1 #accumluate steps
            if self._left == False and \
            (self._edgeAliens(right=True)+ALIEN_H_WALK)>=GAME_WIDTH:
                self._moveAllV()
                self._left = True
            elif self._left is False:
                self._moveAllH(right=True)
            elif self._left == True and \
            (self._edgeAliens(left=True)-ALIEN_H_WALK) <= 0:
                self._moveAllV()
                self._left = False
            else:
                self._moveAllH(left=True)
            self._time = 0

    def _playerBoltExist(self):
        """
        return True if there is a player bolt in _bolts
        """
        for bolts in self._bolts:
            if bolts.isPlayerBolt(bolts.getVelocity()):
                return True
        return False

    def _playerBolt(self):
        """
        returns the bolt from the ship in the _bolts
        """
        for bolts in self._bolts:
            if bolts.isPlayerBolt(bolts.getVelocity()):
                return bolts

    def _alienshooter(self):
        """
        return the alien that will shoot
        """
        tracker = []
        for column_pos in range(ALIENS_IN_ROW): #loop over column of alien
            for rows in self._aliens: #loop over each alien in the column
                if rows[column_pos] is not None and \
                (column_pos not in tracker):
                    tracker.append(column_pos)
                    #add the nonempty column to tracker

        random_column = random.choice(tracker)
        #choose a column from the random column
        row_number = ALIEN_ROWS-1
        #This is the index of top row of aliens (since I create from bottom-up)
        for row_pos in range(ALIEN_ROWS):
            #if there is aliens in lower rows assign the shooter that index
            if self._aliens[row_pos][random_column]\
             is not None and (row_pos < row_number):
                row_number = row_pos

        return self._aliens[row_number][random_column] #this alien will shoot!

    def _alienBoltExists(self):
        """
        return True if there is an alien bolt in _bolt
        """
        for bolts in self._bolts:
            if bolts.getVelocity() < 0:
                return True
        return False

    def _cheats(self,cheats):
        """
        Enables cheats if cheats are turned on (infinte lives and lazer bolts)

        Parameter cheats: if cheats are on or off
        Precondition: cheats is a bool
        """
        if cheats:
            self._lives = 99
            for bolts in self._bolts:
                if self._playerBoltExist():
                    self._playerBolt()._velocity = 25

        else:
            for bolts in self._bolts:
                if self._playerBoltExist():
                    self._playerBolt()._velocity = BOLT_SPEED

    def _lastalien(self):
        """
        Makes sure the last alien does not kill the ship after it's been shot
        """
        tracker = 0
        for rows in self._aliens:
            for alien in rows:
                if alien is not None:
                    tracker += 1
        if tracker == 1 and len(self._alreadyHit) == 1:
            for bolts in self._bolts:
                if bolts._velocity < 0:
                    self._bolts.remove(bolts)
            self._alien_step = 1000

    def transform(self,space):
        if space and self.transform_delay >= 0.5:
            if type(self._ship) == Ship:
                pos = self._ship.x
                lives = self._lives
                self._ship = Ship2()
                self._lives = lives
                self._ship.x = pos
                
            elif type(self._ship) == Ship2:
                pos = self._ship.x
                lives = self._lives
                self._ship = Ship3()
                self._lives = lives
                self._ship.x = pos

            else:
                pos = self._ship.x
                lives = self._lives
                self._ship = Ship()
                self._lives = lives
                self._ship.x = pos




            self.transform_delay = 0



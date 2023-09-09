
from consts import *
from game2d import *

class Ship(GSprite):

    def __init__(self):

        super().__init__(x=GAME_WIDTH/2, y=SHIP_BOTTOM+(SHIP_HEIGHT/2),\
        width=SHIP_WIDTH, height=SHIP_HEIGHT,\
        source='ship-strip.png', format=(2,4))

    def collides(self,bolt):
        right_edge=bolt.x+BOLT_WIDTH/2
        left_edge=bolt.x-BOLT_WIDTH/2
        top_edge=bolt.y+BOLT_HEIGHT/2
        bot_edge=bolt.y-BOLT_HEIGHT/2

        top_right=(right_edge,top_edge)
        top_left=(left_edge,top_edge)
        bot_right=(right_edge,bot_edge)
        bot_left=(left_edge, bot_edge)

        corners=[self.contains(top_right),self.contains(top_left),\
        self.contains(bot_right),self.contains(top_left)]
        for point in corners:
            if point is True:
                return True
        return False

    def animate_ship(self):
        time=0
        tracker=1
        while time<DEATH_SPEED:
            dt=(yield)
            time+=dt
            step=time/DEATH_SPEED
            amount=step*7
            if amount>tracker:
                tracker+=1
                self.frame+=1

class Ship2(GSprite):
    def __init__(self):
        super().__init__(x=GAME_WIDTH/2, y=SHIP_BOTTOM+(SHIP_HEIGHT/2),\
        width=SHIP_WIDTH, height=SHIP_HEIGHT,\
        source='ship-strip2.png', format=(2,4))


    def collides(self,bolt):
        right_edge=bolt.x+BOLT_WIDTH/2
        left_edge=bolt.x-BOLT_WIDTH/2
        top_edge=bolt.y+BOLT_HEIGHT/2
        bot_edge=bolt.y-BOLT_HEIGHT/2

        top_right=(right_edge,top_edge)
        top_left=(left_edge,top_edge)
        bot_right=(right_edge,bot_edge)
        bot_left=(left_edge, bot_edge)

        corners=[self.contains(top_right),self.contains(top_left),\
        self.contains(bot_right),self.contains(top_left)]
        for point in corners:
            if point is True:
                return True
        return False

    # COROUTINE METHOD TO ANIMATE THE SHIP
    def animate_ship(self):

        time=0
        tracker=1
        while time<DEATH_SPEED:
            dt=(yield)
            time+=dt
            step=time/DEATH_SPEED
            amount=step*7
            if amount>tracker:
                tracker+=1
                self.frame+=1

class Ship3(GSprite):

    def __init__(self):

        super().__init__(x=GAME_WIDTH/2, y=SHIP_BOTTOM+(SHIP_HEIGHT/2),\
        width=SHIP_WIDTH, height=SHIP_HEIGHT,\
        source='ship-strip3.png', format=(2,4))

    def collides(self,bolt):
        right_edge=bolt.x+BOLT_WIDTH/2
        left_edge=bolt.x-BOLT_WIDTH/2
        top_edge=bolt.y+BOLT_HEIGHT/2
        bot_edge=bolt.y-BOLT_HEIGHT/2

        top_right=(right_edge,top_edge)
        top_left=(left_edge,top_edge)
        bot_right=(right_edge,bot_edge)
        bot_left=(left_edge, bot_edge)

        corners=[self.contains(top_right),self.contains(top_left),\
        self.contains(bot_right),self.contains(top_left)]
        for point in corners:
            if point is True:
                return True
        return False

    def animate_ship(self):
        time=0
        tracker=1
        while time<DEATH_SPEED:
            dt=(yield)
            time+=dt
            step=time/DEATH_SPEED
            amount=step*7
            if amount>tracker:
                tracker+=1
                self.frame+=1

class Alien(GSprite):
    def __init__(self,a,b,src):
        super().__init__(x=a,y=b,source=src,width=ALIEN_WIDTH,\
         height=ALIEN_HEIGHT, format=(4,2))


    def collides(self,bolt):

        if type(bolt) == Bolt4:

            right_edge=bolt.x+BOLT_FIRE_WIDTH/2
            left_edge=bolt.x-BOLT_FIRE_WIDTH/2
            top_edge=bolt.y+BOLT_FIRE_HEIGHT/2
            bot_edge=bolt.y-BOLT_FIRE_HEIGHT/2

        else:
            right_edge=bolt.x+BOLT_WIDTH/2
            left_edge=bolt.x-BOLT_WIDTH/2
            top_edge=bolt.y+BOLT_HEIGHT/2
            bot_edge=bolt.y-BOLT_HEIGHT/2

        top_right=(right_edge,top_edge)
        top_left=(left_edge,top_edge)
        bot_right=(right_edge,bot_edge)
        bot_left=(left_edge, bot_edge)

        corners=[self.contains(top_right),self.contains(top_left),\
        self.contains(bot_right),self.contains(top_left)]
        for point in corners:
            if point is True:
                return True
        return False


    def animatealiens(self):
        time=0
        tracker=1
        while time<DEATH_SPEED:
            dt=(yield)
            time+=dt
            step=time/DEATH_SPEED
            amount=step*7
            if amount>tracker:
                tracker+=1
                self.frame+=1

class Bolt(GRectangle):
    def getVelocity(self):
        return self._velocity

    def __init__(self,veloc, _x, _y):
        super().__init__(x=_x, y=_y, width=BOLT_WIDTH, height=BOLT_HEIGHT,\
        linecolor='black', fillcolor='white')

        self._velocity=veloc
    def isPlayerBolt(self,veloc):
        return veloc>0

class Bolt2(GSprite):
    def getVelocity(self):
        return self._velocity

    def __init__(self,veloc,_x,_y):

        super().__init__(x=_x, y=_y,\
        width=BOLT_WIDTH2, height=BOLT_HEIGHT,\
        source='ship.png')

        self._velocity=veloc
    def isPlayerBolt(self,veloc):
        return veloc>0

class Bolt3(GSprite):
    def getVelocity(self):
        return self._velocity

    def __init__(self,veloc,_x,_y):

        super().__init__(x=_x, y=_y,\
        width=BOLT_WIDTH2, height=BOLT_HEIGHT,\
        source='ship2.png')

        self._velocity=veloc
    def isPlayerBolt(self,veloc):
        return veloc>0

class Bolt4(GSprite):
    def getVelocity(self):
        return self._velocity

    def __init__(self,veloc,_x,_y):

        super().__init__(x=_x, y=_y,\
        width=BOLT_FIRE_WIDTH, height=BOLT_FIRE_HEIGHT,\
        source='ship3.png')

        self._velocity=veloc
    def isPlayerBolt(self,veloc):
        return veloc>0

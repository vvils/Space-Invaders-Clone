
from consts import *
from game2d import *
from wave import *

class JTTW(GameApp):
    def start(self):
        # Opening Screen Prep
        self._state = STATE_INACTIVE
        self._wave = None
        self._cheats = False
        self._text= GLabel(text='Press \'S\' to Play', font_name=\
             'Arcade.ttf', font_size=GAME_HEIGHT*GAME_WIDTH*\
             FONT_SIZE_ADJUST_64,linecolor='white')
        self._text.x= GAME_WIDTH/2
        self._text.y= 3*GAME_HEIGHT/10
        # Menu Prep
        self._menuprep()
        # Lives Display Prep
        self._livestext=None
        self._livesnum=None
        # Score Display Prep
        self._scoretext = None
        self._scorenum = None
        self._scoretimeA = 0
        self._scoretimeB = 0
        self._scoretimeC = 0
        self._scoretimeD = 0
        self._scoretimeE = 0
        self._score = 0

    def update(self,dt):
        # Menu
        self._menu(dt)
        if self._menuscreen is not None:
            self._menutouch()
        self._inactive_game()
        if self._state is not STATE_INACTIVE \
        and self._state is not STATE_COMPLETE:
            if self._wave is not None:
                self._livesDisplay()
                self._scoreDisplay(dt)
        else:
            self._livestext=None
            self._livesnum=None
            self._scoretext = None
            self._scorenum = None
        self._start_wave()
        self._play_game(dt)
        self._pause_game()
        self._continue_game()
        self._end_game()

    def draw(self):
        # Background
        GRectangle(x=GAME_WIDTH/2, y=GAME_HEIGHT/2, width=GAME_WIDTH,\
        height=GAME_HEIGHT, fillcolor='black').draw(self.view)
        # Title Card
        if self._state == STATE_INACTIVE:
            GLabel(x=GAME_WIDTH//2, y=3.2*GAME_HEIGHT//5,\
            width=239*GAME_WIDTH//320, height=145*GAME_WIDTH//320,\
            text='Journey To The West', font_name='Arcade.ttf', \
            linecolor='orange', font_size=72).draw(self.view)
        # Lives Display
        if self._livestext is not None and self._livesnum is not None:
            if self._scoretext is not None and self._scorenum is not None:
                if self._wave is not None:
                    self._livestext.draw(self.view)
                    self._livesnum.draw(self.view)
                    self._scoretext.draw(self.view)
                    self._scorenum.draw(self.view)
        if self._state != STATE_INACTIVE and self._wave is not None:
            self._wave.draw(self.view)
        # Menu
        self._drawmenu()
        if not self._text is None:
            self._text.draw(self.view)

    # HELPER METHODS FOR THE STATES GO HERE
    def _inactive_game(self):
        if self.input.is_key_down('s') and self._state==STATE_INACTIVE \
        and self._menuscreen is None:
            self._state=STATE_NEWWAVE
            self._text=None

    def _start_wave(self):
        if self._state == STATE_NEWWAVE:
            self._wave = Wave()
            self._state=STATE_ACTIVE

    def _play_game(self,dt):
        if self._state == STATE_ACTIVE:
            if self._wave.getShipAlive() is False:
                self._state=STATE_PAUSED
            elif self._wave.alienCrossed() is True:
                self._state=STATE_COMPLETE
            elif self._wave.gamewin() is True:
                self._state=STATE_COMPLETE
            else:
                self._wave.update(self.input.is_key_down('a'), \
                self.input.is_key_down('d'),\
                dt,self.input.is_key_down('w'),self._cheats, self.input.is_key_down('spacebar'))

    def _pause_game(self):

        if self._wave is not None:
            if self._state == STATE_PAUSED and self._menuscreen is None:
                if self._wave.getLives()>0:
                    self._text= GLabel(text='Press \'S\' to continue',\
                    font_name='Arcade.ttf',font_size=64,x=GAME_WIDTH/2,\
                    y=GAME_HEIGHT/2, linecolor='white')
                    if self.input.is_key_down('s'):
                        self._state=STATE_CONTINUE
                        self._text=None
                else:
                    self._state=STATE_COMPLETE

    def _continue_game(self):
        if self._state==STATE_CONTINUE:
            self._wave.setShip()
            self._wave.setShipAlive(True)
            self._state=STATE_ACTIVE

    def _end_game(self):

        if self._state==STATE_COMPLETE and self._wave is not None:
            if self._wave.getLives()==0:
                self._text=GLabel(text='Game Over!',font_name='Arcade.ttf',\
                font_size=96, x=GAME_WIDTH/2,y=GAME_HEIGHT/2,linecolor='red')
                self._wave = None
            elif self._wave.alienCrossed():
                self._text=GLabel(text='Game Over!',font_name='Arcade.ttf',\
                font_size=96, x=GAME_WIDTH/2,y=GAME_HEIGHT/2,linecolor='red')
                self._wave = None
            else:
                self._text=GLabel(text="You've Reached The West!",font_name='Arcade.ttf',\
                font_size=56,x=GAME_WIDTH/2,y=GAME_HEIGHT/2,linecolor='green')
                self._wave = None

    def _livesDisplay(self):
        """
        Displays player lives
        """
        self._livestext= GLabel(text='Lives:', font_name= 'Arcade.ttf',\
         font_size=GAME_WIDTH*GAME_HEIGHT*FONT_SIZE_ADJUST,linecolor='yellow')
        self._livestext.x= GAME_WIDTH * 0.8375
        self._livestext.y= GAME_HEIGHT * 0.9357
        self._livesnum = GLabel(text=str(self._wave.getLives()), font_name=\
        'Arcade.ttf', font_size=GAME_WIDTH*GAME_HEIGHT*FONT_SIZE_ADJUST,\
         linecolor='white')
        self._livesnum.x= self._livestext.x * 1.1418
        self._livesnum.y= self._livestext.y

    def _scoreDisplay(self,dt):
        """
        Displays the score

        Parameter dt: The time in seconds since last update
        Precondition: dt is a number (int or float)
        """
        self._score += self._scoreCalculator(dt)
        self._scoretext = GLabel(text='Score: ', font_name= 'Arcade.ttf',\
         font_size=GAME_WIDTH*GAME_HEIGHT*FONT_SIZE_ADJUST,linecolor='yellow')
        self._scoretext.x = self._livestext.x * 0.159
        self._scoretext.y = self._livestext.y
        self._scorenum = GLabel(text=str(self._score), font_name= \
        'Arcade.ttf', font_size=GAME_WIDTH*GAME_HEIGHT*FONT_SIZE_ADJUST,\
         linecolor='white')
        self._scorenum.x = self._scoretext.x * 2.1#1.78
        self._scorenum.y = self._scoretext.y

    def _scoreCalculator(self,dt):
        """
        Returns the score earned after defeating an alien

        Parameter dt: The time in seconds since last update
        Precondition: dt is a number (int or float)
        """
        score = 0
        if self._state != STATE_PAUSED:
            self._scoretimeA += dt
            self._scoretimeB += dt
            self._scoretimeC += dt
            self._scoretimeD += dt
            self._scoretimeE += dt
        if self._scoretimeA >= DEATH_SPEED+dt:
            if self._wave._deadalienA != ():
                score += 10*(self._wave._deadalienA[0]+1)
                self._scoretimeA = 0
        if self._scoretimeB >= DEATH_SPEED+dt:
            if self._wave._deadalienB != ():
                score += 10*(self._wave._deadalienB[0]+1)
                self._scoretimeB = 0
        if self._scoretimeC >= DEATH_SPEED+dt:
            if self._wave._deadalienC != ():
                score += 10*(self._wave._deadalienC[0]+1)
                self._scoretimeC = 0
        if self._scoretimeD >= DEATH_SPEED+dt:
            if self._wave._deadalienD != ():
                score += 10*(self._wave._deadalienD[0]+1)
                self._scoretimeD = 0
        if self._scoretimeE >= DEATH_SPEED+dt:
            if self._wave._deadalienE != ():
                score += 10*(self._wave._deadalienE[0]+1)
                self._scoretimeE = 0
        return score

    def _restartgamemenu(self):
        """
        Restarts the game from the menu
        """
        self._wave = None
        self._menuscreen = None
        self._text = None
        self._score = 0
        self._state = STATE_NEWWAVE

    def _menuprep(self):
        """
        Prepares all the menu attributes in start(self)
        """
        self._menutext = GLabel(text='ESC', font_name= 'Arcade.ttf',\
         font_size=GAME_HEIGHT*GAME_WIDTH*\
         FONT_SIZE_ADJUST_30,linecolor='white')
        self._menutext.x= GAME_WIDTH//26
        self._menutext.y= GAME_HEIGHT//51
        self._menuscreen = None
        self._menudelay = 0
        self._storage = None
        self._menumenu = GLabel(text='Menu', font_name= 'Arcade.ttf',\
        font_size=GAME_HEIGHT*GAME_WIDTH*FONT_SIZE_ADJUST_64,\
         x=GAME_WIDTH//2, y=1.35*GAME_HEIGHT//2, linecolor='white')
        # Start Screen
        self._menu1 = GLabel(text='Start Screen', font_name= 'Arcade.ttf',\
        font_size=GAME_HEIGHT*GAME_WIDTH*FONT_SIZE_ADJUST_50, \
        x=GAME_WIDTH/2, y=1.1*GAME_HEIGHT/2, linecolor='white')
        # Restart
        self._menu2 = GLabel(text='Restart', font_name= 'Arcade.ttf',\
        font_size=GAME_HEIGHT*GAME_WIDTH*FONT_SIZE_ADJUST_50, \
        x=GAME_WIDTH/2, y=.89*GAME_HEIGHT/2, linecolor='white')
        # Cheats
        self._menu3 = GLabel(text='Cheats', font_name= 'Arcade.ttf',\
        font_size=GAME_HEIGHT*GAME_WIDTH*FONT_SIZE_ADJUST_50, \
        x=GAME_WIDTH/2, y=.68*GAME_HEIGHT/2, linecolor='white')

    def _menu(self,dt):
        self._menudelay += dt
        if self.input.is_key_down('escape') and self._menudelay >= .2:
            if self._menuscreen is not None:
                self._menuscreen = None
                if self._wave is None or \
                (self._state == STATE_PAUSED and self._wave._ship is None):
                    self._text = self._storage
                else:
                    self._state = STATE_ACTIVE
                self._menudelay = 0
            else:
                if self._text is not None:
                    self._storage = self._text
                    self._text = None
                self._menuscreen = GRectangle(x=GAME_WIDTH//2,\
                y=GAME_HEIGHT//2,width=GAME_WIDTH//2,height=GAME_HEIGHT//2,\
                fillcolor=[.15,.15,.15,1],linewidth=3,linecolor='white')
                if self._state != STATE_INACTIVE and\
                 self._state != STATE_COMPLETE:
                    self._state = STATE_PAUSED
                self._menudelay = 0

    def _menutouch(self):
        """
        Handles menu mouse input
        """
        if self.input.is_touch_down():
            if GRectangle(x=self._menu1.x,y=1.01*self._menu1.y,\
            width=1.1*self._menu1.width,height=self._menu1.height,\
            fillcolor='black',linewidth=1,linecolor='white').contains\
            (self.input.touch):
                self.start()
            if GRectangle(x=self._menu2.x,y=1.01*self._menu2.y,\
            width=1.2*self._menu2.width,height=self._menu2.height,\
            fillcolor='black',linewidth=1,linecolor='white').contains\
            (self.input.touch):
                if self._state != STATE_INACTIVE:
                    self._restartgamemenu()
            if self._state not in [STATE_INACTIVE, STATE_COMPLETE]:
                if GRectangle(x=self._menu3.x,y=1.01*self._menu3.y,\
                 width=1.2*self._menu3.width,height=self._menu3.height,\
                  fillcolor='black',linewidth=1,linecolor='white').contains\
                  (self.input.touch):
                    if self._cheats is True and self._menudelay >= .2:
                        self._cheats = False
                        self._menudelay = 0
                        self._wave._lives = SHIP_LIVES
                    elif self._cheats is False and self._menudelay >= .2:
                        self._cheats = True
                        self._menudelay = 0

    def _drawmenu(self):
        """
        Draws all the menu components
        """
        GRectangle(x=self._menutext.x,y=1.3*self._menutext.y,\
        width=1.2*self._menutext.width,height=self._menutext.height,\
        fillcolor='black',linewidth=1,linecolor='white').draw(self.view)
        self._menutext.draw(self.view)
        if self._menuscreen is not None:
            self._menuscreen.draw(self.view)
            self._menumenu.draw(self.view)
            GRectangle(x=self._menu1.x,y=1.01*self._menu1.y,width=1.1*\
            self._menu1.width, height=self._menu1.height,fillcolor='black',\
            linewidth=1,linecolor='white').draw(self.view)
            GRectangle(x=self._menu2.x,y=1.01*self._menu2.y,width=1.2*\
            self._menu2.width,height=self._menu2.height,fillcolor='black',\
            linewidth=1,linecolor='white').draw(self.view)
            self._changeCheatColor()
            self._menu1.draw(self.view)
            self._menu2.draw(self.view)
            self._menu3.draw(self.view)
            GPath(points=[self._menumenu.x-self._menumenu.width//2,\
            self._menumenu.y-self._menumenu.height//3,self._menumenu.x+\
            self._menumenu.width//2,self._menumenu.y-self._menumenu.height//3],\
             linewidth=1, linecolor="white").draw(self.view)

    def _changeCheatColor(self):
        """
        Changes the cheat button color when clicked
        (only when game is not at welcome/end screens)
        """
        if self._cheats is True:
            GRectangle(x=self._menu3.x,y=1.01*self._menu3.y,width=1.2*\
            self._menu3.width,height=self._menu3.height,fillcolor='green',\
            linewidth=1,linecolor='white').draw(self.view)
        else:
            GRectangle(x=self._menu3.x,y=1.01*self._menu3.y,width=1.2*\
            self._menu3.width,height=self._menu3.height,fillcolor='red',\
            linewidth=1,linecolor='white').draw(self.view)

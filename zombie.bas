REM Zombie Game
REM Danni Pond
REM Powered by VaME 1.0

_TITLE "Zombie Game"
REM Pre-Engine Functuions
10 CLEAR
LET gamename$ = "Zombie Game 1.0"
LET xbox = 200
LET ybox = 100
LET mcolor = 11: REM Menu Colour
ON ERROR GOTO norun
IF _FILEEXISTS("bloat.fuu") = 0 THEN
    OPEN "bloat.fuu" FOR OUTPUT AS #2
    WRITE #2, 0, 0
    CLOSE #2
END IF
OPEN "bloat.fuu" FOR INPUT AS #2
INPUT #2, gameon, profile$
IF gameon = 1 THEN
    OPEN profile$ FOR INPUT AS #1
    INPUT #1, name$, hscore, money, hwave
    CLOSE #1
END IF
dirtycheat666:
IF gameon = 0 THEN
    SCREEN 12
    GOSUB premessage
    GOSUB profile
END IF
LET gameon = 0
CLOSE #2
OPEN "bloat.fuu" FOR OUTPUT AS #2
WRITE #2, gameon, profile$
CLOSE #2
GOSUB mainmenu
REM TUTORIAL AND DICE GOSUBS
IF hscore = 0 THEN GOSUB tutorial
IF money <= 4 THEN GOSUB dice
GOTO game

norun:
REM error catcher upon norun = 1
GOTO dirtycheat666

setgen:
REM Sets Game Variables
RANDOMIZE TIMER
LET gameon = 1
LET youc = 10
LET yskipx = 0
LET yskipy = 0
LET radius = 15
LET pace = 5
REM Randomizes Map Number
randmaploop:
LET randmap = INT(RND * 3) + 1
IF randmap = 1 THEN
    LET mapno = 1
    LET youx = 90
    LET youy = 245
END IF
IF randmap = 2 THEN
    LET mapno = 20
    LET youx = 90
    LET youy = 245
END IF
IF randmap = 3 THEN
    LET mapno = 26
    LET youx = 140
    LET youy = 245
END IF
IF mapno = 0 THEN GOTO randmaploop
LET cyoux = youx
LET cyouy = youy
REM End Map Number Sequence
LET frames = 0
LET message = 0
LET health = 100
LET useitem = 0
LET useexit = 0
LET gametime = 0
LET itime = TIMER
LET ctime = 0
LET tenmed = 0
LET fiftymed = 0
LET fullmed = 0
LET infectheal = 0
LET infectprotect = 0
LET flareg = 0
LET knife = 0
LET shotgun = 0
LET armour = 0
LET adrenaline = 0
LET pills = 0
LET flare = 0
LET bezerk = 0
LET bfg = 0
LET keys = 0
LET ckeys = 0
LET skeys = 0
LET sbezerk = 0
LET gamepoints = 0
LET oldgamepoints = 0
LET zombies = 0
LET zpace = 1
LET zombite = 0.5
LET hidetime1 = 0
LET hidetime2 = 0
LET zcolour = 2
LET dropoffs = 20
LET ckeysused = 0
LET zradius = 20
LET roundtimer = 30
LET movemd1 = 100
LET movemd2 = 100
LET movemd3 = 100
LET movemd4 = 100
LET zombmovetime = 9
LET zomberase = 5
LET warpco = 1
LET wave = 0
LET oldwave = 0
LET masterskip = 10
LET moneysplit = 2
LET endwave = 80
LET killpoints = 10
LET warppoints = 50
IF profile$ = "DOOMGUY" THEN GOSUB doomsetgen
RETURN

doomsetgen:
REM Cheat profile for dev use
LET money = 500
LET health = 100
LET tenmed = 50
LET fiftymed = 50
LET fullmed = 50
LET infectheal = 50
LET infectprotect = 50
LET flareg = 50
LET knife = 50
LET shotgun = 50
LET armour = 50
LET adrenaline = 50
LET pills = 50
LET flare = 50
LET bezerk = 50
LET bfg = 50
LET keys = 50
LET ckeys = 50
LET skeys = 50
LET sbezerk = 50
LET roundtimer = 10
LET mcolor = 4
LET mapno = 26
LET youx = 140
LET youy = 245
RETURN

profile:
REM Profile System
LINE (320 - xbox, 240 - ybox)-(320 + xbox, 240 + ybox), mcolor, BF
LINE ((320 - xbox) + 30, (240 - ybox) + 30)-((320 + xbox) - 30, (240 + ybox) - 30), 0, BF
LOCATE 12, 40 - 7: COLOR 12: PRINT gamename$
LOCATE 14, 40 - 8: COLOR 15: PRINT "INSERT YOUR NAME"
LOCATE 16, 25: INPUT name$
IF name$ = "" THEN GOTO profile
LET profile$ = UCASE$(name$)
IF profile$ = "EXIT" THEN GOTO endscreen
IF profile$ = "QUIT" THEN GOTO endscreen
IF profile$ = "CLOSE" THEN GOTO endscreen
ON ERROR GOTO newprofile: REM divert for if file doesn't exist
errorrecovery: REM file error recovery
OPEN profile$ FOR INPUT AS #1
INPUT #1, name$, hscore, money, hwave
CLOSE #1
RETURN

newprofile:
REM Subroutine for new profile
CLOSE #1
OPEN profile$ FOR OUTPUT AS #1
LET hscore = 0
LET money = 0
LET hwave = 0
WRITE #1, profile$, hscore, money, hwave
CLOSE #1
GOTO errorrecovery

premessage:
REM Pre-Main Menu Messages
CLS
LOCATE 12, 40 - (14 / 2): COLOR 12: PRINT "Danni Presents"
_DELAY 3
CLS
RETURN

options:
REM Options Menu
LET dmenua = 15
opmenuloop1:
GOSUB fullscreen
LINE (320 - xbox, 240 - ybox)-(320 + xbox, 240 + ybox), mcolor, BF
LINE ((320 - xbox) + 30, (240 - ybox) + 30)-((320 + xbox) - 30, (240 + ybox) - 30), 0, BF
LOCATE 12, 40 - 4: COLOR 12: PRINT "OPTIONS"
IF fullscreen = 0 THEN COLOR 15
IF fullscreen = 1 THEN COLOR 10
LOCATE 15, 40 - (10 / 2): PRINT "Fullscreen"
IF fullscreen = 0 THEN COLOR 10
IF fullscreen = 1 THEN COLOR 15
LOCATE 16, 40 - (8 / 2): PRINT "Windowed"
COLOR 15
LOCATE 17, 40 - (8 / 2): PRINT "Profile"
DO
    LOCATE dmenua, 46: COLOR 10: PRINT "<--"
    LOCATE dmenua, 30: COLOR 10: PRINT "-->"
    LET m$ = UCASE$(INKEY$)
    IF m$ = CHR$(0) + CHR$(72) THEN LOCATE dmenua, 46: PRINT "   ": LOCATE dmenua, 30: PRINT "   ": LET dmenua = dmenua - 1
    IF m$ = CHR$(0) + CHR$(80) THEN LOCATE dmenua, 46: PRINT "   ": LOCATE dmenua, 30: PRINT "   ": LET dmenua = dmenua + 1
    IF m$ = CHR$(27) THEN
        GOSUB fullscreen
        CLS
        RETURN
    END IF
    IF dmenua < 15 THEN LET dmenua = 15
    IF dmenua > 17 THEN LET dmenua = 17
LOOP UNTIL m$ = " "
IF dmenua = 15 THEN LET fullscreen = 1
IF dmenua = 16 THEN LET fullscreen = 0
IF dmenua = 17 THEN
    OPEN profile$ FOR OUTPUT AS #1
    WRITE #1, profile$, hscore, money, hwave
    CLOSE #1
    CLS
    CLEAR: GOTO 10
END IF
GOTO opmenuloop1

mainmenu:
REM Main Menu
LET dmenua = 15
mainmenuloop1:
LINE (320 - xbox, 240 - ybox)-(320 + xbox, 240 + ybox), mcolor, BF
LINE ((320 - xbox) + 30, (240 - ybox) + 30)-((320 + xbox) - 30, (240 + ybox) - 30), 0, BF
COLOR 15
LOCATE 1, 1: PRINT "PROFILE: "; name$
LOCATE 2, 1: PRINT "HIGH SCORE: "; hscore
LOCATE 4, 1: PRINT "MONEY: "; money
LOCATE 3, 1: PRINT "HIGH WAVE: "; hwave
LOCATE 12, 40 - 7: COLOR 12: PRINT gamename$
LOCATE 15, 40 - (4 / 2): COLOR 15: PRINT "Play"
LOCATE 16, 40 - (7 / 2): PRINT "Options"
LOCATE 17, 40 - (4 / 2): PRINT "Exit"
DO
    LOCATE dmenua, 46: COLOR 10: PRINT "<--"
    LOCATE dmenua, 30: COLOR 10: PRINT "-->"
    LET m$ = UCASE$(INKEY$)
    IF m$ = CHR$(0) + CHR$(72) THEN LOCATE dmenua, 46: PRINT "   ": LOCATE dmenua, 30: PRINT "   ": LET dmenua = dmenua - 1
    IF m$ = CHR$(0) + CHR$(80) THEN LOCATE dmenua, 46: PRINT "   ": LOCATE dmenua, 30: PRINT "   ": LET dmenua = dmenua + 1
    IF dmenua < 15 THEN LET dmenua = 15
    IF dmenua > 17 THEN LET dmenua = 17
LOOP UNTIL m$ = " "
IF dmenua = 15 THEN
    CLS
    RETURN
END IF
IF dmenua = 16 THEN GOSUB options: GOTO mainmenuloop1
IF dmenua = 17 THEN
    OPEN profile$ FOR OUTPUT AS #1
    WRITE #1, profile$, hscore, money, hwave
    CLOSE #1
    GOTO endscreen
END IF
GOTO mainmenuloop1

endscreen:
CLS
LET message = 3
LET message$ = ":("
LET messagec = 2
GOSUB message
COLOR 15
END

game:
REM Game Engine
REM First Time Load Mechanics
GOSUB setgen: REM Sets Engine Variables For First Time Use
REM Engine Begins
CLS
DO
    REM GUI Subs
    GOSUB map: REM Draws Map
    GOSUB drawyou: REM Draws Player
    GOSUB zombies: REM Zombie AI
    GOSUB hud: REM Draws HUD
    REM Key Control and Frame Limitation
    LET a$ = UCASE$(INKEY$)
    _LIMIT 60
    REM Movement and Mechanics Subs
    GOSUB inputter: REM Deals With a$
    GOSUB timerfunction: REM timer functions
    GOSUB notif: REM Notification System
    REM Health Management
    IF health > 100 THEN LET health = 100
    IF health <= 0 THEN GOTO death
    LET frames = frames + 1: REM Frame Counter
LOOP

death:
REM Death when player health is 0
IF profile$ = "DOOMGUY" THEN DO: LOOP WHILE INKEY$ = ""
BEEP
FOR yd = 0 TO 480
    LINE (0, yd)-(640, yd), 12
    _DELAY .005
NEXT yd
LINE (320 - xbox, 240 - ybox)-(320 + xbox, 240 + ybox), mcolor, BF
LINE ((320 - xbox) + 30, (240 - ybox) + 30)-((320 + xbox) - 30, (240 + ybox) - 30), 0, BF
LET wavec = 15: LET gamepointsc = 15
IF gamepoints > hscore THEN LET hscore = gamepoints: LET gamepointsc = 10
IF wave > hwave THEN LET hwave = wave: LET wavec = 10
LET fig1 = gamepoints
LET fig2 = ctime + (tloop * 254)
LET fig3 = INT(gamepoints / moneysplit)
LET fig4 = wave
DO
    LOCATE 12, 40 - 5: COLOR 12: PRINT "GAME OVER!"
    LOCATE 15, 40 - (12 / 2): COLOR gamepointsc: PRINT "Your Score: "; (gamepoints) - fig1
    LOCATE 16, 40 - (18 / 2): COLOR 15: PRINT "Time Survived: "; (ctime + (tloop * 254)) - fig2
    LOCATE 18, 40 - (16 / 2): COLOR 15: PRINT "Money Earned: "; (INT(gamepoints / moneysplit)) - fig3
    LOCATE 17, 40 - (16 / 2): COLOR wavec: PRINT "Wave Reached: "; (wave) - fig4
    IF fig1 > 0 THEN LET fig1 = fig1 - 1
    IF fig2 > 0 THEN LET fig2 = fig2 - 1
    IF fig3 > 0 THEN LET fig3 = fig3 - 1
    IF fig4 > 0 THEN LET fig4 = fig4 - 1
    IF fig1 + fig2 + fig3 + fig4 = 0 THEN LET fig5 = 1
    IF INKEY$ = " " THEN LET fig1 = 0: LET fig2 = 0: LET fig3 = 0: LET fig4 = 0
    _LIMIT 20
LOOP UNTIL fig5 = 1
LET fig5 = 0
LET money = money + (gamepoints / moneysplit)
LET money = INT(money)
DO: LOOP UNTIL INKEY$ = " "
OPEN profile$ FOR OUTPUT AS #1
WRITE #1, profile$, hscore, money, hwave
CLOSE #1
OPEN "bloat.fuu" FOR OUTPUT AS #2
WRITE #2, gameon, profile$
CLOSE #2
CLS
GOTO 10

timerfunction:
REM Timer Functions
IF ctime = 254 THEN LET tloop = tloop + 1: LET itime = TIMER: LET ctime = 0
LET ctime = INT(TIMER - itime): REM Sets Game Time
REM Invasion Warning
IF ctime + (tloop * 254) = 1 THEN
    LET notif$ = "30 Seconds Until Invasion"
    LET notifon = 1
    LET notift = ctime
    LET notifc = 25
END IF
REM Inventory Timer
IF inventorytimer > 0 THEN
    IF ctime > inventorytimer THEN LET inventorytimer2 = inventorytimer2 + 1
    LET inventorytimer = ctime
END IF
REM Invasion Begins
IF ctime + (tloop * 254) = roundtimer THEN
    LET notif$ = "Invasion Begins"
    LET notifon = 1
    LET notift = ctime
    LET notifc = 16
    LET zombies = 1
    LET wave = 1
    LET invasiontime = ctime
    roundloop1:
    LET roundtimer = INT(RND * 59) + 1
    IF roundtimer < 15 THEN GOTO roundloop1
    IF profile$ = "DOOMGUY" THEN LET roundtimer = 10
END IF
REM Zombie Adder
IF zombies >= 1 THEN
    IF zaloop <> tloop THEN LET zaloop = tloop: LET invasiontime = 1
    IF ctime >= invasiontime + roundtimer THEN
        LET wave = wave + 1: gamepoints = gamepoints + 1
        LET notifon = 3
        LET notift = ctime
        LET notifc = 6
        LET zombies = zombies * 2
        IF zombies > 64 THEN LET zombies = 64
        LET invasiontime = ctime
        LET zombiemapper = 0
        roundloop2:
        LET roundtimer = INT(RND * 59) + 1
        IF roundtimer < 15 THEN GOTO roundloop2
        IF profile$ = "DOOMGUY" THEN LET roundtimer = 10
    END IF
END IF
REM Zombie Draw Glitch Hider
IF useitem = 1 THEN
    IF skipdraw1 = 1 THEN
        IF drawtime1 = 0 THEN LET drawtime1 = ctime
        IF ctime >= drawtime1 + masterskip THEN LET drawtime1 = 0: LET skipdraw1 = 0
    END IF
    IF skipdraw2 = 1 THEN
        IF drawtime2 = 0 THEN LET drawtime2 = ctime
        IF ctime >= drawtime2 + masterskip THEN LET drawtime2 = 0: LET skipdraw2 = 0
    END IF
    IF skipdraw3 = 1 THEN
        IF drawtime3 = 0 THEN LET drawtime3 = ctime
        IF ctime >= drawtime3 + masterskip THEN LET drawtime3 = 0: LET skipdraw3 = 0
    END IF
    IF skipdraw4 = 1 THEN
        IF drawtime4 = 0 THEN LET drawtime4 = ctime
        IF ctime >= drawtime4 + masterskip THEN LET drawtime4 = 0: LET skipdraw4 = 0
    END IF
END IF
IF useitem = 0 THEN
    LET skipdraw1 = 0: LET skipdraw2 = 0: LET skipdraw3 = 0: LET skipdraw4 = 0
    LET drawtime1 = 0: LET drawtime2 = 0: LET drawtime3 = 0: LET drawtime4 = 0
END IF
REM Game Ender - Ends game when Wave limit nears
IF wave > endwave THEN LET infection = 1: LET zbuffer = 4
REM Infection Health Remover
IF infection = 1 THEN
    IF infectt = 0 THEN LET infectt = ctime + (tloop * 254)
    IF ctime + (tloop * 254) >= infectt + 20 THEN LET health = health - 5: LET infectt = 0
END IF
REM Infection Protection
IF infectionprotection = 1 THEN
    IF inpr = 0 THEN LET inpr = ctime + (tloop * 254)
    IF ctime + (tloop * 254) >= inpr + 60 THEN
        LET inpr = 0
        LET infectionprotection = 0
        LET notif$ = "Infection Protection Wears Out"
        LET notifon = 1
        LET notift = ctime
        LET notifc = 30
    END IF
END IF
REM Armour
IF usearmour = 1 THEN
    IF uar = 0 THEN LET uar = ctime + (tloop * 254)
    IF ctime + (tloop * 254) >= uar + 10 THEN
        LET uar = 0
        LET usearmour = 0
        LET notif$ = "Armour Wears Out"
        LET notifon = 1
        LET notift = ctime
        LET notifc = 16
    END IF
END IF
REM Adrenaline
IF useadrenaline = 1 THEN
    IF uad = 0 THEN LET uad = ctime + (tloop * 254)
    IF ctime + (tloop * 254) >= uad + 20 THEN
        LET uad = 0
        LET useadrenaline = 0
        LET notif$ = "Adrenaline Wears Out"
        LET notifon = 1
        LET notift = ctime
        LET notifc = 20
        LET pace = oldpace
    END IF
END IF
REM Pills
IF usepills = 1 THEN
    IF upill = 0 THEN LET upill = ctime + (tloop * 254)
    IF ctime + (tloop * 254) >= upill + 20 THEN
        LET upill = 0
        LET usepills = 0
        LET notif$ = "Pills Wear Out"
        LET notifon = 1
        LET notift = ctime
        LET notifc = 14
        LET zpace = zoldpace
    END IF
END IF
REM Flare
IF useflare = 1 THEN
    IF ufl = 0 THEN LET ufl = ctime + (tloop * 254)
    IF ctime + (tloop * 254) >= ufl + 30 THEN
        LET ufl = 0
        LET useflare = 0
        LET notif$ = "Flare Wears Out"
        LET notifon = 1
        LET notift = ctime
        LET notifc = 16
        CIRCLE (yskipx, yskipy), (radius * 2), bgcolor
    END IF
END IF
REM Bezerk
IF usebezerk = 1 THEN
    IF ubezt = 0 THEN LET ubezt = ctime + (tloop * 254)
    IF ctime + (tloop * 254) >= ubezt + 20 THEN
        LET ubezt = 0
        LET usebezerk = 0
        LET notif$ = "Bezerk Wears Out"
        LET notifon = 1
        LET notift = ctime
        LET notifc = 16
    END IF
END IF
REM Super Bezerk
IF usesbezerk = 1 THEN
    IF ubt = 0 THEN LET ubt = ctime + (tloop * 254)
    IF ctime + (tloop * 254) >= ubt + 20 THEN
        LET ubt = 0
        LET usesbezerk = 0
        LET notif$ = "Super Bezerk Wears Out"
        LET notifon = 1
        LET notift = ctime
        LET notifc = 22
    END IF
END IF
REM Random Zombie Movement during Use Item
IF useitem = 1 THEN
    IF zombtime1 = 0 THEN LET zombtime1 = ctime
    IF zombtime2 = 0 THEN LET zombtime2 = ctime
    IF zombtime3 = 0 THEN LET zombtime3 = ctime
    IF zombtime4 = 0 THEN LET zombtime4 = ctime
    IF ctime > (zombtime1 + movetz1) THEN LET zombtime1 = 0: LET movemd1 = 100: LET movetz1 = 0
    IF ctime > (zombtime2 + movetz2) THEN LET zombtime2 = 0: LET movemd2 = 100: LET movetz2 = 0
    IF ctime > (zombtime3 + movetz3) THEN LET zombtime3 = 0: LET movemd3 = 100: LET movetz3 = 0
    IF ctime > (zombtime4 + movetz4) THEN LET zombtime4 = 0: LET movemd4 = 100: LET movetz4 = 0
END IF
RETURN

notif:
REM Notification System
IF notifon = 0 THEN
    LET h = 1
    DO
        LOCATE 28, h: PRINT " "
        LET h = h + 1
    LOOP UNTIL h = 80
END IF
IF notifb <> notifc THEN
    LET h = 1
    DO
        LOCATE 28, h: PRINT " "
        LET h = h + 1
    LOOP UNTIL h = 80
END IF
IF notifon = 1 THEN
    LOCATE 28, 40 - (notifc / 2): PRINT notif$
    IF notift < ctime - 3 THEN LET notifon = 0
    LET notifb = notifc
END IF
IF notifon = 2 THEN
    LOCATE 28, 40 - (notifc / 2): PRINT notif$
    IF notift < ctime - 10 THEN LET notifon = 0
END IF
IF notifon = 3 THEN
    LOCATE 28, 40 - (notifc / 2): PRINT "Wave "; wave
    IF notift < ctime - 3 THEN LET notifon = 0
END IF
RETURN

message:
REM Popup Game Alert System
LINE (320 - xbox, 240 - ybox)-(320 + xbox, 240 + ybox), mcolor, BF
LINE ((320 - xbox) + 30, (240 - ybox) + 30)-((320 + xbox) - 30, (240 + ybox) - 30), 0, BF
IF message = 3 THEN
    LOCATE 12, 40 - 4: COLOR 12: PRINT "GAME OVER"
    LOCATE 15, 40 - (messagec / 2): COLOR 15: PRINT message$
    RETURN
END IF
IF message = 2 THEN
    IF tutorial = 0 THEN LOCATE 12, 40 - 4: COLOR 12: PRINT "MESSAGE!"
    IF tutorial = 1 THEN LOCATE 12, 40 - 4: COLOR 12: PRINT "TUTORIAL!"
    LOCATE 15, 40 - (messagec / 2): COLOR 15: PRINT message$
    DO: LOOP UNTIL INKEY$ = " "
    RETURN
END IF
IF message = 1 THEN
    IF tutorial = 0 THEN LOCATE 12, 40 - 4: COLOR 12: PRINT "MESSAGE!"
    IF tutorial = 1 THEN LOCATE 12, 40 - 4: COLOR 12: PRINT "TUTORIAL!"
    LOCATE 15, 40 - (messagec / 2): COLOR 15: PRINT message$
    DO: LOOP UNTIL INKEY$ = " "
    CLS
    REM Redraws Player
    LET yksipx = 0: LET yskipy = 0: GOSUB drawyou
    LET message = 0
    LET message$ = ""
    LET messagec = 0
    RETURN
END IF

hud:
REM GUI HUD
REM HUD
FOR hl = 1 TO 80
    LOCATE 1, hl: PRINT " "
    LOCATE 2, hl: PRINT " "
NEXT hl
LINE (0, 35)-(640, 35), 10
LINE (0, 36)-(640, 36), 15
LINE (0, 37)-(640, 37), 12
LOCATE 1, 1: PRINT "LOCATION: "; map$
IF developer = 1 THEN
    LOCATE 2, 1: PRINT "X: "; youx; " Y: "; youy
    LOCATE 28, 1: PRINT "Frames: "; frames
END IF
IF huditemlabel$ = "Exit" THEN LET hudcolor = 10
IF huditemlabel$ = "WARP" THEN LET hudcolor = warpco
IF hudlabelc > 0 THEN LOCATE 1, ((80 - 8) - hudlabelc): COLOR hudcolor: PRINT "OBJECT: "; huditemlabel$
IF hudlabelc = 0 THEN LOCATE 1, (80 - 9): COLOR 12: PRINT "NO OBJECT"
LOCATE 2, 1: COLOR 15: PRINT "WAVE: "; wave
IF oldgamepoints = gamepoints THEN LOCATE 2, 11: COLOR 15: PRINT "SCORE: "; gamepoints
IF oldgamepoints <> gamepoints THEN
    LET oldgamepoints = oldgamepoints + 1
    LOCATE 2, 11: COLOR 15: PRINT "SCORE: "; oldgamepoints
END IF
LOCATE 2, ((80 - 7) - (health / 10)): COLOR youc: PRINT "Health:"
IF health <= 10 THEN LOCATE 2, (80 - (health / 10)): PRINT "#": GOTO jump
IF health <= 20 THEN LOCATE 2, (80 - (health / 10)): PRINT "##": GOTO jump
IF health <= 30 THEN LOCATE 2, (80 - (health / 10)): PRINT "###": GOTO jump
IF health <= 40 THEN LOCATE 2, (80 - (health / 10)): PRINT "####": GOTO jump
IF health <= 50 THEN LOCATE 2, (80 - (health / 10)): PRINT "#####": GOTO jump
IF health <= 60 THEN LOCATE 2, (80 - (health / 10)): PRINT "######": GOTO jump
IF health <= 70 THEN LOCATE 2, (80 - (health / 10)): PRINT "#######": GOTO jump
IF health <= 80 THEN LOCATE 2, (80 - (health / 10)): PRINT "########": GOTO jump
IF health <= 90 THEN LOCATE 2, (80 - (health / 10)): PRINT "#########": GOTO jump
IF health <= 100 THEN LOCATE 2, (80 - (health / 10)): PRINT "##########": GOTO jump
jump:
COLOR 15
RETURN

zombies:
REM Zombie spawn code
IF zombies = 0 THEN RETURN
REM zombie map generator
IF zombies > 0 THEN
    FOR xspawn = 1 TO zombies
        IF mapzomb1 = 0 THEN IF xspawn = 1 THEN LET mapzomb1 = INT(RND * 26) + 1
        IF mapzomb2 = 0 THEN IF xspawn = 2 THEN LET mapzomb2 = INT(RND * 26) + 1
        IF mapzomb3 = 0 THEN IF xspawn = 3 THEN LET mapzomb3 = INT(RND * 26) + 1
        IF mapzomb4 = 0 THEN IF xspawn = 4 THEN LET mapzomb4 = INT(RND * 26) + 1
        IF mapzomb5 = 0 THEN IF xspawn = 5 THEN LET mapzomb5 = INT(RND * 26) + 1
        IF mapzomb6 = 0 THEN IF xspawn = 6 THEN LET mapzomb6 = INT(RND * 26) + 1
        IF mapzomb7 = 0 THEN IF xspawn = 7 THEN LET mapzomb7 = INT(RND * 26) + 1
        IF mapzomb8 = 0 THEN IF xspawn = 8 THEN LET mapzomb8 = INT(RND * 26) + 1
        IF mapzomb9 = 0 THEN IF xspawn = 9 THEN LET mapzomb9 = INT(RND * 26) + 1
        IF mapzomb10 = 0 THEN IF xspawn = 10 THEN LET mapzomb10 = INT(RND * 26) + 1
        IF mapzomb11 = 0 THEN IF xspawn = 11 THEN LET mapzomb11 = INT(RND * 26) + 1
        IF mapzomb12 = 0 THEN IF xspawn = 12 THEN LET mapzomb12 = INT(RND * 26) + 1
        IF mapzomb13 = 0 THEN IF xspawn = 13 THEN LET mapzomb13 = INT(RND * 26) + 1
        IF mapzomb14 = 0 THEN IF xspawn = 14 THEN LET mapzomb14 = INT(RND * 26) + 1
        IF mapzomb15 = 0 THEN IF xspawn = 15 THEN LET mapzomb15 = INT(RND * 26) + 1
        IF mapzomb16 = 0 THEN IF xspawn = 16 THEN LET mapzomb16 = INT(RND * 26) + 1
        IF mapzomb17 = 0 THEN IF xspawn = 17 THEN LET mapzomb17 = INT(RND * 26) + 1
        IF mapzomb18 = 0 THEN IF xspawn = 18 THEN LET mapzomb18 = INT(RND * 26) + 1
        IF mapzomb19 = 0 THEN IF xspawn = 19 THEN LET mapzomb19 = INT(RND * 26) + 1
        IF mapzomb20 = 0 THEN IF xspawn = 20 THEN LET mapzomb20 = INT(RND * 26) + 1
        IF mapzomb21 = 0 THEN IF xspawn = 21 THEN LET mapzomb21 = INT(RND * 26) + 1
        IF mapzomb22 = 0 THEN IF xspawn = 22 THEN LET mapzomb22 = INT(RND * 26) + 1
        IF mapzomb23 = 0 THEN IF xspawn = 23 THEN LET mapzomb23 = INT(RND * 26) + 1
        IF mapzomb24 = 0 THEN IF xspawn = 24 THEN LET mapzomb24 = INT(RND * 26) + 1
        IF mapzomb25 = 0 THEN IF xspawn = 25 THEN LET mapzomb25 = INT(RND * 26) + 1
        IF mapzomb26 = 0 THEN IF xspawn = 26 THEN LET mapzomb26 = INT(RND * 26) + 1
        IF mapzomb27 = 0 THEN IF xspawn = 27 THEN LET mapzomb27 = INT(RND * 26) + 1
        IF mapzomb28 = 0 THEN IF xspawn = 28 THEN LET mapzomb28 = INT(RND * 26) + 1
        IF mapzomb29 = 0 THEN IF xspawn = 29 THEN LET mapzomb29 = INT(RND * 26) + 1
        IF mapzomb30 = 0 THEN IF xspawn = 30 THEN LET mapzomb30 = INT(RND * 26) + 1
        IF mapzomb31 = 0 THEN IF xspawn = 31 THEN LET mapzomb31 = INT(RND * 26) + 1
        IF mapzomb32 = 0 THEN IF xspawn = 32 THEN LET mapzomb32 = INT(RND * 26) + 1
        IF mapzomb33 = 0 THEN IF xspawn = 33 THEN LET mapzomb33 = INT(RND * 26) + 1
        IF mapzomb34 = 0 THEN IF xspawn = 34 THEN LET mapzomb34 = INT(RND * 26) + 1
        IF mapzomb35 = 0 THEN IF xspawn = 35 THEN LET mapzomb35 = INT(RND * 26) + 1
        IF mapzomb36 = 0 THEN IF xspawn = 36 THEN LET mapzomb36 = INT(RND * 26) + 1
        IF mapzomb37 = 0 THEN IF xspawn = 37 THEN LET mapzomb37 = INT(RND * 26) + 1
        IF mapzomb38 = 0 THEN IF xspawn = 38 THEN LET mapzomb38 = INT(RND * 26) + 1
        IF mapzomb39 = 0 THEN IF xspawn = 39 THEN LET mapzomb39 = INT(RND * 26) + 1
        IF mapzomb40 = 0 THEN IF xspawn = 40 THEN LET mapzomb40 = INT(RND * 26) + 1
        IF mapzomb41 = 0 THEN IF xspawn = 41 THEN LET mapzomb41 = INT(RND * 26) + 1
        IF mapzomb42 = 0 THEN IF xspawn = 42 THEN LET mapzomb42 = INT(RND * 26) + 1
        IF mapzomb43 = 0 THEN IF xspawn = 43 THEN LET mapzomb43 = INT(RND * 26) + 1
        IF mapzomb44 = 0 THEN IF xspawn = 44 THEN LET mapzomb44 = INT(RND * 26) + 1
        IF mapzomb45 = 0 THEN IF xspawn = 45 THEN LET mapzomb45 = INT(RND * 26) + 1
        IF mapzomb46 = 0 THEN IF xspawn = 46 THEN LET mapzomb46 = INT(RND * 26) + 1
        IF mapzomb47 = 0 THEN IF xspawn = 47 THEN LET mapzomb47 = INT(RND * 26) + 1
        IF mapzomb48 = 0 THEN IF xspawn = 48 THEN LET mapzomb48 = INT(RND * 26) + 1
        IF mapzomb49 = 0 THEN IF xspawn = 49 THEN LET mapzomb49 = INT(RND * 26) + 1
        IF mapzomb50 = 0 THEN IF xspawn = 50 THEN LET mapzomb50 = INT(RND * 26) + 1
        IF mapzomb51 = 0 THEN IF xspawn = 51 THEN LET mapzomb51 = INT(RND * 26) + 1
        IF mapzomb52 = 0 THEN IF xspawn = 52 THEN LET mapzomb52 = INT(RND * 26) + 1
        IF mapzomb53 = 0 THEN IF xspawn = 53 THEN LET mapzomb53 = INT(RND * 26) + 1
        IF mapzomb54 = 0 THEN IF xspawn = 54 THEN LET mapzomb54 = INT(RND * 26) + 1
        IF mapzomb55 = 0 THEN IF xspawn = 55 THEN LET mapzomb55 = INT(RND * 26) + 1
        IF mapzomb56 = 0 THEN IF xspawn = 56 THEN LET mapzomb56 = INT(RND * 26) + 1
        IF mapzomb57 = 0 THEN IF xspawn = 57 THEN LET mapzomb57 = INT(RND * 26) + 1
        IF mapzomb58 = 0 THEN IF xspawn = 58 THEN LET mapzomb58 = INT(RND * 26) + 1
        IF mapzomb59 = 0 THEN IF xspawn = 59 THEN LET mapzomb59 = INT(RND * 26) + 1
        IF mapzomb60 = 0 THEN IF xspawn = 60 THEN LET mapzomb60 = INT(RND * 26) + 1
        IF mapzomb61 = 0 THEN IF xspawn = 61 THEN LET mapzomb61 = INT(RND * 26) + 1
        IF mapzomb62 = 0 THEN IF xspawn = 62 THEN LET mapzomb62 = INT(RND * 26) + 1
        IF mapzomb63 = 0 THEN IF xspawn = 63 THEN LET mapzomb63 = INT(RND * 26) + 1
        IF mapzomb64 = 0 THEN IF xspawn = 64 THEN LET mapzomb64 = INT(RND * 26) + 1
    NEXT xspawn
    LET xspawn = 0
    REM zombie activator
    REM IF zombiemapper = 0 THEN LET zombiemapper = mapno
    IF zombiemapper <> mapno THEN
        LET zbuffer = 0
        IF mapzomb1 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb2 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb3 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb4 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb5 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb6 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb7 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb8 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb9 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb10 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb11 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb12 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb13 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb14 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb15 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb16 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb17 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb18 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb19 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb20 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb21 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb22 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb23 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb24 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb25 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb26 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb27 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb28 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb29 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb30 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb31 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb32 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb33 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb34 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb35 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb36 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb37 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb38 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb39 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb40 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb41 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb42 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb43 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb44 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb45 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb46 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb47 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb48 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb49 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb50 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb51 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb52 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb53 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb54 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb55 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb56 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb57 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb58 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb59 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb60 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb61 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb62 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb63 = mapno THEN zbuffer = zbuffer + 1
        IF mapzomb64 = mapno THEN zbuffer = zbuffer + 1
        IF zbuffer > 4 THEN LET zbuffer = 4
        IF oldzbuffer <> zbuffer THEN
            IF zbuffer = 1 THEN LET skipdraw1 = 1
            IF zbuffer = 2 THEN LET skipdraw1 = 1: LET skipdraw2 = 1
            IF zbuffer = 3 THEN LET skipdraw1 = 1: LET skipdraw2 = 1: LET skipdraw3 = 1
            IF zbuffer = 4 THEN LET skipdraw1 = 1: LET skipdraw2 = 1: LET skipdraw3 = 1: LET skipdraw4 = 1
            LET oldzbuffer = zbuffer
        END IF
        REM IF usebfg = 1 THEN LET zbuffer = 0: LET usebfg = 0: CLS
        LET zombiemapper = mapno
    END IF
END IF
IF zbuffer = 0 THEN RETURN
IF zbuffer = 1 THEN
    GOSUB z1
END IF
IF zbuffer = 2 THEN
    GOSUB z1: GOSUB z2
END IF
IF zbuffer = 3 THEN
    GOSUB z1: GOSUB z2: GOSUB z3
END IF
IF zbuffer = 4 THEN
    GOSUB z1: GOSUB z2: GOSUB z3: GOSUB z4
END IF
GOSUB avoidzomb
RETURN
REM Zombie AI code
z1: REM ZOMBIE 1
IF useitem = 1 THEN
    IF movemd1 = 100 THEN LET movemd1 = INT(RND * 4)
    IF movemd1 = 100 THEN LET movetz1 = INT(RND * zombmovetime)
    IF movemd1 = 0 THEN LET cz1y = z1y: LET z1y = z1y - zpace
    IF movemd1 = 1 THEN LET cz1y = z1y: LET z1y = z1y + zpace
    IF movemd1 = 2 THEN LET cz1x = z1x: LET z1x = z1x - zpace
    IF movemd1 = 3 THEN LET cz1x = z1x: LET z1x = z1x + zpace
END IF
REM Defines Coordinates
IF z1x = 0 THEN
    dcz1x:
    LET z1x = INT(RND * 639) + 1
    IF z1x < zombcx1 + radius THEN GOTO dcz1x
    IF z1x > zombcx2 - radius THEN GOTO dcz1x
END IF
IF z1y = 0 THEN
    dcz1y:
    LET z1y = INT(RND * 639) + 1
    IF z1y < zombcy1 + radius THEN GOTO dcz1y
    IF z1y > zombcy2 - radius THEN GOTO dcz1y
END IF
REM Erases Old Zombie
CIRCLE (cz1x, cz1y), (radius + zomberase), bgcolor
PAINT (cz1x, cz1y), 0, bgcolor
movez1:
REM Calculates Movement
IF useitem = 1 THEN GOTO zskip1
LET cz1x = z1x
LET cz1y = z1y
LET z1mt = 0
IF zmd1 = 1 THEN LET zmd1 = 0: GOTO z110
IF zmd1 = 2 THEN LET zmd1 = 0: GOTO z120
IF zmd1 = 3 THEN LET zmd1 = 0: GOTO z130
IF zmd1 = 4 THEN LET zmd1 = 0: GOTO z140
z110: IF z1x > youx THEN LET z1x = z1x - zpace: LET z1mt = z1mt + 1: IF z1mt = 1 THEN GOTO zskip1
z120: IF z1x < youx THEN LET z1x = z1x + zpace: LET z1mt = z1mt + 1: IF z1mt = 1 THEN GOTO zskip1
z130: IF z1y > youy THEN LET z1y = z1y - zpace: LET z1mt = z1mt + 1: IF z1mt = 1 THEN GOTO zskip1
z140: IF z1y < youy THEN LET z1y = z1y + zpace: LET z1mt = z1mt + 1: IF z1mt = 1 THEN GOTO zskip1
zskip1:
IF z1c > 5 THEN LET zmd1 = INT(RND * 3) + 1: LET z1c = 0
REM Draws Zombie
REM draw skip for spawn glitch??
IF skipdraw1 = 1 THEN
    IF useitem = 1 THEN
        GOTO bufferskip1
    END IF
END IF
CIRCLE (z1x, z1y), radius, zcolour
PAINT (z1x, z1y), zcolour
REM CIRCLE (z1x, z1y), radius / 2, 15
IF zcolour = bgcolor THEN
    CIRCLE (z1x, z1y), radius, 10
    PAINT (z1x, z1y), 10
END IF
REM flare avoidance
IF useflare = 1 THEN
    LET b1 = 0: LET b2 = 0
    FOR i = (z1x - radius * 2) TO (z1x + radius * 2)
        IF youx + radius * 2 = i THEN LET b1 = b1 + 1
        IF youx - radius * 2 = i THEN LET b1 = b1 + 1
    NEXT i
    FOR i = (z1y - radius * 2) TO (z1y + radius * 2)
        IF youy + radius * 2 = i THEN LET b2 = b2 + 1
        IF youy - radius * 2 = i THEN LET b2 = b2 + 1
    NEXT i
    IF b1 >= 1 AND b2 >= 1 THEN
        LET z1x = cz1x
        LET z1y = cz1y
    END IF
    LET b1 = 0: LET b2 = 0
    FOR i = (youx - radius * 2) TO (youx + radius * 2)
        IF z1x + radius * 2 = i THEN LET b1 = b1 + 1
        IF z1x - radius * 2 = i THEN LET b1 = b1 + 1
    NEXT i
    FOR i = (youy - radius * 2) TO (youy + radius * 2)
        IF z1y + radius * 2 = i THEN LET b2 = b2 + 1
        IF z1y - radius * 2 = i THEN LET b2 = b2 + 1
    NEXT i
    IF b1 >= 1 AND b2 >= 1 THEN
        LET z1x = cz1x
        LET z1y = cz1y
    END IF
END IF
REM Avoids character collision - Your perspective
LET b1 = 0: LET b2 = 0
FOR i = (z1x - radius) TO (z1x + radius)
    IF youx + radius = i THEN LET b1 = b1 + 1
    IF youx - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (z1y - radius) TO (z1y + radius)
    IF youy + radius = i THEN LET b2 = b2 + 1
    IF youy - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    LET z1x = cz1x
    LET z1y = cz1y
    IF usearmour = 0 THEN LET health = health - zombite
    IF infectionprotection = 0 THEN LET inc = INT(RND * 4) + 1
    IF inc = 3 THEN LET infection = 1
    LET inc = 0
END IF
REM Avoids character collision - AI perspective
LET b1 = 0: LET b2 = 0
FOR i = (youx - radius) TO (youx + radius)
    IF z1x + radius = i THEN LET b1 = b1 + 1
    IF z1x - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (youy - radius) TO (youy + radius)
    IF z1y + radius = i THEN LET b2 = b2 + 1
    IF z1y - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    IF usesbezerk = 1 THEN LET zbuffer = zbuffer - 1: LET gamepoints = gamepoints + killpoints: CLS: RETURN
    IF usebezerk = 1 THEN LET zbuffer = zbuffer - 1: LET gamepoints = gamepoints + killpoints: CLS: RETURN
    LET z1x = cz1x
    LET z1y = cz1y
    IF usearmour = 0 THEN LET health = health - zombite
    IF infectionprotection = 0 THEN LET inc = INT(RND * 4) + 1
    IF inc = 3 THEN LET infection = 1
    LET inc = 0
END IF
bufferskip1:
RETURN
z2: REM ZOMBIE 2
IF useitem = 1 THEN
    IF movemd2 = 100 THEN LET movemd2 = INT(RND * 4)
    IF movemd2 = 100 THEN LET movetz2 = INT(RND * zombmovetime)
    IF movemd2 = 0 THEN LET cz2y = z2y: LET z2y = z2y - zpace
    IF movemd2 = 1 THEN LET cz2y = z2y: LET z2y = z2y + zpace
    IF movemd2 = 2 THEN LET cz2x = z2x: LET z2x = z2x - zpace
    IF movemd2 = 3 THEN LET cz2x = z2x: LET z2x = z2x + zpace
END IF
REM Defines Coordinates
IF z2x = 0 THEN
    dcz2x:
    LET z2x = INT(RND * 639) + 1
    IF z2x < zombcx1 + radius THEN GOTO dcz2x
    IF z2x > zombcx2 - radius THEN GOTO dcz2x
END IF
IF z2y = 0 THEN
    dcz2y:
    LET z2y = INT(RND * 639) + 1
    IF z2y < zombcy1 + radius THEN GOTO dcz2y
    IF z2y > zombcy2 - radius THEN GOTO dcz2y
END IF
REM Erases Old Zombie
CIRCLE (cz2x, cz2y), (radius + zomberase), bgcolor
PAINT (cz2x, cz2y), bgcolor
movez2:
REM Calculates Movement
IF useitem = 1 THEN GOTO zskip2
LET cz2x = z2x
LET cz2y = z2y
LET z2mt = 0
IF zmd2 = 1 THEN LET zmd2 = 0: GOTO z210
IF zmd2 = 2 THEN LET zmd2 = 0: GOTO z220
IF zmd2 = 3 THEN LET zmd2 = 0: GOTO z230
IF zmd2 = 4 THEN LET zmd2 = 0: GOTO z240
z210: IF z2x > youx THEN LET z2x = z2x - zpace: LET z2mt = z2mt + 1: IF z2mt = 1 THEN GOTO zskip2
z220: IF z2x < youx THEN LET z2x = z2x + zpace: LET z2mt = z2mt + 1: IF z2mt = 1 THEN GOTO zskip2
z230: IF z2y > youy THEN LET z2y = z2y - zpace: LET z2mt = z2mt + 1: IF z2mt = 1 THEN GOTO zskip2
z240: IF z2y < youy THEN LET z2y = z2y + zpace: LET z2mt = z2mt + 1: IF z2mt = 1 THEN GOTO zskip2
zskip2:
IF z2c > 5 THEN LET zmd2 = INT(RND * 3) + 2: LET z2c = 0
REM draw skip for spawn glitch??
IF skipdraw2 = 1 THEN
    IF useitem = 1 THEN
        GOTO bufferskip2
    END IF
END IF
CIRCLE (z2x, z2y), radius, zcolour
PAINT (z2x, z2y), zcolour
REM CIRCLE (z2x, z2y), radius / 2, 12
IF zcolour = bgcolor THEN
    CIRCLE (z2x, z2y), radius, 10
    PAINT (z2x, z2y), 10
END IF
REM flare avoidance
IF useflare = 1 THEN
    LET b1 = 0: LET b2 = 0
    FOR i = (z2x - radius * 2) TO (z2x + radius * 2)
        IF youx + radius * 2 = i THEN LET b1 = b1 + 1
        IF youx - radius * 2 = i THEN LET b1 = b1 + 1
    NEXT i
    FOR i = (z2y - radius * 2) TO (z2y + radius * 2)
        IF youy + radius * 2 = i THEN LET b2 = b2 + 1
        IF youy - radius * 2 = i THEN LET b2 = b2 + 1
    NEXT i
    IF b1 >= 1 AND b2 >= 1 THEN
        LET z2x = cz2x
        LET z2y = cz2y
    END IF
    LET b1 = 0: LET b2 = 0
    FOR i = (youx - radius * 2) TO (youx + radius * 2)
        IF z2x + radius * 2 = i THEN LET b1 = b1 + 1
        IF z2x - radius * 2 = i THEN LET b1 = b1 + 1
    NEXT i
    FOR i = (youy - radius * 2) TO (youy + radius * 2)
        IF z2x + radius * 2 = i THEN LET b2 = b2 + 1
        IF z2y - radius * 2 = i THEN LET b2 = b2 + 1
    NEXT i
    IF b1 >= 1 AND b2 >= 1 THEN
        LET z2x = cz2x
        LET z2y = cz2y
    END IF
END IF
REM Avoids character collision - Your perspective
LET b1 = 0: LET b2 = 0
FOR i = (z2x - radius) TO (z2x + radius)
    IF youx + radius = i THEN LET b1 = b1 + 1
    IF youx - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (z2y - radius) TO (z2y + radius)
    IF youy + radius = i THEN LET b2 = b2 + 1
    IF youy - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    LET z2x = cz2x
    LET z2y = cz2y
    IF usearmour = 0 THEN LET health = health - zombite
    LET inc = INT(RND * 4) + 1
    IF infectionprotection = 0 THEN LET inc = INT(RND * 4) + 1
    LET inc = 0
END IF
REM Avoids character collision - AI perspective
LET b1 = 0: LET b2 = 0
FOR i = (youx - radius) TO (youx + radius)
    IF z2x + radius = i THEN LET b1 = b1 + 1
    IF z2x - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (youy - radius) TO (youy + radius)
    IF z2y + radius = i THEN LET b2 = b2 + 1
    IF z2y - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    IF usesbezerk = 1 THEN LET zbuffer = zbuffer - 1: LET gamepoints = gamepoints + killpoints: CLS: RETURN
    IF usebezerk = 1 THEN LET zbuffer = zbuffer - 1: LET gamepoints = gamepoints + killpoints: CLS: RETURN
    LET z2x = cz2x
    LET z2y = cz2y
    IF usearmour = 0 THEN LET health = health - zombite
    IF infectionprotection = 0 THEN LET inc = INT(RND * 4) + 1
    IF inc = 3 THEN LET infection = 1
    LET inc = 0
END IF
bufferskip2:
RETURN
z3: REM ZOMBIE 3
IF useitem = 1 THEN
    IF movemd3 = 100 THEN LET movemd3 = INT(RND * 4)
    IF movemd3 = 100 THEN LET movetz3 = INT(RND * zombmovetime)
    IF movemd3 = 0 THEN LET cz3y = z3y: LET z3y = z3y - zpace
    IF movemd3 = 1 THEN LET cz3y = z3y: LET z3y = z3y + zpace
    IF movemd3 = 2 THEN LET cz3x = z3x: LET z3x = z3x - zpace
    IF movemd3 = 3 THEN LET cz3x = z3x: LET z3x = z3x + zpace
END IF
REM Defines Coordinates
IF z3x = 0 THEN
    dcz3x:
    LET z3x = INT(RND * 639) + 1
    IF z3x < zombcx1 + radius THEN GOTO dcz3x
    IF z3x > zombcx2 - radius THEN GOTO dcz3x
END IF
IF z3y = 0 THEN
    dcz3y:
    LET z3y = INT(RND * 639) + 1
    IF z3y < zombcy1 + radius THEN GOTO dcz3y
    IF z3y > zombcy2 - radius THEN GOTO dcz3y
END IF
REM Erases Old Zombie
CIRCLE (cz3x, cz3y), radius + zomberase, bgcolor
PAINT (cz3x, cz3y), bgcolor
movez3:
REM Calculates Movement
IF useitem = 1 THEN GOTO zskip3
LET cz3x = z3x
LET cz3y = z3y
LET z3mt = 0
IF zmd3 = 1 THEN LET zmd3 = 0: GOTO z310
IF zmd3 = 2 THEN LET zmd3 = 0: GOTO z320
IF zmd3 = 3 THEN LET zmd3 = 0: GOTO z330
IF zmd3 = 4 THEN LET zmd3 = 0: GOTO z340
z310: IF z3x > youx THEN LET z3x = z3x - zpace: LET z3mt = z3mt + 1: IF z3mt = 1 THEN GOTO zskip3
z320: IF z3x < youx THEN LET z3x = z3x + zpace: LET z3mt = z3mt + 1: IF z3mt = 1 THEN GOTO zskip3
z330: IF z3y > youy THEN LET z3y = z3y - zpace: LET z3mt = z3mt + 1: IF z3mt = 1 THEN GOTO zskip3
z340: IF z3y < youy THEN LET z3y = z3y + zpace: LET z3mt = z3mt + 1: IF z3mt = 1 THEN GOTO zskip3
zskip3:
IF z3c > 5 THEN LET zmd3 = INT(RND * 3) + 3: LET z3c = 0
REM Draws Zombie
REM draw skip for spawn glitch??
IF skipdraw3 = 1 THEN
    IF useitem = 1 THEN
        GOTO bufferskip3
    END IF
END IF
CIRCLE (z3x, z3y), radius, zcolour
PAINT (z3x, z3y), zcolour
REM CIRCLE (z3x, z3y), radius / 2, 1
IF zcolour = bgcolor THEN
    CIRCLE (z3x, z3y), radius, 10
    PAINT (z3x, z3y), 10
END IF
REM flare avoidance
IF useflare = 1 THEN
    LET b1 = 0: LET b2 = 0
    FOR i = (z3x - radius * 2) TO (z3x + radius * 2)
        IF youx + radius * 2 = i THEN LET b1 = b1 + 1
        IF youx - radius * 2 = i THEN LET b1 = b1 + 1
    NEXT i
    FOR i = (z3y - radius * 2) TO (z3y + radius * 2)
        IF youy + radius * 2 = i THEN LET b2 = b2 + 1
        IF youy - radius * 2 = i THEN LET b2 = b2 + 1
    NEXT i
    IF b1 >= 1 AND b2 >= 1 THEN
        LET z3x = cz3x
        LET z3y = cz3y
    END IF
    LET b1 = 0: LET b2 = 0
    FOR i = (youx - radius * 2) TO (youx + radius * 2)
        IF z3x + radius * 2 = i THEN LET b1 = b1 + 1
        IF z3x - radius * 2 = i THEN LET b1 = b1 + 1
    NEXT i
    FOR i = (youy - radius * 2) TO (youy + radius * 2)
        IF z3x + radius * 2 = i THEN LET b2 = b2 + 1
        IF z3y - radius * 2 = i THEN LET b2 = b2 + 1
    NEXT i
    IF b1 >= 1 AND b2 >= 1 THEN
        LET z3x = cz3x
        LET z3y = cz3y
    END IF
END IF
REM Avoids character collision - Your perspective
LET b1 = 0: LET b2 = 0
FOR i = (z3x - radius) TO (z3x + radius)
    IF youx + radius = i THEN LET b1 = b1 + 1
    IF youx - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (z3y - radius) TO (z3y + radius)
    IF youy + radius = i THEN LET b2 = b2 + 1
    IF youy - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    LET z3x = cz3x
    LET z3y = cz3y
    IF usearmour = 0 THEN LET health = health - zombite
    LET inc = INT(RND * 4) + 1
    IF infectionprotection = 0 THEN LET inc = INT(RND * 4) + 1
    LET inc = 0
END IF
REM Avoids character collision - AI perspective
LET b1 = 0: LET b2 = 0
FOR i = (youx - radius) TO (youx + radius)
    IF z3x + radius = i THEN LET b1 = b1 + 1
    IF z3x - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (youy - radius) TO (youy + radius)
    IF z3y + radius = i THEN LET b2 = b2 + 1
    IF z3y - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    IF usesbezerk = 1 THEN LET zbuffer = zbuffer - 1: LET gamepoints = gamepoints + killpoints: CLS: RETURN
    IF usebezerk = 1 THEN LET zbuffer = zbuffer - 1: LET gamepoints = gamepoints + killpoints: CLS: RETURN
    LET z3x = cz3x
    LET z3y = cz3y
    IF usearmour = 0 THEN LET health = health - zombite
    IF infectionprotection = 0 THEN LET inc = INT(RND * 4) + 1
    IF inc = 3 THEN LET infection = 1
    LET inc = 0
END IF
bufferskip3:
RETURN
z4: REM ZOMBIE 4
IF useitem = 1 THEN
    IF movemd4 = 100 THEN LET movemd4 = INT(RND * 4)
    IF movemd4 = 100 THEN LET movetz4 = INT(RND * zombmovetime)
    IF movemd4 = 0 THEN LET cz4y = z4y: LET z4y = z4y - zpace
    IF movemd4 = 1 THEN LET cz4y = z4y: LET z4y = z4y + zpace
    IF movemd4 = 2 THEN LET cz4x = z4x: LET z4x = z4x - zpace
    IF movemd4 = 3 THEN LET cz4x = z4x: LET z4x = z4x + zpace
END IF
REM Defines Coordinates
IF z4x = 0 THEN
    dcz4x:
    LET z4x = INT(RND * 639) + 1
    IF z4x < zombcx1 + radius THEN GOTO dcz4x
    IF z4x > zombcx2 - radius THEN GOTO dcz4x
END IF
IF z4y = 0 THEN
    dcz4y:
    LET z4y = INT(RND * 639) + 1
    IF z4y < zombcy1 + radius THEN GOTO dcz4y
    IF z4y > zombcy2 - radius THEN GOTO dcz4y
END IF
REM Erases Old Zombie
CIRCLE (cz4x, cz4y), (radius + zomberase), bgcolor
PAINT (cz4x, cz4y), bgcolor
movez4:
REM Calculates Movement
IF useitem = 1 THEN GOTO zskip4
LET cz4x = z4x
LET cz4y = z4y
LET z4mt = 0
IF zmd4 = 1 THEN LET zmd4 = 0: GOTO z410
IF zmd4 = 2 THEN LET zmd4 = 0: GOTO z420
IF zmd4 = 3 THEN LET zmd4 = 0: GOTO z430
IF zmd4 = 4 THEN LET zmd4 = 0: GOTO z440
z410: IF z4x > youx THEN LET z4x = z4x - zpace: LET z4mt = z4mt + 1: IF z4mt = 1 THEN GOTO zskip4
z420: IF z4x < youx THEN LET z4x = z4x + zpace: LET z4mt = z4mt + 1: IF z4mt = 1 THEN GOTO zskip4
z430: IF z4y > youy THEN LET z4y = z4y - zpace: LET z4mt = z4mt + 1: IF z4mt = 1 THEN GOTO zskip4
z440: IF z4y < youy THEN LET z4y = z4y + zpace: LET z4mt = z4mt + 1: IF z4mt = 1 THEN GOTO zskip4
zskip4:
IF z4c > 5 THEN LET zmd4 = INT(RND * 4) + 4: LET z4c = 0
REM Draws Zombie
REM draw skip for spawn glitch??
IF skipdraw4 = 1 THEN
    IF useitem = 1 THEN
        GOTO bufferskip4
    END IF
END IF
CIRCLE (z4x, z4y), radius, zcolour
PAINT (z4x, z4y), zcolour
REM CIRCLE (z4x, z4y), radius / 2, 14
IF zcolour = bgcolor THEN
    CIRCLE (z4x, z4y), radius, 10
    PAINT (z4x, z4y), 10
END IF
REM flare avoidance
IF useflare = 1 THEN
    LET b1 = 0: LET b2 = 0
    FOR i = (z4x - radius * 2) TO (z4x + radius * 2)
        IF youx + radius * 2 = i THEN LET b1 = b1 + 1
        IF youx - radius * 2 = i THEN LET b1 = b1 + 1
    NEXT i
    FOR i = (z4y - radius * 2) TO (z4y + radius * 2)
        IF youy + radius * 2 = i THEN LET b2 = b2 + 1
        IF youy - radius * 2 = i THEN LET b2 = b2 + 1
    NEXT i
    IF b1 >= 1 AND b2 >= 1 THEN
        LET z4x = cz4x
        LET z4y = cz4y
    END IF
    LET b1 = 0: LET b2 = 0
    FOR i = (youx - radius * 2) TO (youx + radius * 2)
        IF z4x + radius * 2 = i THEN LET b1 = b1 + 1
        IF z4x - radius * 2 = i THEN LET b1 = b1 + 1
    NEXT i
    FOR i = (youy - radius * 2) TO (youy + radius * 2)
        IF z4x + radius * 2 = i THEN LET b2 = b2 + 1
        IF z4y - radius * 2 = i THEN LET b2 = b2 + 1
    NEXT i
    IF b1 >= 1 AND b2 >= 1 THEN
        LET z4x = cz4x
        LET z4y = cz4y
    END IF
END IF
REM Avoids character collision - Your perspective
LET b1 = 0: LET b2 = 0
FOR i = (z4x - radius) TO (z4x + radius)
    IF youx + radius = i THEN LET b1 = b1 + 1
    IF youx - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (z4y - radius) TO (z4y + radius)
    IF youy + radius = i THEN LET b2 = b2 + 1
    IF youy - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    LET z4x = cz4x
    LET z4y = cz4y
    IF usearmour = 0 THEN LET health = health - zombite
    LET inc = INT(RND * 4) + 1
    IF infectionprotection = 0 THEN LET inc = INT(RND * 4) + 1
    LET inc = 0
END IF
REM Avoids character collision - AI perspective
LET b1 = 0: LET b2 = 0
FOR i = (youx - radius) TO (youx + radius)
    IF z4x + radius = i THEN LET b1 = b1 + 1
    IF z4x - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (youy - radius) TO (youy + radius)
    IF z4y + radius = i THEN LET b2 = b2 + 1
    IF z4y - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    IF usesbezerk = 1 THEN LET zbuffer = zbuffer - 1: LET gamepoints = gamepoints + killpoints: CLS: RETURN
    IF usebezerk = 1 THEN LET zbuffer = zbuffer - 1: LET gamepoints = gamepoints + killpoints: CLS: RETURN
    LET z4x = cz4x
    LET z4y = cz4y
    IF usearmour = 0 THEN LET health = health - zombite
    IF infectionprotection = 0 THEN LET inc = INT(RND * 4) + 1
    IF inc = 3 THEN LET infection = 1
    LET inc = 0
END IF
bufferskip4:
RETURN

avoidzomb:
REM Zombie collision detection
IF zbuffer = 1 THEN
    GOSUB avoidzomb1
END IF
IF zbuffer = 2 THEN
    GOSUB avoidzomb1: GOSUB avoidzomb2
END IF
IF zbuffer = 3 THEN
    GOSUB avoidzomb1: GOSUB avoidzomb2: GOSUB avoidzomb3
END IF
IF zbuffer = 4 THEN
    GOSUB avoidzomb1: GOSUB avoidzomb2: GOSUB avoidzomb3: GOSUB avoidzomb4
END IF
RETURN
avoidzomb1:
REM ZOMBIE 1-2
LET b1 = 0: LET b2 = 0
FOR i = (z1x - radius) TO (z1x + radius)
    IF z2x + radius = i THEN LET b1 = b1 + 1
    IF z2x - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (z1y - radius) TO (z1y + radius)
    IF z2y + radius = i THEN LET b2 = b2 + 1
    IF z2y - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    LET z1x = cz1x
    LET z1y = cz1y
    LET z1c = z1c + 1
END IF
REM ZOMBIE 1-3
LET b1 = 0: LET b2 = 0
FOR i = (z1x - radius) TO (z1x + radius)
    IF z3x + radius = i THEN LET b1 = b1 + 1
    IF z3x - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (z1y - radius) TO (z1y + radius)
    IF z3y + radius = i THEN LET b2 = b2 + 1
    IF z3y - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    LET z1x = cz1x
    LET z1y = cz1y
    LET z1c = z1c + 1
END IF
REM ZOMBIE 1-4
LET b1 = 0: LET b2 = 0
FOR i = (z1x - radius) TO (z1x + radius)
    IF z4x + radius = i THEN LET b1 = b1 + 1
    IF z4x - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (z1y - radius) TO (z1y + radius)
    IF z4y + radius = i THEN LET b2 = b2 + 1
    IF z4y - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    LET z1x = cz1x
    LET z1y = cz1y
    LET z1c = z1c + 1
END IF
RETURN
avoidzomb2:
REM ZOMBIE 2-1
LET b1 = 0: LET b2 = 0
FOR i = (z2x - radius) TO (z2x + radius)
    IF z1x + radius = i THEN LET b1 = b1 + 1
    IF z1x - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (z2y - radius) TO (z2y + radius)
    IF z1y + radius = i THEN LET b2 = b2 + 1
    IF z1y - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    LET z2x = cz2x
    LET z2y = cz2y
    LET z2c = z2c + 1
END IF
REM ZOMBIE 2-3
LET b1 = 0: LET b2 = 0
FOR i = (z2x - radius) TO (z2x + radius)
    IF z3x + radius = i THEN LET b1 = b1 + 1
    IF z3x - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (z2y - radius) TO (z2y + radius)
    IF z3y + radius = i THEN LET b2 = b2 + 1
    IF z3y - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    LET z2x = cz2x
    LET z2y = cz2y
    LET z2c = z2c + 1
END IF
REM ZOMBIE 2-4
LET b1 = 0: LET b2 = 0
FOR i = (z2x - radius) TO (z2x + radius)
    IF z4x + radius = i THEN LET b1 = b1 + 1
    IF z4x - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (z2y - radius) TO (z2y + radius)
    IF z4y + radius = i THEN LET b2 = b2 + 1
    IF z4y - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    LET z2x = cz2x
    LET z2y = cz2y
    LET z2c = z2c + 1
END IF
RETURN
avoidzomb3:
REM ZOMBIE 3-1
LET b1 = 0: LET b2 = 0
FOR i = (z3x - radius) TO (z3x + radius)
    IF z1x + radius = i THEN LET b1 = b1 + 1
    IF z1x - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (z3y - radius) TO (z3y + radius)
    IF z1y + radius = i THEN LET b2 = b2 + 1
    IF z1y - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    LET z3x = cz3x
    LET z3y = cz3y
    LET z3c = z3c + 1
END IF
REM ZOMBIE 3-2
LET b1 = 0: LET b2 = 0
FOR i = (z3x - radius) TO (z3x + radius)
    IF z2x + radius = i THEN LET b1 = b1 + 1
    IF z2x - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (z3y - radius) TO (z3y + radius)
    IF z2y + radius = i THEN LET b2 = b2 + 1
    IF z2y - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    LET z3x = cz3x
    LET z3y = cz3y
    LET z3c = z3c + 1
END IF
REM ZOMBIE 3-4
LET b1 = 0: LET b2 = 0
FOR i = (z3x - radius) TO (z3x + radius)
    IF z4x + radius = i THEN LET b1 = b1 + 1
    IF z4x - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (z3y - radius) TO (z3y + radius)
    IF z4y + radius = i THEN LET b2 = b2 + 1
    IF z4y - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    LET z3x = cz3x
    LET z3y = cz3y
    LET z3c = z3c + 1
END IF
RETURN
avoidzomb4:
REM ZOMBIE 4-1
LET b1 = 0: LET b2 = 0
FOR i = (z4x - radius) TO (z4x + radius)
    IF z1x + radius = i THEN LET b1 = b1 + 1
    IF z1x - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (z4y - radius) TO (z4y + radius)
    IF z1y + radius = i THEN LET b2 = b2 + 1
    IF z1y - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    LET z4x = cz4x
    LET z4y = cz4y
    LET z4c = z4c + 1
END IF
REM ZOMBIE 4-2
LET b1 = 0: LET b2 = 0
FOR i = (z4x - radius) TO (z4x + radius)
    IF z2x + radius = i THEN LET b1 = b1 + 1
    IF z2x - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (z4y - radius) TO (z4y + radius)
    IF z2y + radius = i THEN LET b2 = b2 + 1
    IF z2y - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    LET z4x = cz4x
    LET z4y = cz4y
    LET z4c = z4c + 1
END IF
REM ZOMBIE 4-3
LET b1 = 0: LET b2 = 0
FOR i = (z4x - radius) TO (z4x + radius)
    IF z3x + radius = i THEN LET b1 = b1 + 1
    IF z3x - radius = i THEN LET b1 = b1 + 1
NEXT i
FOR i = (z4y - radius) TO (z4y + radius)
    IF z3y + radius = i THEN LET b2 = b2 + 1
    IF z3y - radius = i THEN LET b2 = b2 + 1
NEXT i
IF b1 >= 1 AND b2 >= 1 THEN
    LET z4x = cz4x
    LET z4y = cz4y
    LET z4c = z4c + 1
END IF
RETURN

drawyou:
REM Draws player
REM Sets Colour Based On Health
IF health <= 10 THEN LET youc = 4
IF health > 10 THEN LET youc = 12
IF health > 25 THEN LET youc = 14
IF health > 50 THEN LET youc = 10
REM Erases old circle
IF mapexit = 0 THEN
    CIRCLE (yskipx, yskipy), radius, bgcolor
    PAINT (yskipx, yskipy), bgcolor
END IF
IF mapexit = 1 THEN
    LET mapexit = 0
    REM CLS
END IF
REM Flare Powerup (required before drawing of user character)
IF useflare = 1 THEN
    CIRCLE (yskipx, yskipy), (radius * 2), bgcolor
    CIRCLE (youx, youy), (radius * 2), 13
END IF
REM Draws new circle
CIRCLE (youx, youy), radius, youc
PAINT (youx, youy), youc
REM Powerup Changes
IF usepills = 1 THEN
    LINE (youx - (radius / 2), youy)-(youx + (radius / 2), youy), 8
    LINE (youx, youy - (radius / 2))-(youx, youy + (radius / 2)), 8
END IF
IF useadrenaline = 1 THEN
    CIRCLE (youx, youy), (radius / 2), 13
END IF
IF usebezerk = 1 THEN
    CIRCLE (youx, youy), (radius / 2), 2
END IF
IF usesbezerk = 1 THEN
    CIRCLE (youx, youy), (radius / 2), 15
END IF
IF infectionprotection = 1 THEN
    CIRCLE (youx, youy), (radius / 3), 9
END IF
IF usearmour = 1 THEN
    LINE (youx - (radius / 2), youy)-(youx + (radius / 2), youy), 3
    LINE (youx, youy - (radius / 2))-(youx, youy + (radius / 2)), 3
END IF
IF infection = 1 THEN
    IF health > 25 THEN
        LINE (youx, youy)-(youx - (radius / 2), youy - (radius / 2)), 13
        LINE (youx, youy)-(youx + (radius / 2), youy + (radius / 2)), 13
        LINE (youx, youy)-(youx - (radius / 2), youy + (radius / 2)), 13
        LINE (youx, youy)-(youx + (radius / 2), youy - (radius / 2)), 13
    END IF
    IF health <= 24 THEN
        LINE (youx, youy)-(youx - (radius / 2), youy - (radius / 2)), 14
        LINE (youx, youy)-(youx + (radius / 2), youy + (radius / 2)), 14
        LINE (youx, youy)-(youx - (radius / 2), youy + (radius / 2)), 14
        LINE (youx, youy)-(youx + (radius / 2), youy - (radius / 2)), 14
    END IF
END IF
LET yskipx = youx
LET yskipy = youy
RETURN

inputter:
REM Input Sub
REM Movement
IF useitem = 0 THEN
    REM UP
    IF a$ = CHR$(0) + CHR$(72) THEN LET cyouy = youy: LET youy = youy - pace
    REM DOWN
    IF a$ = CHR$(0) + CHR$(80) THEN LET cyouy = youy: LET youy = youy + pace
    REM RIGHT
    IF a$ = CHR$(0) + CHR$(77) THEN LET cyoux = youx: LET youx = youx + pace
    REM LEFT
    IF a$ = CHR$(0) + CHR$(75) THEN LET cyoux = youx: LET youx = youx - pace
    REM INVENTORY
    IF a$ = "I" THEN GOSUB inventory: GOSUB map: GOSUB drawyou
END IF
REM PAUSE MENU
IF a$ = CHR$(27) THEN GOSUB pausemenu
REM Divert for when highlighted object is used
IF hudlabelc > 0 THEN IF a$ = CHR$(32) THEN GOSUB object
RETURN

pausemenu:
REM Pause Menu when ESC is pressed
LET dmenua = 15
pmainmenuloop1:
LINE (320 - xbox, 240 - ybox)-(320 + xbox, 240 + ybox), mcolor, BF
LINE ((320 - xbox) + 30, (240 - ybox) + 30)-((320 + xbox) - 30, (240 + ybox) - 30), 0, BF
LOCATE 12, 62 - 6: COLOR 12: PRINT "PAUSED"
LOCATE 15, 40 - (6 / 2): COLOR 15: PRINT "Resume"
LOCATE 17, 40 - (9 / 2): PRINT "Suicidium"
LOCATE 12, 20: PRINT "PROFILE: "; profile$
DO
    LOCATE dmenua, 46: COLOR 10: PRINT "<--"
    LOCATE dmenua, 30: COLOR 10: PRINT "-->"
    LET m$ = UCASE$(INKEY$)
    IF m$ = CHR$(0) + CHR$(72) THEN LOCATE dmenua, 46: PRINT "   ": LOCATE dmenua, 30: PRINT "   ": LET dmenua = dmenua - 2
    IF m$ = CHR$(0) + CHR$(80) THEN LOCATE dmenua, 46: PRINT "   ": LOCATE dmenua, 30: PRINT "   ": LET dmenua = dmenua + 2
    IF dmenua < 15 THEN LET dmenua = 15
    IF dmenua > 17 THEN LET dmenua = 17
    IF m$ = CHR$(27) THEN
        CLS
        LET yskipx = 0: LET yskipy = 0
        GOSUB map
        GOSUB drawyou
        RETURN
    END IF
LOOP UNTIL m$ = " "
IF dmenua = 15 THEN CLS: GOSUB drawyou: RETURN
IF dmenua = 17 THEN
    OPEN "bloat.fuu" FOR OUTPUT AS #2
    WRITE #2, gameon, profile$
    CLOSE #2
    FOR yd = 0 TO 480
        LINE (0, yd)-(640, yd), 12
        _DELAY .005
    NEXT yd
    LINE (320 - xbox, 240 - ybox)-(320 + xbox, 240 + ybox), mcolor, BF
    LINE ((320 - xbox) + 30, (240 - ybox) + 30)-((320 + xbox) - 30, (240 + ybox) - 30), 0, BF
    LOCATE 12, 40 - 5: COLOR 12: PRINT "GAME OVER!"
    LOCATE 16, 40 - (12 / 2): COLOR 15: PRINT "You Gave Up"
    DO: LOOP UNTIL INKEY$ = " "
    CLS
    GOTO 10
END IF
GOTO pmainmenuloop1
RETURN

fullscreen:
REM Fullscreen Function
IF fullscreen = fullscreenc THEN RETURN
LET fullscreenc = fullscreen
IF fullscreen = 1 THEN _FULLSCREEN _SQUAREPIXELS
IF fullscreen = 0 THEN _FULLSCREEN _OFF
_DELAY 1
RETURN

object:
REM Decides what to do when object is used
REM Bed
IF usetypec = 0 THEN GOTO dirtycheat
IF usetypec = 1 THEN GOSUB usetype1
IF usetypec = 2 THEN GOSUB usetype2
IF usetypec = 3 THEN GOSUB usetype3
dirtycheat:
REM Secret Items
IF mapno = 19 THEN IF huditemlabel$ = "Bush 6" THEN GOSUB carkeys
IF mapno = 15 THEN IF huditemlabel$ = "Car" THEN GOSUB usecar
IF mapno = 14 THEN IF huditemlabel$ = "WARP" THEN GOSUB usewarp
REM Vending Machine
IF huditemlabel$ = "Vending Machine" THEN GOSUB vending
REM Exit
LET usetypec = 0
IF message = 1 THEN LET message = 0
IF huditemlabel$ = "Exit" THEN
    IF cexitno = 1 THEN
        IF keyr1 = 1 THEN
            IF skeys > 0 THEN
                IF mapno = 13 THEN
                    LET mapno = 14
                    LET youx = 345
                    LET youy = 205
                    LET cyoux = 345
                    LET cyouy = 205
                    LET cexitd4 = 0
                    GOTO keycheat
                END IF
                IF mapno = 14 THEN
                    LET mapno = 13
                    LET youx = 250
                    LET youy = 120
                    LET cyoux = 250
                    LET cyouy = 120
                    LET cexitd1 = 0
                    GOTO keycheat
                END IF
            END IF
            IF keys > 0 THEN
                IF mapno = 7 THEN
                    LET mapno = 23
                    LET youx = 100
                    LET youy = 350
                    LET cyoux = 100
                    LET cyouy = 350
                    LET cexitd4 = 0
                    GOTO keycheat
                END IF
                IF mapno = 23 THEN
                    LET mapno = 7
                    LET youx = 350
                    LET youy = 375
                    LET cyoux = 350
                    LET cyouy = 375
                    LET cexitd4 = 0
                    GOTO keycheat
                END IF
            END IF
            LET notif$ = "Door Locked"
            LET notifon = 1
            LET notift = ctime
            LET notifc = 11
            RETURN
        END IF
        LET mapno = cexitd1
        LET youx = exitx1
        LET youy = exity1
        LET cyoux = exitx1
        LET cyouy = exity1
        LET cexitd1 = 0
    END IF
    IF cexitno = 2 THEN
        IF keyr2 = 1 THEN
            IF skeys > 0 THEN
                IF mapno = 13 THEN
                    LET mapno = 14
                    LET youx = 345
                    LET youy = 205
                    LET cyoux = 345
                    LET cyouy = 205
                    LET cexitd4 = 0
                    GOTO keycheat
                END IF
                IF mapno = 14 THEN
                    LET mapno = 13
                    LET youx = 250
                    LET youy = 120
                    LET cyoux = 250
                    LET cyouy = 120
                    LET cexitd1 = 0
                    GOTO keycheat
                END IF
            END IF
            IF keys > 0 THEN
                IF mapno = 7 THEN
                    LET mapno = 23
                    LET youx = 100
                    LET youy = 350
                    LET cyoux = 100
                    LET cyouy = 350
                    LET cexitd4 = 0
                    GOTO keycheat
                END IF
                IF mapno = 23 THEN
                    LET mapno = 7
                    LET youx = 350
                    LET youy = 375
                    LET cyoux = 350
                    LET cyouy = 375
                    LET cexitd4 = 0
                    GOTO keycheat
                END IF
            END IF
            LET notif$ = "Door Locked"
            LET notifon = 1
            LET notift = ctime
            LET notifc = 11
            RETURN
        END IF
        LET mapno = cexitd2
        LET youx = exitx2
        LET youy = exity2
        LET cyoux = exitx2
        LET cyouy = exity2
        LET cexitd2 = 0
    END IF
    IF cexitno = 3 THEN
        IF keyr3 = 1 THEN
            IF skeys > 0 THEN
                IF mapno = 13 THEN
                    LET mapno = 14
                    LET youx = 345
                    LET youy = 205
                    LET cyoux = 345
                    LET cyouy = 205
                    LET cexitd4 = 0
                    GOTO keycheat
                END IF
                IF mapno = 14 THEN
                    LET mapno = 13
                    LET youx = 250
                    LET youy = 120
                    LET cyoux = 250
                    LET cyouy = 120
                    LET cexitd1 = 0
                    GOTO keycheat
                END IF
            END IF
            IF keys > 0 THEN
                IF mapno = 7 THEN
                    LET mapno = 23
                    LET youx = 100
                    LET youy = 350
                    LET cyoux = 100
                    LET cyouy = 350
                    LET cexitd4 = 0
                    GOTO keycheat
                END IF
                IF mapno = 23 THEN
                    LET mapno = 7
                    LET youx = 350
                    LET youy = 375
                    LET cyoux = 350
                    LET cyouy = 375
                    LET cexitd4 = 0
                    GOTO keycheat
                END IF
            END IF
            LET notif$ = "Door Locked"
            LET notifon = 1
            LET notift = ctime
            LET notifc = 11
            RETURN
        END IF
        LET mapno = cexitd3
        LET youx = exitx3
        LET youy = exity3
        LET cyoux = exitx3
        LET cyouy = exity3
        LET cexitd3 = 0
    END IF
    IF cexitno = 4 THEN
        IF keyr4 = 1 THEN
            IF skeys > 0 THEN
                IF mapno = 13 THEN
                    LET mapno = 14
                    LET youx = 345
                    LET youy = 205
                    LET cyoux = 345
                    LET cyouy = 205
                    LET cexitd4 = 0
                    GOTO keycheat
                END IF
                IF mapno = 14 THEN
                    LET mapno = 13
                    LET youx = 250
                    LET youy = 120
                    LET cyoux = 250
                    LET cyouy = 120
                    LET cexitd1 = 0
                    GOTO keycheat
                END IF
            END IF
            IF keys > 0 THEN
                IF mapno = 7 THEN
                    LET mapno = 23
                    LET youx = 100
                    LET youy = 350
                    LET cyoux = 100
                    LET cyouy = 350
                    LET cexitd4 = 0
                    GOTO keycheat
                END IF
                IF mapno = 23 THEN
                    LET mapno = 7
                    LET youx = 350
                    LET youy = 375
                    LET cyoux = 350
                    LET cyouy = 375
                    LET cexitd4 = 0
                    GOTO keycheat
                END IF
            END IF
            LET notif$ = "Door Locked"
            LET notifon = 1
            LET notift = ctime
            LET notifc = 11
            RETURN
        END IF
        LET mapno = cexitd4
        LET youx = exitx4
        LET youy = exity4
        LET cyoux = exitx4
        LET cyouy = exity4
        LET cexitd4 = 0
    END IF
    keycheat:
    LET texit1 = 0
    LET texit2 = 0
    LET texit3 = 0
    LET texit4 = 0
    LET xexit1 = 0
    LET xexit2 = 0
    LET xexit3 = 0
    LET xexit4 = 0
    LET yexit1 = 0
    LET yexit2 = 0
    LET yexit3 = 0
    LET yexit4 = 0
    LET exitd1 = 0
    LET exitd2 = 0
    LET exitd3 = 0
    LET exitd4 = 0
    LET keyr1 = 0
    LET keyr2 = 0
    LET keyr3 = 0
    LET keyr4 = 0
    LET mapexit = 1
    CLS
END IF
RETURN

carkeys:
REM Secret car keys
IF ckeysused = 1 THEN RETURN: REM Return if keys already taken
LET ckeysused = 1
LET ckeys = ckeys + 1
LET notif$ = "Car Keys Found"
LET notifon = 1
LET notift = ctime
LET notifc = 14
RETURN

usewarp:
REM Secret warp in shed
warpmaploop:
LET warpmap = INT(RND * 3) + 1
IF warpmap = 1 THEN
    LET mapno = 1
    LET youx = 90
    LET youy = 245
END IF
IF warpmap = 2 THEN
    LET mapno = 20
    LET youx = 90
    LET youy = 245
END IF
IF warpmap = 3 THEN
    LET mapno = 26
    LET youx = 140
    LET youy = 245
END IF
IF mapno = 0 THEN GOTO warpmaploop
LET cyoux = youx
LET cyouy = youy
LET gamepoints = gamepoints + warppoints
CLS
GOSUB map
GOSUB drawyou
RETURN

usecar:
REM Secret weapon in car
IF ckeys = 0 THEN
    LET notif$ = "Car Locked"
    LET notifon = 1
    LET notift = ctime
    LET notifc = 10
    RETURN
END IF
IF ckeys = 1 THEN
    LET notif$ = "BFG 9K Found"
    LET notifon = 1
    LET notift = ctime
    LET notifc = 12
    LET ckeys = ckeys - 1
    LET bfg = bfg + 1
    RETURN
END IF

usetype3:
REM Null Use Code (prevent use item confusion bug)
LET youx = youx: LET youy = youy
LET useitem = 0
RETURN

usetype2:
REM Use Code for Storage Items
IF dropoffs = 0 THEN GOSUB noitem2: RETURN
LET rand2 = INT(RND * 99) + 1
REM NO ITEM
IF rand2 < 50 THEN GOSUB noitem2: RETURN
LET rand1 = INT(RND * 11)
REM MONEY ITEM
IF rand1 <= 3 OR rand1 = 0 THEN
    LET rmoney = INT(RND * dropoffs) + 1
    LET money = money + rmoney
    LET notif$ = "You Find Money"
    LET notifon = 1
    LET notift = ctime
    LET notifc = 14
    LET dropoffs = dropoffs - 1
    RETURN
END IF
REM HEALTH ITEM
IF rand1 > 3 AND rand1 <= 6 THEN
    LET rhealth = INT(RND * 9) + 1
    IF rhealth <= 3 THEN LET tenmed = tenmed + 1
    IF rhealth > 3 AND rhealth <= 6 THEN LET infectheal = infectheal + 1
    IF rhealth = 7 THEN LET fiftymed = fiftymed + 1
    IF rhealth = 8 THEN LET fullmed = fullmed + 1
    IF rhealth >= 9 THEN LET infectprotect = infectprotect + 1
    LET notif$ = "You Find Health"
    LET notifon = 1
    LET notift = ctime
    LET notifc = 14
    LET dropoffs = dropoffs - 1
    RETURN
END IF
REM WEAPON ITEM
IF rand1 = 7 OR rand1 = 8 THEN
    LET rhealth = INT(RND * 9) + 1
    IF rhealth <= 3 THEN LET shotgun = shotgun + 1
    IF rhealth > 3 AND rhealth <= 6 THEN LET flareg = flareg + 1
    IF rhealth > 6 THEN LET knife = knife + 1
    LET notif$ = "You Find Weapons"
    LET notifon = 1
    LET notift = ctime
    LET notifc = 15
    LET dropoffs = dropoffs - 1
    RETURN
END IF
REM OTHER ITEM
IF rand1 = 9 THEN
    LET rhealth = INT(RND * 9) + 1
    IF rhealth <= 3 THEN LET flare = flare + 1
    IF rhealth > 3 AND rhealth <= 6 THEN LET pills = pills + 1
    IF rhealth = 7 THEN LET armour = armour + 1
    IF rhealth = 8 THEN LET bezerk = bezerk + 1
    IF rhealth >= 9 THEN LET adrenaline = adrenaline + 1
    LET notif$ = "You Find Other Item"
    LET notifon = 1
    LET notift = ctime
    LET notifc = 19
    LET dropoffs = dropoffs - 1
    RETURN
END IF
REM SPECIAL ITEM
IF rand1 = 10 OR rand1 = 11 OR rand1 = 12 THEN
    LET rhealth = INT(RND * 9) + 1
    IF rhealth <= 5 THEN LET keys = keys + 1
    IF rhealth > 5 AND rhealth <= 9 THEN LET skeys = skeys + 1
    IF rhealth = 10 THEN LET sbezerk = sbezerk + 1
    LET notif$ = "You Find Special Item"
    LET notifon = 1
    LET notift = ctime
    LET notifc = 21
    LET dropoffs = dropoffs - 1
    RETURN
END IF

noitem2:
REM Code for when no item in container object
LET notif$ = "Nothing Found"
LET notifon = 1
LET notift = ctime
LET notifc = 13
RETURN

usetype1:
REM Use Code for Furniture Items
IF useitem = 1 THEN GOSUB unuse1: RETURN
LET youx = usexc
LET youy = useyc
LET useitem = 1
LET hidetime1 = ctime
GOSUB drawyou
RETURN

unuse1:
REM Unuse's Items
LET youx = cyoux
LET youy = cyouy
LET useitem = 0
LET hidetime2 = hidetime2 + (ctime - hidetime1)
GOSUB drawyou
RETURN

vending:
REM Vending Machine Menu
LET dmenu = 1: LET dmenua = 14
menuloop1:
REM Draws Menu
LINE (320 - xbox, 240 - ybox)-(320 + xbox, 240 + ybox), mcolor, BF
LINE ((320 - xbox) + 30, (240 - ybox) + 30)-((320 + xbox) - 30, (240 + ybox) - 30), 0, BF
REM Menu Data
REM Vending Machine Menu
IF dmenu = 1 THEN
    LOCATE 12, 20: COLOR 12: PRINT "VENDING MACHINE!"
    LOCATE 12, 50: COLOR 10: PRINT "MONEY: "; money
    LOCATE 14, 20: COLOR 15: PRINT "Buy Health"
    LOCATE 18, 20: COLOR 15: PRINT "Buy Other"
    LOCATE 16, 20: PRINT "Buy Weapons"
    DO
        REM Timer Protocal
        GOSUB timerfunction
        LOCATE 2, 1: COLOR 15: PRINT "WAVE: "; wave
        LOCATE dmenua, 40: COLOR 10: PRINT "<--"
        LET m$ = UCASE$(INKEY$)
        IF m$ = CHR$(0) + CHR$(72) THEN LOCATE dmenua, 40: PRINT "   ": LET dmenua = dmenua - 2
        IF m$ = CHR$(0) + CHR$(80) THEN LOCATE dmenua, 40: PRINT "   ": LET dmenua = dmenua + 2
        IF m$ = CHR$(27) THEN
            CLS
            LET yskipx = 0: LET yskipy = 0
            GOSUB map
            GOSUB drawyou
            RETURN
        END IF
        IF dmenua < 14 THEN LET dmenua = 14
        IF dmenua > 18 THEN LET dmenua = 18
    LOOP UNTIL m$ = " "
    IF dmenua = 14 THEN LET dmenu = 2
    IF dmenua = 16 THEN LET dmenu = 3: LET dmenua = 14
    IF dmenua = 18 THEN LET dmenu = 4: LET dmenua = 14
    GOTO menuloop1
END IF
REM Buy Health Menu
IF dmenu = 2 THEN
    LOCATE 12, 20: COLOR 12: PRINT "BUY HEALTH!"
    LOCATE 12, 50: COLOR 10: PRINT "MONEY: "; money
    COLOR 15: IF money < 25 THEN COLOR 8
    LOCATE 14, 20: PRINT "10 Health - 25"
    COLOR 15: IF money < 50 THEN COLOR 8
    LOCATE 15, 20: PRINT "50 Health - 50"
    COLOR 15: IF money < 100 THEN COLOR 8
    LOCATE 16, 20: PRINT "Full Health - 100"
    COLOR 15: IF money < 10 THEN COLOR 8
    LOCATE 17, 20: PRINT "Infection Heal - 10"
    COLOR 15: IF money < 50 THEN COLOR 8
    LOCATE 18, 20: PRINT "Infect-Protect - 50"
    DO
        REM Timer Protocal
        GOSUB timerfunction
        LOCATE 2, 1: COLOR 15: PRINT "WAVE: "; wave
        LOCATE dmenua, 40: COLOR 10: PRINT "<--"
        LET m$ = UCASE$(INKEY$)
        IF m$ = CHR$(0) + CHR$(72) THEN LOCATE dmenua, 40: PRINT "   ": LET dmenua = dmenua - 1
        IF m$ = CHR$(0) + CHR$(80) THEN LOCATE dmenua, 40: PRINT "   ": LET dmenua = dmenua + 1
        IF m$ = CHR$(27) THEN LET dmenu = 1: LET dmenua = 14: GOTO menuloop1
        IF dmenua < 14 THEN LET dmenua = 14
        IF dmenua > 18 THEN LET dmenua = 18
    LOOP UNTIL m$ = " "
    IF dmenua = 14 THEN
        IF money < 25 THEN GOSUB nomoney: GOTO menuloop1
        LET money = money - 25: LET tenmed = tenmed + 1
    END IF
    IF dmenua = 15 THEN
        IF money < 50 THEN GOSUB nomoney: GOTO menuloop1
        LET money = money - 50: LET fiftymed = fiftymed + 1
    END IF
    IF dmenua = 16 THEN
        IF money < 100 THEN GOSUB nomoney: GOTO menuloop1
        LET money = money - 100: LET fullmed = fullmed + 1
    END IF
    IF dmenua = 17 THEN
        IF money < 10 THEN GOSUB nomoney: GOTO menuloop1
        LET money = money - 10: LET infectheal = infectheal + 1
    END IF
    IF dmenua = 18 THEN
        IF money < 50 THEN GOSUB nomoney: GOTO menuloop1
        LET money = money - 50: LET infectprotect = infectprotect + 1
    END IF
END IF
REM Buy Weapons Menu
IF dmenu = 3 THEN
    LOCATE 12, 20: COLOR 12: PRINT "BUY WEAPONS!"
    LOCATE 12, 50: COLOR 10: PRINT "MONEY: "; money
    REM COLOR 15: IF money < 5 THEN COLOR 8
    REM LOCATE 14, 20: PRINT "Snare - 5"
    REM COLOR 15: IF money < 20 THEN COLOR 8
    REM LOCATE 15, 20: PRINT "Explosive Snare - 20"
    COLOR 15: IF money < 50 THEN COLOR 8
    LOCATE 14, 20: PRINT "Flare Gun - 50"
    COLOR 15: IF money < 5 THEN COLOR 8
    LOCATE 16, 20: PRINT "Knife - 5"
    COLOR 15: IF money < 100 THEN COLOR 8
    LOCATE 18, 20: PRINT "Shotgun - 100"
    DO
        REM Timer Protocal
        GOSUB timerfunction
        LOCATE 2, 1: COLOR 15: PRINT "WAVE: "; wave
        LOCATE dmenua, 40: COLOR 10: PRINT "<--"
        LET m$ = UCASE$(INKEY$)
        IF m$ = CHR$(0) + CHR$(72) THEN LOCATE dmenua, 40: PRINT "   ": LET dmenua = dmenua - 2
        IF m$ = CHR$(0) + CHR$(80) THEN LOCATE dmenua, 40: PRINT "   ": LET dmenua = dmenua + 2
        IF m$ = CHR$(27) THEN LET dmenu = 1: LET dmenua = 14: GOTO menuloop1
        IF dmenua < 14 THEN LET dmenua = 14
        IF dmenua > 18 THEN LET dmenua = 18
    LOOP UNTIL m$ = " "
    IF dmenua = 14 THEN
        IF money < 50 THEN GOSUB nomoney: GOTO menuloop1
        LET money = money - 50: LET flareg = flareg + 1
    END IF
    IF dmenua = 16 THEN
        IF money < 5 THEN GOSUB nomoney: GOTO menuloop1
        LET money = money - 5: LET knife = knife + 1
    END IF
    IF dmenua = 18 THEN
        IF money < 100 THEN GOSUB nomoney: GOTO menuloop1
        LET money = money - 100: LET shotgun = shotgun + 1
    END IF
END IF
REM Buy Other Menu
IF dmenu = 4 THEN
    LOCATE 12, 20: COLOR 12: PRINT "BUY OTHER!"
    LOCATE 12, 50: COLOR 10: PRINT "MONEY: "; money
    COLOR 15: IF money < 75 THEN COLOR 8
    LOCATE 14, 20: PRINT "Armour - 75"
    COLOR 15: IF money < 50 THEN COLOR 8
    LOCATE 15, 20: PRINT "Adrenaline - 50"
    COLOR 15: IF money < 50 THEN COLOR 8
    LOCATE 16, 20: PRINT "Pills - 50"
    COLOR 15: IF money < 30 THEN COLOR 8
    LOCATE 17, 20: PRINT "Flare - 30"
    COLOR 15: IF money < 150 THEN COLOR 8
    LOCATE 18, 20: PRINT "Bezerk - 150"
    DO
        REM Timer Protocal
        GOSUB timerfunction
        LOCATE 2, 1: COLOR 15: PRINT "WAVE: "; wave
        LOCATE dmenua, 40: COLOR 10: PRINT "<--"
        LET m$ = UCASE$(INKEY$)
        IF m$ = CHR$(0) + CHR$(72) THEN LOCATE dmenua, 40: PRINT "   ": LET dmenua = dmenua - 1
        IF m$ = CHR$(0) + CHR$(80) THEN LOCATE dmenua, 40: PRINT "   ": LET dmenua = dmenua + 1
        IF m$ = CHR$(27) THEN LET dmenu = 1: LET dmenua = 14: GOTO menuloop1
        IF dmenua < 14 THEN LET dmenua = 14
        IF dmenua > 18 THEN LET dmenua = 18
    LOOP UNTIL m$ = " "
    IF dmenua = 14 THEN
        IF money < 75 THEN GOSUB nomoney: GOTO menuloop1
        LET money = money - 75: LET armour = armour + 1
    END IF
    IF dmenua = 15 THEN
        IF money < 50 THEN GOSUB nomoney: GOTO menuloop1
        LET money = money - 50: LET adrenaline = adrenaline + 1
    END IF
    IF dmenua = 16 THEN
        IF money < 50 THEN GOSUB nomoney: GOTO menuloop1
        LET money = money - 50: LET pills = pills + 1
    END IF
    IF dmenua = 17 THEN
        IF money < 30 THEN GOSUB nomoney: GOTO menuloop1
        LET money = money - 30: LET flare = flare + 1
    END IF
    IF dmenua = 18 THEN
        IF money < 150 THEN GOSUB nomoney: GOTO menuloop1
        LET money = money - 150: LET bezerk = bezerk + 1
    END IF
END IF
GOTO menuloop1

inventory:
REM Displays Inventory
LET dmenu = 1: LET dmenua = 14
LET hidetime1 = ctime
LET inventorytime = ctime
menuloop2:
REM Draws Menu
LINE (320 - xbox, 240 - ybox)-(320 + xbox, 240 + ybox), mcolor, BF
LINE ((320 - xbox) + 30, (240 - ybox) + 30)-((320 + xbox) - 30, (240 + ybox) - 30), 0, BF
REM Menu Data
REM Inventory Menu
IF dmenu = 1 THEN
    LOCATE 12, 20: COLOR 12: PRINT "INVENTORY!"
    LOCATE 12, 50: COLOR 10: PRINT "MONEY: "; money
    LOCATE 14, 20: COLOR 15: PRINT "Health Items"
    LOCATE 15, 20: PRINT "Weapon Items"
    LOCATE 16, 20: COLOR 15: PRINT "Other Items"
    LOCATE 17, 20: COLOR 15: PRINT "Special Items"
    DO
        REM Timer Protocal
        GOSUB timerfunction
        LOCATE dmenua, 40: COLOR 10: PRINT "<--"
        LET m$ = UCASE$(INKEY$)
        IF m$ = CHR$(0) + CHR$(72) THEN LOCATE dmenua, 40: PRINT "   ": LET dmenua = dmenua - 1
        IF m$ = CHR$(0) + CHR$(80) THEN LOCATE dmenua, 40: PRINT "   ": LET dmenua = dmenua + 1
        IF m$ = CHR$(27) THEN
            CLS
            LET yskipx = 0: LET yskipy = 0
            LET hidetime2 = hidetime2 + (ctime - hidetime1)
            LET ctime = ctime - inventorytime2
            LET inventorytime = 0: LET inventorytime2 = 0
            GOSUB map
            GOSUB drawyou
            RETURN
        END IF
        IF dmenua < 14 THEN LET dmenua = 14
        IF dmenua > 17 THEN LET dmenua = 17
    LOOP UNTIL m$ = " "
    IF dmenua = 14 THEN LET dmenu = 2
    IF dmenua = 15 THEN LET dmenu = 3: LET dmenua = 14
    IF dmenua = 16 THEN LET dmenu = 4: LET dmenua = 14
    IF dmenua = 17 THEN LET dmenu = 5: LET dmenua = 14
    GOTO menuloop2
END IF
REM Special Menu
IF dmenu = 5 THEN
    LOCATE 12, 20: COLOR 12: PRINT "SPECIAL ITEMS!"
    LOCATE 12, 50: COLOR 10: PRINT "MONEY: "; money
    COLOR 15: IF keys < 1 THEN COLOR 8: LOCATE 14, 20: PRINT "#### ###": GOTO mskip1:
    LOCATE 14, 20: PRINT "Door Key"
    mskip1: COLOR 15: IF skeys < 1 THEN COLOR 8: LOCATE 15, 20: PRINT "#### ###": GOTO mskip2
    LOCATE 15, 20: PRINT "Shed Key"
    mskip2: COLOR 15: IF ckeys < 1 THEN COLOR 8: LOCATE 16, 20: PRINT "### ###": GOTO mskip3
    LOCATE 16, 20: PRINT "Car Key"
    mskip3: COLOR 15: IF bfg < 1 THEN COLOR 8: LOCATE 17, 20: PRINT "### ##": GOTO mskip4
    LOCATE 17, 20: PRINT "BFG 9K"
    mskip4: COLOR 15: IF sbezerk < 1 THEN COLOR 8: LOCATE 18, 20: PRINT "##### ######": GOTO mskip5
    LOCATE 18, 20: PRINT "Super Bezerk"
    mskip5:
    DO
        LOCATE dmenua, 40: COLOR 10: PRINT "<--"
        LET m$ = UCASE$(INKEY$)
        IF m$ = CHR$(0) + CHR$(72) THEN LOCATE dmenua, 40: PRINT "   ": LET dmenua = dmenua - 1
        IF m$ = CHR$(0) + CHR$(80) THEN LOCATE dmenua, 40: PRINT "   ": LET dmenua = dmenua + 1
        IF m$ = CHR$(27) THEN LET dmenu = 1: LET dmenua = 14: GOTO menuloop2
        IF dmenua < 14 THEN LET dmenua = 14
        IF dmenua > 18 THEN LET dmenua = 18
    LOOP UNTIL m$ = " "
    IF dmenua = 14 THEN
        IF keys < 1 THEN GOSUB noitem: GOTO menuloop2
        REM LET keys = keys - 1
        CLS
        LET yskipx = 0: LET yskipy = 0
        GOSUB map
        GOSUB drawyou
        RETURN
    END IF
    IF dmenua = 15 THEN
        IF skeys < 1 THEN GOSUB noitem: GOTO menuloop2
        REM LET skeys = skeys - 1
        CLS
        LET yskipx = 0: LET yskipy = 0
        GOSUB map
        GOSUB drawyou
        RETURN
    END IF
    IF dmenua = 16 THEN
        IF ckeys < 1 THEN GOSUB noitem: GOTO menuloop2
        REM LET ckeys = ckeys - 1
        CLS
        LET yskipx = 0: LET yskipy = 0
        GOSUB map
        GOSUB drawyou
        RETURN
    END IF
    IF dmenua = 17 THEN
        IF bfg < 1 THEN GOSUB noitem: GOTO menuloop2
        LET bfg = bfg - 1
        LET notif$ = "BOOOOOOOOOOOOOOOOOM!"
        LET notifon = 2
        LET notift = ctime
        LET notifc = 20
        LET usebfg = 1
        GOSUB scope
        CLS
        LET yskipx = 0: LET yskipy = 0
        GOSUB map
        GOSUB drawyou
        RETURN
    END IF
    IF dmenua = 18 THEN
        IF sbezerk < 1 THEN GOSUB noitem: GOTO menuloop2
        LET sbezerk = sbezerk - 1
        LET notif$ = "SUPER BEZERK!"
        LET notifon = 2
        LET notift = ctime
        LET notifc = 13
        LET usesbezerk = 1
        CLS
        LET yskipx = 0: LET yskipy = 0
        GOSUB map
        GOSUB drawyou
        RETURN
    END IF
END IF
REM Health Menu
IF dmenu = 2 THEN
    LOCATE 12, 20: COLOR 12: PRINT "HEALTH ITEMS!"
    LOCATE 12, 50: COLOR 10: PRINT "MONEY: "; money
    COLOR 15: IF tenmed < 1 THEN COLOR 8
    LOCATE 14, 20: PRINT "10 Health: "; tenmed
    COLOR 15: IF fiftymed < 1 THEN COLOR 8
    LOCATE 15, 20: PRINT "50 Health: "; fiftymed
    COLOR 15: IF fullmed < 1 THEN COLOR 8
    LOCATE 16, 20: PRINT "Full Health: "; fullmed
    COLOR 15: IF infectheal < 1 THEN COLOR 8
    LOCATE 17, 20: PRINT "Infection Heal: "; infectheal
    COLOR 15: IF infectprotect < 1 THEN COLOR 8
    LOCATE 18, 20: PRINT "Infect-Protect: "; infectprotect
    DO
        LOCATE dmenua, 40: COLOR 10: PRINT "<--"
        LET m$ = UCASE$(INKEY$)
        IF m$ = CHR$(0) + CHR$(72) THEN LOCATE dmenua, 40: PRINT "   ": LET dmenua = dmenua - 1
        IF m$ = CHR$(0) + CHR$(80) THEN LOCATE dmenua, 40: PRINT "   ": LET dmenua = dmenua + 1
        IF m$ = CHR$(27) THEN LET dmenu = 1: LET dmenua = 14: GOTO menuloop2
        IF dmenua < 14 THEN LET dmenua = 14
        IF dmenua > 18 THEN LET dmenua = 18
    LOOP UNTIL m$ = " "
    IF dmenua = 14 THEN
        IF tenmed < 1 THEN GOSUB noitem: GOTO menuloop2
        LET tenmed = tenmed - 1
        LET health = health + 10
        LET notif$ = "10 Health Gained"
        LET notifon = 2
        LET notift = ctime
        LET notifc = 16
        CLS
        LET yskipx = 0: LET yskipy = 0
        GOSUB map
        GOSUB drawyou
        RETURN
    END IF
    IF dmenua = 15 THEN
        IF fiftymed < 1 THEN GOSUB noitem: GOTO menuloop2
        LET fiftymed = fiftymed - 1
        LET health = health + 50
        LET notif$ = "50 Health Gained"
        LET notifon = 2
        LET notift = ctime
        LET notifc = 16
        CLS
        LET yskipx = 0: LET yskipy = 0
        GOSUB map
        GOSUB drawyou
        RETURN
    END IF
    IF dmenua = 16 THEN
        IF fullmed < 1 THEN GOSUB noitem: GOTO menuloop2
        LET fullmed = fullmed - 1
        LET health = 100
        LET notif$ = "Health Fully Restored"
        LET notifon = 2
        LET notift = ctime
        LET notifc = 22
        CLS
        LET yskipx = 0: LET yskipy = 0
        GOSUB map
        GOSUB drawyou
        RETURN
    END IF
    IF dmenua = 17 THEN
        IF infectheal < 1 THEN GOSUB noitem: GOTO menuloop2
        LET infectheal = infectheal - 1
        LET infection = 0
        LET notif$ = "Infection Cured"
        LET notifon = 2
        LET notift = ctime
        LET notifc = 16
        CLS
        LET yskipx = 0: LET yskipy = 0
        GOSUB map
        GOSUB drawyou
        RETURN
    END IF
    IF dmenua = 18 THEN
        IF infectprotect < 1 THEN GOSUB noitem: GOTO menuloop2
        LET infectprotect = infectprotect - 1
        LET infection = 0
        LET infectionprotection = 1
        LET notif$ = "Infect Protection for 1 Minute"
        LET notifon = 2
        LET notift = ctime
        LET notifc = 30
        CLS
        LET yskipx = 0: LET yskipy = 0
        GOSUB map
        GOSUB drawyou
        RETURN
    END IF
END IF
REM Weapons Menu
IF dmenu = 3 THEN
    LOCATE 12, 20: COLOR 12: PRINT "WEAPON ITEMS!"
    LOCATE 12, 50: COLOR 10: PRINT "MONEY: "; money
    COLOR 15: IF flareg < 1 THEN COLOR 8
    LOCATE 14, 20: PRINT "Flare Gun: "; flareg
    COLOR 15: IF knife < 1 THEN COLOR 8
    LOCATE 16, 20: PRINT "Knife: "; knife
    COLOR 15: IF shotgun < 1 THEN COLOR 8
    LOCATE 18, 20: PRINT "Shotgun: "; shotgun
    DO
        LOCATE dmenua, 40: COLOR 10: PRINT "<--"
        LET m$ = UCASE$(INKEY$)
        IF m$ = CHR$(0) + CHR$(72) THEN LOCATE dmenua, 40: PRINT "   ": LET dmenua = dmenua - 2
        IF m$ = CHR$(0) + CHR$(80) THEN LOCATE dmenua, 40: PRINT "   ": LET dmenua = dmenua + 2
        IF m$ = CHR$(27) THEN LET dmenu = 1: LET dmenua = 14: GOTO menuloop2
        IF dmenua < 14 THEN LET dmenua = 14
        IF dmenua > 18 THEN LET dmenua = 18
    LOOP UNTIL m$ = " "
    IF dmenua = 14 THEN
        IF flareg < 1 THEN GOSUB noitem: GOTO menuloop2
        LET flareg = flareg - 1
        LET useflareg = 1
        GOSUB scope
        LET yskipx = 0: LET yskipy = 0
        RETURN
    END IF
    IF dmenua = 16 THEN
        IF knife < 1 THEN GOSUB noitem: GOTO menuloop2
        LET knife = knife - 1
        LET useknife = 1
        GOSUB scope
        LET yskipx = 0: LET yskipy = 0
        RETURN
    END IF
    IF dmenua = 18 THEN
        IF shotgun < 1 THEN GOSUB noitem: GOTO menuloop2
        LET shotgun = shotgun - 1
        LET useshotgun = 1
        GOSUB scope
        LET yskipx = 0: LET yskipy = 0
        RETURN
    END IF
END IF
REM Other Menu
IF dmenu = 4 THEN
    LOCATE 12, 20: COLOR 12: PRINT "OTHER ITEMS!"
    LOCATE 12, 50: COLOR 10: PRINT "MONEY: "; money
    COLOR 15: IF armour < 1 THEN COLOR 8
    LOCATE 14, 20: PRINT "Armour: "; armour
    COLOR 15: IF adrenaline < 1 THEN COLOR 8
    LOCATE 15, 20: PRINT "Adrenaline: "; adrenaline
    COLOR 15: IF pills < 1 THEN COLOR 8
    LOCATE 16, 20: PRINT "Pills: "; pills
    COLOR 15: IF flare < 1 THEN COLOR 8
    LOCATE 17, 20: PRINT "Flare: "; flare
    COLOR 15: IF bezerk < 1 THEN COLOR 8
    LOCATE 18, 20: PRINT "Bezerk: "; bezerk
    DO
        LOCATE dmenua, 40: COLOR 10: PRINT "<--"
        LET m$ = UCASE$(INKEY$)
        IF m$ = CHR$(0) + CHR$(72) THEN LOCATE dmenua, 40: PRINT "   ": LET dmenua = dmenua - 1
        IF m$ = CHR$(0) + CHR$(80) THEN LOCATE dmenua, 40: PRINT "   ": LET dmenua = dmenua + 1
        IF m$ = CHR$(27) THEN LET dmenu = 1: LET dmenua = 14: GOTO menuloop2
        IF dmenua < 14 THEN LET dmenua = 14
        IF dmenua > 18 THEN LET dmenua = 18
    LOOP UNTIL m$ = " "
    IF dmenua = 14 THEN
        IF armour < 1 THEN GOSUB noitem: GOTO menuloop2
        LET armour = armour - 1
        LET usearmour = 1
        LET notif$ = "Armour for 10 Seconds"
        LET notifon = 2
        LET notift = ctime
        LET notifc = 22
        CLS
        LET yskipx = 0: LET yskipy = 0
        GOSUB map
        GOSUB drawyou
        RETURN
    END IF
    IF dmenua = 15 THEN
        IF adrenaline < 1 THEN GOSUB noitem: GOTO menuloop2
        LET adrenaline = adrenaline - 1
        LET useadrenaline = 1
        LET notif$ = "Adrenaline for 20 Seconds"
        LET notifon = 2
        LET notift = ctime
        LET notifc = 25
        LET oldpace = pace
        LET pace = pace * 2
        CLS
        LET yskipx = 0: LET yskipy = 0
        GOSUB map
        GOSUB drawyou
        RETURN
    END IF
    IF dmenua = 16 THEN
        IF pills < 1 THEN GOSUB noitem: GOTO menuloop2
        LET pills = pills - 1
        LET usepills = 1
        LET notif$ = "Pills for 20 Seconds"
        LET notifon = 2
        LET notift = ctime
        LET notifc = 20
        LET zoldpace = zpace
        LET zpace = zpace / 2
        CLS
        LET yskipx = 0: LET yskipy = 0
        GOSUB map
        GOSUB drawyou
        RETURN
    END IF
    IF dmenua = 17 THEN
        IF flare < 1 THEN GOSUB noitem: GOTO menuloop2
        LET flare = flare - 1
        LET useflare = 1
        LET notif$ = "Flare for 30 Seconds"
        LET notifon = 2
        LET notift = ctime
        LET notifc = 20
        CLS
        LET yskipx = 0: LET yskipy = 0
        GOSUB map
        GOSUB drawyou
        RETURN
    END IF
    IF dmenua = 18 THEN
        IF bezerk < 1 THEN GOSUB noitem: GOTO menuloop2
        LET bezerk = bezerk - 1
        LET usebezerk = 1
        LET notif$ = "Bezerk for 20 Seconds"
        LET notifon = 2
        LET notift = ctime
        LET notifc = 20
        LET health = health / 2
        CLS
        LET yskipx = 0: LET yskipy = 0
        GOSUB map
        GOSUB drawyou
        RETURN
    END IF
END IF
GOTO menuloop2

scope:
REM Zombie Killer Algorythm and Weapons Animation
IF zbuffer = 0 THEN
    REM Return for if no zombies present
    CLS
    GOSUB map
    GOSUB drawyou
    LET notif$ = "No Zombies Present -- Ammo Wasted"
    LET notifon = 1
    LET notift = ctime
    LET notifc = 32
    RETURN
END IF
CLS
GOSUB map
GOSUB zombies
GOSUB drawyou
LET scopelooper = 0
LET zombdeath = 0
IF useknife = 1 THEN LET zombdeath = 1: LET anic = 7
IF useflareg = 1 THEN LET zombdeath = 2: LET anic = 14
IF useshotgun = 1 THEN LET zombdeath = 3: LET anic = 6
IF usebfg = 1 THEN LET zombdeath = 4: LET anic = 10
LET useknife = 0: LET useflareg = 0: LET useshotgun = 0: LET usebfg = 0
LET anil = 0
REM Weapon Animations
DO
    LINE (mborderx1, mbordery1)-(mborderx2, mbordery2), anic, BF
    _DELAY 0.1
    CLS
    GOSUB map
    GOSUB drawyou
    GOSUB zombies
    LET anil = anil + 1
LOOP UNTIL anil = zombdeath
REM Zombie Remover
IF mapzomb1 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb2 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb3 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb4 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb5 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb6 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb7 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb8 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb9 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb10 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb11 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb12 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb13 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb14 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb15 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb16 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb17 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb18 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb19 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb20 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb21 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb22 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb23 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb24 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb25 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb26 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb27 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb28 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb29 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb30 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb31 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb32 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb33 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb34 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb35 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb36 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb37 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb38 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb39 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb40 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb41 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb42 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb43 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb44 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb45 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb46 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb47 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb48 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb49 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb50 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb51 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb52 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb53 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb54 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb55 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb56 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb57 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb58 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb59 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb60 = mapno THEN
    LET mapzomb60 = 0
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb61 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb62 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb63 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
IF mapzomb64 = mapno THEN
    LET zbuffer = zbuffer - 1
    LET scopelooper = scopelooper + 1
    LET gamepoints = gamepoints + killpoints
    IF scopelooper >= zombdeath THEN GOTO endscope
END IF
endscope:
IF zbuffer < 0 THEN LET zbuffer = 0
CLS
REM Erases Zombie 1
CIRCLE (z1x, z1y), radius + 5, bgcolor
PAINT (z1x, z1y), 0, bgcolor
REM Erases Zombie 2
CIRCLE (z2x, z2y), radius + 5, bgcolor
PAINT (z2x, z2y), 0, bgcolor
REM Erases Zombie 3
CIRCLE (z3x, z3y), radius + 5, bgcolor
PAINT (z3x, z3y), 0, bgcolor
REM Erases Zombie 4
CIRCLE (z4x, z4y), radius + 5, bgcolor
PAINT (z4x, z4y), 0, bgcolor
LET weapfx = 0
LET zombdeath = 0
CLS
GOSUB map
GOSUB drawyou
RETURN

noitem:
LET message = 2
LET message$ = "You don't have that item!"
LET messagec = 26
GOSUB message
LET message = 0
RETURN

nomoney:
LET message = 2
LET message$ = "You don't have enough money!"
LET messagec = 28
GOSUB message
LET message = 0
RETURN

dice:
REM Dice System
REM reset Dice Variables
IF profile$ = "DOOMGUY" THEN RETURN
CLS
LET break = 0
LET tumble = 0
REM Send Notifs
LET message = 2
IF money = 0 THEN
    LET message$ = "You have no money!"
    LET messagec = 18
END IF
IF money > 0 THEN
    LET message$ = "You have little money!"
    LET messagec = 22
END IF
GOSUB message
LET message = 2
LET message$ = "Press space to stop the dice!"
LET messagec = 30
GOSUB message
LET message = 0
REM Dice Loop
DO
    DO
        LET dice$ = UCASE$(INKEY$)
        LET d1 = INT(RND * 6) + 1
        LET d2 = INT(RND * 6) + 1
        GOSUB diceoutline
        IF d1 = 1 THEN GOSUB dice11
        IF d1 = 2 THEN GOSUB dice12
        IF d1 = 3 THEN GOSUB dice13
        IF d1 = 4 THEN GOSUB dice14
        IF d1 = 5 THEN GOSUB dice15
        IF d1 = 6 THEN GOSUB dice16
        IF d2 = 1 THEN GOSUB dice21
        IF d2 = 2 THEN GOSUB dice22
        IF d2 = 3 THEN GOSUB dice23
        IF d2 = 4 THEN GOSUB dice24
        IF d2 = 5 THEN GOSUB dice25
        IF d2 = 6 THEN GOSUB dice26
        IF break = 0 THEN
            LOCATE 25, 25
            PRINT "Press space to stop the dice."
        END IF
        IF dice$ = " " THEN LET break = 1
        _DELAY 0.1
    LOOP UNTIL break = 1
    tumble = tumble + 1
    IF tumble = 1 THEN _DELAY 0.1
    IF tumble = 2 THEN _DELAY 0.3
    IF tumble = 3 THEN _DELAY 0.5
    IF tumble = 4 THEN _DELAY 0.75
    IF tumble = 5 THEN _DELAY 1
LOOP UNTIL tumble = 6
_DELAY 1
COLOR 10
LOCATE 17, 27: PRINT d1
LOCATE 20, 52: PRINT d2
_DELAY 1
COLOR 15
LOCATE 25, 32: PRINT d1; " + "; d2; " = "; d1 + d2
_DELAY 1
LOCATE 26, 32: PRINT d1 + d2; " *  5 = "; (d1 + d2) * 5
COLOR 10
_DELAY 1
LOCATE 27, 30: PRINT "You win "; (d1 + d2) * 5; " money!"
_DELAY 1
LET money = money + ((d1 + d2) * 5)
LET message = 2
LET message$ = "Press space to return!"
LET messagec = 22
GOSUB message
CLS
RETURN
diceoutline:
CLS
LINE (170, 140)-(270, 240), 15, B
LINE (370, 190)-(470, 290), 15, B
PAINT (220, 190), 15
PAINT (420, 240), 15
RETURN
dice11:
CIRCLE (220, 190), 10, 12
PAINT (220, 190), 12
RETURN
dice12:
CIRCLE (185, 155), 10, 12
PAINT (185, 155), 12
CIRCLE (255, 225), 10, 12
PAINT (255, 225), 12
RETURN
dice13:
CIRCLE (185, 155), 10, 12
PAINT (185, 155), 12
CIRCLE (255, 225), 10, 12
PAINT (255, 225), 12
CIRCLE (220, 190), 10, 12
PAINT (220, 190), 12
RETURN
dice14:
CIRCLE (185, 155), 10, 12
PAINT (185, 155), 12
CIRCLE (255, 225), 10, 12
PAINT (255, 225), 12
CIRCLE (255, 155), 10, 12
PAINT (255, 155), 12
CIRCLE (185, 225), 10, 12
PAINT (185, 225), 12
RETURN
dice15:
CIRCLE (220, 190), 10, 12
PAINT (220, 190), 12
CIRCLE (185, 155), 10, 12
PAINT (185, 155), 12
CIRCLE (255, 225), 10, 12
PAINT (255, 225), 12
CIRCLE (255, 155), 10, 12
PAINT (255, 155), 12
CIRCLE (185, 225), 10, 12
PAINT (185, 225), 12
RETURN
dice16:
CIRCLE (195, 155), 10, 12
PAINT (195, 155), 12
CIRCLE (245, 225), 10, 12
PAINT (245, 225), 12
CIRCLE (245, 155), 10, 12
PAINT (245, 155), 12
CIRCLE (195, 225), 10, 12
PAINT (195, 225), 12
CIRCLE (195, 190), 10, 12
PAINT (195, 190), 12
CIRCLE (245, 190), 10, 12
PAINT (245, 190), 12
RETURN
dice21:
CIRCLE (420, 240), 10, 12
PAINT (420, 240), 12
RETURN
dice22:
CIRCLE (385, 205), 10, 12
PAINT (385, 205), 12
CIRCLE (455, 275), 10, 12
PAINT (455, 275), 12
RETURN
dice23:
CIRCLE (385, 205), 10, 12
PAINT (385, 205), 12
CIRCLE (455, 275), 10, 12
PAINT (455, 275), 12
CIRCLE (420, 240), 10, 12
PAINT (420, 240), 12
RETURN
dice24:
CIRCLE (385, 205), 10, 12
PAINT (385, 205), 12
CIRCLE (455, 275), 10, 12
PAINT (455, 275), 12
CIRCLE (455, 205), 10, 12
PAINT (455, 205), 12
CIRCLE (385, 275), 10, 12
PAINT (385, 275), 12
RETURN
dice25:
CIRCLE (420, 240), 10, 12
PAINT (420, 240), 12
CIRCLE (385, 205), 10, 12
PAINT (385, 205), 12
CIRCLE (455, 275), 10, 12
PAINT (455, 275), 12
CIRCLE (455, 205), 10, 12
PAINT (455, 205), 12
CIRCLE (385, 275), 10, 12
PAINT (385, 275), 12
RETURN
dice26:
CIRCLE (395, 205), 10, 12
PAINT (395, 205), 12
CIRCLE (445, 275), 10, 12
PAINT (445, 275), 12
CIRCLE (445, 205), 10, 12
PAINT (445, 205), 12
CIRCLE (395, 275), 10, 12
PAINT (395, 275), 12
CIRCLE (395, 240), 10, 12
PAINT (395, 240), 12
CIRCLE (445, 240), 10, 12
PAINT (445, 240), 12
RETURN

map:
REM VARIABLE MAP ENGINE (VaME)
REM Line positions - DATA
LET z = 0
LET hudlabelc = 0
REM Flush Variables
LET linex1 = 0
LET linex2 = 0
LET liney1 = 0
LET liney2 = 0
LET linec = 0
LET labelc = 0
LET stepd = 0
LET stepa = 0
LET treex = 0
LET treey = 0
LET treec = 0
LET treer = 0
LET xx = 0
LET xy = 0
LET xc = 0
LET usetype = 0
LET usey = 0
LET usex = 0
LET usetypec = 0
LET useyc = 0
LET usexc = 0
LET bgcox = 0
LET bgcoy = 0
LET hudcolor = 15
REM Map Data
DO
    LET z = z + 1
    REM Map decider
    IF mapno = 0 THEN LET map$ = "MISSINGNO"
    IF mapno = 1 THEN GOSUB mapdata1
    IF mapno = 2 THEN GOSUB mapdata2
    IF mapno = 3 THEN GOSUB mapdata3
    IF mapno = 4 THEN GOSUB mapdata4
    IF mapno = 5 THEN GOSUB mapdata5
    IF mapno = 6 THEN GOSUB mapdata6
    IF mapno = 7 THEN GOSUB mapdata7
    IF mapno = 8 THEN GOSUB mapdata8
    IF mapno = 9 THEN GOSUB mapdata9
    IF mapno = 10 THEN GOSUB mapdata10
    IF mapno = 11 THEN GOSUB mapdata11
    IF mapno = 12 THEN GOSUB mapdata12
    IF mapno = 13 THEN GOSUB mapdata13
    IF mapno = 14 THEN GOSUB mapdata14
    IF mapno = 15 THEN GOSUB mapdata15
    IF mapno = 16 THEN GOSUB mapdata16
    IF mapno = 17 THEN GOSUB mapdata17
    IF mapno = 18 THEN GOSUB mapdata18
    IF mapno = 19 THEN GOSUB mapdata19
    IF mapno = 20 THEN GOSUB mapdata20
    IF mapno = 21 THEN GOSUB mapdata21
    IF mapno = 22 THEN GOSUB mapdata22
    IF mapno = 23 THEN GOSUB mapdata23
    IF mapno = 24 THEN GOSUB mapdata24
    IF mapno = 25 THEN GOSUB mapdata25
    IF mapno = 26 THEN GOSUB mapdata26
    REM Draw Lines and Fill Boxes  - ENGINE
    IF objecttype = 7 THEN GOSUB warp
    IF objecttype = 6 THEN GOSUB road
    IF objecttype = 5 THEN GOSUB tree
    IF objecttype = 4 THEN GOSUB steps
    IF objecttype = 3 THEN GOSUB mapexit
    IF objecttype = 2 THEN GOSUB oblong
    IF objecttype = 1 THEN GOSUB border
LOOP UNTIL z = 10
RETURN

tree:
REM Draws Trees
CIRCLE (treex, treey), treer, treec
PAINT (treex, treey), treec
CIRCLE (treex - treer, treey), treer, treec
PAINT (treex - treer, treey), treec
PAINT (treex - (treer + (treer / 2)), treey), treec
CIRCLE (treex + treer, treey), treer, treec
PAINT (treex + treer, treey), treec
PAINT (treex + (treer + (treer / 2)), treey), treec
CIRCLE (treex, treey - treer), treer, treec
PAINT (treex, treey - treer), treec
PAINT (treex, treey - (treer + (treer / 2))), treec
CIRCLE (treex, treey + treer), treer, treec
PAINT (treex, treey + treer), treec
PAINT (treex, treey + (treer + (treer / 2))), treec
REM Avoids Zombie collision
LET t1 = 0: LET t2 = 0
FOR i = (treex - treer * 2) TO (treex + treer * 2)
    IF z1x + zradius = i THEN LET t1 = t1 + 1
    IF z1x - zradius = i THEN LET t1 = t1 + 1
NEXT i
FOR i = (treey - treer * 2) TO (treey + treer * 2)
    IF z1y + zradius = i THEN LET t2 = t2 + 1
    IF z1y - zradius = i THEN LET t2 = t2 + 1
NEXT i
IF t1 >= 1 AND t2 >= 1 THEN
    LET z1x = cz1x
    LET z1y = cz1y
END IF
LET t1 = 0: LET t2 = 0
FOR i = (treex - treer * 2) TO (treex + treer * 2)
    IF z2x + zradius = i THEN LET t1 = t1 + 1
    IF z2x - zradius = i THEN LET t1 = t1 + 1
NEXT i
FOR i = (treey - treer * 2) TO (treey + treer * 2)
    IF z2y + zradius = i THEN LET t2 = t2 + 1
    IF z2y - zradius = i THEN LET t2 = t2 + 1
NEXT i
IF t1 >= 1 AND t2 >= 1 THEN
    LET z2x = cz2x
    LET z2y = cz2y
END IF
LET t1 = 0: LET t2 = 0
FOR i = (treex - treer * 2) TO (treex + treer * 2)
    IF z3x + zradius = i THEN LET t1 = t1 + 1
    IF z3x - zradius = i THEN LET t1 = t1 + 1
NEXT i
FOR i = (treey - treer * 2) TO (treey + treer * 2)
    IF z3y + zradius = i THEN LET t2 = t2 + 1
    IF z3y - zradius = i THEN LET t2 = t2 + 1
NEXT i
IF t1 >= 1 AND t2 >= 1 THEN
    LET z3x = cz3x
    LET z3y = cz3y
END IF
LET t1 = 0: LET t2 = 0
FOR i = (treex - treer * 2) TO (treex + treer * 2)
    IF z4x + zradius = i THEN LET t1 = t1 + 1
    IF z4x - zradius = i THEN LET t1 = t1 + 1
NEXT i
FOR i = (treey - treer * 2) TO (treey + treer * 2)
    IF z4y + zradius = i THEN LET t2 = t2 + 1
    IF z4y - zradius = i THEN LET t2 = t2 + 1
NEXT i
IF t1 >= 1 AND t2 >= 1 THEN
    LET z4x = cz4x
    LET z4y = cz4y
END IF
REM Return for if item is in use
IF useitem = 1 THEN RETURN
REM Avoids Tree Collision
LET t1 = 0: LET t2 = 0
FOR i = (treex - treer * 2) TO (treex + treer * 2)
    IF youx + radius = i THEN LET t1 = t1 + 1
    IF youx - radius = i THEN LET t1 = t1 + 1
NEXT i
FOR i = (treey - treer * 2) TO (treey + treer * 2)
    IF youy + radius = i THEN LET t2 = t2 + 1
    IF youy - radius = i THEN LET t2 = t2 + 1
NEXT i
IF t1 >= 1 AND t2 >= 1 THEN
    LET youx = cyoux
    LET youy = cyouy
END IF
REM Object Highlighting
LET t1 = 0: LET t2 = 0
FOR i = (treex - treer * 2) TO (treex + treer * 2)
    IF youx + (radius * 1.8) = i THEN LET t1 = t1 + 1
    IF youx - (radius * 1.8) = i THEN LET t1 = t1 + 1
NEXT i
FOR i = (treey - treer * 2) TO (treey + treer * 2)
    IF youy + (radius * 1.8) = i THEN LET t2 = t2 + 1
    IF youy - (radius * 1.8) = i THEN LET t2 = t2 + 1
NEXT i
IF t1 >= 1 AND t2 >= 1 THEN
    LET huditemlabel$ = itemlabel$
    LET hudlabelc = labelc
    LET hudcolor = treec
END IF
RETURN

steps:
REM Steps generator
IF stepd = 1 THEN
    LET gap = (linex2 - linex1) / stepa
    FOR u = 1 TO stepa
        LINE (linex1 + (gap * u), liney1)-(linex1 + (gap * u), liney2), 7
        LINE ((linex1 + (gap * u) - 2), liney1)-((linex1 + (gap * u) - 2), liney2), 15
    NEXT u
END IF
IF stepd = 2 THEN
    LET gap = (liney2 - liney1) / stepa
    FOR u = 1 TO stepa
        LINE (linex1, liney1 + (gap * u))-(linex2, liney1 + (gap * u)), 7
        LINE (linex1, (liney1 + (gap * u) - 2))-(linex2, (liney1 + (gap * u) - 2)), 15
    NEXT u
END IF
RETURN

border:
REM Box to be kept within
REM Hollow Box
IF linec = 15 THEN
    LINE (linex1, liney1)-(linex2, liney2), linec, B
    LET bgcolor = 0
END IF
REM Filled Box
IF linec < 15 THEN
    LINE (linex1, liney1)-(linex2, liney2), linec, B
    IF yskipx = youx THEN IF yskipy = youy THEN GOTO anotherdirtybitofcode
    IF bgcox = 0 THEN IF bgcoy = 0 THEN PAINT ((linex1 + 1), (liney1 + 1)), linec
    IF bgcox > 0 THEN IF bgcoy > 0 THEN PAINT (bgcox, bgcoy), linec
    LET bgcolor = linec
END IF
anotherdirtybitofcode:
REM Carrier for Border Containment for weapon animation sprites
LET mborderx1 = linex1
LET mbordery1 = liney1
LET mborderx2 = linex2
LET mbordery2 = liney2
REM Carrier for Zombie Placement
LET zombcx1 = linex1
LET zombcx2 = linex2
LET zombcy1 = liney1
LET zombcy2 = liney2
LET zombcx3 = linex1
LET zombcx4 = linex2
LET zombcy3 = liney1
LET zombcy4 = liney2
REM Zombie Spawn Containment
IF zombiemapper <> mapno THEN
    mapperlooper1:
    IF borderz1 <> mapno THEN
        LET z1x = INT(RND * 640)
        LET z1y = INT(RND * 480)
        LET borderz1 = mapno
    END IF
    IF borderz2 <> mapno THEN
        LET z2x = INT(RND * 640)
        LET z2y = INT(RND * 480)
        LET borderz2 = mapno
    END IF
    IF borderz3 <> mapno THEN
        LET z3x = INT(RND * 640)
        LET z3y = INT(RND * 480)
        LET borderz3 = mapno
    END IF
    IF borderz4 <> mapno THEN
        LET z4x = INT(RND * 640)
        LET z4y = INT(RND * 480)
        LET borderz4 = mapno
    END IF
    IF z1x + zradius < linex1 THEN LET borderz1 = 0: GOTO mapperlooper1
    IF z1x - zradius > linex2 THEN LET borderz1 = 0: GOTO mapperlooper1
    IF z1y + zradius < liney1 THEN LET borderz1 = 0: GOTO mapperlooper1
    IF z1y - zradius > liney2 THEN LET borderz1 = 0: GOTO mapperlooper1
    IF z2x + zradius < linex1 THEN LET borderz2 = 0: GOTO mapperlooper1
    IF z2x - zradius > linex2 THEN LET borderz2 = 0: GOTO mapperlooper1
    IF z2y + zradius < liney1 THEN LET borderz2 = 0: GOTO mapperlooper1
    IF z2y - zradius > liney2 THEN LET borderz2 = 0: GOTO mapperlooper1
    IF z3x + zradius < linex1 THEN LET borderz3 = 0: GOTO mapperlooper1
    IF z3x - zradius > linex2 THEN LET borderz3 = 0: GOTO mapperlooper1
    IF z3y + zradius < liney1 THEN LET borderz3 = 0: GOTO mapperlooper1
    IF z3y - zradius > liney2 THEN LET borderz3 = 0: GOTO mapperlooper1
    IF z4x + zradius < linex1 THEN LET borderz4 = 0: GOTO mapperlooper1
    IF z4x - zradius > linex2 THEN LET borderz4 = 0: GOTO mapperlooper1
    IF z4y + zradius < liney1 THEN LET borderz4 = 0: GOTO mapperlooper1
    IF z4y - zradius > liney2 THEN LET borderz4 = 0: GOTO mapperlooper1
END IF
REM Ensures zombie containment
IF z1x < linex1 + zradius THEN LET z1x = cz1x
IF z1x > linex2 - zradius THEN LET z1x = cz1x
IF z1y < liney1 + zradius THEN LET z1y = cz1y
IF z1y > liney2 - zradius THEN LET z1y = cz1y
IF z2x < linex1 + zradius THEN LET z2x = cz2x
IF z2x > linex2 - zradius THEN LET z2x = cz2x
IF z2y < liney1 + zradius THEN LET z2y = cz2y
IF z2y > liney2 - zradius THEN LET z2y = cz2y
IF z3x < linex1 + zradius THEN LET z3x = cz3x
IF z3x > linex2 - zradius THEN LET z3x = cz3x
IF z3y < liney1 + zradius THEN LET z3y = cz3y
IF z3y > liney2 - zradius THEN LET z3y = cz3y
IF z4x < linex1 + zradius THEN LET z4x = cz4x
IF z4x > linex2 - zradius THEN LET z4x = cz4x
IF z4y < liney1 + zradius THEN LET z4y = cz4y
IF z4y > liney2 - zradius THEN LET z4y = cz4y
IF useitem = 1 THEN RETURN: REM return for if item is in use
REM Ensures player containment
IF youx < linex1 + radius THEN LET youx = cyoux
IF youx > linex2 - radius THEN LET youx = cyoux
IF youy < liney1 + radius THEN LET youy = cyouy
IF youy > liney2 - radius THEN LET youy = cyouy
RETURN

road:
REM Road
IF rtype = 1 THEN
    LET ly = (liney1 + liney2) / 2
    LET lx = (linex1 + linex2) / 6
    LET diff = 3
    FOR ceawl = 1 TO 5
        LINE ((lx * ceawl) - (diff * 3), ly - diff)-((lx * ceawl) + (diff * 3), ly + diff), 15, BF
    NEXT ceawl
END IF
IF rtype = 2 THEN
    LET ly = (liney1 + liney2) / 6
    LET lx = (linex1 + linex2) / 2
    LET diff = 3
    FOR ceawl = 1 TO 5
        LINE ((lx * ceawl) - diff, ly - (diff * 3))-((lx * ceawl) + diff, ly + (diff * 3)), 15, BF
    NEXT ceawl
END IF
REM Return for if item is in use
RETURN

oblong:
REM box to be kept out
REM Draws Box
IF useitem = 0 THEN LINE (linex1, liney1)-(linex2, liney2), linec, BF
IF useitem = 1 THEN
    LINE (linex1, liney1)-(linex2, liney2), linec, B
    PAINT (linex1 + 1, liney1 + 1), linec
END IF
REM Return for if item is in use
REM Object Highlighting
LET by1 = 0: LET by2 = 0
FOR i = linex1 TO linex2
    IF youx + (radius * 1.8) = i THEN LET by1 = by1 + 1:
    IF youx - (radius * 1.8) = i THEN LET by1 = by1 + 1:
NEXT i
FOR i = liney1 TO liney2
    IF youy + (radius * 1.8) = i THEN LET by2 = by2 + 1:
    IF youy - (radius * 1.8) = i THEN LET by2 = by2 + 1:
NEXT i
IF by1 >= 1 AND by2 >= 1 THEN
    LET huditemlabel$ = itemlabel$
    LET hudlabelc = labelc
    LET usetypec = usetype
    LET usexc = usex
    LET useyc = usey
    LET hudcolor = linec
END IF
REM prevents zombie collision
LET by1 = 0: LET by2 = 0: LET bm1 = 0: LET bm2 = 0
FOR i = linex1 TO linex2
    IF z1x + zradius = i THEN LET by1 = by1 + 1:
    IF z1x - zradius = i THEN LET by1 = by1 + 1:
NEXT i
FOR i = liney1 TO liney2
    IF z1y + zradius = i THEN LET by2 = by2 + 1:
    IF z1y - zradius = i THEN LET by2 = by2 + 1:
NEXT i
IF by1 >= 1 AND by2 >= 1 THEN LET z1x = cz1x: LET z1y = cz1y: LET z1c = z1c + 1
LET by1 = 0: LET by2 = 0: LET bm1 = 0: LET bm2 = 0
FOR i = linex1 TO linex2
    IF z2x + zradius = i THEN LET by1 = by1 + 1:
    IF z2x - zradius = i THEN LET by1 = by1 + 1:
NEXT i
FOR i = liney1 TO liney2
    IF z2y + zradius = i THEN LET by2 = by2 + 1:
    IF z2y - zradius = i THEN LET by2 = by2 + 1:
NEXT i
IF by1 >= 1 AND by2 >= 1 THEN LET z2x = cz2x: LET z2y = cz2y: LET z2c = z2c + 1
LET by1 = 0: LET by2 = 0: LET bm1 = 0: LET bm2 = 0
FOR i = linex1 TO linex2
    IF z3x + zradius = i THEN LET by1 = by1 + 1:
    IF z3x - zradius = i THEN LET by1 = by1 + 1:
NEXT i
FOR i = liney1 TO liney2
    IF z3y + zradius = i THEN LET by2 = by2 + 1:
    IF z3y - zradius = i THEN LET by2 = by2 + 1:
NEXT i
IF by1 >= 1 AND by2 >= 1 THEN LET z3x = cz3x: LET z3y = cz3y: LET z3c = z3c + 1
LET by1 = 0: LET by2 = 0: LET bm1 = 0: LET bm2 = 0
FOR i = linex1 TO linex2
    IF z4x + zradius = i THEN LET by1 = by1 + 1:
    IF z4x - zradius = i THEN LET by1 = by1 + 1:
NEXT i
FOR i = liney1 TO liney2
    IF z4y + zradius = i THEN LET by2 = by2 + 1:
    IF z4y - zradius = i THEN LET by2 = by2 + 1:
NEXT i
IF by1 >= 1 AND by2 >= 1 THEN LET z4x = cz4x: LET z4y = cz4y: LET z4c = z4c + 1
IF useitem = 1 THEN RETURN
REM Prevents character clipping
LET by1 = 0: LET by2 = 0: LET bm1 = 0: LET bm2 = 0
FOR i = linex1 TO linex2
    IF youx + radius = i THEN LET by1 = by1 + 1:
    IF youx - radius = i THEN LET by1 = by1 + 1:
NEXT i
FOR i = liney1 TO liney2
    IF youy + radius = i THEN LET by2 = by2 + 1:
    IF youy - radius = i THEN LET by2 = by2 + 1:
NEXT i
IF by1 >= 1 AND by2 >= 1 THEN LET youx = cyoux: LET youy = cyouy
RETURN

warp:
REM WARP
REM Draws Box
LINE (linex1, liney1)-(linex2, liney2), warpco, BF
LET warpco = warpco + 1
IF warpco > 15 THEN LET warpco = 1
REM Return for if item is in use
REM Object Highlighting
LET by1 = 0: LET by2 = 0
FOR i = linex1 TO linex2
    IF youx + (radius * 1.8) = i THEN LET by1 = by1 + 1:
    IF youx - (radius * 1.8) = i THEN LET by1 = by1 + 1:
NEXT i
FOR i = liney1 TO liney2
    IF youy + (radius * 1.8) = i THEN LET by2 = by2 + 1:
    IF youy - (radius * 1.8) = i THEN LET by2 = by2 + 1:
NEXT i
IF by1 >= 1 AND by2 >= 1 THEN
    LET huditemlabel$ = itemlabel$
    LET hudlabelc = labelc
    LET usetypec = usetype
    LET usexc = usex
    LET useyc = usey
    LET hudcolor = linec
END IF
REM prevents zombie collision
LET by1 = 0: LET by2 = 0: LET bm1 = 0: LET bm2 = 0
FOR i = linex1 TO linex2
    IF z1x + zradius = i THEN LET by1 = by1 + 1:
    IF z1x - zradius = i THEN LET by1 = by1 + 1:
NEXT i
FOR i = liney1 TO liney2
    IF z1y + zradius = i THEN LET by2 = by2 + 1:
    IF z1y - zradius = i THEN LET by2 = by2 + 1:
NEXT i
IF by1 >= 1 AND by2 >= 1 THEN LET z1x = cz1x: LET z1y = cz1y: LET z1c = z1c + 1
LET by1 = 0: LET by2 = 0: LET bm1 = 0: LET bm2 = 0
FOR i = linex1 TO linex2
    IF z2x + zradius = i THEN LET by1 = by1 + 1:
    IF z2x - zradius = i THEN LET by1 = by1 + 1:
NEXT i
FOR i = liney1 TO liney2
    IF z2y + zradius = i THEN LET by2 = by2 + 1:
    IF z2y - zradius = i THEN LET by2 = by2 + 1:
NEXT i
IF by1 >= 1 AND by2 >= 1 THEN LET z2x = cz2x: LET z2y = cz2y: LET z2c = z2c + 1
LET by1 = 0: LET by2 = 0: LET bm1 = 0: LET bm2 = 0
FOR i = linex1 TO linex2
    IF z3x + zradius = i THEN LET by1 = by1 + 1:
    IF z3x - zradius = i THEN LET by1 = by1 + 1:
NEXT i
FOR i = liney1 TO liney2
    IF z3y + zradius = i THEN LET by2 = by2 + 1:
    IF z3y - zradius = i THEN LET by2 = by2 + 1:
NEXT i
IF by1 >= 1 AND by2 >= 1 THEN LET z3x = cz3x: LET z3y = cz3y: LET z3c = z3c + 1
LET by1 = 0: LET by2 = 0: LET bm1 = 0: LET bm2 = 0
FOR i = linex1 TO linex2
    IF z4x + zradius = i THEN LET by1 = by1 + 1:
    IF z4x - zradius = i THEN LET by1 = by1 + 1:
NEXT i
FOR i = liney1 TO liney2
    IF z4y + zradius = i THEN LET by2 = by2 + 1:
    IF z4y - zradius = i THEN LET by2 = by2 + 1:
NEXT i
IF by1 >= 1 AND by2 >= 1 THEN LET z4x = cz4x: LET z4y = cz4y: LET z4c = z4c + 1
IF useitem = 1 THEN RETURN
REM Prevents character clipping
LET by1 = 0: LET by2 = 0: LET bm1 = 0: LET bm2 = 0
FOR i = linex1 TO linex2
    IF youx + radius = i THEN LET by1 = by1 + 1:
    IF youx - radius = i THEN LET by1 = by1 + 1:
NEXT i
FOR i = liney1 TO liney2
    IF youy + radius = i THEN LET by2 = by2 + 1:
    IF youy - radius = i THEN LET by2 = by2 + 1:
NEXT i
IF by1 >= 1 AND by2 >= 1 THEN LET youx = cyoux: LET youy = cyouy
RETURN

mapexit:
REM Creates Map Exits
IF exitno = 1 THEN GOSUB exit1
IF exitno = 2 THEN GOSUB exit2
IF exitno = 3 THEN GOSUB exit3
IF exitno = 4 THEN GOSUB exit4
LET ex = 0
RETURN
exit1:
REM Exit 1
IF texit1 = 1 THEN GOTO xleft1
IF texit1 = 2 THEN GOTO xright1
IF texit1 = 3 THEN GOTO yup1
IF texit1 = 4 THEN GOTO ydown1
RETURN
xleft1:
REM Left Hand Side Exit
LINE (xexit1 - 30, yexit1)-(xexit1, yexit1), linec
FOR m = 1 TO 10
    LINE (xexit1 - 15, yexit1 - m)-(xexit1, yexit1), linec
    LINE (xexit1 - 15, yexit1 + m)-(xexit1, yexit1), linec
NEXT m
GOTO endexit1
xright1:
REM Right Hand Side Exit
LINE (xexit1 + 30, yexit1)-(xexit1, yexit1), linec
FOR m = 1 TO 10
    LINE (xexit1 + 15, yexit1 + m)-(xexit1, yexit1), linec
    LINE (xexit1 + 15, yexit1 - m)-(xexit1, yexit1), linec
NEXT m
GOTO endexit1
yup1:
REM Upwards Exit Exit
LINE (xexit1, yexit1 + 30)-(xexit1, yexit1), linec
FOR m = 1 TO 10
    LINE (xexit1 + m, yexit1 + 15)-(xexit1, yexit1), linec
    LINE (xexit1 - m, yexit1 + 15)-(xexit1, yexit1), linec
NEXT m
GOTO endexit1
ydown1:
REM Downwards Exit Exit
LINE (xexit1, yexit1 - 30)-(xexit1, yexit1), linec
FOR m = 1 TO 10
    LINE (xexit1 - m, yexit1 - 15)-(xexit1, yexit1), linec
    LINE (xexit1 + m, yexit1 - 15)-(xexit1, yexit1), linec
NEXT m
GOTO endexit1
endexit1:
IF (youx + radius) >= xexit1 AND (youx - radius) <= (xexit1 + 15) THEN ex = ex + 1
IF (youy + radius) >= (yexit1 - 15) AND (youy - radius) <= (yexit1 + 15) THEN ex = ex + 1
IF ex >= 2 THEN
    LET huditemlabel$ = itemlabel$
    LET hudlabelc = labelc
    LET cexitd1 = exitd1
    LET cexitx1 = exitx1
    LET cexity1 = exity1
    LET cexitno = exitno
    LET hudcolor = linec
END IF
RETURN
exit2:
REM Exit 2
IF texit2 = 1 THEN GOTO xleft2
IF texit2 = 2 THEN GOTO xright2
IF texit2 = 3 THEN GOTO yup2
IF texit2 = 4 THEN GOTO ydown2
RETURN
xleft2:
REM Left Hand Side Exit
LINE (xexit2 - 30, yexit2)-(xexit2, yexit2), linec
FOR m = 1 TO 10
    LINE (xexit2 - 15, yexit2 - m)-(xexit2, yexit2), linec
    LINE (xexit2 - 15, yexit2 + m)-(xexit2, yexit2), linec
NEXT m
GOTO endexit2
xright2:
REM Right Hand Side Exit
LINE (xexit2 + 30, yexit2)-(xexit2, yexit2), linec
FOR m = 1 TO 10
    LINE (xexit2 + 15, yexit2 + m)-(xexit2, yexit2), linec
    LINE (xexit2 + 15, yexit2 - m)-(xexit2, yexit2), linec
NEXT m
GOTO endexit2
yup2:
REM Upwards Exit Exit
LINE (xexit2, yexit2 + 30)-(xexit2, yexit2), linec
FOR m = 1 TO 10
    LINE (xexit2 + m, yexit2 + 15)-(xexit2, yexit2), linec
    LINE (xexit2 - m, yexit2 + 15)-(xexit2, yexit2), linec
NEXT m
GOTO endexit2
ydown2:
REM Downwards Exit Exit
LINE (xexit2, yexit2 - 30)-(xexit2, yexit2), linec
FOR m = 1 TO 10
    LINE (xexit2 - m, yexit2 - 15)-(xexit2, yexit2), linec
    LINE (xexit2 + m, yexit2 - 15)-(xexit2, yexit2), linec
NEXT m
GOTO endexit2
endexit2:
IF (youx + radius) >= xexit2 AND (youx - radius) <= (xexit2 + 15) THEN ex = ex + 1
IF (youy + radius) >= (yexit2 - 15) AND (youy - radius) <= (yexit2 + 15) THEN ex = ex + 1
IF ex >= 2 THEN
    LET huditemlabel$ = itemlabel$
    LET hudlabelc = labelc
    LET cexitd2 = exitd2
    LET cexitx2 = exitx2
    LET cexity2 = exity2
    LET cexitno = exitno
END IF
RETURN
exit3:
REM Exit 3
IF texit3 = 1 THEN GOTO xleft3
IF texit3 = 2 THEN GOTO xright3
IF texit3 = 3 THEN GOTO yup3
IF texit3 = 4 THEN GOTO ydown3
RETURN
xleft3:
REM Left Hand Side Exit
LINE (xexit3 - 30, yexit3)-(xexit3, yexit3), linec
FOR m = 1 TO 10
    LINE (xexit3 - 15, yexit3 - m)-(xexit3, yexit3), linec
    LINE (xexit3 - 15, yexit3 + m)-(xexit3, yexit3), linec
NEXT m
GOTO endexit3
xright3:
REM Right Hand Side Exit
LINE (xexit3 + 30, yexit3)-(xexit3, yexit3), linec
FOR m = 1 TO 10
    LINE (xexit3 + 15, yexit3 + m)-(xexit3, yexit3), linec
    LINE (xexit3 + 15, yexit3 - m)-(xexit3, yexit3), linec
NEXT m
GOTO endexit3
yup3:
REM Upwards Exit Exit
LINE (xexit3, yexit3 + 30)-(xexit3, yexit3), linec
FOR m = 1 TO 10
    LINE (xexit3 + m, yexit3 + 15)-(xexit3, yexit3), linec
    LINE (xexit3 - m, yexit3 + 15)-(xexit3, yexit3), linec
NEXT m
GOTO endexit3
ydown3:
REM Downwards Exit Exit
LINE (xexit3, yexit3 - 30)-(xexit3, yexit3), linec
FOR m = 1 TO 10
    LINE (xexit3 - m, yexit3 - 15)-(xexit3, yexit3), linec
    LINE (xexit3 + m, yexit3 - 15)-(xexit3, yexit3), linec
NEXT m
GOTO endexit3
endexit3:
IF (youx + radius) >= xexit3 AND (youx - radius) <= (xexit3 + 15) THEN ex = ex + 1
IF (youy + radius) >= (yexit3 - 15) AND (youy - radius) <= (yexit3 + 15) THEN ex = ex + 1
IF ex >= 2 THEN
    LET huditemlabel$ = itemlabel$
    LET hudlabelc = labelc
    LET cexitd3 = exitd3
    LET cexitx3 = exitx3
    LET cexity3 = exity3
    LET cexitno = exitno
END IF
RETURN
exit4:
REM Exit 4
IF texit4 = 1 THEN GOTO xleft4
IF texit4 = 2 THEN GOTO xright4
IF texit4 = 3 THEN GOTO yup4
IF texit4 = 4 THEN GOTO ydown4
RETURN
xleft4:
REM Left Hand Side Exit
LINE (xexit4 - 30, yexit4)-(xexit4, yexit4), linec
FOR m = 1 TO 10
    LINE (xexit4 - 15, yexit4 - m)-(xexit4, yexit4), linec
    LINE (xexit4 - 15, yexit4 + m)-(xexit4, yexit4), linec
NEXT m
GOTO endexit4
xright4:
REM Right Hand Side Exit
LINE (xexit4 + 30, yexit4)-(xexit4, yexit4), linec
FOR m = 1 TO 10
    LINE (xexit4 + 15, yexit4 + m)-(xexit4, yexit4), linec
    LINE (xexit4 + 15, yexit4 - m)-(xexit4, yexit4), linec
NEXT m
GOTO endexit4
yup4:
REM Upwards Exit Exit
LINE (xexit4, yexit4 + 30)-(xexit4, yexit4), linec
FOR m = 1 TO 10
    LINE (xexit4 + m, yexit4 + 15)-(xexit4, yexit4), linec
    LINE (xexit4 - m, yexit4 + 15)-(xexit4, yexit4), linec
NEXT m
GOTO endexit4
ydown4:
REM Downwards Exit Exit
LINE (xexit4, yexit4 - 30)-(xexit4, yexit4), linec
FOR m = 1 TO 10
    LINE (xexit4 - m, yexit4 - 15)-(xexit4, yexit4), linec
    LINE (xexit4 + m, yexit4 - 15)-(xexit4, yexit4), linec
NEXT m
GOTO endexit4
endexit4:
IF (youx + radius) >= xexit4 AND (youx - radius) <= (xexit4 + 15) THEN ex = ex + 1
IF (youy + radius) >= (yexit4 - 15) AND (youy - radius) <= (yexit4 + 15) THEN ex = ex + 1
IF ex >= 2 THEN
    LET huditemlabel$ = itemlabel$
    LET hudlabelc = labelc
    LET cexitd4 = exitd4
    LET cexitx4 = exitx4
    LET cexity4 = exity4
    LET cexitno = exitno
END IF
RETURN

mapdata1:
REM Map 1 Data
REM Skips Exit relocation for New Game
LET map$ = "Your Bedroom"
IF z = 1 THEN GOSUB data11
IF z = 2 THEN GOSUB data12
IF z = 3 THEN GOSUB data13
IF z = 4 THEN GOSUB data14
IF z = 5 THEN GOSUB data15
IF z = 6 THEN GOSUB data16
IF z = 7 THEN GOSUB data17
REM IF z = 8 THEN GOSUB data18
REM IF z = 9 THEN GOSUB data19
REM IF z = 10 THEN GOSUB data20
RETURN
data11:
REM Bedroom Walls - BORDER
LET objecttype = 1
LET linex1 = 15: LET liney1 = 105: REM Corner 1
LET linex2 = 625: LET liney2 = 375: REM Corner 2
LET linec = 15: REM Line Colour
RETURN
data12:
REM Desk - OBLONG
LET objecttype = 2
LET linex1 = 20: LET liney1 = 150: REM Corner 1
LET linex2 = 70: LET liney2 = 335: REM Corner 2
LET linec = 6: REM Line Colour
LET itemlabel$ = "Desk": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET usetype = 2
RETURN
data13:
REM Exit Wall 1 - OBLONG
LET objecttype = 2
LET linex1 = 594: LET liney1 = 106: REM Corner 1
LET linex2 = 624: LET liney2 = 215: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN
data14:
REM Exit Wall 2 - OBLONG
LET objecttype = 2
LET linex1 = 594: LET liney1 = 255: REM Corner 1
LET linex2 = 624: LET liney2 = 374: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN
data15:
REM Exit To Stairs - EXIT
LET objecttype = 3
LET yexit1 = 235: LET xexit1 = 610: REM Exit Co-ordinates
LET texit1 = 1: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 2: REM Map number exit leads to
LET exity1 = 215: LET exitx1 = 30: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data16:
REM Bed - OBLONG
LET objecttype = 2
LET linex1 = 170: LET liney1 = 270: REM Corner 1
LET linex2 = 400: LET liney2 = 355: REM Corner 2
LET linec = 9: REM Line Colour
LET itemlabel$ = "Bed": REM Item Label
LET labelc = 3: REM Item Label Character Count
LET usex = 195
LET usey = 310
LET usetype = 1
RETURN
data17:
REM Vending Machine - OBLONG
LET objecttype = 2
LET linex1 = 250: LET liney1 = 106: REM Corner 1
LET linex2 = 310: LET liney2 = 140: REM Corner 2
LET linec = 1: REM Line Colour
LET itemlabel$ = "Vending Machine": REM Item Label
LET labelc = 15: REM Item Label Character Count
LET usetype = 0
RETURN


mapdata2:
REM Map 2 Data
LET map$ = "Stairs"
IF z = 1 THEN GOSUB data21
IF z = 2 THEN GOSUB data22
IF z = 3 THEN GOSUB data23
IF z = 4 THEN GOSUB data24
IF z = 5 THEN GOSUB data25
IF z = 6 THEN GOSUB data26
IF z = 7 THEN GOSUB data27
IF z = 8 THEN GOSUB data28
REM IF z = 9 THEN GOSUB data29
REM IF z = 10 THEN GOSUB data30
RETURN
data21:
REM Stairs Walls - BORDER
LET objecttype = 1
LET linex1 = 15: LET liney1 = 145: REM Corner 1
LET linex2 = 625: LET liney2 = 285: REM Corner 2
LET linec = 15: REM Line Colour
RETURN
data22:
REM Top Stairs Wall 1 - OBLONG
LET objecttype = 2
LET linex1 = 16: LET liney1 = 146: REM Corner 1
LET linex2 = 45: LET liney2 = 190: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN
data23:
REM Top Stairs Wall 2 - OBLONG
LET objecttype = 2
LET linex1 = 16: LET liney1 = 240: REM Corner 1
LET linex2 = 45: LET liney2 = 284: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN
data24:
REM Exit To Bedroom - EXIT
LET objecttype = 3
LET yexit1 = 215: LET xexit1 = 30: REM Exit Co-ordinates
LET texit1 = 2: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 1: REM Map number exit leads to
LET exity1 = 235: LET exitx1 = 610: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data25:
REM Bottom Stairs Wall 1 - OBLONG
LET objecttype = 2
LET linex1 = 595: LET liney1 = 146: REM Corner 1
LET linex2 = 624: LET liney2 = 190: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN
data26:
REM Bottom Stairs Wall 2 - OBLONG
LET objecttype = 2
LET linex1 = 595: LET liney1 = 240: REM Corner 1
LET linex2 = 624: LET liney2 = 284: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN
data27:
REM Exit To Brother's Bedroom - EXIT
LET objecttype = 3
LET yexit2 = 215: LET xexit2 = 610: REM Exit Co-ordinates
LET texit2 = 1: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 3: REM Map number exit leads to
LET exity2 = 360: LET exitx2 = 105: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data28:
REM Stairs - STEPS
LET objecttype = 4
LET linex1 = 50: LET liney1 = 150: REM Corner 1
LET linex2 = 590: LET liney2 = 280: REM Corner 2
LET stepa = 10: REM Amount of Steps
LET stepd = 1: REM Direction of Steps
RETURN

mapdata3:
REM Map 3 Data
LET map$ = "Brother's Bedroom"
IF z = 1 THEN GOSUB data31
IF z = 2 THEN GOSUB data32
IF z = 3 THEN GOSUB data33
IF z = 4 THEN GOSUB data34
IF z = 5 THEN GOSUB data35
IF z = 6 THEN GOSUB data36
IF z = 7 THEN GOSUB data37
IF z = 8 THEN GOSUB data38
REM IF z = 9 THEN GOSUB data39
REM IF z = 10 THEN GOSUB data30
RETURN
data31:
REM Bedroom Walls - BORDER
LET objecttype = 1
LET linex1 = 85: LET liney1 = 105: REM Corner 1
LET linex2 = 535: LET liney2 = 375: REM Corner 2
LET linec = 15: REM Line Colour
RETURN
data32:
REM Exit To Stairs - EXIT
LET objecttype = 3
LET yexit1 = 360: LET xexit1 = 105: REM Exit Co-ordinates
LET texit1 = 4: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 2: REM Map number exit leads to
LET exity1 = 215: LET exitx1 = 610: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data33:
REM Wall - OBLONG
LET objecttype = 2
LET linex1 = 130: LET liney1 = 330: REM Corner 1
LET linex2 = 534: LET liney2 = 374: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN
data34:
REM Exit to Landing - EXIT
LET objecttype = 3
LET yexit2 = 305: LET xexit2 = 530: REM Exit Co-ordinates
LET texit2 = 1: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 4: REM Map number exit leads to
LET exity2 = 235: LET exitx2 = 170: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data35:
REM Side Wall - OBLONG
LET objecttype = 2
LET linex1 = 505: LET liney1 = 106: REM Corner 1
LET linex2 = 534: LET liney2 = 285: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN
data36:
REM Brother's Bed - OBLONG
LET objecttype = 2
LET linex1 = 395: LET liney1 = 125: REM Corner 1
LET linex2 = 490: LET liney2 = 270: REM Corner 2
LET linec = 2: REM Line Colour
LET itemlabel$ = "Brother's Bed": REM Item Label
LET labelc = 13: REM Item Label Character Count
LET usex = 440
LET usey = 150
LET usetype = 1
RETURN
data37:
REM Brother's Desk - OBLONG
LET objecttype = 2
LET linex1 = 200: LET liney1 = 210: REM Corner 1
LET linex2 = 370: LET liney2 = 275: REM Corner 2
LET linec = 6: REM Line Colour
LET itemlabel$ = "Brother's Desk": REM Item Label
LET labelc = 14: REM Item Label Character Count
LET usetype = 2
RETURN
data38:
REM Draws - OBLONG
LET objecttype = 2
LET linex1 = 86: LET liney1 = 106: REM Corner 1
LET linex2 = 135: LET liney2 = 150: REM Corner 2
LET linec = 8: REM Line Colour
LET itemlabel$ = "Draws": REM Item Label
LET labelc = 5: REM Item Label Character Count
LET usetype = 2
RETURN

mapdata4:
REM Map 4 Data
LET map$ = "Landing"
IF z = 1 THEN GOSUB data41
IF z = 2 THEN GOSUB data42
IF z = 3 THEN GOSUB data43
IF z = 4 THEN GOSUB data44
IF z = 5 THEN GOSUB data45
REM IF z = 6 THEN GOSUB data46
REM IF z = 7 THEN GOSUB data47
REM IF z = 8 THEN GOSUB data48
REM IF z = 9 THEN GOSUB data49
REM IF z = 10 THEN GOSUB data40
RETURN
data41:
REM Landing Walls - BORDER
LET objecttype = 1
LET linex1 = 155: LET liney1 = 160: REM Corner 1
LET linex2 = 460: LET liney2 = 310: REM Corner 2
LET linec = 15: REM Line Colour
RETURN
data42:
REM Exit to Brother's Bedroom - EXIT
LET objecttype = 3
LET yexit1 = 235: LET xexit1 = 160: REM Exit Co-ordinates
LET texit1 = 2: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 3: REM Map number exit leads to
LET exity1 = 305: LET exitx1 = 520: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data43:
REM Exit to Parent's Bedroom - EXIT
LET objecttype = 3
LET yexit2 = 165: LET xexit2 = 305: REM Exit Co-ordinates
LET texit2 = 3: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 5: REM Map number exit leads to
LET exity2 = 370: LET exitx2 = 435: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data44:
REM Exit to Bathroom - EXIT
LET objecttype = 3
LET yexit3 = 275: LET xexit3 = 455: REM Exit Co-ordinates
LET texit3 = 1: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd3 = 6: REM Map number exit leads to
LET exity3 = 325: LET exitx3 = 90: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 3: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data45:
REM Exit to Stairs - EXIT
LET objecttype = 3
LET yexit4 = 305: LET xexit4 = 305: REM Exit Co-ordinates
LET texit4 = 4: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd4 = 7: REM Map number exit leads to
LET exity4 = 95: LET exitx4 = 320: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 4: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN

mapdata5:
REM Map 5 Data
LET map$ = "Parent's Bedroom"
IF z = 1 THEN GOSUB data51
IF z = 2 THEN GOSUB data52
IF z = 3 THEN GOSUB data53
IF z = 4 THEN GOSUB data54
IF z = 5 THEN GOSUB data55
IF z = 6 THEN GOSUB data56
REM IF z = 7 THEN GOSUB data57
REM IF z = 8 THEN GOSUB data58
REM IF z = 9 THEN GOSUB data59
REM IF z = 10 THEN GOSUB data50
RETURN
data51:
REM Bedroom Walls - BORDER
LET objecttype = 1
LET linex1 = 65: LET liney1 = 125: REM Corner 1
LET linex2 = 555: LET liney2 = 385: REM Corner 2
LET linec = 15: REM Line Colour
RETURN
data52:
REM Parent's Bed - OBLONG
LET objecttype = 2
LET linex1 = 66: LET liney1 = 190: REM Corner 1
LET linex2 = 355: LET liney2 = 320: REM Corner 2
LET linec = 4: REM Line Colour
LET itemlabel$ = "Parent's Bed": REM Item Label
LET labelc = 11: REM Item Label Character Count
LET usex = 100
LET usey = 250
LET usetype = 1
RETURN
data53:
REM Cabinet 1 - OBLONG
LET objecttype = 2
LET linex1 = 66: LET liney1 = 340: REM Corner 1
LET linex2 = 110: LET liney2 = 384: REM Corner 2
LET linec = 6: REM Line Colour
LET itemlabel$ = "Cabinet": REM Item Label
LET labelc = 7: REM Item Label Character Count
LET usetype = 2
RETURN
data54:
REM Cabinet 2 - OBLONG
LET objecttype = 2
LET linex1 = 66: LET liney1 = 126: REM Corner 1
LET linex2 = 110: LET liney2 = 170: REM Corner 2
LET linec = 6: REM Line Colour
LET itemlabel$ = "Cabinet": REM Item Label
LET labelc = 7: REM Item Label Character Count
LET usetype = 2
RETURN
data55:
REM Exit To Landing - EXIT
LET objecttype = 3
LET yexit1 = 380: LET xexit1 = 435: REM Exit Co-ordinates
LET texit1 = 4: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 4: REM Map number exit leads to
LET exity1 = 180: LET exitx1 = 305: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data56:
REM Cupboard - OBLONG
LET objecttype = 2
LET linex1 = 500: LET liney1 = 126: REM Corner 1
LET linex2 = 554: LET liney2 = 384: REM Corner 2
LET linec = 6: REM Line Colour
LET itemlabel$ = "Cupboard": REM Item Label
LET labelc = 8: REM Item Label Character Count
LET usetype = 2
RETURN

mapdata6:
REM Map 6 Data
LET map$ = "Bathroom"
IF z = 1 THEN GOSUB data61
IF z = 2 THEN GOSUB data62
IF z = 3 THEN GOSUB data63
IF z = 4 THEN GOSUB data64
REM IF z = 5 THEN GOSUB data65
REM IF z = 6 THEN GOSUB data66
REM IF z = 7 THEN GOSUB data67
REM IF z = 8 THEN GOSUB data68
REM IF z = 9 THEN GOSUB data69
REM IF z = 10 THEN GOSUB data60
RETURN
data61:
REM Bathroom Walls - BORDER
LET objecttype = 1
LET linex1 = 75: LET liney1 = 180: REM Corner 1
LET linex2 = 345: LET liney2 = 340: REM Corner 2
LET linec = 15: REM Line Colour
RETURN
data62:
REM Exit To Landing - EXIT
LET objecttype = 3
LET yexit1 = 325: LET xexit1 = 80: REM Exit Co-ordinates
LET texit1 = 2: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 4: REM Map number exit leads to
LET exity1 = 275: LET exitx1 = 445: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data63:
REM Bath - OBLONG
LET objecttype = 2
LET linex1 = 76: LET liney1 = 181: REM Corner 1
LET linex2 = 260: LET liney2 = 250: REM Corner 2
LET linec = 8: REM Line Colour
LET itemlabel$ = "Bath": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET usetype = 1
LET usex = 105
LET usey = 215
RETURN
data64:
REM Toilet - OBLONG
LET objecttype = 2
LET linex1 = 310: LET liney1 = 310: REM Corner 1
LET linex2 = 344: LET liney2 = 339: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "Toilet": REM Item Label
LET labelc = 6: REM Item Label Character Count
LET usetype = 2
RETURN

mapdata7:
REM Map 7 Data
LET map$ = "Stairs"
IF z = 1 THEN GOSUB data71
IF z = 2 THEN GOSUB data72
IF z = 3 THEN GOSUB data73
IF z = 4 THEN GOSUB data74
IF z = 5 THEN GOSUB data75
IF z = 6 THEN GOSUB data76
IF z = 7 THEN GOSUB data77
REM IF z = 8 THEN GOSUB data78
REM IF z = 9 THEN GOSUB data79
REM IF z = 10 THEN GOSUB data70
RETURN
data71:
REM Stairs Walls - BORDER
LET objecttype = 1
LET linex1 = 260: LET liney1 = 80: REM Corner 1
LET linex2 = 375: LET liney2 = 395: REM Corner 2
LET linec = 15: REM Line Colour
RETURN
data72:
REM Top Stairs Wall 1 - OBLONG
LET objecttype = 2
LET linex1 = 261: LET liney1 = 81: REM Corner 1
LET linex2 = 285: LET liney2 = 105: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN
data73:
REM Top Stairs Wall 2 - OBLONG
LET objecttype = 2
LET linex1 = 350: LET liney1 = 81: REM Corner 1
LET linex2 = 374: LET liney2 = 105: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN
data74:
REM Exit to Landing - EXIT
LET objecttype = 3
LET yexit1 = 85: LET xexit1 = 320: REM Exit Co-ordinates
LET texit1 = 3: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 4: REM Map number exit leads to
LET exity1 = 295: LET exitx1 = 305: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data75:
REM Front Door - EXIT
LET objecttype = 3
LET yexit2 = 390: LET xexit2 = 350: REM Exit Co-ordinates
LET texit2 = 4: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 23: REM Map number exit leads to
LET exity2 = 345: LET exitx2 = 100: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 12: REM Exit Colour
LET keyr2 = 1
RETURN
data76:
REM Steps - STEPS
LET objecttype = 4
LET linex1 = 265: LET liney1 = 110: REM Corner 1
LET linex2 = 370: LET liney2 = 365: REM Corner 2
LET stepa = 10: REM Amount of Steps
LET stepd = 2: REM Direction of Steps
RETURN
data77:
REM Exit to Living Room - EXIT
LET objecttype = 3
LET yexit3 = 375: LET xexit3 = 265: REM Exit Co-ordinates
LET texit3 = 2: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd3 = 8: REM Map number exit leads to
LET exity3 = 375: LET exitx3 = 95: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 3: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN

mapdata8:
REM Map 8 Data
LET map$ = "Living Room"
IF z = 1 THEN GOSUB data81
IF z = 2 THEN GOSUB data82
IF z = 3 THEN GOSUB data83
IF z = 4 THEN GOSUB data84
IF z = 5 THEN GOSUB data85
IF z = 6 THEN GOSUB data86
IF z = 7 THEN GOSUB data87
REM IF z = 8 THEN GOSUB data88
IF z = 9 THEN GOSUB data89
REM IF z = 10 THEN GOSUB data80
RETURN
data81:
REM Living Room Walls - BORDER
LET objecttype = 1
LET linex1 = 80: LET liney1 = 90: REM Corner 1
LET linex2 = 540: LET liney2 = 390: REM Corner 2
LET linec = 15: REM Line Colour
RETURN
data82:
REM Exit To Stairs - EXIT
LET objecttype = 3
LET yexit1 = 385: LET xexit1 = 100: REM Exit Co-ordinates
LET texit1 = 4: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 7: REM Map number exit leads to
LET exity1 = 375: LET exitx1 = 275: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data83:
REM Exit to Kitchen - EXIT
LET objecttype = 3
LET yexit2 = 330: LET xexit2 = 535: REM Exit Co-ordinates
LET texit2 = 1: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 9: REM Map number exit leads to
LET exity2 = 345: LET exitx2 = 135: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data84:
REM Sofa 1 - OBLONG
LET objecttype = 2
LET linex1 = 185: LET liney1 = 330: REM Corner 1
LET linex2 = 440: LET liney2 = 385: REM Corner 2
LET linec = 6: REM Line Colour
LET itemlabel$ = "Sofa": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET usetype = 1
LET usex = 305
LET usey = 355
RETURN
data85:
REM Sofa 2 - OBLONG
LET objecttype = 2
LET linex1 = 465: LET liney1 = 170: REM Corner 1
LET linex2 = 535: LET liney2 = 290: REM Corner 2
LET linec = 6: REM Line Colour
LET itemlabel$ = "Sofa": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET usetype = 1
LET usex = 500
LET usey = 230
RETURN
data86:
REM Fireplace - OBLONG
LET objecttype = 2
LET linex1 = 190: LET liney1 = 91: REM Corner 1
LET linex2 = 420: LET liney2 = 120: REM Corner 2
LET linec = 8: REM Line Colour
LET itemlabel$ = "Fireplace": REM Item Label
LET labelc = 9: REM Item Label Character Count
LET usetype = 3
RETURN
data87:
REM TV - OBLONG
LET objecttype = 2
LET linex1 = 85: LET liney1 = 95: REM Corner 1
LET linex2 = 135: LET liney2 = 130: REM Corner 2
LET linec = 3: REM Line Colour
LET itemlabel$ = "TV": REM Item Label
LET labelc = 2: REM Item Label Character Count
LET usetype = 3
RETURN
data88:
REM Chair - OBLONG
LET objecttype = 2
LET linex1 = 135: LET liney1 = 205: REM Corner 1
LET linex2 = 170: LET liney2 = 240: REM Corner 2
LET linec = 6: REM Line Colour
LET itemlabel$ = "Chair": REM Item Label
LET labelc = 5: REM Item Label Character Count
LET usetype = 3
RETURN
data89:
REM Cupboard - OBLONG
LET objecttype = 2
LET linex1 = 490: LET liney1 = 95: REM Corner 1
LET linex2 = 535: LET liney2 = 125: REM Corner 2
LET linec = 7: REM Line Colour
LET itemlabel$ = "Cupboard": REM Item Label
LET labelc = 8: REM Item Label Character Count
LET usetype = 2
RETURN

mapdata9:
REM Map 9 Data
LET map$ = "Kitchen"
IF z = 1 THEN GOSUB data91
IF z = 2 THEN GOSUB data92
IF z = 3 THEN GOSUB data93
IF z = 4 THEN GOSUB data94
IF z = 5 THEN GOSUB data95
IF z = 6 THEN GOSUB data96
IF z = 7 THEN GOSUB data97
IF z = 8 THEN GOSUB data98
IF z = 9 THEN GOSUB data99
REM IF z = 10 THEN GOSUB data90
RETURN
data91:
REM Kitchen Walls - BORDER
LET objecttype = 1
LET linex1 = 120: LET liney1 = 50: REM Corner 1
LET linex2 = 500: LET liney2 = 430: REM Corner 2
LET linec = 15: REM Line Colour
RETURN
data92:
REM Exit to Utility Cupboard - EXIT
LET objecttype = 3
LET yexit1 = 405: LET xexit1 = 125: REM Exit Co-ordinates
LET texit1 = 2: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 10: REM Map number exit leads to
LET exity1 = 195: LET exitx1 = 440: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data93:
REM Exit to Living Room - EXIT
LET objecttype = 3
LET yexit2 = 345: LET xexit2 = 125: REM Exit Co-ordinates
LET texit2 = 2: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 8: REM Map number exit leads to
LET exity2 = 330: LET exitx2 = 525: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data94:
REM Work Surface 1 - OBLONG
LET objecttype = 2
LET linex1 = 121: LET liney1 = 51: REM Corner 1
LET linex2 = 155: LET liney2 = 190: REM Corner 2
LET linec = 6: REM Line Colour
LET itemlabel$ = "Work Top": REM Item Label
LET labelc = 8: REM Item Label Character Count
LET usetype = 2
RETURN
data95:
REM Work Surface 2 - OBLONG
LET objecttype = 2
LET linex1 = 121: LET liney1 = 51: REM Corner 1
LET linex2 = 495: LET liney2 = 80: REM Corner 2
LET linec = 6: REM Line Colour
LET itemlabel$ = "Work Top": REM Item Label
LET labelc = 8: REM Item Label Character Count
LET usetype = 3
RETURN
data96:
REM Work Surface 3 - OBLONG
LET objecttype = 2
LET linex1 = 465: LET liney1 = 51: REM Corner 1
LET linex2 = 499: LET liney2 = 305: REM Corner 2
LET linec = 6: REM Line Colour
LET itemlabel$ = "Work Top": REM Item Label
LET labelc = 8: REM Item Label Character Count
LET usetype = 3
RETURN
data97:
REM Exit to Conservatory - EXIT
LET objecttype = 3
LET yexit3 = 345: LET xexit3 = 495: REM Exit Co-ordinates
LET texit3 = 1: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd3 = 11: REM Map number exit leads to
LET exity3 = 340: LET exitx3 = 95: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 3: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data98:
REM Table - OBLONG
LET objecttype = 2
LET linex1 = 210: LET liney1 = 345: REM Corner 1
LET linex2 = 415: LET liney2 = 405: REM Corner 2
LET linec = 7: REM Line Colour
LET itemlabel$ = "Table": REM Item Label
LET labelc = 5: REM Item Label Character Count
LET usetype = 3
RETURN
data99:
REM Fridge - OBLONG
LET objecttype = 2
LET linex1 = 121: LET liney1 = 235: REM Corner 1
LET linex2 = 155: LET liney2 = 290: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "Fridge": REM Item Label
LET labelc = 6: REM Item Label Character Count
LET usetype = 2
RETURN

mapdata10:
REM Map 10 Data
LET map$ = "Utility Cupboard"
IF z = 1 THEN GOSUB data101
IF z = 2 THEN GOSUB data102
REM IF z = 3 THEN GOSUB data103
REM IF z = 4 THEN GOSUB data104
REM IF z = 5 THEN GOSUB data105
REM IF z = 6 THEN GOSUB data106
REM IF z = 7 THEN GOSUB data107
REM IF z = 8 THEN GOSUB data108
REM IF z = 9 THEN GOSUB data109
REM IF z = 10 THEN GOSUB data100
RETURN
data101:
REM Cupboard Walls - BORDER
LET objecttype = 1
LET linex1 = 285: LET liney1 = 155: REM Corner 1
LET linex2 = 455: LET liney2 = 230: REM Corner 2
LET linec = 15: REM Line Colour
RETURN
data102:
REM Exit to Kitchen - EXIT
LET objecttype = 3
LET yexit1 = 195: LET xexit1 = 450: REM Exit Co-ordinates
LET texit1 = 1: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 9: REM Map number exit leads to
LET exity1 = 405: LET exitx1 = 135: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN

mapdata11:
REM Map 0 Data
LET map$ = "Conservatory"
IF z = 1 THEN GOSUB data111
IF z = 2 THEN GOSUB data112
IF z = 3 THEN GOSUB data113
IF z = 4 THEN GOSUB data114
IF z = 5 THEN GOSUB data115
IF z = 6 THEN GOSUB data116
IF z = 7 THEN GOSUB data117
IF z = 8 THEN GOSUB data118
REM IF z = 9 THEN GOSUB data119
REM IF z = 10 THEN GOSUB data110
RETURN
data111:
REM Conservatory Walls - BORDER
LET objecttype = 1
LET linex1 = 75: LET liney1 = 125: REM Corner 1
LET linex2 = 535: LET liney2 = 370: REM Corner 2
LET linec = 15: REM Line Colour
RETURN
data112:
REM  Exit to Kitchen - EXIT
LET objecttype = 3
LET yexit1 = 340: LET xexit1 = 80: REM Exit Co-ordinates
LET texit1 = 2: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 9: REM Map number exit leads to
LET exity1 = 345: LET exitx1 = 480: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data113:
REM Exit to Decking 1 - EXIT
LET objecttype = 3
LET yexit2 = 245: LET xexit2 = 530: REM Exit Co-ordinates
LET texit2 = 1: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 12: REM Map number exit leads to
LET exity2 = 240: LET exitx2 = 90: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data114:
REM Exit to Decking 2 - EXIT
LET objecttype = 3
LET yexit3 = 265: LET xexit3 = 530: REM Exit Co-ordinates
LET texit3 = 1: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd3 = 12: REM Map number exit leads to
LET exity3 = 240: LET exitx3 = 90: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 3: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data115:
REM Wall - OBLONG
LET objecttype = 2
LET linex1 = 76: LET liney1 = 126: REM Corner 1
LET linex2 = 115: LET liney2 = 305: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN
data116:
REM Shoe Stand - OBLONG
LET objecttype = 2
LET linex1 = 380: LET liney1 = 330: REM Corner 1
LET linex2 = 530: LET liney2 = 365: REM Corner 2
LET linec = 11: REM Line Colour
LET itemlabel$ = "Shoe Stand": REM Item Label
LET labelc = 10: REM Item Label Character Count
RETURN
data117:
REM Coat Hooks - OBLONG
LET objecttype = 2
LET linex1 = 175: LET liney1 = 355: REM Corner 1
LET linex2 = 255: LET liney2 = 369: REM Corner 2
LET linec = 6: REM Line Colour
LET itemlabel$ = "Coat Hooks": REM Item Label
LET labelc = 10: REM Item Label Character Count
RETURN
data118:
REM Dog Bed - OBLONG
LET objecttype = 2
LET linex1 = 225: LET liney1 = 130: REM Corner 1
LET linex2 = 345: LET liney2 = 190: REM Corner 2
LET linec = 8: REM Line Colour
LET itemlabel$ = "Dog Bed": REM Item Label
LET labelc = 7: REM Item Label Character Count
RETURN

mapdata12:
REM Map 12 Data
LET map$ = "Back Garden"
IF z = 1 THEN GOSUB data121
IF z = 2 THEN GOSUB data122
IF z = 3 THEN GOSUB data123
IF z = 4 THEN GOSUB data124
IF z = 5 THEN GOSUB data125
IF z = 6 THEN GOSUB data126
REM IF z = 7 THEN GOSUB data127
IF z = 8 THEN GOSUB data128
IF z = 9 THEN GOSUB data129
REM IF z = 10 THEN GOSUB data120
RETURN
data121:
REM Garden - BORDER
LET objecttype = 1
LET linex1 = 70: LET liney1 = 120: REM Corner 1
LET linex2 = 570: LET liney2 = 350: REM Corner 2
LET linec = 7: REM Line Colour
LET bgcox = 345: LET bgcoy = 135
RETURN
data122:
REM Exit to Conservatory - EXIT
LET objecttype = 3
LET yexit1 = 240: LET xexit1 = 75: REM Exit Co-ordinates
LET texit1 = 2: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 11: REM Map number exit leads to
LET exity1 = 255: LET exitx1 = 520: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data123:
REM Flower Bed - OBLONG
LET objecttype = 2
LET linex1 = 380: LET liney1 = 121: REM Corner 1
LET linex2 = 569: LET liney2 = 165: REM Corner 2
LET linec = 6: REM Line Colour
LET itemlabel$ = "Flower Bed": REM Item Label
LET labelc = 10: REM Item Label Character Count
RETURN
data124:
REM House Wall 1 - OBLONG
LET objecttype = 2
LET linex1 = 70: LET liney1 = 120: REM Corner 1
LET linex2 = 115: LET liney2 = 210: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN
data125:
REM House Wall 2 - OBLONG
LET objecttype = 2
LET linex1 = 70: LET liney1 = 265: REM Corner 1
LET linex2 = 115: LET liney2 = 350: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN
data126:
REM Decking Wall - OBLONG
LET objecttype = 2
LET linex1 = 115: LET liney1 = 290: REM Corner 1
LET linex2 = 320: LET liney2 = 305: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN
data127:
REM Steps from Decking - STEPS
LET objecttype = 4
LET linex1 = 265: LET liney1 = 120: REM Corner 1
LET linex2 = 320: LET liney2 = 290: REM Corner 2
LET stepa = 5: REM Amount of Steps
LET stepd = 1: REM Direction of Steps
RETURN
data128:
REM Exit to House 406's Garden - EXIT
LET objecttype = 3
LET yexit2 = 125: LET xexit2 = 145: REM Exit Co-ordinates
LET texit2 = 3: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 15: REM Map number exit leads to
LET exity2 = 375: LET exitx2 = 195: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data129:
REM Exit to Back Field - EXIT
LET objecttype = 3
LET yexit3 = 280: LET xexit3 = 565: REM Exit Co-ordinates
LET texit3 = 1: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd3 = 13: REM Map number exit leads to
LET exity3 = 360: LET exitx3 = 25: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 3: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN

mapdata13:
REM Map 13 Data
LET map$ = "Back Feild"
IF z = 1 THEN GOSUB data131
IF z = 2 THEN GOSUB data132
IF z = 3 THEN GOSUB data133
IF z = 4 THEN GOSUB data134
IF z = 5 THEN GOSUB data135
IF z = 6 THEN GOSUB data136
IF z = 7 THEN GOSUB data137
IF z = 8 THEN GOSUB data138
IF z = 9 THEN GOSUB data139
IF z = 10 THEN GOSUB data130
RETURN
data131:
REM Field Border - BORDER
LET objecttype = 1
LET linex1 = 10: LET liney1 = 80: REM Corner 1
LET linex2 = 630: LET liney2 = 410: REM Corner 2
LET linec = 2: REM Line Colour
RETURN
data132:
REM Exit to Back Garden - EXIT
LET objecttype = 3
LET yexit1 = 360: LET xexit1 = 15 REM Exit Co-ordinates
LET texit1 = 2: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 12: REM Map number exit leads to
LET exity1 = 280: LET exitx1 = 555: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data133:
REM Fence - OBLONG
LET objecttype = 2
LET linex1 = 11: LET liney1 = 225: REM Corner 1
LET linex2 = 285: LET liney2 = 250: REM Corner 2
LET linec = 6: REM Line Colour
LET itemlabel$ = "Fence": REM Item Label
LET labelc = 5: REM Item Label Character Count
RETURN
data134:
REM Shed 1 - OBLONG
LET objecttype = 2
LET linex1 = 185: LET liney1 = 315: REM Corner 1
LET linex2 = 415: LET liney2 = 405: REM Corner 2
LET linec = 8: REM Line Colour
LET itemlabel$ = "Shed": REM Item Label
LET labelc = 4: REM Item Label Character Count
RETURN
data135:
REM Shed 2 - OBLONG
LET objecttype = 2
LET linex1 = 215: LET liney1 = 140: REM Corner 1
LET linex2 = 285: LET liney2 = 220: REM Corner 2
LET linec = 7: REM Line Colour
LET itemlabel$ = "Shed": REM Item Label
LET labelc = 4: REM Item Label Character Count
RETURN
data136:
REM Exit to Grandma's Back Garden - EXIT
LET objecttype = 3
LET yexit2 = 160: LET xexit2 = 15: REM Exit Co-ordinates
LET texit2 = 2: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 15: REM Map number exit leads to
LET exity2 = 360: LET exitx2 = 580: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data137:
REM Exit to Woods - EXIT
LET objecttype = 3
LET yexit3 = 105: LET xexit3 = 625: REM Exit Co-ordinates
LET texit3 = 1: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd3 = 16: REM Map number exit leads to
LET exity3 = 405: LET exitx3 = 70: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 3: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data138:
REM Exit to Shed - EXIT
LET objecttype = 3
LET yexit4 = 135: LET xexit4 = 250: REM Exit Co-ordinates
LET texit4 = 4: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd4 = 14: REM Map number exit leads to
LET exity4 = 205: LET exitx4 = 350: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 4: REM Exit Number 1-4
LET linec = 12: REM Exit Colour
LET keyr4 = 1
RETURN
data139:
REM Tree - TREE
LET objecttype = 5
LET treex = 575: LET treey = 350: REM Tree Co-ordinates
LET treec = 10: REM Tree Colour
LET treer = 25: REM Tree radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data130:
REM Tree 2 - TREE
LET objecttype = 5
LET treex = 585: LET treey = 220: REM Tree Co-ordinates
LET treec = 10: REM Tree Colour
LET treer = 10: REM Tree radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN

mapdata14:
REM Map 14 Data
LET map$ = "Shed"
IF z = 1 THEN GOSUB data141
IF z = 2 THEN GOSUB data142
IF z = 3 THEN GOSUB data143
REM IF z = 4 THEN GOSUB data144
REM IF z = 5 THEN GOSUB data145
REM IF z = 6 THEN GOSUB data146
REM IF z = 7 THEN GOSUB data147
REM IF z = 8 THEN GOSUB data148
REM IF z = 9 THEN GOSUB data149
REM IF z = 10 THEN GOSUB data140
RETURN
data141:
REM Shed - BORDER
LET objecttype = 1
LET linex1 = 170: LET liney1 = 140: REM Corner 1
LET linex2 = 365: LET liney2 = 270: REM Corner 2
LET linec = 6: REM Line Colour
RETURN
data142:
REM Exit to Back Field - EXIT
LET objecttype = 3
LET yexit1 = 205: LET xexit1 = 360: REM Exit Co-ordinates
LET texit1 = 1: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 13: REM Map number exit leads to
LET exity1 = 120: LET exitx1 = 245: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 12: REM Exit Colour
LET keyr1 = 1
RETURN
data143:
REM WARP - WARP
LET objecttype = 7
LET linex1 = 171: LET liney1 = 141: REM Corner 1
LET linex2 = 220: LET liney2 = 190: REM Corner 2
LET itemlabel$ = "WARP": REM Item Label
LET labelc = 4: REM Item Label Character Count
RETURN

mapdata15:
REM Map 15 Data
LET map$ = "406's Back Garden"
IF z = 1 THEN GOSUB data151
IF z = 2 THEN GOSUB data152
IF z = 3 THEN GOSUB data153
IF z = 4 THEN GOSUB data154
IF z = 5 THEN GOSUB data155
IF z = 6 THEN GOSUB data156
IF z = 7 THEN GOSUB data157
IF z = 8 THEN GOSUB data158
REM IF z = 9 THEN GOSUB data159
REM IF z = 10 THEN GOSUB data150
RETURN
data151:
REM Garden Border - BORDER
LET objecttype = 1
LET linex1 = 75: LET liney1 = 105: REM Corner 1
LET linex2 = 595: LET liney2 = 390: REM Corner 2
LET linec = 8: REM Line Colour
RETURN
data152:
REM 406's House - OBLONG
LET objecttype = 2
LET linex1 = 76: LET liney1 = 175: REM Corner 1
LET linex2 = 160: LET liney2 = 389: REM Corner 2
LET linec = 7: REM Line Colour
LET itemlabel$ = "406's House": REM Item Label
LET labelc = 11: REM Item Label Character Count
RETURN
data153:
REM Exit to Garden - EXIT
LET objecttype = 3
LET yexit1 = 385: LET xexit1 = 195: REM Exit Co-ordinates
LET texit1 = 4: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 12: REM Map number exit leads to
LET exity1 = 145: LET exitx1 = 145: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data154:
REM Exit to Road - EXIT
LET objecttype = 3
LET yexit2 = 140: LET xexit2 = 80: REM Exit Co-ordinates
LET texit2 = 2: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 23: REM Map number exit leads to
LET exity2 = 400: LET exitx2 = 350: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data155:
REM Exit to Back Field - EXIT
LET objecttype = 3
LET yexit3 = 360: LET xexit3 = 590: REM Exit Co-ordinates
LET texit3 = 1: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd3 = 13: REM Map number exit leads to
LET exity3 = 160: LET exitx3 = 25: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 3: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data156:
REM Grandma's Garage - OBLONG
LET objecttype = 2
LET linex1 = 466: LET liney1 = 110: REM Corner 1
LET linex2 = 590: LET liney2 = 324: REM Corner 2
LET linec = 6: REM Line Colour
LET itemlabel$ = "Garage": REM Item Label
LET labelc = 6: REM Item Label Character Count
RETURN
data157:
REM Car - OBLONG
LET objecttype = 2
LET linex1 = 280: LET liney1 = 155: REM Corner 1
LET linex2 = 405: LET liney2 = 225: REM Corner 2
LET linec = 12: REM Line Colour
LET itemlabel$ = "Car": REM Item Label
LET labelc = 3: REM Item Label Character Count
RETURN
data158:
REM Exit to Grandma's Kitchen - EXIT
LET objecttype = 3
LET yexit4 = 170: LET xexit4 = 135: REM Exit Co-ordinates
LET texit4 = 4: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd4 = 24: REM Map number exit leads to
LET exity4 = 380: LET exitx4 = 380: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 4: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
LET keyr = 0
RETURN

mapdata16:
REM Map 16 Data
LET map$ = "Woods"
IF z = 1 THEN GOSUB data161
IF z = 2 THEN GOSUB data162
IF z = 3 THEN GOSUB data163
IF z = 4 THEN GOSUB data164
IF z = 5 THEN GOSUB data165
IF z = 6 THEN GOSUB data166
IF z = 7 THEN GOSUB data167
IF z = 8 THEN GOSUB data168
IF z = 9 THEN GOSUB data169
IF z = 10 THEN GOSUB data160
RETURN
data161:
REM Woods Border - BORDER
LET objecttype = 1
LET linex1 = 50: LET liney1 = 65: REM Corner 1
LET linex2 = 385: LET liney2 = 420: REM Corner 2
LET linec = 6: REM Line Colour
RETURN
data162:
REM Exit to Back Field - EXIT
LET objecttype = 3
LET yexit1 = 415: LET xexit1 = 70: REM Exit Co-ordinates
LET texit1 = 4: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 13: REM Map number exit leads to
LET exity1 = 105: LET exitx1 = 615: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data163:
REM Exit to Woods - EXIT
LET objecttype = 3
LET yexit2 = 70: LET xexit2 = 70: REM Exit Co-ordinates
LET texit2 = 3: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 17: REM Map number exit leads to
LET exity2 = 385: LET exitx2 = 60: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data164:
REM Tree - TREE
LET objecttype = 5
LET treex = 165: LET treey = 130: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 10: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data165:
REM Tree - TREE
LET objecttype = 5
LET treex = 165: LET treey = 240: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 20: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data166:
REM Tree - TREE
LET objecttype = 5
LET treex = 140: LET treey = 335: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 15: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data167:
REM Tree - TREE
LET objecttype = 5
LET treex = 300: LET treey = 345: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 25: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data168:
REM Tree - TREE
LET objecttype = 5
LET treex = 300: LET treey = 170: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 20: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data169:
REM Tree - TREE
LET objecttype = 5
LET treex = 230: LET treey = 105: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 15: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data160:
REM Tree - TREE
LET objecttype = 5
LET treex = 335: LET treey = 255: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 10: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN

mapdata17:
REM Map 17 Data
LET map$ = "Woods"
IF z = 1 THEN GOSUB data171
IF z = 2 THEN GOSUB data172
IF z = 3 THEN GOSUB data173
IF z = 4 THEN GOSUB data174
IF z = 5 THEN GOSUB data175
IF z = 6 THEN GOSUB data176
IF z = 7 THEN GOSUB data177
IF z = 8 THEN GOSUB data178
IF z = 9 THEN GOSUB data179
IF z = 10 THEN GOSUB data170
RETURN
data171:
REM Woods Border - BORDER
LET objecttype = 1
LET linex1 = 35: LET liney1 = 85: REM Corner 1
LET linex2 = 565: LET liney2 = 400: REM Corner 2
LET linec = 6: REM Line Colour
RETURN
data172:
REM Exit to Woods - EXIT
LET objecttype = 3
LET yexit1 = 395: LET xexit1 = 60: REM Exit Co-ordinates
LET texit1 = 4: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 16: REM Map number exit leads to
LET exity1 = 80: LET exitx1 = 70: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data173:
REM Exit to Woods - EXIT
LET objecttype = 3
LET yexit2 = 90: LET xexit2 = 185: REM Exit Co-ordinates
LET texit2 = 3: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 18: REM Map number exit leads to
LET exity2 = 270: LET exitx2 = 80: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data174:
REM Tree - TREE
LET objecttype = 5
LET treex = 85: LET treey = 155: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 15: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data175:
REM Tree - TREE
LET objecttype = 5
LET treex = 350: LET treey = 205: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 30: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data176:
REM Tree - TREE
LET objecttype = 5
LET treex = 475: LET treey = 310: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 20: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data177:
REM Tree - TREE
LET objecttype = 5
LET treex = 495: LET treey = 160: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 10: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data178:
REM Tree - TREE
LET objecttype = 5
LET treex = 170: LET treey = 345: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 17: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data179:
REM Tree - TREE
LET objecttype = 5
LET treex = 185: LET treey = 235: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 10: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data170:
REM Exit to Bush - EXIT
LET objecttype = 3
LET yexit3 = 90: LET xexit3 = 430: REM Exit Co-ordinates
LET texit3 = 3: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd3 = 19: REM Map number exit leads to
LET exity3 = 250: LET exitx3 = 145: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 3: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN

mapdata18:
REM Map 18 Data
LET map$ = "Woods"
IF z = 1 THEN GOSUB data181
IF z = 2 THEN GOSUB data182
IF z = 3 THEN GOSUB data183
IF z = 4 THEN GOSUB data184
IF z = 5 THEN GOSUB data185
IF z = 6 THEN GOSUB data186
IF z = 7 THEN GOSUB data187
IF z = 8 THEN GOSUB data188
IF z = 9 THEN GOSUB data189
IF z = 10 THEN GOSUB data180
RETURN
data181:
REM Woods Border - BORDER
LET objecttype = 1
LET linex1 = 65: LET liney1 = 95: REM Corner 1
LET linex2 = 545: LET liney2 = 390: REM Corner 2
LET linec = 6: REM Line Colour
RETURN
data182:
REM Exit to Woods - EXIT
LET objecttype = 3
LET yexit1 = 270: LET xexit1 = 70: REM Exit Co-ordinates
LET texit1 = 2: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 17: REM Map number exit leads to
LET exity1 = 100: LET exitx1 = 185: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data183:
REM Exit to Bush - EXIT
LET objecttype = 3
LET yexit2 = 385: LET xexit2 = 225: REM Exit Co-ordinates
LET texit2 = 4: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 19: REM Map number exit leads to
LET exity2 = 175: LET exitx2 = 270: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data184:
REM Exit to Park - EXIT
LET objecttype = 3
LET yexit3 = 100: LET xexit3 = 95: REM Exit Co-ordinates
LET texit3 = 3: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd3 = 21: REM Map number exit leads to
LET exity3 = 360: LET exitx3 = 85: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 3: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data185:
REM Exit to Top Field - EXIT
LET objecttype = 3
LET yexit4 = 120: LET xexit4 = 540: REM Exit Co-ordinates
LET texit4 = 1: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd4 = 20: REM Map number exit leads to
LET exity4 = 385: LET exitx4 = 50: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 4: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data186:
REM Tree - TREE
LET objecttype = 5
LET treex = 475: LET treey = 205: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 20: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data187:
REM Tree - TREE
LET objecttype = 5
LET treex = 385: LET treey = 205: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 15: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data188:
REM Tree - TREE
LET objecttype = 5
LET treex = 270: LET treey = 205: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 25: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data189:
REM Tree - TREE
LET objecttype = 5
LET treex = 115: LET treey = 185: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 15: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data180:
REM Tree - TREE
LET objecttype = 5
LET treex = 440: LET treey = 305: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 25: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN

mapdata19:
REM Map 19 Data
LET map$ = "Bush"
IF z = 1 THEN GOSUB data191
IF z = 2 THEN GOSUB data192
IF z = 3 THEN GOSUB data193
IF z = 4 THEN GOSUB data194
IF z = 5 THEN GOSUB data195
IF z = 6 THEN GOSUB data196
IF z = 7 THEN GOSUB data197
IF z = 8 THEN GOSUB data198
IF z = 9 THEN GOSUB data199
REM IF z = 10 THEN GOSUB data190
RETURN
data191:
REM Bush Border - BORDER
LET objecttype = 1
LET linex1 = 130: LET liney1 = 160: REM Corner 1
LET linex2 = 415: LET liney2 = 310: REM Corner 2
LET linec = 6: REM Line Colour
RETURN
data192:
REM Exit to Woods - EXIT
LET objecttype = 3
LET yexit1 = 250: LET xexit1 = 135: REM Exit Co-ordinates
LET texit1 = 2: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 17: REM Map number exit leads to
LET exity1 = 100: LET exitx1 = 430: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data193:
REM Exit to Woods - EXIT
LET objecttype = 3
LET yexit2 = 165: LET xexit2 = 270: REM Exit Co-ordinates
LET texit2 = 3: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 18: REM Map number exit leads to
LET exity2 = 375: LET exitx2 = 225: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data194:
REM Bush - TREE
LET objecttype = 5
LET treex = 380: LET treey = 275: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 10: REM Tree Radius
LET itemlabel$ = "Bush 1"
LET labelc = 6
RETURN
data195:
REM Bush - TREE
LET objecttype = 5
LET treex = 330: LET treey = 280: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 10: REM Tree Radius
LET itemlabel$ = "Bush 2"
LET labelc = 6
RETURN
data196:
REM Bush - TREE
LET objecttype = 5
LET treex = 280: LET treey = 280: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 10: REM Tree Radius
LET itemlabel$ = "Bush 3"
LET labelc = 6
RETURN
data197:
REM Bush - TREE
LET objecttype = 5
LET treex = 225: LET treey = 2800: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 10: REM Tree Radius
LET itemlabel$ = "Bush 4"
LET labelc = 6
RETURN
data198:
REM Bush - TREE
LET objecttype = 5
LET treex = 185: LET treey = 195: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 10: REM Tree Radius
LET itemlabel$ = "Bush 5"
LET labelc = 6
RETURN
data199:
REM Bush - TREE
LET objecttype = 5
LET treex = 360: LET treey = 195: REM Tree Co-ordinates
LET treec = 2: REM Tree Colour
LET treer = 10: REM Tree Radius
LET itemlabel$ = "Bush 6"
LET labelc = 6
RETURN

mapdata20:
REM Map 20 Data
LET map$ = "Top Field"
IF z = 1 THEN GOSUB data201
IF z = 2 THEN GOSUB data202
IF z = 3 THEN GOSUB data203
IF z = 4 THEN GOSUB data204
IF z = 5 THEN GOSUB data205
IF z = 6 THEN GOSUB data206
IF z = 7 THEN GOSUB data207
IF z = 8 THEN GOSUB data208
IF z = 9 THEN GOSUB data209
IF z = 10 THEN GOSUB data200
RETURN
data201:
REM Field Border - BORDER
LET objecttype = 1
LET linex1 = 35: LET liney1 = 80: REM Corner 1
LET linex2 = 580: LET liney2 = 420: REM Corner 2
LET linec = 2: REM Line Colour
RETURN
data202:
REM Exit to Woods - EXIT
LET objecttype = 3
LET yexit1 = 385: LET xexit1 = 40: REM Exit Co-ordinates
LET texit1 = 2: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 18: REM Map number exit leads to
LET exity1 = 120: LET exitx1 = 530: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data203:
REM Exit to Park - EXIT
LET objecttype = 3
LET yexit2 = 235: LET xexit2 = 40: REM Exit Co-ordinates
LET texit2 = 2: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 21: REM Map number exit leads to
LET exity2 = 235: LET exitx2 = 555: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data204:
REM Exit to Road - EXIT
LET objecttype = 3
LET yexit3 = 85: LET xexit3 = 530: REM Exit Co-ordinates
LET texit3 = 3: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd3 = 22: REM Map number exit leads to
LET exity3 = 400: LET exitx3 = 545: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 3: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data205:
REM Tree - TREE
LET objecttype = 5
LET treex = 520: LET treey = 370: REM Tree Co-ordinates
LET treec = 10: REM Tree Colour
LET treer = 15: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data206:
REM Tree - TREE
LET objecttype = 5
LET treex = 65: LET treey = 100: REM Tree Co-ordinates
LET treec = 10: REM Tree Colour
LET treer = 10: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data207:
REM Tree - TREE
LET objecttype = 5
LET treex = 165: LET treey = 100: REM Tree Co-ordinates
LET treec = 10: REM Tree Colour
LET treer = 10: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data208:
REM Tree - TREE
LET objecttype = 5
LET treex = 295: LET treey = 100: REM Tree Co-ordinates
LET treec = 10: REM Tree Colour
LET treer = 10: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data209:
REM Tree - TREE
LET objecttype = 5
LET treex = 430: LET treey = 100: REM Tree Co-ordinates
LET treec = 10: REM Tree Colour
LET treer = 10: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data200:
REM Vending Machine - OBLONG
LET objecttype = 2
LET linex1 = 535: LET liney1 = 210: REM Corner 1
LET linex2 = 579: LET liney2 = 260: REM Corner 2
LET linec = 1: REM Line Colour
LET itemlabel$ = "Vending Machine": REM Item Label
LET labelc = 15: REM Item Label Character Count
LET usetype = 0
RETURN

mapdata21:
REM Map 21 Data
LET map$ = "Park"
IF z = 1 THEN GOSUB data211
IF z = 2 THEN GOSUB data212
IF z = 3 THEN GOSUB data213
IF z = 4 THEN GOSUB data214
IF z = 5 THEN GOSUB data215
IF z = 6 THEN GOSUB data216
IF z = 7 THEN GOSUB data217
IF z = 8 THEN GOSUB data218
IF z = 9 THEN GOSUB data219
IF z = 10 THEN GOSUB data210
RETURN
data211:
REM Park Border - BORDER
LET objecttype = 1
LET linex1 = 60: LET liney1 = 95: REM Corner 1
LET linex2 = 570: LET liney2 = 375: REM Corner 2
LET linec = 2: REM Line Colour
RETURN
data212:
REM Exit to Woods - EXIT
LET objecttype = 3
LET yexit1 = 370: LET xexit1 = 85: REM Exit Co-ordinates
LET texit1 = 4: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 18: REM Map number exit leads to
LET exity1 = 110: LET exitx1 = 95: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data213:
REM Exit to Road - EXIT
LET objecttype = 3
LET yexit2 = 100: LET xexit2 = 85: REM Exit Co-ordinates
LET texit2 = 3: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 22: REM Map number exit leads to
LET exity2 = 400: LET exitx2 = 100: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data214:
REM Exit to Top Field - EXIT
LET objecttype = 3
LET yexit3 = 235: LET xexit3 = 565: REM Exit Co-ordinates
LET texit3 = 1: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd3 = 20: REM Map number exit leads to
LET exity3 = 235: LET exitx3 = 50: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 3: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data215:
REM Tree - TREE
LET objecttype = 5
LET treex = 335: LET treey = 285: REM Tree Co-ordinates
LET treec = 10: REM Tree Colour
LET treer = 30: REM Tree Radius
LET itemlabel$ = "Tree"
LET labelc = 4
RETURN
data216:
REM Slide - OBLONG
LET objecttype = 2
LET linex1 = 230: LET liney1 = 120: REM Corner 1
LET linex2 = 360: LET liney2 = 155: REM Corner 2
LET linec = 9: REM Line Colour
LET itemlabel$ = "Slide": REM Item Label
LET labelc = 5: REM Item Label Character Count
RETURN
data217:
REM Steps - STEPS
LET objecttype = 4
LET linex1 = 65: LET liney1 = 140: REM Corner 1
LET linex2 = 110: LET liney2 = 330: REM Corner 2
LET stepa = 10: REM Amount of Steps
LET stepd = 2: REM Direction of Steps
RETURN
data218:
REM Swings - OBLONG
LET objecttype = 2
LET linex1 = 420: LET liney1 = 325: REM Corner 1
LET linex2 = 555: LET liney2 = 360: REM Corner 2
LET linec = 13: REM Line Colour
LET itemlabel$ = "Swings": REM Item Label
LET labelc = 6: REM Item Label Character Count
RETURN
data219:
REM Steps - STEPS
LET objecttype = 4
LET linex1 = 410: LET liney1 = 215: REM Corner 1
LET linex2 = 525: LET liney2 = 255: REM Corner 2
LET stepa = 6: REM Amount of Steps
LET stepd = 1: REM Direction of Steps
RETURN
data210:
REM Steps - STEPS
LET objecttype = 4
LET linex1 = 120: LET liney1 = 165: REM Corner 1
LET linex2 = 450: LET liney2 = 215: REM Corner 2
LET stepa = 15: REM Amount of Steps
LET stepd = 1: REM Direction of Steps
RETURN

mapdata22:
REM Map 22 Data
LET map$ = "Road"
IF z = 1 THEN GOSUB data221
IF z = 2 THEN GOSUB data222
IF z = 3 THEN GOSUB data223
IF z = 4 THEN GOSUB data224
IF z = 5 THEN GOSUB data225
IF z = 6 THEN GOSUB data226
IF z = 7 THEN GOSUB data227
IF z = 8 THEN GOSUB data228
REM IF z = 9 THEN GOSUB data229
REM IF z = 10 THEN GOSUB data220
RETURN
data221:
REM Object Description - BORDER
LET objecttype = 1
LET linex1 = 30: LET liney1 = 190: REM Corner 1
LET linex2 = 600: LET liney2 = 415: REM Corner 2
LET linec = 8: REM Line Colour
LET bgcox = 290: LET bgcoy = 350
RETURN
data222:
REM Exit to Park - EXIT
LET objecttype = 3
LET yexit1 = 410: LET xexit1 = 100: REM Exit Co-ordinates
LET texit1 = 4: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 21: REM Map number exit leads to
LET exity1 = 110: LET exitx1 = 85: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data223:
REM Exit to Road - EXIT
LET objecttype = 3
LET yexit2 = 345: LET xexit2 = 35: REM Exit Co-ordinates
LET texit2 = 2: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 23: REM Map number exit leads to
LET exity2 = 350: LET exitx2 = 585: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data224:
REM Exit to Top Field - EXIT
LET objecttype = 3
LET yexit3 = 410: LET xexit3 = 545: REM Exit Co-ordinates
LET texit3 = 4: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd3 = 20: REM Map number exit leads to
LET exity3 = 95: LET exitx3 = 530: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 3: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data225:
REM Road - ROAD
LET objecttype = 6
LET linex1 = 31: LET liney1 = 191: REM Corner 1
LET linex2 = 599: LET liney2 = 324: REM Corner 2
LET rtype = 1: REM Road Type. 1 = Horizontal. 2 = Vertical.
RETURN
data226:
REM Wall - OBLONG
LET objecttype = 2
LET linex1 = 31: LET liney1 = 375: REM Corner 1
LET linex2 = 70: LET liney2 = 414: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN
data227:
REM Wall - OBLONG
LET objecttype = 2
LET linex1 = 130: LET liney1 = 375: REM Corner 1
LET linex2 = 520: LET liney2 = 414: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN
data228:
REM Wall - OBLONG
LET objecttype = 2
LET linex1 = 570: LET liney1 = 375: REM Corner 1
LET linex2 = 599: LET liney2 = 414: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN

mapdata23:
REM Map 23 Data
LET map$ = "Road"
IF z = 1 THEN GOSUB data231
IF z = 2 THEN GOSUB data232
IF z = 3 THEN GOSUB data233
IF z = 4 THEN GOSUB data234
IF z = 5 THEN GOSUB data235
IF z = 6 THEN GOSUB data236
IF z = 7 THEN GOSUB data237
IF z = 8 THEN GOSUB data238
REM IF z = 9 THEN GOSUB data239
REM IF z = 10 THEN GOSUB data230
RETURN
data231:
REM Road Border - BORDER
LET objecttype = 1
LET linex1 = 30: LET liney1 = 190: REM Corner 1
LET linex2 = 600: LET liney2 = 415: REM Corner 2
LET linec = 8: REM Line Colour
LET bgcox = 290: LET bgcoy = 350
RETURN
data232:
REM Road - ROAD
LET objecttype = 6
LET linex1 = 31: LET liney1 = 191: REM Corner 1
LET linex2 = 599: LET liney2 = 324: REM Corner 2
LET rtype = 1: REM Road Type. 1 = Horizontal. 2 = Vertical.
RETURN
data233:
REM Your House - OBLONG
LET objecttype = 2
LET linex1 = 31: LET liney1 = 365: REM Corner 1
LET linex2 = 175: LET liney2 = 414: REM Corner 2
LET linec = 14: REM Line Colour
LET itemlabel$ = "Your House": REM Item Label
LET labelc = 10: REM Item Label Character Count
RETURN
data234:
REM Grandma's House - OBLONG
LET objecttype = 2
LET linex1 = 176: LET liney1 = 365: REM Corner 1
LET linex2 = 313: LET liney2 = 414: REM Corner 2
LET linec = 7: REM Line Colour
LET itemlabel$ = "Grandma's House": REM Item Label
LET labelc = 15: REM Item Label Character Count
RETURN
data235:
REM Exit to Grandma's Back Garden - EXIT
LET objecttype = 3
LET yexit1 = 410: LET xexit1 = 350: REM Exit Co-ordinates
LET texit1 = 4: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 15: REM Map number exit leads to
LET exity1 = 140: LET exitx1 = 90: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data236:
REM Wall - OBLONG
LET objecttype = 2
LET linex1 = 395: LET liney1 = 380: REM Corner 1
LET linex2 = 599: LET liney2 = 414: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN
data237:
REM Exit to Road - EXIT
LET objecttype = 3
LET yexit2 = 350: LET xexit2 = 595: REM Exit Co-ordinates
LET texit2 = 1: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 22: REM Map number exit leads to
LET exity2 = 345: LET exitx2 = 45: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
RETURN
data238:
REM Exit to Stairs - EXIT
LET objecttype = 3
LET yexit3 = 360: LET xexit3 = 100: REM Exit Co-ordinates
LET texit3 = 4: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd3 = 7: REM Map number exit leads to
LET exity3 = 380: LET exitx3 = 350: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 3: REM Exit Number 1-4
LET linec = 12: REM Exit Colour
LET keyr3 = 1
RETURN

mapdata24:
REM Map 24 Data
LET map$ = "406's Kitchen"
IF z = 1 THEN GOSUB data241
IF z = 2 THEN GOSUB data242
IF z = 3 THEN GOSUB data243
IF z = 4 THEN GOSUB data244
IF z = 5 THEN GOSUB data245
IF z = 6 THEN GOSUB data246
REM IF z = 7 THEN GOSUB data247
REM IF z = 8 THEN GOSUB data248
REM IF z = 9 THEN GOSUB data249
REM IF z = 10 THEN GOSUB data240
RETURN
data241:
REM 406's Kicthen - BORDER
LET objecttype = 1
LET linex1 = 110: LET liney1 = 110: REM Corner 1
LET linex2 = 485: LET liney2 = 395: REM Corner 2
LET linec = 15: REM Line Colour
RETURN
data242:
REM Exit to 406's Garden - EXIT
LET objecttype = 3
LET yexit1 = 390: LET xexit1 = 380: REM Exit Co-ordinates
LET texit1 = 4: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 15: REM Map number exit leads to
LET exity1 = 155: LET exitx1 = 135: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
LET keyr = 0
RETURN
data243:
REM Exit to Toilet - EXIT
LET objecttype = 3
LET yexit2 = 115: LET xexit2 = 190: REM Exit Co-ordinates
LET texit2 = 3: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd2 = 25: REM Map number exit leads to
LET exity2 = 210: LET exitx2 = 185: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 2: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
LET keyr = 0
RETURN
data244:
REM Exit to 406's Living Room - EXIT
LET objecttype = 3
LET yexit3 = 330: LET xexit3 = 480: REM Exit Co-ordinates
LET texit3 = 1: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd3 = 26: REM Map number exit leads to
LET exity3 = 315: LET exitx3 = 60: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 3: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
LET keyr = 0
RETURN
data245:
REM Fridge - OBLONG
LET objecttype = 2
LET linex1 = 445: LET liney1 = 111: REM Corner 1
LET linex2 = 484: LET liney2 = 175: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "Fridge": REM Item Label
LET labelc = 6: REM Item Label Character Count
LET usetype = 2
RETURN
data246:
REM Work Surface - OBLONG
LET objecttype = 2
LET linex1 = 111: LET liney1 = 111: REM Corner 1
LET linex2 = 150: LET liney2 = 394: REM Corner 2
LET linec = 6: REM Line Colour
LET itemlabel$ = "Work Surface": REM Item Label
LET labelc = 12: REM Item Label Character Count
LET usetype = 2
RETURN

mapdata25:
REM Map 25 Data
LET map$ = "Toilet"
IF z = 1 THEN GOSUB data251
IF z = 2 THEN GOSUB data252
IF z = 3 THEN GOSUB data253
REM IF z = 4 THEN GOSUB data254
REM IF z = 5 THEN GOSUB data255
REM IF z = 6 THEN GOSUB data256
REM IF z = 7 THEN GOSUB data257
REM IF z = 8 THEN GOSUB data258
REM IF z = 9 THEN GOSUB data259
REM IF z = 10 THEN GOSUB data250
RETURN
data251:
REM Toilet - BORDER
LET objecttype = 1
LET linex1 = 145: LET liney1 = 150: REM Corner 1
LET linex2 = 385: LET liney2 = 230: REM Corner 2
LET linec = 15: REM Line Colour
RETURN
data252:
REM Exit to 406's Kitchen - EXIT
LET objecttype = 3
LET yexit1 = 225: LET xexit1 = 185: REM Exit Co-ordinates
LET texit1 = 4: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 24: REM Map number exit leads to
LET exity1 = 130: LET exitx1 = 190: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
LET keyr = 0
RETURN
data253:
REM Toilet - OBLONG
LET objecttype = 2
LET linex1 = 315: LET liney1 = 151: REM Corner 1
LET linex2 = 384: LET liney2 = 229: REM Corner 2
LET linec = 7: REM Line Colour
LET itemlabel$ = "Toilet": REM Item Label
LET labelc = 6: REM Item Label Character Count
LET usetype = 1
LET usex = 350
LET usey = 190
RETURN

mapdata26:
REM Map 26 Data
LET map$ = "406's Living Room"
IF z = 1 THEN GOSUB data261
IF z = 2 THEN GOSUB data262
IF z = 3 THEN GOSUB data263
IF z = 4 THEN GOSUB data264
IF z = 5 THEN GOSUB data265
IF z = 6 THEN GOSUB data266
IF z = 7 THEN GOSUB data267
IF z = 8 THEN GOSUB data268
IF z = 9 THEN GOSUB data269
REM IF z = 10 THEN GOSUB data260
RETURN
data261:
REM 406's Living Room - BORDER
LET objecttype = 1
LET linex1 = 45: LET liney1 = 120: REM Corner 1
LET linex2 = 550: LET liney2 = 355: REM Corner 2
LET linec = 15: REM Line Colour
RETURN
data262:
REM Exit to 406's Kitchen - EXIT
LET objecttype = 3
LET yexit1 = 315: LET xexit1 = 50: REM Exit Co-ordinates
LET texit1 = 2: REM Exit Type. 1 = Left. 2 = Right. 3 = Up. 4 = Down
LET exitd1 = 24: REM Map number exit leads to
LET exity1 = 330: LET exitx1 = 470: REM Player Position on Map change
LET itemlabel$ = "Exit": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET exitno = 1: REM Exit Number 1-4
LET linec = 10: REM Exit Colour
LET keyr = 0
RETURN
data263:
REM Table - OBLONG
LET objecttype = 2
LET linex1 = 46: LET liney1 = 170: REM Corner 1
LET linex2 = 115: LET liney2 = 275: REM Corner 2
LET linec = 6: REM Line Colour
LET itemlabel$ = "Table": REM Item Label
LET labelc = 5: REM Item Label Character Count
LET usetype = 0
RETURN
data264:
REM Shelf - OBLONG
LET objecttype = 2
LET linex1 = 46: LET liney1 = 121: REM Corner 1
LET linex2 = 240: LET liney2 = 150: REM Corner 2
LET linec = 6: REM Line Colour
LET itemlabel$ = "Shelf": REM Item Label
LET labelc = 5: REM Item Label Character Count
LET usetype = 2
RETURN
data265:
REM Wall - OBLONG
LET objecttype = 2
LET linex1 = 241: LET liney1 = 121: REM Corner 1
LET linex2 = 550: LET liney2 = 150: REM Corner 2
LET linec = 15: REM Line Colour
LET itemlabel$ = "": REM Item Label
LET labelc = 0: REM Item Label Character Count
RETURN
data266:
REM Sofa - OBLONG
LET objecttype = 2
LET linex1 = 315: LET liney1 = 151: REM Corner 1
LET linex2 = 445: LET liney2 = 195: REM Corner 2
LET linec = 4: REM Line Colour
LET itemlabel$ = "Sofa": REM Item Label
LET labelc = 4: REM Item Label Character Count
LET usetype = 1
LET usex = 380
LET usey = 180
RETURN
data267:
REM Chair - OBLONG
LET objecttype = 2
LET linex1 = 250: LET liney1 = 295: REM Corner 1
LET linex2 = 315: LET liney2 = 354: REM Corner 2
LET linec = 4: REM Line Colour
LET itemlabel$ = "Chair": REM Item Label
LET labelc = 5: REM Item Label Character Count
LET usetype = 1
LET usex = 285
LET usey = 320
RETURN
data268:
REM Vending Machine - OBLONG
LET objecttype = 2
LET linex1 = 160: LET liney1 = 315: REM Corner 1
LET linex2 = 235: LET liney2 = 354: REM Corner 2
LET linec = 1: REM Line Colour
LET itemlabel$ = "Vending Machine": REM Item Label
LET labelc = 15: REM Item Label Character Count
LET usetype = 0
RETURN
data269:
REM TV - OBLONG
LET objecttype = 2
LET linex1 = 495: LET liney1 = 280: REM Corner 1
LET linex2 = 549: LET liney2 = 354: REM Corner 2
LET linec = 3: REM Line Colour
LET itemlabel$ = "TV": REM Item Label
LET labelc = 2: REM Item Label Character Count
LET usetype = 0
RETURN

tutorial:
REM Tutorial for new players
LET tutorial = 1
IF profile$ = "DOOMGUY" THEN RETURN
LET message = 2
LET message$ = "Welcome to Zombie Game!"
LET messagec = 23
GOSUB message
LET message$ = "Use the arrow keys to move!"
LET messagec = 27
GOSUB message
LET message$ = "Press SPACE to use an object or item!"
LET messagec = 36
GOSUB message
LET message$ = "Press I to access the inventory!"
LET messagec = 32
GOSUB message
LET message$ = "Press ESC to go back!"
LET messagec = 21
GOSUB message
LET message$ = "Avoid the zombies and good luck!"
LET messagec = 32
GOSUB message
LET tutorial = 0
RETURN


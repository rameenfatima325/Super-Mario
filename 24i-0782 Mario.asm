INCLUDE Irvine32.inc
INCLUDELIB winmm.lib 

PlaySound PROTO,
    pszSound:PTR BYTE,
    hmod:DWORD,
    fdwSound:DWORD

SND_FILENAME    EQU 00020000h
SND_ASYNC       EQU 00000001h
SND_LOOP        EQU 00000008h
SND_NOSTOP      EQU 00000010h
SND_SYNC        EQU 00000000h
SND_NODEFAULT  EQU 00000002h

ENTITY_DATA_LEN = 9
MAX_ENTITIES = 10
POWERUP_LIMIT = 480 
STD_OUTPUT_HANDLE EQU -11
TURBO_DURATION = 160 

initSystem PROTO
showFinalMsg PROTO 
showTitle PROTO
showMenu PROTO
showInstructions PROTO
showPauseMenu PROTO
showTransition PROTO
showHighScores PROTO
playVictory PROTO
startGame PROTO
endSystem PROTO
getExtractionStatus PROTO
updatePhysics PROTO
loadMapConfig PROTO
clearMapBuffers PROTO
copyMapData PROTO
resetLevelState PROTO
checkGroundCollision PROTO
checkCeilingCollision PROTO
checkBlockCollision PROTO
checkShaftCollision PROTO
eraseMario PROTO
drawMario PROTO
initEnemiesLevel1 PROTO
initEnemiesLevel2 PROTO
updateEnemies PROTO
evalEnemyCollision PROTO
renderStatus PROTO
updateBoost PROTO
getBoost PROTO
renderLevel PROTO
drawFlag PROTO
drawCoins PROTO
checkCoins PROTO
drawPowerCrates PROTO
drawPlatforms PROTO
drawShafts PROTO
drawBoxes PROTO
drawSolidBlocks PROTO
drawPhantomBlocks PROTO
revealPhantomBlocks PROTO
activateBoxes PROTO
checkLifeBonus PROTO 
loadScores PROTO 
saveScores PROTO
getName PROTO
addScore PROTO
sortScores PROTO
drawStars PROTO
checkStars PROTO
updateTurbo PROTO

.data
  
soundJump       BYTE "jump.wav", 0
soundCoin       BYTE "coin.wav", 0
soundPowerup    BYTE "power.wav", 0
soundStomp      BYTE "stomp.wav", 0
soundDeath      BYTE "death.wav", 0
soundBGM1       BYTE "bgmusic.wav", 0
soundBGM2       BYTE "bgmusic.wav", 0

outHandle DWORD ?

filename        BYTE "scores.txt",0
fileHandle      DWORD ?
bestScore       DWORD 0
bytesRead       DWORD ?
bytesWritten    DWORD ?

MAX_SCORES = 10
NAME_LENGTH = 20
scoreCount      DWORD 0
playerNames     BYTE MAX_SCORES * NAME_LENGTH DUP(0)
playerScores    DWORD MAX_SCORES DUP(0)
currentName     BYTE NAME_LENGTH DUP(0)
fileBuffer      BYTE 1000 DUP(0)

blankLine BYTE "                                                                                                    ",0

msgScore    BYTE "Score: ",0   
msgTime    BYTE "Time: ",0
msgLives BYTE "Lives: ",0
msgLevel   BYTE "World: ",0
msgWin  BYTE "Mission Complete!",0
msgWinMsg  BYTE "The pilot has reached the extraction point.",0
msgCoinsCount    BYTE "Coins: ",0 
msgRollNum   BYTE "Roll No: 24i-0782",0 

msgTitle BYTE "                       S U P E R   M A R I O   B R O S                            ",0 
msgTitleLine BYTE " ============================================================================ ",0
msgPressStart BYTE "Press any key to continue...",0
msgStartGame    BYTE "   [ S T A R T   G A M E ]   ",0
msgHighScore     BYTE "   [ H I G H   S C O R E ]   ",0
msgQuitGame     BYTE "   [ E X I T   G A M E ]     ",0
msgHelpScreen BYTE "   [ I N S T R U C T I O N S ] ",0
msgResumeGame   BYTE "   Resume Game   ",0
msgQuitToMenu     BYTE "   Quit to Menu  ",0
msgSelection   BYTE "-->",0
msgLevelComplete BYTE "   L E V E L   C O M P L E T E D !   ",0
msgBossLevel BYTE "      B O S S   L E V E L      ",0
msgStartLevel BYTE "   Press ENTER to Start...   ",0

msgHighScoresTitle BYTE "   H I G H   S C O R E   ",0
msgEnterName   BYTE "Enter your name: ",0
msgRank           BYTE ". ",0
msgDashScore           BYTE " - ",0
msgEmptyScores       BYTE "No scores yet. Be the first!",0
msgBestScore       BYTE "   Best Score: ",0

msgControls    BYTE "CONTROLS:",0
msgJump    BYTE "W: Jump",0
msgMoveLeft    BYTE "A: Move Left",0
msgMoveRight    BYTE "D: Move Right",0
msgPause   BYTE "P: Pause Game",0
msgGameMission   BYTE "OBJECTIVES:",0
msgCollect BYTE "- Collect coins & powerups",0
msgEnemies BYTE "- Jump on enemies to defeat them",0
msgExit BYTE "- Reach the end of the level",0
msgBackMenu BYTE "Press any key to go back...",0

score       DWORD 0
lifeBonus DWORD 0       
timeLeft   DWORD 2000       
lives   BYTE 3
level   BYTE 1
totalCoins       DWORD 0           
gameMode  BYTE 0            
menuChoice BYTE 0         
pauseChoice BYTE 0        

marioX BYTE 10
marioY BYTE 27        
marioXPrev  BYTE 10 
velocityY SBYTE 0         
isJumping   BYTE 0
groundY  BYTE 28           
moveSpeed  BYTE 1
hasBoost BYTE 0
boostTime  DWORD 0

isTurbo BYTE 0          
turboTime  DWORD 0         
stepCount BYTE 0          

keyPressed   BYTE ?
scrollPos DWORD 0
isColliding BYTE 0
justScrolled BYTE 0 

enemies     BYTE MAX_ENTITIES * ENTITY_DATA_LEN DUP(0)
enemyFrameCount BYTE 0

groundLevel   BYTE 2000 DUP(' ')
skyLevel    BYTE 2000 DUP(' ')
sceneryLayer     BYTE 2000 DUP(' ')
platformsList BYTE 2000 DUP(0)
shaftsList    BYTE 100 DUP(0)
boxesList     BYTE 100 DUP(0)
boostList       BYTE 50 DUP(0)
blocksList       BYTE 100 DUP(0)
phantomList     BYTE 50 DUP(0)
coinsList  BYTE 200 DUP(0) 
starsList        BYTE 50 DUP(0)  

L1_groundLevel       BYTE "[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]"
                       BYTE 500 DUP ('['), 0 
L1_skyLevel        BYTE "     {}{}{}         {}{}{}{}              {}{}{}         {}{}{}{}              {}{}{}         {}{}{}{}           "
                       BYTE 500 DUP (' '), 0
L1_sceneryLayer     BYTE "          -------              -----------                  --------              -----------                    "
                       BYTE 500 DUP (' '), 0
L1_platformsList  BYTE 40,25,8, 60,22,6, 90,20,10, 120,23,8, 150,25,6, 0
L1_shaftsList     BYTE 30,3, 70,4, 100,2, 140,5, 0 
L1_boxesList      BYTE 25,25,1, 55,15,1, 85,17,1, 115,20,1, 0
L1_boostList        BYTE 65,25,1, 0
L1_blocksList        BYTE 45,20, 46,20, 47,20, 65,18, 66,18, 0
L1_phantomList      BYTE 35,19,0, 75,21,0, 0
L1_coinsList   BYTE 15,25,1, 16,25,1, 17,25,1, 30,25,1, 33,23,1, 34,22,1, 42,23,1, 43,23,1, 62,20,1, 92,18,1, 0
L1_starsList         BYTE 20,25,1, 80,15,1, 0

L2_groundLevel       BYTE "[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]"
                       BYTE 500 DUP (']'), 0
L2_skyLevel        BYTE "   (BOSS)      (LEVEL)        {}{}{}              (DANGER)            {}{}{}           (0782)          "
                       BYTE 500 DUP (' '), 0
L2_sceneryLayer     BYTE "      ---          ---           ------               ---              --------              ------------      "
                       BYTE 500 DUP (' '), 0
L2_platformsList  BYTE 15,24,5, 30,20,5, 45,18,5, 60,22,5, 80,25,10, 100,20,8, 0
L2_shaftsList     BYTE 20,2, 90,4, 130,3, 0
L2_boxesList      BYTE 32,15,1, 47,13,1, 85,18,1, 0
L2_boostList        BYTE 50,12,1, 0
L2_blocksList        BYTE 10,20, 11,20, 12,20, 80,20, 81,20, 82,20, 0
L2_phantomList      BYTE 25,18,0, 65,18,0, 0
L2_coinsList   BYTE 15,24,1, 16,24,1, 17,24,1, 30,23,1, 31,23,1, 45,22,1, 46,22,1, 60,23,1, 85,24,1, 0
L2_starsList         BYTE 25,15,1, 20,15,1, 0


.code

main PROC
    ;call playBGM1
    call Clrscr
    call Randomize
    call initSystem 
    call loadScores 
    
    mov gameMode, 0

mainLoop:
    cmp gameMode, 0
    je showTitleScreen
    cmp gameMode, 1
    je showMenuScreen
    cmp gameMode, 2
    je showHelpScreen
    cmp gameMode, 3
    je playLevel
    cmp gameMode, 4
    je pauseLevel
    cmp gameMode, 5
    je levelTransition
    cmp gameMode, 6
    je showScoresScreen
    call endSystem 
    
showTitleScreen:
    call showTitle
    call ReadKey 
titleLoop:
    mov eax, 50
    call Delay
    call ReadKey
    jz titleLoop 
    mov keyPressed, al 
    cmp keyPressed, 'x'
    je quitGame
    mov gameMode, 1
    jmp mainLoop

quitGame:
    call endSystem

showMenuScreen:
    call showMenu
menuLoop:
    mov eax, 50
    call Delay
    call ReadKey
    jz menuLoop
    mov keyPressed, al
    cmp keyPressed, 'w' 
    je menuMoveUp
    cmp keyPressed, 's' 
    je menuMoveDown
    cmp keyPressed, 13
    je menuSelect
    cmp keyPressed, 'x'
    je quitGame
    jmp menuLoop
menuMoveUp:
    mov al, menuChoice
    cmp al, 0
    je wrapMenuUp
    dec menuChoice
    jmp showMenuScreen 
wrapMenuUp:
    mov menuChoice, 3
    jmp showMenuScreen 
menuMoveDown:
    mov al, menuChoice
    cmp al, 3
    je wrapMenuDown
    inc menuChoice
    jmp showMenuScreen 
wrapMenuDown:
    mov menuChoice, 0 
    jmp showMenuScreen 
menuSelect:
    mov al, menuChoice
    cmp al, 0
    je startNewGame
    cmp al, 1
    je goToScores 
    cmp al, 2
    je showHelpScreen
    cmp al, 3
    je quitGame
    jmp menuLoop
startNewGame:
call getName
    call startGame
    jmp mainLoop 
goToScores:
    mov gameMode, 6 
    jmp mainLoop

showHelpScreen:
    call showInstructions
helpLoop:
    mov eax, 50
    call Delay
    call ReadKey
    jz helpLoop 
    mov keyPressed, al
    cmp keyPressed, 'x'
    je backToMenu
    jmp backToMenu
backToMenu:
    mov gameMode, 1
    jmp mainLoop

showScoresScreen:
    call showHighScores
scoresLoop:
    mov eax, 50
    call Delay
    call ReadKey
    jz scoresLoop
    mov keyPressed, al
    cmp keyPressed, 'x'
    je backToMenu
    jmp backToMenu

playLevel:
    cmp lives, 0
    jle gameOver

    dec timeLeft
    cmp timeLeft, 0
    jg timeOk
    
    dec lives
    
    cmp lives, 0
    jle gameOver
    
    call resetLevelState 
    jmp playLevel

timeOk:
    call updateBoost
    call updateTurbo 
    call updateEnemies
    call evalEnemyCollision
    
    call renderStatus 
    call updatePhysics

    mov eax, 30 
    call Delay
    
    call ReadKey
    jz noInput
    
    mov keyPressed, al
    cmp keyPressed, 'x'
    je quitGame
    cmp keyPressed, 'p'
    je pauseGame      
    cmp keyPressed, 'w'
    je jumpAction
    cmp keyPressed, 'a'
    je moveLeft
    cmp keyPressed, 'd'
    je moveRight
    jmp playLevel

pauseGame:
    mov gameMode, 4 
    jmp mainLoop

noInput:
    jmp playLevel

jumpAction:
    call checkGroundCollision
    cmp al, 1
    jne playLevel 
    mov velocityY, -4 
    mov isJumping, 1
    ;call PlayJumpSound
    jmp playLevel

moveLeft: 
    call eraseMario
    cmp marioX, 0
    jle afterLeftMove
    
    mov al, marioX
    mov marioXPrev, al
    
    mov al, 1 
    inc stepCount
    test stepCount, 3 
    jnz skipSpeedBoost
    inc al 
skipSpeedBoost:
    cmp isTurbo, 1
    jne normalLeftSpeed
    shl al, 1 
normalLeftSpeed:

    sub marioX, al
    
    call checkBlockCollision
    cmp isColliding, 1
    jne checkShaftLeft
    mov al, marioXPrev
    mov marioX, al 
    jmp afterLeftMove

checkShaftLeft:
    call checkShaftCollision 
    cmp isColliding, 1
    jne checkBoundLeft
    mov al, marioXPrev
    mov marioX, al
    jmp afterLeftMove

checkBoundLeft:
    cmp marioX, 0
    jge afterLeftMove
    mov marioX, 0
afterLeftMove:
    call drawMario
    jmp playLevel

moveRight: 
    call eraseMario
    
    mov al, marioX
    mov marioXPrev, al

    mov al, 1 
    inc stepCount
    test stepCount, 3
    jnz skipSpeedBoostR
    inc al
skipSpeedBoostR:
    cmp isTurbo, 1
    jne normalRightSpeed
    shl al, 1 
normalRightSpeed:

    add marioX, al
    
    cmp marioX, 99
    jle doCollisionChecks
    mov marioX, 99
doCollisionChecks:

    call checkBlockCollision
    cmp isColliding, 1
    jne checkShaftRight
    mov al, marioXPrev
    mov marioX, al 
    jmp afterRightMove

checkShaftRight:
    call checkShaftCollision 
    cmp isColliding, 1
    jne checkScrollTrigger
    mov al, marioXPrev
    mov marioX, al
    jmp afterRightMove
    
checkScrollTrigger:
    mov al, marioX
    cmp al, 75
    jle checkLevelEnd
    
    inc scrollPos
    call renderLevel 
    mov marioX, 75

checkLevelEnd:
    mov eax, scrollPos
    movzx ebx, marioX
    add eax, ebx
    cmp eax, 170
    jl afterRightMove 

    cmp level, 1
    je nextLevel
    jmp levelComplete 

nextLevel:
    inc level 
    mov gameMode, 5  
    jmp mainLoop

afterRightMove:
    call drawMario
    jmp playLevel

levelComplete:
    call playVictory
    jmp mainLoop

gameOver:
    ;call StopAllSounds
    ;call PlayDeathSound
    mov eax, 1000
    call Delay
    call addScore
    call saveScores
    call Clrscr
    mov eax, white + (black * 16)
    call SetTextColor
    mov gameMode, 1 
    jmp mainLoop

pauseLevel:
    call showPauseMenu
pauseLoop:
    mov eax, 50
    call Delay
    call ReadKey
    jz pauseLoop
    mov keyPressed, al
    cmp keyPressed, 'w' 
    je pauseMoveUp
    cmp keyPressed, 's' 
    je pauseMoveDown
    cmp keyPressed, 13 
    je pauseSelect
    cmp keyPressed, 'p' 
    je resumeGame
    cmp keyPressed, 'x'
    je quitGame
    jmp pauseLoop
pauseMoveUp:
    mov al, pauseChoice
    cmp al, 0
    je wrapPauseUp
    dec pauseChoice
    jmp pauseLevel 
wrapPauseUp:
    mov pauseChoice, 1 
    jmp pauseLevel
pauseMoveDown:
    mov al, pauseChoice
    cmp al, 1
    je wrapPauseDown
    inc pauseChoice
    jmp pauseLevel
wrapPauseDown:
    mov pauseChoice, 0 
    jmp pauseLevel
pauseSelect:
    mov al, pauseChoice
    cmp al, 0
    je resumeGame
    cmp al, 1
    je pauseQuit
    jmp pauseLoop
resumeGame:
    mov eax, white + (black * 16)
    call SetTextColor
    call Clrscr
    call renderStatus
    call renderLevel 
    call drawMario
    mov gameMode, 3 
    ;call playBGM1
    jmp mainLoop
pauseQuit:
    call StopAllSounds
    call addScore
    call saveScores
    mov gameMode, 1 
    mov pauseChoice, 0 
    jmp mainLoop

levelTransition:
    call showTransition
transLoop:
    mov eax, 50
    call Delay
    call ReadKey
    jz transLoop
    mov keyPressed, al
    cmp keyPressed, 13 
    je startLvl2
    cmp keyPressed, 'x'
    je quitGame
    jmp transLoop
startLvl2:
    call loadMapConfig 
    mov gameMode, 3      
    jmp mainLoop

main ENDP

PlayJumpSound PROC
    INVOKE PlaySound, ADDR soundJump, NULL, SND_FILENAME OR SND_ASYNC OR SND_NODEFAULT
    mov eax, 500
    call Delay
    INVOKE PlaySound, ADDR soundBGM1, NULL, SND_FILENAME OR SND_ASYNC OR SND_LOOP OR SND_NODEFAULT
    ret
PlayJumpSound ENDP

PlayCoinSound PROC
    INVOKE PlaySound, ADDR soundCoin, NULL, SND_FILENAME OR SND_ASYNC OR SND_NODEFAULT
    mov eax, 500
    call Delay
    INVOKE PlaySound, ADDR soundBGM1, NULL, SND_FILENAME OR SND_ASYNC OR SND_LOOP OR SND_NODEFAULT
    ret
PlayCoinSound ENDP

PlayPowerupSound PROC
    INVOKE PlaySound, ADDR soundPowerup, NULL, SND_FILENAME OR SND_ASYNC OR SND_NODEFAULT
    mov eax, 500
    call Delay
    INVOKE PlaySound, ADDR soundBGM1, NULL, SND_FILENAME OR SND_ASYNC OR SND_LOOP OR SND_NODEFAULT
    ret
PlayPowerupSound ENDP

PlayStompSound PROC
    INVOKE PlaySound, ADDR soundStomp, NULL, SND_FILENAME OR SND_ASYNC OR SND_NODEFAULT
    mov eax, 500
    call Delay
    INVOKE PlaySound, ADDR soundBGM1, NULL, SND_FILENAME OR SND_ASYNC OR SND_LOOP OR SND_NODEFAULT
    ret
PlayStompSound ENDP

PlayDeathSound PROC
    INVOKE PlaySound, ADDR soundDeath, NULL, SND_FILENAME OR SND_ASYNC OR SND_NODEFAULT
    mov eax, 500
    call Delay
    INVOKE PlaySound, ADDR soundBGM1, NULL, SND_FILENAME OR SND_ASYNC OR SND_LOOP OR SND_NODEFAULT
    ret
PlayDeathSound ENDP

PlayBGM1 PROC
    INVOKE PlaySound, ADDR soundBGM1, NULL, SND_FILENAME OR SND_ASYNC OR SND_LOOP OR SND_NODEFAULT
    ret
PlayBGM1 ENDP

PlayBGM2 PROC
    INVOKE PlaySound, ADDR soundBGM2, NULL, SND_FILENAME OR SND_ASYNC OR SND_LOOP OR SND_NODEFAULT
    ret
PlayBGM2 ENDP

StopAllSounds PROC
    INVOKE PlaySound, NULL, NULL, 0
    ret
StopAllSounds ENDP

startGame PROC
    mov lives, 3
    mov timeLeft, 2000
    mov score, 0
    mov totalCoins, 0
    mov lifeBonus, 0 
    mov isTurbo, 0 
    mov turboTime, 0
    mov level, 1
    call loadMapConfig
    mov gameMode, 3 
    ret
startGame ENDP

endSystem PROC
    call StopAllSounds
    call saveScores
    call Clrscr
    mov eax, white + (black * 16)
    call SetTextColor
    exit
endSystem ENDP

initSystem PROC 
    mov eax, white + (black * 16)
    call SetTextColor
    call Clrscr
    call Clrscr
    ret
initSystem ENDP

playVictory PROC
    call StopAllSounds
    call addScore
    call saveScores
    call Clrscr
    call showFinalMsg 
    mov gameMode, 1
    ret
playVictory ENDP

showFinalMsg PROC 
    mov dl, 50
    mov dh, 12
    call Gotoxy
    
    mov eax, yellow + (black * 16)
    call SetTextColor
    
    mov edx, OFFSET msgWin
    call WriteString
    
    mov eax, 2000
    call Delay
    
    mov eax, white + (black * 16)
    call SetTextColor
    
    ret
showFinalMsg ENDP

getExtractionStatus PROC
    push ecx
    push esi
    push ebx
    mov ecx, MAX_ENTITIES
    mov esi, 0
checkAllEnemies:
    mov al, [esi + 4] 
    cmp al, 1
    je foundEnemy 
    add esi, ENTITY_DATA_LEN
    loop checkAllEnemies
    mov al, 1
    jmp exitExtraction
foundEnemy:
    mov al, 0
exitExtraction:
    pop ebx
    pop esi
    pop ecx
    ret
getExtractionStatus ENDP

updatePhysics PROC
    call eraseMario
    cmp velocityY, 3
    jge limitGravity
    inc velocityY
limitGravity:
    mov al, velocityY
    add marioY, al
    
    cmp marioY, 2 
    jge noSkyBound
    mov marioY, 2
    mov velocityY, 0 
noSkyBound:

    cmp velocityY, 0
    jge checkFall
    call checkCeilingCollision
checkFall:
    call checkGroundCollision
    cmp al, 1
    je landedSafe
    cmp marioY, 35
    jg deathFall
    jmp physicsEnd
landedSafe:
    mov velocityY, 0
    mov isJumping, 0
    jmp physicsEnd
deathFall:

    dec lives
    call resetLevelState
physicsEnd:
    call revealPhantomBlocks
    call activateBoxes
    call checkCoins
    call checkStars 
    call getBoost
    call drawMario
    ret
updatePhysics ENDP


loadMapConfig PROC
    mov timeLeft, 2000
    mov marioX, 10
    mov marioY, 27      
    mov velocityY, 0
    mov scrollPos, 0
    mov isJumping, 0
    
    mov isTurbo, 0
    mov hasBoost, 0
    mov moveSpeed, 1
    
    call clearMapBuffers
    cmp level, 1
    je loadLevel1
    jmp loadLevel2
loadLevel1:
    mov esi, OFFSET L1_groundLevel
    mov edi, OFFSET groundLevel
    call copyMapData
    mov esi, OFFSET L1_platformsList
    mov edi, OFFSET platformsList
    call copyMapData
    mov esi, OFFSET L1_shaftsList
    mov edi, OFFSET shaftsList
    call copyMapData
    mov esi, OFFSET L1_boxesList
    mov edi, OFFSET boxesList
    call copyMapData
    mov esi, OFFSET L1_boostList
    mov edi, OFFSET boostList
    call copyMapData
    mov esi, OFFSET L1_blocksList
    mov edi, OFFSET blocksList
    call copyMapData
    mov esi, OFFSET L1_phantomList
    mov edi, OFFSET phantomList
    call copyMapData
    mov esi, OFFSET L1_coinsList
    mov edi, OFFSET coinsList
    call copyMapData
    mov esi, OFFSET L1_starsList 
    mov edi, OFFSET starsList
    call copyMapData
    mov esi, OFFSET L1_skyLevel
    mov edi, OFFSET skyLevel
    call copyMapData
    mov esi, OFFSET L1_sceneryLayer
    mov edi, OFFSET sceneryLayer
    call copyMapData
    call initEnemiesLevel1
    ;call playBGM1
    jmp configDone
loadLevel2:
    mov esi, OFFSET L2_groundLevel
    mov edi, OFFSET groundLevel
    call copyMapData
    mov esi, OFFSET L2_platformsList
    mov edi, OFFSET platformsList
    call copyMapData
    mov esi, OFFSET L2_shaftsList
    mov edi, OFFSET shaftsList
    call copyMapData
    mov esi, OFFSET L2_boxesList
    mov edi, OFFSET boxesList
    call copyMapData
    mov esi, OFFSET L2_boostList
    mov edi, OFFSET boostList
    call copyMapData
    mov esi, OFFSET L2_blocksList
    mov edi, OFFSET blocksList
    call copyMapData
    mov esi, OFFSET L2_phantomList
    mov edi, OFFSET phantomList
    call copyMapData
    mov esi, OFFSET L2_coinsList
    mov edi, OFFSET coinsList
    call copyMapData
    mov esi, OFFSET L2_starsList 
    mov edi, OFFSET starsList
    call copyMapData
    mov esi, OFFSET L2_skyLevel
    mov edi, OFFSET skyLevel
    call copyMapData
    mov esi, OFFSET L2_sceneryLayer
    mov edi, OFFSET sceneryLayer
    call copyMapData
    call initEnemiesLevel2
    ;call PlayBGM2
configDone:
    call Clrscr 
    call renderLevel
    call drawMario
    ret
loadMapConfig ENDP

clearMapBuffers PROC
    pusha
    mov edi, OFFSET groundLevel
    mov ecx, 2000
    mov bl, ' '
clearGround:
    mov [edi], bl
    inc edi
    loop clearGround
    mov edi, OFFSET skyLevel
    mov ecx, 2000
    mov bl, ' '
clearSky:
    mov [edi], bl
    inc edi
    loop clearSky
    mov edi, OFFSET sceneryLayer
    mov ecx, 2000
    mov bl, ' '
clearScenery:
    mov [edi], bl
    inc edi
    loop clearScenery
    mov al, 0
    mov edi, OFFSET platformsList
    mov ecx, 200
    rep stosb
    mov edi, OFFSET shaftsList
    mov ecx, 100
    rep stosb
    mov edi, OFFSET boxesList
    mov ecx, 100
    rep stosb
    mov edi, OFFSET boostList
    mov ecx, 50
    rep stosb
    mov edi, OFFSET blocksList
    mov ecx, 100
    rep stosb
    mov edi, OFFSET phantomList
    mov ecx, 50
    rep stosb
    mov edi, OFFSET coinsList
    mov ecx, 200
    rep stosb
    mov edi, OFFSET starsList
    mov ecx, 50
    rep stosb
    popa
    ret
clearMapBuffers ENDP

copyMapData PROC
    pusha
dataCopy:
    mov bl, [esi] 
    mov [edi], bl
    inc esi
    inc edi
    cmp bl, 0 
    jne dataCopy
    popa
    ret
copyMapData ENDP

resetLevelState PROC
    cmp lives, 0
    jle shutdown
    call StopAllSounds
    ;call PlayDeathSound
    mov eax, 500
    call Delay
    mov score, 0
    call loadMapConfig
shutdown:
    ret
resetLevelState ENDP

check_surface_contact PROC
    push ebx
    push ecx
    push edx
    push esi
    
    mov bl, 99
    
    movzx eax, marioX
    add eax, scrollPos
    mov esi, OFFSET groundLevel
    add esi, eax
    mov al, [esi]
    cmp al, ' '
    je checkScenery
    
    mov al, marioY
    cmp al, groundY
    jl checkScenery
    
    mov bl, 28
    
checkScenery:
    movzx eax, marioX
    add eax, scrollPos
    mov esi, OFFSET sceneryLayer
    add esi, eax
    mov al, [esi]
    cmp al, ' '
    je checkPlatforms
    
    mov al, marioY
    cmp al, 26
    jl checkPlatforms
    cmp al, 28
    jg checkPlatforms
    
    mov cl, 26
    cmp cl, bl
    jge checkPlatforms
    mov bl, cl

checkPlatforms:
    mov esi, OFFSET platformsList
platformLoop:
    mov al, [esi]
    cmp al, 0
    je checkBlocks
    
    movzx edx, al
    sub edx, scrollPos
    mov cl, [esi+1]
    mov ch, [esi+2]
    add esi, 3
    
    cmp edx, 100
    jge platformLoop
    cmp edx, 0
    jl platformLoop
    
    movzx eax, marioX
    cmp eax, edx
    jl platformLoop
    add edx, ecx
    and edx, 0FFh
    mov dh, 0
    movzx edx, ch
    movzx eax, byte ptr [esi-3]
    sub eax, scrollPos
    add eax, edx
    movzx edx, marioX
    cmp edx, eax
    jg platformLoop
    
    mov al, marioY
    inc al
    cmp al, cl
    jne platformLoop
    
    dec cl
    cmp cl, bl
    jge platformLoop
    mov bl, cl
    jmp platformLoop

checkBlocks:
    mov esi, OFFSET blocksList
blockLoop:
    mov al, [esi]
    cmp al, 0
    je checkBoxes
    
    movzx edx, al
    sub edx, scrollPos
    mov cl, [esi+1]
    add esi, 2
    
    cmp edx, 100
    jge blockLoop
    cmp edx, 0
    jl blockLoop
    
    movzx eax, marioX
    cmp eax, edx
    je blockYCheck
    inc edx
    cmp eax, edx
    jne blockLoop
    
blockYCheck:
    mov al, marioY
    inc al
    cmp al, cl
    jne blockLoop
    
    dec cl
    cmp cl, bl
    jge blockLoop
    mov bl, cl
    jmp blockLoop

checkBoxes:
    mov esi, OFFSET boxesList
boxLoop:
    mov al, [esi]
    cmp al, 0
    je checkBoost
    
    movzx edx, al
    sub edx, scrollPos
    mov cl, [esi+1]
    add esi, 3
    
    cmp edx, 100
    jge boxLoop
    cmp edx, 0
    jl boxLoop
    
    movzx eax, marioX
    cmp eax, edx
    jl boxLoop
    add edx, 2
    cmp eax, edx
    jg boxLoop
    
    mov al, marioY
    inc al
    cmp al, cl
    jne boxLoop
    
    dec cl
    cmp cl, bl
    jge boxLoop
    mov bl, cl
    jmp boxLoop

checkBoost:
    mov esi, OFFSET boostList
boostLoop:
    mov al, [esi]
    cmp al, 0
    je checkPhantom
    
    movzx edx, al
    sub edx, scrollPos
    mov cl, [esi+1]
    add esi, 3
    
    cmp edx, 100
    jge boostLoop
    cmp edx, 0
    jl boostLoop
    
    movzx eax, marioX
    cmp eax, edx
    jl boostLoop
    add edx, 2
    cmp eax, edx
    jg boostLoop
    
    mov al, marioY
    inc al
    cmp al, cl
    jne boostLoop
    
    dec cl
    cmp cl, bl
    jge boostLoop
    mov bl, cl
    jmp boostLoop

checkPhantom:
    mov esi, OFFSET phantomList
phantomLoop:
    mov al, [esi]
    cmp al, 0
    je checkShafts
    
    movzx edx, al
    sub edx, scrollPos
    mov cl, [esi+1]
    mov ch, [esi+2]
    add esi, 3
    
    cmp ch, 1
    jne phantomLoop
    
    cmp edx, 100
    jge phantomLoop
    cmp edx, 0
    jl phantomLoop
    
    movzx eax, marioX
    cmp eax, edx
    jl phantomLoop
    add edx, 2
    cmp eax, edx
    jg phantomLoop
    
    mov al, marioY
    inc al
    cmp al, cl
    jne phantomLoop
    
    dec cl
    cmp cl, bl
    jge phantomLoop
    mov bl, cl
    jmp phantomLoop

checkShafts:
    mov esi, OFFSET shaftsList
shaftLoop:
    mov al, [esi]
    cmp al, 0
    je finalCheck
    
    movzx edx, al
    sub edx, scrollPos
    mov cl, [esi+1]
    add esi, 2
    
    cmp edx, 100
    jge shaftLoop
    cmp edx, 0
    jl shaftLoop
    
    movzx eax, marioX
    cmp eax, edx
    je shaftYCheck
    inc edx
    cmp eax, edx
    jne shaftLoop
    
shaftYCheck:
    mov ch, 29
    sub ch, cl
    
    mov al, marioY
    inc al
    cmp al, ch
    jl shaftLoop
    
    sub al, ch
    cmp al, 5
    jg shaftLoop
    
    dec ch
    cmp ch, bl
    jge shaftLoop
    mov bl, ch
    jmp shaftLoop

finalCheck:
    cmp bl, 99
    je noGround
    
    mov marioY, bl
    mov velocityY, 0
    mov isJumping, 0
    mov al, 1
    jmp exitGround

noGround:
    mov al, 0

exitGround:
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret
check_surface_contact ENDP

checkGroundCollision PROC
    push ebx
    push ecx
    push edx
    push esi
    
    mov bl, 99
    
    movzx eax, marioX
    add eax, scrollPos
    mov esi, OFFSET groundLevel
    add esi, eax
    mov al, [esi]
    cmp al, ' '
    je checkDistantScenery
    
    mov al, marioY
    cmp al, groundY
    jl checkDistantScenery
    
    mov bl, 28
    
checkDistantScenery:
    movzx eax, marioX
    add eax, scrollPos
    mov esi, OFFSET sceneryLayer
    add esi, eax
    mov al, [esi]
    cmp al, ' '
    je checkElevatedPlatforms
    
    mov al, marioY
    cmp al, 26
    jl checkElevatedPlatforms
    cmp al, 28
    jg checkElevatedPlatforms
    
    mov cl, 26
    cmp cl, bl
    jge checkElevatedPlatforms
    mov bl, cl

checkElevatedPlatforms:
    mov esi, OFFSET platformsList
platLoop:
    mov al, [esi]
    cmp al, 0
    je checkSolidBlocks
    
    movzx edx, al
    sub edx, scrollPos
    mov cl, [esi+1]
    mov ch, [esi+2]
    add esi, 3
    
    cmp edx, 100
    jge platLoop
    cmp edx, 0
    jl platLoop
    
    movzx eax, marioX
    cmp eax, edx
    jl platLoop
    add edx, ecx
    and edx, 0FFh
    mov dh, 0
    movzx edx, ch
    movzx eax, byte ptr [esi-3]
    sub eax, scrollPos
    add eax, edx
    movzx edx, marioX
    cmp edx, eax
    jg platLoop
    
    mov al, marioY
    inc al
    cmp al, cl
    jne platLoop
    
    dec cl
    cmp cl, bl
    jge platLoop
    mov bl, cl
    jmp platLoop

checkSolidBlocks:
    mov esi, OFFSET blocksList
solidLoop:
    mov al, [esi]
    cmp al, 0
    je checkMysteryBoxes
    
    movzx edx, al
    sub edx, scrollPos
    mov cl, [esi+1]
    add esi, 2
    
    cmp edx, 100
    jge solidLoop
    cmp edx, 0
    jl solidLoop
    
    movzx eax, marioX
    cmp eax, edx
    je solidYCheck
    inc edx
    cmp eax, edx
    jne solidLoop
    
solidYCheck:
    mov al, marioY
    inc al
    cmp al, cl
    jne solidLoop
    
    dec cl
    cmp cl, bl
    jge solidLoop
    mov bl, cl
    jmp solidLoop

checkMysteryBoxes:
    mov esi, OFFSET boxesList
mysteryLoop:
    mov al, [esi]
    cmp al, 0
    je checkBoostCrates
    
    movzx edx, al
    sub edx, scrollPos
    mov cl, [esi+1]
    add esi, 3
    
    cmp edx, 100
    jge mysteryLoop
    cmp edx, 0
    jl mysteryLoop
    
    movzx eax, marioX
    cmp eax, edx
    jl mysteryLoop
    add edx, 2
    cmp eax, edx
    jg mysteryLoop
    
    mov al, marioY
    inc al
    cmp al, cl
    jne mysteryLoop
    
    dec cl
    cmp cl, bl
    jge mysteryLoop
    mov bl, cl
    jmp mysteryLoop

checkBoostCrates:
    mov esi, OFFSET boostList
powerLoop:
    mov al, [esi]
    cmp al, 0
    je checkPhantomBlocks
    
    movzx edx, al
    sub edx, scrollPos
    mov cl, [esi+1]
    add esi, 3
    
    cmp edx, 100
    jge powerLoop
    cmp edx, 0
    jl powerLoop
    
    movzx eax, marioX
    cmp eax, edx
    jl powerLoop
    add edx, 2
    cmp eax, edx
    jg powerLoop
    
    mov al, marioY
    inc al
    cmp al, cl
    jne powerLoop
    
    dec cl
    cmp cl, bl
    jge powerLoop
    mov bl, cl
    jmp powerLoop

checkPhantomBlocks:
    mov esi, OFFSET phantomList
ghostLoop:
    mov al, [esi]
    cmp al, 0
    je checkVerticalShafts
    
    movzx edx, al
    sub edx, scrollPos
    mov cl, [esi+1]
    mov ch, [esi+2]
    add esi, 3
    
    cmp ch, 1
    jne ghostLoop
    
    cmp edx, 100
    jge ghostLoop
    cmp edx, 0
    jl ghostLoop
    
    movzx eax, marioX
    cmp eax, edx
    jl ghostLoop
    add edx, 2
    cmp eax, edx
    jg ghostLoop
    
    mov al, marioY
    inc al
    cmp al, cl
    jne ghostLoop
    
    dec cl
    cmp cl, bl
    jge ghostLoop
    mov bl, cl
    jmp ghostLoop

checkVerticalShafts:
    mov esi, OFFSET shaftsList
pitLoop:
    mov al, [esi]
    cmp al, 0
    je endGroundCheck
    
    movzx edx, al
    sub edx, scrollPos
    mov cl, [esi+1]
    add esi, 2
    
    cmp edx, 100
    jge pitLoop
    cmp edx, 0
    jl pitLoop
    
    movzx eax, marioX
    cmp eax, edx
    je pitYCheck
    inc edx
    cmp eax, edx
    jne pitLoop
    
pitYCheck:
    mov ch, 29
    sub ch, cl
    
    mov al, marioY
    inc al
    cmp al, ch
    jl pitLoop
    
    sub al, ch
    cmp al, 5
    jg pitLoop
    
    dec ch
    cmp ch, bl
    jge pitLoop
    mov bl, ch
    jmp pitLoop

endGroundCheck:
    cmp bl, 99
    je noGroundFound
    
    mov marioY, bl
    mov velocityY, 0
    mov isJumping, 0
    mov al, 1
    jmp exitGroundCheck

noGroundFound:
    mov al, 0

exitGroundCheck:
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret
checkGroundCollision ENDP

checkCeilingCollision PROC
    pusha
    mov esi, OFFSET blocksList
roofLoop:
    mov al, [esi]
    cmp al, 0
    je checkCrateCeiling
    mov bl, al        
    sub ebx, scrollPos
    mov cl, [esi+1] 
    
    mov al, marioY
    cmp al, cl
    jne nextRoof

    movzx eax, marioX
    cmp eax, ebx
    jl nextRoof
    inc ebx
    cmp eax, ebx
    jg nextRoof
    
    mov velocityY, 0
    inc marioY
    jmp doneRoof
nextRoof:
    add esi, 2
    jmp roofLoop

checkCrateCeiling:
    mov esi, OFFSET boxesList
crateRoofLoop:
    mov al, [esi]
    cmp al, 0
    je checkBoostCeiling
    mov bl, al
    sub ebx, scrollPos
    mov cl, [esi+1]
    
    mov al, marioY
    cmp al, cl
    jne nextCrateRoof

    movzx eax, marioX
    cmp eax, ebx
    jl nextCrateRoof
    add ebx, 2
    cmp eax, ebx
    jg nextCrateRoof
    
    mov velocityY, 0
    inc marioY
    jmp doneRoof
nextCrateRoof:
    add esi, 3
    jmp crateRoofLoop

checkBoostCeiling:
    mov esi, OFFSET boostList
boostRoofLoop:
    mov al, [esi]
    cmp al, 0
    je doneRoof
    mov bl, al
    sub ebx, scrollPos
    mov cl, [esi+1]
    
    mov al, marioY
    cmp al, cl
    jne nextBoostRoof

    movzx eax, marioX
    cmp eax, ebx
    jl nextBoostRoof
    add ebx, 2
    cmp eax, ebx
    jg nextBoostRoof
    
    mov velocityY, 0
    inc marioY
    jmp doneRoof
nextBoostRoof:
    add esi, 3
    jmp boostRoofLoop

doneRoof:
    popa
    ret
checkCeilingCollision ENDP

checkBlockCollision PROC
    pusha
    mov isColliding, 0
    mov esi, OFFSET blocksList
sideLoop:
    mov al, [esi]
    cmp al, 0
    je checkCratesSide
    mov bl, al        
    sub ebx, scrollPos
    mov cl, [esi+1] 
    
    mov al, marioY
    cmp al, cl
    jne nextBlockSide
    
    movzx eax, marioX
    cmp eax, ebx
    jl nextBlockSide
    inc ebx
    cmp eax, ebx
    jg nextBlockSide
    
    mov isColliding, 1 
    jmp doneBlockSide
nextBlockSide:
    add esi, 2
    jmp sideLoop

checkCratesSide:
    mov esi, OFFSET boxesList
crateSideLoop:
    mov al, [esi]
    cmp al, 0
    je checkBoostSide
    mov bl, al
    sub ebx, scrollPos
    mov cl, [esi+1] 
    
    mov al, marioY
    cmp al, cl
    jne nextCrateSide

    movzx eax, marioX
    cmp eax, ebx
    jl nextCrateSide
    add ebx, 2
    cmp eax, ebx
    jg nextCrateSide
    
    mov isColliding, 1
    jmp doneBlockSide
nextCrateSide:
    add esi, 3
    jmp crateSideLoop

checkBoostSide:
    mov esi, OFFSET boostList
boostSideLoop:
    mov al, [esi]
    cmp al, 0
    je doneBlockSide
    mov bl, al
    sub ebx, scrollPos
    mov cl, [esi+1]
    
    mov al, marioY
    cmp al, cl
    jne nextBoostSide

    movzx eax, marioX
    cmp eax, ebx
    jl nextBoostSide
    add ebx, 2
    cmp eax, ebx
    jg nextBoostSide
    
    mov isColliding, 1
    jmp doneBlockSide
nextBoostSide:
    add esi, 3
    jmp boostSideLoop
doneBlockSide:
    popa
    ret
checkBlockCollision ENDP

checkShaftCollision PROC
    pusha
    mov isColliding, 0
    mov esi, OFFSET shaftsList
shaftSideLoop:
    mov al, [esi]
    cmp al, 0
    je doneShaftSide
    movzx ebx, byte ptr [esi] 
    sub ebx, scrollPos
    inc esi
    mov al, [esi] 
    mov cl, al
    inc esi
    cmp ebx, 80
    jg shaftSideLoop
    cmp ebx, 0
    jl shaftSideLoop
    mov ch, 29
    sub ch, cl 
    cmp marioY, ch
    jle shaftSideLoop 
    movzx eax, marioX
    cmp eax, ebx
    je shaftSideHit
    inc ebx
    cmp eax, ebx
    je shaftSideHit
    jmp shaftSideLoop
shaftSideHit:
    mov isColliding, 1
doneShaftSide:
    popa
    ret
checkShaftCollision ENDP

eraseMario PROC
    pusha
    mov dl, marioX
    mov dh, marioY
    call Gotoxy
    pusha
    mov esi, OFFSET shaftsList
restoreShaftLoop:
    mov al, [esi]
    cmp al, 0
    je restoreSolid
    movzx ebx, al
    sub ebx, scrollPos 
    movzx ecx, marioX
    cmp ecx, ebx
    je checkShaftYPos
    inc ebx
    cmp ecx, ebx
    je checkShaftYPos
    add esi, 2
    jmp restoreShaftLoop
checkShaftYPos:
    mov cl, [esi+1] 
    mov ch, 29
    sub ch, cl 
    cmp marioY, ch
    jl nextShaftRestore 
    cmp marioY, 29
    jg nextShaftRestore 
    mov eax, red + (black * 16)
    call SetTextColor
    mov al, '#'
    call WriteChar
    popa
    popa 
    ret  
nextShaftRestore:
    add esi, 2
    jmp restoreShaftLoop
restoreSolid:
    popa
    pusha
    mov esi, OFFSET blocksList
restoreSolidLoop:
    mov al, [esi]
    cmp al, 0
    je restoreBackground
    movzx ebx, al
    sub ebx, scrollPos
    movzx ecx, marioX
    cmp ecx, ebx
    jne nextSolidRestore
    mov al, [esi+1] 
    cmp marioY, al
    jne nextSolidRestore
    mov eax, brown + (black * 16)
    call SetTextColor
    mov al, '<' 
    call WriteChar
    popa
    popa
    ret
nextSolidRestore:
    add esi, 2
    jmp restoreSolidLoop
restoreBackground:
    popa
    pusha
    mov esi, OFFSET platformsList
restorePlatLoop:
    mov al, [esi]
    cmp al, 0
    je restoreSceneryFinal
    movzx ebx, al 
    sub ebx, scrollPos
    movzx ecx, marioX
    cmp ecx, ebx
    jl nextPlatRestore
    mov dl, [esi+2] 
    movzx edx, dl
    add ebx, edx
    cmp ecx, ebx
    jge nextPlatRestore
    mov al, [esi+1] 
    cmp marioY, al
    jne nextPlatRestore
    mov eax, blue + (black * 16)
    call SetTextColor
    mov al, '^' 
    call WriteChar
    popa
    popa
    ret
nextPlatRestore:
    add esi, 3
    jmp restorePlatLoop
restoreSceneryFinal:
    popa
    movzx eax, marioX
    add eax, scrollPos
    mov edi, eax
    mov eax, white + (black * 16)
    call SetTextColor
    cmp marioY, 27
    jne checkSkyRestore
    mov esi, OFFSET sceneryLayer
    add esi, edi
    mov bl, [esi]
    cmp bl, ' '
    je checkSkyRestore
    mov eax, lightGreen + (black * 16)
    call SetTextColor
    mov al, bl
    call WriteChar 
    jmp restoreEnd
checkSkyRestore:
    cmp marioY, 2
    jne drawEmptyChar
    mov esi, OFFSET skyLevel
    add esi, edi
    mov bl, [esi]
    cmp bl, ' '
    je drawEmptyChar
    mov al, bl
    call WriteChar 
    jmp restoreEnd
drawEmptyChar:
    mov eax, white + (black * 16)
    call SetTextColor
    mov al, ' '
    call WriteChar
restoreEnd:
    popa
    ret
eraseMario ENDP

drawMario PROC
    mov eax, lightBlue + (black * 16) 
    call SetTextColor
    mov dl,marioX 
    mov dh,marioY 
    call Gotoxy
    mov al,'M' 
    call WriteChar
    ret
drawMario ENDP

initEnemiesLevel1 PROC
    pusha
    mov ecx, MAX_ENTITIES * ENTITY_DATA_LEN
    mov esi, OFFSET enemies
    mov al, 0
clearEnemies1:
    mov [esi], al
    inc esi
    loop clearEnemies1

    mov enemies[0], 0  
    mov enemies[1], 35
    mov enemies[2], 28
    mov enemies[3], 0
    mov enemies[4], 1
    mov enemies[5], 35
    mov enemies[6], 40

    mov enemies[9], 1
    mov enemies[10], 75
    mov enemies[11], 28
    mov enemies[12], 0
    mov enemies[13], 1
    mov enemies[14], 75
    mov enemies[25], 85

    popa
    ret
initEnemiesLevel1 ENDP

initEnemiesLevel2 PROC
    pusha
    mov ecx, MAX_ENTITIES * ENTITY_DATA_LEN
    mov esi, OFFSET enemies
    mov al, 0
clearEnemies2:
    mov [esi], al
    inc esi
    loop clearEnemies2

    mov enemies[0], 1    
    mov enemies[1], 30   
    mov enemies[2], 28   
    mov enemies[3], 0    
    mov enemies[4], 1    
    mov enemies[5], 29   
    mov enemies[6], 39 
    mov enemies[7], 0
    mov enemies[8], 0
    
    mov enemies[9], 2 
    mov enemies[10], 45 
    mov enemies[11], 28   
    mov enemies[12], 0    
    mov enemies[13], 1    
    mov enemies[14], 40 
    mov enemies[15], 50 
    mov enemies[16], 0
    mov enemies[17], 0
    
    mov enemies[18], 0    
    mov enemies[19], 60 
    mov enemies[20], 21  
    mov enemies[21], 0    
    mov enemies[22], 1    
    mov enemies[23], 58 
    mov enemies[24], 63 
    mov enemies[25], 0    
    mov enemies[26], 0
    
    mov enemies[27], 2 
    mov enemies[28], 80 
    mov enemies[29], 28   
    mov enemies[30], 1    
    mov enemies[31], 1    
    mov enemies[32], 75 
    mov enemies[33], 90 
    mov enemies[34], 0    
    mov enemies[35], 0

    popa
    ret
initEnemiesLevel2 ENDP

updateEnemies PROC
    pusha
    
    inc enemyFrameCount
    
    mov ecx, MAX_ENTITIES
    mov esi, 0

enemyLoop:
    mov eax, esi
    mov ebx, ENTITY_DATA_LEN
    mul bx
    mov edi, eax
    
    mov al, enemies[edi + 4] 
    cmp al, 1
    jne nextEnemy
    
    cmp enemyFrameCount, 6
    jb justDrawEnemy
    
    mov al, enemies[edi]
    cmp al, 3
    je justDrawEnemy
    
    cmp justScrolled, 1
    je doMovement
    
    movzx eax, byte ptr enemies[edi + 1]
    mov ebx, scrollPos
    sub eax, ebx 
    
    cmp eax, 0
    jl doMovement
    cmp eax, 99
    jg doMovement
    
    mov dl, al
    mov dh, enemies[edi + 2]
    call Gotoxy
    mov al, ' '
    call WriteChar
    
doMovement:
    mov al, enemies[edi]
    cmp al, 2
    jne normalMove
    
    mov al, enemies[edi + 7]
    cmp al, 3
    jge capFall
    inc enemies[edi + 7]
    
capFall:
    mov al, enemies[edi + 7]
    add enemies[edi + 2], al
    
    mov al, enemies[edi + 2]
    cmp al, 28
    jle checkJump
    
    mov enemies[edi + 2], 28
    mov enemies[edi + 7], 0
    
checkJump:
    inc enemies[edi + 8]
    mov al, enemies[edi + 8]
    cmp al, 4
    jl normalMove
    
    mov al, enemies[edi + 2]
    cmp al, 28
    jne resetJumpCounter
    
    mov enemies[edi + 7], -5
    mov enemies[edi + 8], 0
    jmp normalMove
    
resetJumpCounter:
    mov enemies[edi + 8], 0
    
normalMove:
    mov al, enemies[edi + 3]
    cmp al, 0
    je moveRight
    
    dec enemies[edi + 1]
    mov al, enemies[edi + 1]
    cmp al, enemies[edi + 5]
    jge checkDone
    mov enemies[edi + 3], 0
    jmp checkDone
    
moveRight:
    inc enemies[edi + 1]
    mov al, enemies[edi + 1]
    cmp al, enemies[edi + 6]
    jle checkDone
    mov enemies[edi + 3], 1
    
checkDone:
    
justDrawEnemy:
    movzx eax, byte ptr enemies[edi + 1]
    mov ebx, scrollPos
    sub eax, ebx
    
    cmp eax, 0
    jl nextEnemy
    cmp eax, 99
    jg nextEnemy
    
    mov dl, al
    mov dh, enemies[edi + 2]
    call Gotoxy
    
    mov al, enemies[edi]
    cmp al, 0
    je drawGoomba
    cmp al, 1
    je drawKoopa
    cmp al, 2
    je drawSentinel
    cmp al, 3
    je drawShell
    jmp nextEnemy
    
drawShell:
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov al, 'S'
    jmp drawEnemyChar
    
drawKoopa:
    mov eax, green + (black * 16)
    call SetTextColor
    mov al, 'K'
    jmp drawEnemyChar
    
drawSentinel:
    mov eax, magenta + (black * 16)
    call SetTextColor
    mov al, 'S'
    jmp drawEnemyChar
    
drawGoomba:
    mov eax, brown + (black * 16)
    call SetTextColor
    mov al, 'G'
    
drawEnemyChar:
    call WriteChar
    
nextEnemy:
    inc esi
    dec ecx
    jne enemyLoop
    
    cmp enemyFrameCount, 6
    jb exitEnemyUpdate
    mov enemyFrameCount, 0
    
exitEnemyUpdate:
    mov justScrolled, 0
    popa
    ret
updateEnemies ENDP

evalEnemyCollision PROC
    pusha
    mov ecx, MAX_ENTITIES
    mov esi, 0
contactLoop:
    mov eax, esi
    mov ebx, ENTITY_DATA_LEN
    mul bx
    mov edi, eax
    mov al, enemies[edi + 4] 
    cmp al, 1
    jne nextContact
    
    movzx eax, byte ptr enemies[edi + 1]
    mov ebx, scrollPos
    sub eax, ebx
    
    cmp eax, 105 
    jg nextContact 
    cmp eax, -5
    jl nextContact

    mov bl, enemies[edi + 2] 
    mov dl, marioX
    
    movzx edx, marioX
    sub edx, eax
    
    cmp edx, 0
    jge hDiffPositive
    neg edx
hDiffPositive:
    cmp edx, 1
    jg nextContact
    
    mov dl, marioY
    sub dl, bl
    cmp dl, 0
    jge vDiffPositive
    neg dl
vDiffPositive:
    cmp dl, 2 
    jg nextContact
    
    mov al, marioY
    cmp al, bl
    jl hitEnemy 
    
    cmp velocityY, 0
    jg hitEnemy

    dec lives
    call resetLevelState
    jmp doneContacts

hitEnemy:
    pusha
    movzx eax, byte ptr enemies[edi + 1]
    mov ebx, scrollPos
    sub eax, ebx
    
    cmp eax, 0
    jl skipEraseEnemy
    cmp eax, 99
    jg skipEraseEnemy
    
    mov dl, al
    mov dh, enemies[edi + 2]
    call Gotoxy
    mov al, ' '
    call WriteChar
skipEraseEnemy:
    popa
    
    mov al, enemies[edi] 
    cmp al, 1
    je koopaBecomeShell
    cmp al, 3
    je shellDie
    
    mov enemies[edi+4], 0 
    cmp al, 0 
    je scoreGoomba
    cmp al, 2
    je scoreSentinel
    ;call PlayStompSound
    jmp afterScore
    
koopaBecomeShell:
    mov enemies[edi], 3
    add score, 100
    call checkLifeBonus
    mov velocityY, -3
    jmp nextContact
    
shellDie:
    mov enemies[edi+4], 0
    add score, 200
    call checkLifeBonus
    mov velocityY, -3
    jmp nextContact
    
scoreGoomba:
    add score, 100
    jmp afterScore
    
scoreSentinel:
    add score, 500
    
afterScore:
    call checkLifeBonus 
    mov velocityY, -3        
    
nextContact:
    inc esi
    dec ecx
    jne contactLoop
doneContacts:
    popa
    ret
evalEnemyCollision ENDP

checkLifeBonus PROC
    pusha
    mov eax, score
    mov ebx, lifeBonus
    sub eax, ebx
    cmp eax, 100
    jl noBonus
    inc lives
    mov ecx, 100
updateTracking:
    add lifeBonus, ecx
    mov eax, score
    mov ebx, lifeBonus
    sub eax, ebx
    cmp eax, 100
    jge updateTracking 
noBonus:
    popa
    ret
checkLifeBonus ENDP

renderStatus PROC
    pusha
    mov eax, white + (black * 16)
    
    cmp isTurbo, 1
    jne normalTime
    mov eax, lightBlue + (black * 16) 
    jmp setTimeColor
normalTime:
    mov eax, white + (black * 16)
setTimeColor:
    call SetTextColor
    
    mov dl,0
    mov dh,0
    call Gotoxy
    mov edx,OFFSET msgScore
    call WriteString
    mov eax,score
    call WriteDec
    
    mov dl,15
    mov dh,0
    call Gotoxy
    mov edx,OFFSET msgCoinsCount
    call WriteString
    mov eax,totalCoins
    call WriteDec
    
    mov dl,30
    mov dh,0
    call Gotoxy
    mov edx,OFFSET msgLevel
    call WriteString
    movzx eax,level
    call WriteDec
    
    mov dl,45
    mov dh,0
    call Gotoxy
    mov edx,OFFSET msgTime
    call WriteString
    mov eax,timeLeft
    call WriteDec
    
    mov dl,60
    mov dh,0
    call Gotoxy
    mov edx,OFFSET msgLives
    call WriteString
    movzx eax,lives
    call WriteDec
    popa
    ret
renderStatus ENDP

updateBoost PROC
    pusha
    cmp hasBoost, 1
    jne noBUpdate
    dec boostTime
    jnz noBUpdate
    mov hasBoost, 0
noBUpdate:
    popa
    ret
updateBoost ENDP

updateTurbo PROC
    pusha
    cmp isTurbo, 1
    jne noTUpdate
    dec turboTime
    jnz noTUpdate
    mov isTurbo, 0
noTUpdate:
    popa
    ret
updateTurbo ENDP

checkStars PROC
    pusha
    mov esi,OFFSET starsList
starLoop:
    mov al,[esi]
    cmp al,0
    je noDraw
    movzx ebx,al   
    mov al,[esi+1] 
    mov dh,al      
    mov al,[esi+2] 
    cmp al,1
    jne nextStar
    sub ebx, scrollPos
    movzx eax, marioX
    sub eax, ebx 
    jns starXDelta
    neg eax
starXDelta:
    cmp eax, 1 
    jg nextStar 
    movzx eax, marioY
    sub al, dh
    movsx eax, al
    jns starYDelta
    neg eax
starYDelta:
    cmp eax, 1 
    jg nextStar
    mov BYTE PTR [esi+2], 0 
    pusha
    movzx ebx, byte ptr [esi] 
    sub ebx, scrollPos
    mov dl, bl
    mov dh, byte ptr [esi+1]
    call Gotoxy
    mov al, ' '
    call WriteChar
    popa
    mov isTurbo, 1
    mov turboTime, TURBO_DURATION
    ;call PlayPowerupSound
   
nextStar:
    add esi, 3 
    jmp starLoop
noDraw:
    popa
    ret
checkStars ENDP

drawStars PROC
    pusha
    mov eax, lightBlue + (black * 16) 
    call SetTextColor
    mov esi,OFFSET starsList
starsLoop:
    mov al,[esi]
    cmp al,0
    je noMoreStars
    movzx ebx,al 
    mov al,[esi+1] 
    mov dh,al
    mov al,[esi+2] 
    cmp al,1
    jne nextStarDraw 
    sub ebx,scrollPos
    cmp ebx,100
    jge nextStarDraw
    cmp ebx,0
    jl nextStarDraw
    mov dl,bl
    call Gotoxy
    mov al,'*' 
    call WriteChar
nextStarDraw:
    add esi, 3
    jmp starsLoop
noMoreStars:
    popa
    ret
drawStars ENDP

getBoost PROC
    pusha
    mov esi,OFFSET boostList
boostCheck:
    mov al,[esi]
    cmp al,0
    je noBOOST
    movzx ebx,al
    sub ebx,scrollPos
    inc esi
    mov al,[esi]
    mov dh,al 
    inc esi
    mov al,[esi]
    cmp al,0
    je nextBoostCheck 
    movzx eax,marioX
    cmp eax,ebx
    jl nextBoostCheck
    inc ebx
    cmp eax,ebx
    jg nextBoostCheck
    movzx eax,marioY
    cmp al,dh
    jne nextBoostCheck
    mov BYTE PTR [esi],0 
    mov hasBoost, 1
    mov boostTime, POWERUP_LIMIT
    add score, 1000
    ;call PlayPowerupSound
    call checkLifeBonus 
    call renderLevel 
nextBoostCheck:
    inc esi
    jmp boostCheck
noBOOST:
    popa
    ret
getBoost ENDP

renderLevel PROC
    pusha
    
    mov justScrolled, 1
    
    mov eax, blue + (black * 16)
    call SetTextColor
    
    mov dh,2
    mov dl,0
    call Gotoxy
    mov esi,OFFSET skyLevel
    add esi,scrollPos
    mov ecx,99 
drawSky:
    lodsb
    cmp al,0
    jne goodSky
    mov al, ' ' 
goodSky:
    call WriteChar
    loop drawSky

    mov edi, 3
clearAir:
    cmp edi, 27
    jge airDone
    
    mov dl, 0
    mov dh, al
    mov eax, edi
    mov dh, al
    call Gotoxy
    
    mov edx, OFFSET blankLine
    call WriteString
    
    inc edi
    jmp clearAir
airDone:

    mov eax, lightGreen + (black * 16)
    call SetTextColor
    mov dh,27
    mov dl,0
    call Gotoxy
    mov esi,OFFSET sceneryLayer
    add esi,scrollPos
    mov ecx,99              
drawScenery:
    lodsb
    cmp al,0
    jne goodScenery
    mov al, ' '
goodScenery:
    call WriteChar
    loop drawScenery

    
    mov eax, white + (black * 16)
    call SetTextColor
    mov dl, 0
    mov dh, 28
    call Gotoxy
    mov edx, OFFSET blankLine
    call WriteString

    mov eax, Gray + (black * 16)
    call SetTextColor
    mov dh,29
    mov dl,0
    call Gotoxy
    mov esi,OFFSET groundLevel
    add esi,scrollPos
    mov ecx,99              
drawGround:
    lodsb
    cmp al,0
    jne goodGround
    mov al, ' '
goodGround:
    call WriteChar
    loop drawGround

    
    call drawPlatforms
    call drawShafts
    call drawBoxes
    call drawPowerCrates
    call drawSolidBlocks
    call drawPhantomBlocks
    call drawCoins
    call drawStars 
    call drawFlag 
    popa
    ret
renderLevel ENDP

drawFlag PROC
    mov eax, 170 
    sub eax, scrollPos
    cmp eax, 0
    jl noFlag
    cmp eax, 99
    jg noFlag
    mov dl, al 
    mov dh, 15 
    mov ecx, 14 
    mov eax, lightRed + (black * 16) 
    call SetTextColor
flagLoop:
    call Gotoxy
    mov al, '|'
    call WriteChar
    inc dh
    loop flagLoop
    mov dh, 15
    call Gotoxy
    mov al, '>' 
    call WriteChar
noFlag:
    ret
drawFlag ENDP

drawCoins PROC
    pusha
    mov eax, yellow + (black * 16) 
    call SetTextColor
    mov esi,OFFSET coinsList
coinLoop:
    mov al,[esi]
    cmp al,0
    je coinEnd
    movzx ebx,al 
    mov al,[esi+1] 
    mov dh,al
    mov al,[esi+2] 
    cmp al,1
    jne nextCoin 
    sub ebx,scrollPos
    cmp ebx,100
    jge nextCoin
    cmp ebx,0
    jl nextCoin
    mov dl,bl
    call Gotoxy
    mov al,'o' 
    call WriteChar
nextCoin:
    add esi, 3
    jmp coinLoop
coinEnd:
    popa
    ret
drawCoins ENDP

checkCoins PROC
    pusha
    mov esi,OFFSET coinsList
coinCheck:
    mov al,[esi]
    cmp al,0
    je coinCheckEnd
    movzx ebx,al   
    mov al,[esi+1] 
    mov dh,al      
    mov al,[esi+2] 
    cmp al,1
    jne nextCoinCheck 
    sub ebx, scrollPos
    movzx eax, marioX
    sub eax, ebx 
    cmp eax, 0 
    jne nextCoinCheck 
    movzx eax, marioY
    sub al, dh
    movsx eax, al
    jns yDelta
    neg eax
yDelta:
    cmp eax, 1 
    jg nextCoinCheck
    mov BYTE PTR [esi+2], 0 
    pusha
    movzx ebx, byte ptr [esi] 
    sub ebx, scrollPos
    mov dl, bl
    mov dh, byte ptr [esi+1]
    call Gotoxy
    mov al, ' '
    call WriteChar
    popa
    add score, 10          
    add totalCoins, 1  
    ;call PlayCoinSound
    call checkLifeBonus 
nextCoinCheck:
    add esi, 3 
    jmp coinCheck
coinCheckEnd:
    popa
    ret
checkCoins ENDP

drawPowerCrates PROC
    pusha
    mov esi,OFFSET boostList
powerDraw:
    mov al,[esi]
    cmp al,0
    je powerEnd
    movzx ebx,al
    sub ebx,scrollPos
    cmp ebx,100
    jge skipPower
    cmp ebx,0
    jl skipPower
    mov dl,bl
    inc esi
    mov al,[esi]
    mov dh,al
    inc esi
    mov al,[esi]
    cmp al,1
    jne emptyPower
    mov eax, blue + (black * 16)
    call SetTextColor
    call Gotoxy
    mov al,'{' 
    call WriteChar
    mov al,'*'
    call WriteChar
    mov al,'}' 
    call WriteChar
    jmp nextPower
emptyPower:
    mov eax, brown + (black * 16)
    call SetTextColor
    call Gotoxy
    mov al,'{'
    call WriteChar
    mov al,' '
    call WriteChar
    mov al,'}'
    call WriteChar
nextPower:
    inc esi
    jmp powerDraw
skipPower:
    inc esi
    inc esi
    jmp powerDraw
powerEnd:
    popa
    ret
drawPowerCrates ENDP

drawPlatforms PROC
    pusha
    mov eax, blue + (black * 16)
    call SetTextColor
    mov esi,OFFSET platformsList
platDraw:
    lodsb
    cmp al,0
    je platEnd
    movzx ebx,al
    sub ebx,scrollPos
    cmp ebx,100
    jge skipPlat
    cmp ebx,0
    jl skipPlat
    mov dl,bl
    lodsb
    mov dh,al
    lodsb
    movzx ecx,al
    call Gotoxy
drawPlatSeg:
    push ecx
    mov al,'^' 
    call WriteChar
    mov al,'^' 
    call WriteChar
    pop ecx
    loop drawPlatSeg
    jmp platDraw
skipPlat:
    inc esi
    inc esi
    jmp platDraw
platEnd:
    popa
    ret
drawPlatforms ENDP

drawShafts PROC
    pusha
    mov eax, red + (black * 16)
    call SetTextColor
    mov esi,OFFSET shaftsList
shaftDraw:
    lodsb
    cmp al,0
    je shaftEnd
    movzx ebx,al
    sub ebx,scrollPos
    cmp ebx,100
    jge skipShaft
    cmp ebx,0
    jl skipShaft
    mov dl,bl
    lodsb
    movzx ecx,al 
    mov dh,29
    sub dh,cl 
drawShaftSeg:
    push ecx
    call Gotoxy
    mov al,'#' 
    call WriteChar
    mov al,'#' 
    call WriteChar
    inc dh
    pop ecx
    loop drawShaftSeg
    jmp shaftDraw
skipShaft:
    inc esi
    jmp shaftDraw
shaftEnd:
    popa
    ret
drawShafts ENDP

drawBoxes PROC
    pusha
    mov eax, brown + (black * 16)
    call SetTextColor
    mov esi,OFFSET boxesList
boxDraw:
    lodsb
    cmp al,0
    je boxEnd
    movzx ebx,al
    sub ebx,scrollPos
    cmp ebx,100
    jge skipBox
    cmp ebx,0
    jl skipBox
    mov dl,bl
    lodsb
    mov dh,al
    lodsb
    cmp al,1
    jne emptyBox
    call Gotoxy
    mov al,'['
    call WriteChar
    mov al,'?'
    call WriteChar
    mov al,']'
    call WriteChar
    jmp boxDraw
emptyBox:
    call Gotoxy
    mov al,'['
    call WriteChar
    mov al,' '
    call WriteChar
    mov al,']'
    call WriteChar
    jmp boxDraw
skipBox:
    inc esi
    inc esi
    jmp boxDraw
boxEnd:
    popa
    ret
drawBoxes ENDP

drawSolidBlocks PROC
    pusha
    mov eax, brown + (black * 16)
    call SetTextColor
    mov esi,OFFSET blocksList
solidDraw:
    lodsb
    cmp al,0
    je solidEnd
    movzx ebx,al
    sub ebx,scrollPos
    cmp ebx,100
    jge skipSolid
    cmp ebx,0
    jl skipSolid
    mov dl,bl
    lodsb
    mov dh,al
    call Gotoxy
    mov al,'<' 
    call WriteChar
    mov al,'>' 
    call WriteChar
    jmp solidDraw
skipSolid:
    inc esi
    jmp solidDraw
solidEnd:
    popa
    ret
drawSolidBlocks ENDP

drawPhantomBlocks PROC
    pusha
    mov eax, brown + (black * 16)
    call SetTextColor
    mov esi,OFFSET phantomList
phantomDraw:
    lodsb
    cmp al,0
    je phantomEnd
    movzx ebx,al
    sub ebx,scrollPos
    lodsb
    mov dh,al
    lodsb
    cmp al,0
    je skipPhantom 
    cmp ebx,100
    jge skipPhantom
    cmp ebx,0
    jl skipPhantom
    mov dl,bl
    call Gotoxy
    mov al,'['
    call WriteChar
    mov al,'!' 
    call WriteChar
    mov al,']'
    call WriteChar
    jmp phantomDraw
skipPhantom:
    jmp phantomDraw
phantomEnd:
    popa
    ret
drawPhantomBlocks ENDP

revealPhantomBlocks PROC
    pusha
    mov esi,OFFSET phantomList
revealLoop:
    lodsb
    cmp al,0
    je revealEnd
    movzx ebx,al
    sub ebx,scrollPos
    lodsb
    mov dh,al 
    movzx eax,marioX
    cmp eax,ebx
    jne nextReveal
    movzx eax,marioY
    cmp al,dh
    jne nextReveal
    mov al,[esi]
    cmp al,1
    je nextReveal 
    mov BYTE PTR [esi],1 
    add score,100
    call checkLifeBonus 
    call renderLevel
nextReveal:
    inc esi
    jmp revealLoop
revealEnd:
    popa
    ret
revealPhantomBlocks ENDP

activateBoxes PROC
    pusha
    mov esi,OFFSET boxesList
boxActive:
    lodsb
    cmp al,0
    je activeEnd
    movzx ebx,al
    sub ebx,scrollPos
    lodsb
    mov cl,al 
    movzx eax,marioX
    cmp eax,ebx
    jl checkNextBox
    cmp eax,ebx
    jg checkNextBoxX
    movzx eax,marioY
    mov dh,cl
    dec dh
    cmp al,dh
    jne checkNextBox
    mov al,[esi]
    cmp al,0
    je checkNextBox 
    mov BYTE PTR [esi],0
    add score,200
    add totalCoins, 1
    call checkLifeBonus 
    call renderLevel
    jmp checkNextBox
checkNextBoxX:
    inc ebx
    cmp eax,ebx
    jne checkNextBox
    movzx eax,marioY
    mov dh,cl
    dec dh
    cmp al,dh
    jne checkNextBox
    mov al,[esi]
    cmp al,0
    je checkNextBox
    mov BYTE PTR [esi],0
    add score,200
    add totalCoins, 1
    call checkLifeBonus 
    call renderLevel
checkNextBox:
    inc esi
    jmp boxActive
activeEnd:
    popa
    ret
activateBoxes ENDP

showTitle PROC
    pusha
    call Clrscr
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 15
    call Gotoxy
    mov edx, OFFSET msgTitle 
    call WriteString
    mov dl, 25
    mov dh, 17
    call Gotoxy
    mov edx, OFFSET msgTitleLine
    call WriteString
    
    mov eax, cyan + (black * 16)
    call SetTextColor
    mov dl, 55
    mov dh, 19
    call Gotoxy
    mov edx, OFFSET msgRollNum
    call WriteString
    mov eax, white + (black * 16)
    call SetTextColor
    mov eax, white + (black * 16)
    mov dl, 50
    mov dh, 22 
    call Gotoxy
    mov edx, OFFSET msgPressStart
    call WriteString
    popa
    ret
showTitle ENDP

showMenu PROC
    pusha
    call Clrscr
    
    ; Draw Level 1 background (static)
    ; Draw sky layer
    mov eax, blue + (black * 16)
    call SetTextColor
    mov dh, 2
    mov dl, 0
    call Gotoxy
    mov esi, OFFSET L1_skyLevel
    mov ecx, 99
drawMenuSky:
    lodsb
    cmp al, 0
    jne goodMenuSky
    mov al, ' '
goodMenuSky:
    call WriteChar
    loop drawMenuSky
    
    ; Draw scenery layer
    mov eax, lightGreen + (black * 16)
    call SetTextColor
    mov dh, 27
    mov dl, 0
    call Gotoxy
    mov esi, OFFSET L1_sceneryLayer
    mov ecx, 99
drawMenuScenery:
    lodsb
    cmp al, 0
    jne goodMenuScenery
    mov al, ' '
goodMenuScenery:
    call WriteChar
    loop drawMenuScenery
    
    ; Draw ground layer
    mov eax, Gray + (black * 16)
    call SetTextColor
    mov dh, 29
    mov dl, 0
    call Gotoxy
    mov esi, OFFSET L1_groundLevel
    mov ecx, 99
drawMenuGround:
    lodsb
    cmp al, 0
    jne goodMenuGround
    mov al, ' '
goodMenuGround:
    call WriteChar
    loop drawMenuGround
    
    mov eax, white + (black * 16)
    call SetTextColor
    
    mov dh, 9
    mov dl, 35
    mov ecx, 5
clearMenuLines:
    push ecx
    call Gotoxy
    mov edx, OFFSET blankLine
    push edx
    mov ecx, 50
    mov al, ' '
printSpaces:
    call WriteChar
    loop printSpaces
    pop edx
    inc dh
    inc dh
    pop ecx
    loop clearMenuLines
    
    mov dl, 50
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET msgStartGame
    call WriteString
    
    mov dl, 50
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET msgHighScore
    call WriteString
    
    mov dl, 50
    mov dh, 14
    call Gotoxy
    mov edx, OFFSET msgHelpScreen
    call WriteString
    
    mov dl, 50
    mov dh, 16
    call Gotoxy
    mov edx, OFFSET msgQuitGame
    call WriteString
    
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov dl, 55
    mov dh, 18
    call Gotoxy
    mov edx, OFFSET msgBestScore
    call WriteString
    mov eax, bestScore
    call WriteDec
    
    mov eax, white + (black * 16)
    call SetTextColor
    mov al, menuChoice
    cmp al, 0
    je drawMenuStart
    cmp al, 1
    je drawMenuHigh
    cmp al, 2
    je drawMenuHelp
    cmp al, 3
    je drawMenuQuit

drawMenuStart:
    mov dl, 47
    mov dh, 10
    jmp drawMenuArrow

drawMenuHigh:
    mov dl, 47
    mov dh, 12
    jmp drawMenuArrow

drawMenuHelp:
    mov dl, 47
    mov dh, 14
    jmp drawMenuArrow

drawMenuQuit:
    mov dl, 47
    mov dh, 16

drawMenuArrow:
    call Gotoxy
    mov edx, OFFSET msgSelection
    call WriteString
    
    popa
    ret
showMenu ENDP

showInstructions PROC
    pusha
    call Clrscr
    mov eax, white + (black * 16)
    call SetTextColor
    mov dl, 50
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET msgHelpScreen
    call WriteString
    mov dl, 50
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET msgControls 
    call WriteString
    mov dl, 15
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET msgJump
    call WriteString
    mov dl, 15
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET msgMoveLeft
    call WriteString
    mov dl, 15
    mov dh, 9
    call Gotoxy
    mov edx, OFFSET msgMoveRight
    call WriteString
    mov dl, 15
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET msgPause
    call WriteString
    mov dl, 45
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET msgGameMission 
    call WriteString
    mov dl, 45
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET msgCollect
    call WriteString
    mov dl, 45
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET msgEnemies
    call WriteString
    mov dl, 45
    mov dh, 9
    call Gotoxy
    mov edx, OFFSET msgExit
    call WriteString
    mov dl, 25
    mov dh, 15
    call Gotoxy
    mov edx, OFFSET msgBackMenu
    call WriteString
    popa
    ret
showInstructions ENDP

showPauseMenu PROC
    pusha

    call Clrscr

    mov eax, white + (black*16)
    call SetTextColor

    mov dl, 50
    mov dh, 11
    call Gotoxy
    mov edx, OFFSET msgResumeGame
    call WriteString

    mov dl, 50
    mov dh, 13
    call Gotoxy
    mov edx, OFFSET msgQuitToMenu
    call WriteString

    mov al, pauseChoice
    cmp al, 0
    je drawResume
    cmp al, 1
    je drawPauseQuit

drawResume:
    mov dl, 48
    mov dh, 11
    jmp drawPauseArrow

drawPauseQuit:
    mov dl, 50
    mov dh, 13

drawPauseArrow:
    call Gotoxy
    mov edx, OFFSET msgSelection
    call WriteString

    popa
    ret
showPauseMenu ENDP

showTransition PROC
    pusha
    call Clrscr
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET msgLevelComplete
    call WriteString
    mov dl, 25
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET msgBossLevel
    call WriteString
    mov eax, white + (black * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 16
    call Gotoxy
    mov edx, OFFSET msgStartLevel
    call WriteString
    popa
    ret
showTransition ENDP

getName PROC
    pusha
    call Clrscr
    
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET msgEnterName
    call WriteString
    
    mov edi, OFFSET currentName
    mov ecx, NAME_LENGTH
    mov al, 0
clearName:
    mov [edi], al
    inc edi
    loop clearName
    
    mov eax, white + (black * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET currentName
    mov ecx, 15
    call ReadString
    
    popa
    ret
getName ENDP

addScore PROC
    pusha
    
    mov eax, score
    cmp eax, 0
    je skipNewScore
    
    mov eax, scoreCount
    cmp eax, MAX_SCORES
    jge checkBetter
    
    mov ebx, eax
    imul ebx, NAME_LENGTH
    lea edi, playerNames
    add edi, ebx
    lea esi, currentName
    mov ecx, NAME_LENGTH
copyName:
    mov al, [esi]
    mov [edi], al
    inc esi
    inc edi
    loop copyName
    
    mov eax, scoreCount
    shl eax, 2
    lea edi, playerScores
    add edi, eax
    mov eax, score
    mov [edi], eax
    
    inc scoreCount
    call sortScores
    jmp skipNewScore

checkBetter:
    mov eax, MAX_SCORES
    dec eax
    shl eax, 2
    lea esi, playerScores
    add esi, eax
    mov ebx, [esi]
    mov eax, score
    cmp eax, ebx
    jle skipNewScore
    
    mov eax, MAX_SCORES
    dec eax
    imul eax, NAME_LENGTH
    lea edi, playerNames
    add edi, eax
    lea esi, currentName
    mov ecx, NAME_LENGTH
copyReplaceName:
    mov al, [esi]
    mov [edi], al
    inc esi
    inc edi
    loop copyReplaceName
    
    mov eax, MAX_SCORES
    dec eax
    shl eax, 2
    lea edi, playerScores
    add edi, eax
    mov eax, score
    mov [edi], eax
    
    call sortScores

skipNewScore:
    popa
    ret
addScore ENDP

sortScores PROC
    pusha
    
    mov ecx, scoreCount
    cmp ecx, 1
    jle doneSort
    
sortOuter:
    mov ebx, 0
    mov esi, 0
    
sortInner:
    mov eax, esi
    inc eax
    cmp eax, scoreCount
    jge checkSwapFlag
    
    push esi
    mov eax, esi
    shl eax, 2
    lea edi, playerScores
    add edi, eax
    mov eax, [edi]
    mov edx, [edi+4]
    
    cmp eax, edx
    jge noNeedSwap
    
    mov [edi], edx
    mov [edi+4], eax
    
    pop esi
    push esi
    mov eax, esi
    imul eax, NAME_LENGTH
    lea edi, playerNames
    add edi, eax
    mov esi, edi
    add edi, NAME_LENGTH
    
    mov ecx, NAME_LENGTH
swapName:
    mov al, [esi]
    mov dl, [edi]
    mov [edi], al
    mov [esi], dl
    inc esi
    inc edi
    loop swapName
    
    mov ebx, 1
    
noNeedSwap:
    pop esi
    inc esi
    jmp sortInner
    
checkSwapFlag:
    cmp ebx, 0
    je doneSort
    jmp sortOuter
    
doneSort:
    cmp scoreCount, 0
    je skipUpdateBest
    lea esi, playerScores
    mov eax, [esi]
    mov bestScore, eax
skipUpdateBest:
    popa
    ret
sortScores ENDP
loadScores PROC
    pusha
    
    ; Initialize
    mov scoreCount, 0
    mov bestScore, 0
    
    ; Clear existing data
    mov edi, OFFSET playerNames
    mov ecx, MAX_SCORES * NAME_LENGTH
    mov al, 0
clearNames:
    mov [edi], al
    inc edi
    loop clearNames
    
    mov edi, OFFSET playerScores
    mov ecx, MAX_SCORES
    mov eax, 0
clearScores:
    mov [edi], eax
    add edi, 4
    loop clearScores
    
    ; Open file
    mov edx, OFFSET filename
    call OpenInputFile
    cmp eax, INVALID_HANDLE_VALUE
    je noScoresFile
    
    mov fileHandle, eax
    
    ; Read file
    mov edx, OFFSET fileBuffer
    mov ecx, 1000
    call ReadFromFile
    mov bytesRead, eax
    
    cmp eax, 0
    je fileclose
    
    ; Parse scores
    mov esi, OFFSET fileBuffer
    mov edi, 0
    
parseLoop:
    cmp edi, MAX_SCORES
    jge fileclose
    
    ; Check if we're at end of buffer
    mov eax, esi
    sub eax, OFFSET fileBuffer
    cmp eax, bytesRead
    jge fileclose
    
    ; Skip any leading whitespace/newlines
skipWhitespace:
    mov al, [esi]
    cmp al, 0
    je fileclose
    cmp al, 13
    je skipWS
    cmp al, 10
    je skipWS
    cmp al, ' '
    je skipWS
    jmp startParseName
skipWS:
    inc esi
    mov eax, esi
    sub eax, OFFSET fileBuffer
    cmp eax, bytesRead
    jge fileclose
    jmp skipWhitespace
    
startParseName:
    ; Get name buffer address
    push edi
    mov eax, edi
    imul eax, NAME_LENGTH
    lea ebx, playerNames
    add ebx, eax
    mov ecx, 0
    
readNameLoop:
    mov eax, esi
    sub eax, OFFSET fileBuffer
    cmp eax, bytesRead
    jge parseError
    
    mov al, [esi]
    cmp al, 0
    je parseError
    cmp al, ':'
    je parseScore
    cmp al, 13
    je skipNameChar
    cmp al, 10
    je parseError
    
    cmp ecx, NAME_LENGTH - 1
    jge skipToColon
    
    mov [ebx], al
    inc ebx
    inc ecx
    
skipNameChar:
    inc esi
    jmp readNameLoop
    
skipToColon:
    mov al, [esi]
    cmp al, ':'
    je parseScore
    inc esi
    mov eax, esi
    sub eax, OFFSET fileBuffer
    cmp eax, bytesRead
    jge parseError
    jmp skipToColon
    
parseScore:
    mov BYTE PTR [ebx], 0
    inc esi
    pop edi
    push edi
    
    ; Parse score number
    mov eax, 0
    mov ebx, 10
    
readDigits:
    push eax
    mov eax, esi
    sub eax, OFFSET fileBuffer
    cmp eax, bytesRead
    pop eax
    jge storeScore
    
    mov cl, [esi]
    cmp cl, 0
    je storeScore
    cmp cl, 13
    je storeScore
    cmp cl, 10
    je storeScore
    cmp cl, ' '
    je storeScore
    cmp cl, '0'
    jl storeScore
    cmp cl, '9'
    jg storeScore
    
    sub cl, '0'
    mul ebx
    movzx ecx, cl
    add eax, ecx
    inc esi
    jmp readDigits
    
storeScore:
    pop edi
    push edi
    mov ebx, edi
    shl ebx, 2
    lea ecx, playerScores
    add ecx, ebx
    mov [ecx], eax
    
    pop edi
    inc edi
    inc scoreCount
    
    ; Skip to next line
skipToNewline:
    push eax
    mov eax, esi
    sub eax, OFFSET fileBuffer
    cmp eax, bytesRead
    pop eax
    jge fileclose
    
    mov al, [esi]
    inc esi
    cmp al, 10
    je parseLoop
    cmp al, 0
    je fileclose
    jmp skipToNewline
    
parseError:
    pop edi
    jmp fileclose
    
fileclose:
    mov eax, fileHandle
    call CloseFile
    call sortScores
    jmp loadEnd
    
noScoresFile:
    mov scoreCount, 0
    mov bestScore, 0
    
loadEnd:
    popa
    ret
loadScores ENDP

saveScores PROC
    pusha
    
    mov edx, OFFSET filename
    call CreateOutputFile
    cmp eax, INVALID_HANDLE_VALUE
    je skipWrite
    
    mov fileHandle, eax
    
    mov esi, 0
    
writeScores:
    cmp esi, scoreCount
    jge writeEnd
    
    push esi
    mov edi, OFFSET fileBuffer
    mov ecx, 100
    mov al, 0
clearBuf:
    mov [edi], al
    inc edi
    loop clearBuf
    pop esi
    
    mov edi, OFFSET fileBuffer
    
    push esi
    mov eax, esi
    imul eax, NAME_LENGTH
    lea ebx, playerNames
    add ebx, eax
copyNameWrite:
    mov al, [ebx]
    cmp al, 0
    je nameCopied
    mov [edi], al
    inc ebx
    inc edi
    jmp copyNameWrite
nameCopied:
    mov BYTE PTR [edi], ':'
    inc edi
    
    pop esi
    push esi
    mov eax, esi
    shl eax, 2
    lea ebx, playerScores
    add ebx, eax
    mov eax, [ebx]
    
    mov ebx, 10
    mov ecx, 0
pushDigits:
    mov edx, 0
    div ebx
    push dx
    inc ecx
    test eax, eax
    jnz pushDigits
    
popDigits:
    pop dx
    add dl, '0'
    mov [edi], dl
    inc edi
    loop popDigits
    
    mov BYTE PTR [edi], 13
    inc edi
    mov BYTE PTR [edi], 10
    inc edi
    
    mov ecx, edi
    sub ecx, OFFSET fileBuffer
    mov eax, fileHandle
    mov edx, OFFSET fileBuffer
    call WriteToFile
    
    pop esi
    inc esi
    jmp writeScores
    
writeEnd:
    mov eax, fileHandle
    call CloseFile
    
skipWrite:
    popa
    ret
saveScores ENDP

showHighScores PROC
    pusha
    call Clrscr
    
    mov eax, yellow + (black * 16)
    call SetTextColor

    mov dl, 50           
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET msgHighScoresTitle
    call WriteString
    
    mov eax, white + (black * 16)
    call SetTextColor
    
    cmp scoreCount, 0
    je showEmpty
    
    mov esi, 0          

showLoop:
    cmp esi, scoreCount
    jge doneShow

    mov eax, esi         
    add eax, 5            
    mov dh, al           
    
    mov dl, 30           
    call Gotoxy

    mov eax, esi
    inc eax              
    call WriteDec
    mov edx, OFFSET msgRank
    call WriteString     

    ; ===== NAME =====
    mov eax, esi
    imul eax, NAME_LENGTH
    lea edx, playerNames
    add edx, eax
    call WriteString

    mov edx, OFFSET msgDashScore
    call WriteString

    mov eax, esi
    shl eax, 2            
    lea ebx, playerScores
    add ebx, eax
    mov eax, [ebx]
    call WriteDec

    inc esi
    jmp showLoop    

showEmpty:
    mov dl, 50
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET msgEmptyScores
    call WriteString
    
doneShow:
    mov dl, 55
    mov dh, 22
    call Gotoxy
    mov edx, OFFSET msgBackMenu
    call WriteString
    
    popa
    ret
showHighScores ENDP


END main

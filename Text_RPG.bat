@echo off
title Text RPG
color 0a
mode 1000
if "%1" neq "" ( goto %1)

: ----------Menu------------------------------------------------------------------------------------------------------- :
:Menu
cls
echo.
echo ^8^8^8^8^8^8^8^8^8^8^8                ^8^8^8         ^8^8^8^8^8^8^8^b^.  ^8^8^8^8^8^8^8^b^.   ^.^d^8^8^8^8^b^.  
echo     ^8^8^8                    ^8^8^8         ^8^8^8   ^Y^8^8^b ^8^8^8   ^Y^8^8^b ^d^8^8^P  ^Y^8^8^b 
echo     ^8^8^8                    ^8^8^8         ^8^8^8    ^8^8^8 ^8^8^8    ^8^8^8 ^8^8^8    ^8^8^8 
echo     ^8^8^8   ^.^d^8^8^b^.  ^8^8^8  ^8^8^8 ^8^8^8^8^8^8      ^8^8^8   ^d^8^8^P ^8^8^8   ^d^8^8^P ^8^8^8        
echo     ^8^8^8  ^d^8^P  ^Y^8^b ^`^Y^8^b^d^8^P^' ^8^8^8         ^8^8^8^8^8^8^8^P^"  ^8^8^8^8^8^8^8^P^"  ^8^8^8  ^8^8^8^8^8 
echo     ^8^8^8  ^8^8^8^8^8^8^8^8   ^X^8^8^K   ^8^8^8         ^8^8^8 ^T^8^8^b   ^8^8^8        ^8^8^8    ^8^8^8 
echo     ^8^8^8  ^Y^8^b^.     ^.^d^8^"^"^8^b^. ^Y^8^8^b^.       ^8^8^8  ^T^8^8^b  ^8^8^8        ^Y^8^8^b  ^d^8^8^P 
echo     ^8^8^8   ^"^Y^8^8^8^8  ^8^8^8  ^8^8^8  ^"^Y^8^8^8      ^8^8^8   ^T^8^8^b ^8^8^8         ^'^Y^8^8^8^8^P^8^8 
echo.
echo You must enter 1, 2, 3, or 4.
echo.
echo 1. New Game
echo 2. Load Game
echo 3. Credits
echo 4. Exit
set /p answer=Type the number of your option and press enter : 
if %answer%==1 goto New_Game
if %answer%==2 goto Load_Game
if %answer%==3 goto Credits
if %answer%==4 goto Exit
else goto Menu

: ----------Create new game-------------------------------------------------------------------------------------------- :
:New_Game
cls
echo Are you sure you would like to start a new game?
echo This will erase any previous saved game data.
echo.
echo 1. Yes, start new game
echo 2. No, back to the menu
set /p answer=Type the number of your option and press enter : 
if %answer%==1 goto Start_1
if %answer%==2 goto Menu
else goto New_Game

: ----------Create new game data--------------------------------------------------------------------------------------- :
:Start_1
cls
SET /A player_health = 100
SET /A player_attack = 5
SET /A battles_won = 0
SET /A health_potions = 1
SET /A savepoint = 1
echo Health: %player_health%     Attack: %player_attack%
echo Health Potions: %health_potions%
(
	echo %player_health%
	echo %player_attack%
    echo %battles_won%
    echo %health_potions%
    echo %savepoint%
) > savegame.sav
echo.
echo Text RPG start message.
echo.
pause
goto Load_Game

: ----------Savepoint_1----------------------------------------------------------------------------------------------- :
:Savepoint_1
SET /A goblin_health = 50
SET /A goblin_attack = 3
goto Savepoint_1_1
:Savepoint_1_1
set /a attackNum1=%random% %%3 +1
SET /A player_damage=%player_attack%+%attackNum1%
set /a attackNum2=%random% %%3 +1
set /A goblin_damage=%goblin_attack%+%attackNum2%
set /a player_defend=%player_damage% - 2
set /a goblin_defend=%goblin_damage% - 3
SET /A potionNum1=%random% %%3 +1
set /a potion_heal=%potionNum1%+15
cls
echo Health: %player_health%     Attack: %player_attack%
echo Health Potions: %health_potions%
echo.
echo As you enter a dark room of the Hive, one goblin warrior emerges with club raised to fight.
echo Goblin Health: %goblin_health%     Goblin Attack: %goblin_attack%
echo.
echo 1. Attack with spear.
echo 2. Defend with spear.
if %health_potions% GEQ 1 echo 3. Drink health potion.
set /p answer=Type the number of your option and press enter : 
if %answer%==1 (
    SET /A goblin_health -= %player_damage%
    SET /A player_health -= %goblin_damage%
    echo.
    echo You stab the goblin and it strikes back!
    echo The goblin takes %player_damage% damage!
    echo You take %goblin_damage% damage!
    pause
)
if %answer%==2 (
    SET /A goblin_health -= %player_defend%
    SET /A player_health -= %goblin_defend%
    echo.
    echo You hold your spear out and the goblin scrapes it as it rushes to club you.
    echo The goblin takes %player_defend% damage!
    echo You take %goblin_defend% damage!
    pause
)
if %answer%==3 (
    if %health_potions% GEQ 1 (
        SET /A player_health += %potion_heal%
        set /a player_health -= %goblin_damage%
        SET /A health_potions -= 1
        echo.
        echo You chug a potion from your inventory and gain %potion_heal% health.
        echo The goblin clubs you and you take %goblin_damage% damage!
    )
    if %health_potions% LEQ 0 (
        echo.
        echo You have no health potions.
        pause
        goto Savepoint_1_1
    )
    pause
)
if %goblin_health% LEQ 0 (
    SET /A battles_won = %battles_won% + 1
    SET /A savepoint = 2
    (
	    echo %player_health%
	    echo %player_attack%
        echo %battles_won%
        echo %health_potions%
        echo %savepoint%
    ) > savegame.sav

    if %battles_won% GEQ 5 (
        goto Final_Battle
    )
    goto Savepoint_2
)
if %player_health% LEQ 0 (
    goto Credits
)
goto Savepoint_1_1

: ----------Savepoint_2----------------------------------------------------------------------------------------------- :
:Savepoint_2
cls
echo Health: %player_health%     Attack: %player_attack%
echo Health Potions: %health_potions%
echo.
echo Savepoint_2 goes here.
echo.
pause
goto Final_Battle

: ----------Final Battle---------------------------------------------------------------------------------------------- :
:Final_Battle
cls
echo Health: %player_health%     Attack: %player_attack%
echo Health Potions: %health_potions%
echo.
echo Final battle goes here.
echo.
pause
goto Victory

: ----------Victory--------------------------------------------------------------------------------------------------- :
:Victory
cls
echo Victory
pause
goto Credits

: ----------Load game file-------------------------------------------------------------------------------------------- :
:Load_Game
cls
(
	set /p player_health=
	set /p player_attack=
    set /p battles_won=
    set /p health_potions=
    set /p savepoint=
) < savegame.sav 
echo Health: %player_health%     Attack: %player_attack%
echo Health Potions: %health_potions%
echo.
echo Continue your adventure.
echo.
pause
if %savepoint%==1 goto Savepoint_1
if %savepoint%==2 goto Savepoint_2
else goto Menu

: ----------Credits---------------------------------------------------------------------------------------------------- :
:Credits
cls
echo Credits
echo.
echo Thank you for playing!
echo Game created by __________.
pause
goto Menu

: ----------Exit Game-------------------------------------------------------------------------------------------------- :
:Exit
cls
echo Thanks for playing!
pause
exit /b
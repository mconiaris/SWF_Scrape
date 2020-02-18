from data.globalConstants import *
# Shingo Takagi
name = 'Shingo Takagi'

# General Card Definitions: 
#    1000 = OC
#    1001 = OC/TT
#    1002 = DC
GeneralCard = [1002, 1001, 1000, 1002, 1002, 1000, 1002, 1000, 1002, 1000, 1002]

# Offensive Card Definitions:
#    1003 = Pin attempt move (P/A)
#    1004 = Submission Move (*)
#    1005 = Specialty Move (S)
#    1006 = Disqualification Move (DQ)
#    1008 = Regular Offensive Move
#    1009 = Grudge Match Move (XX)
#    1010 = Ropes Move (ROPES)
OffensiveCard = \
[   {'MOVE_TYPE': 1010, 'MOVE_NAME': 'ROPES'},
    {   'MOVE_NAME': '"LAST FALCONI" WRIST-CLUTCH DEATH VALLEY DRIVER',
        'MOVE_TYPE': 1005},
    {   'MOVE_NAME': 'SWINGING KICK TO HEAD',
        'MOVE_POINTS': 7,
        'MOVE_TYPE': 1009},
    {'MOVE_POINTS': 6, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'CLOTHESLINE '},
    {'MOVE_POINTS': 6, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'FLYING KNEE SMASH'},
    {'MOVE_POINTS': 5, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'CHOPS'},
    {'MOVE_POINTS': 7, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'STIFF FOREARMS'},
    {'MOVE_POINTS': 8, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'FRONT SUPLEX'},
    {   'MOVE_NAME': 'REVERSE POWER BOMB (GALLON THROW)',
        'MOVE_POINTS': 9,
        'MOVE_TYPE': 1008},
    {   'MOVE_NAME': 'BLOOD FALL (SPICY DROP)',
        'MOVE_POINTS': 9,
        'MOVE_TYPE': 1003},
    {   'MOVE_NAME': '"MANRIKI" ANACONDA VICE',
        'MOVE_POINTS': 9,
        'MOVE_TYPE': 1004}]

# Defensive Card Definitions:
#    0 = B - No points on defense
#    2 = A - 2 points on defense
#    4 = C - 4 points on defense and neutralize offensive move
#    5 = Reverse - Reverse offensive move
DefensiveCard = [2, 0, 4, 2, 0, 0, 2, 0, 5, 2, 2]

# Specialty Card Definitions:
#    1003 = Pin attempt move (P/A)
#    1004 = Submission Move (*)
#    1005 = Specialty Move (S)
#    1006 = Disqualification Move (DQ)
Specialty = {   '"LAST FALCONI" WRIST-CLUTCH DEATH VALLEY DRIVER': [   {   'MOVE_POINTS': 9,
                                                               'MOVE_TYPE': 1005},
                                                           {   'MOVE_POINTS': 11,
                                                               'MOVE_TYPE': 1005},
                                                           {   'MOVE_POINTS': 12,
                                                               'MOVE_TYPE': 1005},
                                                           {   'MOVE_POINTS': 9,
                                                               'MOVE_TYPE': 1003},
                                                           {   'MOVE_POINTS': 10,
                                                               'MOVE_TYPE': 1005},
                                                           {   'MOVE_POINTS': 12,
                                                               'MOVE_TYPE': 1005}]}

# Ropes Card Definitions:
#    1003 = Pin attempt move (P/A)
#    1004 = Submission Move (*)
#    1005 = Specialty Move (S)
#    1006 = Disqualification Move (DQ)
#    1008 = Regular Offensive Move
#    1009 = Grudge Match Move (XX)
#    1010 = Ropes Move (ROPES)
#    1014 = No Action (NA)
Ropes = \
[   {'MOVE_POINTS': 0, 'MOVE_TYPE': 1014, 'MOVE_NAME': 'NA'},
    {'MOVE_POINTS': 8, 'MOVE_TYPE': 1004, 'MOVE_NAME': 'CRIPPLER CROSSFACE'},
    {'MOVE_POINTS': 7, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'FLYING KNEE SMASH'},
    {'MOVE_POINTS': 0, 'MOVE_TYPE': 1014, 'MOVE_NAME': 'NA'},
    {   'MOVE_NAME': 'CLOTHESLINE IN CORNER',
        'MOVE_POINTS': 8,
        'MOVE_TYPE': 1008},
    {'MOVE_POINTS': 6, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'SHOULDER TACKLE'},
    {'MOVE_POINTS': 0, 'MOVE_TYPE': 1014, 'MOVE_NAME': 'NA'},
    {   'MOVE_NAME': '"LAST FALCONI" WRIST-CLUTCH DEATH VALLEY DRIVER',
        'MOVE_TYPE': 1005},
    {'MOVE_POINTS': 6, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'CHOPS'},
    {'MOVE_POINTS': 0, 'MOVE_TYPE': 1014, 'MOVE_NAME': 'NA'},
    {'MOVE_POINTS': 8, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'BEARHUG'}]

Sub = (2, 7)
TagTeam = (2, 5)
Priority = (2, 2)
nameSet = "Philip's"

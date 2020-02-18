from data.globalConstants import *
# Ivan Koloff
name = 'Ivan Koloff'

# General Card Definitions: 
#    1000 = OC
#    1001 = OC/TT
#    1002 = DC
GeneralCard = [1000, 1001, 1000, 1002, 1002, 1000, 1000, 1002, 1002, 1000, 1002]

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
    {'MOVE_POINTS': 8, 'MOVE_TYPE': 1004, 'MOVE_NAME': 'RUSSIAN BACKBREAKER'},
    {'MOVE_POINTS': 9, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'HAMMER & SICKLE'},
    {'MOVE_POINTS': 8, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'SOVIET SLAM'},
    {'MOVE_POINTS': 6, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'CONTINUOUS FOREARMS'},
    {'MOVE_POINTS': 10, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'CHOKE WITH CHAINS'},
    {'MOVE_POINTS': 7, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'TURNBUCKLE SMASH'},
    {'MOVE_TYPE': 1005, 'MOVE_NAME': 'ATOMIC DROP'},
    {'MOVE_POINTS': 7, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'GLASNOST SUPLEX'},
    {'MOVE_POINTS': 11, 'MOVE_TYPE': 1009, 'MOVE_NAME': 'RUSKIE MIG DIVE'},
    {'MOVE_POINTS': 6, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'UNCLE IVAN KNEEDROP'}]

# Defensive Card Definitions:
#    0 = B - No points on defense
#    2 = A - 2 points on defense
#    4 = C - 4 points on defense and neutralize offensive move
#    5 = Reverse - Reverse offensive move
DefensiveCard = [2, 4, 2, 2, 0, 0, 0, 0, 2, 5, 2]

# Specialty Card Definitions:
#    1003 = Pin attempt move (P/A)
#    1004 = Submission Move (*)
#    1005 = Specialty Move (S)
#    1006 = Disqualification Move (DQ)
Specialty = {   'ATOMIC DROP': [   {'MOVE_POINTS': 10, 'MOVE_TYPE': 1003},
                       {'MOVE_POINTS': 12, 'MOVE_TYPE': 1005},
                       {'MOVE_POINTS': 11, 'MOVE_TYPE': 1005},
                       {'MOVE_POINTS': 8, 'MOVE_TYPE': 1005},
                       {'MOVE_POINTS': 14, 'MOVE_TYPE': 1005},
                       {'MOVE_POINTS': 11, 'MOVE_TYPE': 1005}]}

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
    {'MOVE_TYPE': 1006, 'MOVE_NAME': 'THROW OUT OF RING'},
    {'MOVE_POINTS': 11, 'MOVE_TYPE': 1003, 'MOVE_NAME': 'SMASH WITH CHAINS'},
    {'MOVE_POINTS': 0, 'MOVE_TYPE': 1014, 'MOVE_NAME': 'NA'},
    {'MOVE_POINTS': 0, 'MOVE_TYPE': 1014, 'MOVE_NAME': 'NA'},
    {'MOVE_POINTS': 6, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'BACK BODYDROP'},
    {'MOVE_POINTS': 6, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'CHOKE AGAINST ROPES'},
    {'MOVE_POINTS': 0, 'MOVE_TYPE': 1014, 'MOVE_NAME': 'NA'},
    {'MOVE_POINTS': 9, 'MOVE_TYPE': 1008, 'MOVE_NAME': 'RUSSIAN MIG DIVE'},
    {'MOVE_TYPE': 1006, 'MOVE_NAME': 'THROW OUT OF RING'},
    {'MOVE_POINTS': 0, 'MOVE_TYPE': 1014, 'MOVE_NAME': 'NA'}]

Sub = (2, 7)
TagTeam = (2, 5)
Priority = (3, 1)
nameSet = "NWA '88"

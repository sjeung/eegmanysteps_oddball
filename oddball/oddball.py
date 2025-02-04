#######################################
#
#      Create experiment using PsychoPy
#
#######################################
#
# Author: Julius Welzel (Klinik für Neurologie, UKSH Kiel,University of Kiel)
# Contact: j.welzel@neurologie.uni-kiel.de
# Version: 1.0 // setting up default (04.02.2025)


#import standard packages
import psychopy
psychopy.prefs.hardware['audioLib'] = ['PTB', 'pyo','pygame']
psychopy.prefs.hardware['audioLatencyMode'] = '3'
from psychopy import visual, core, event, sound, data
import numpy as np
from pylsl import StreamOutlet, StreamInfo
from win32api import GetSystemMetrics # pckg to retrieve screen size

# create stream info for lsl outlet
lsl_info = StreamInfo('PsychoPyMarker', 'Markers', 1, 0, 'string')
# next make an outlet
global lsl_outlet
lsl_outlet = StreamOutlet(lsl_info)

input('Press Enter to continue')


def main_experiment():

    ##################    Setup Psychopy     ####################
    win_width  = GetSystemMetrics(0)
    win_height = GetSystemMetrics(1)
    global win
    win = visual.Window(size=(win_width,win_height),fullscr=True, color=[-1,-1,-1], units='norm')

    global conditions
    conditions = generate_conditions(num_trials=100, num_targets=10, num_distractors=20)
    global trials
    trials = data.TrialHandler(trialList=conditions, nReps=1)

    global t_conditions
    t_conditions = generate_training_conditions()
    global t_trials
    t_trials = data.TrialHandler(trialList=t_conditions, nReps=1)

    ## ################    Stimuli Psychopy    #################

    ## intro
    global exp_text
    exp_text = visual.TextStim(win,
                               pos=[0,0],
                               color=(1,1,1))

    ## main trial components

    global circle_center
    circle_center = visual.Circle(win, radius=(.01*9/16,.01), fillColor="red", lineColor=None)

    global beep_target
    beep_target = sound.Sound(1200, secs=0.08, volume=0.8)
    global beep_distractor
    beep_distractor = sound.Sound(500, secs=0.08)
    global beep_standard
    beep_standard = sound.Sound(1000, secs=0.08, volume=0.8)

    # Set timer
    global timer
    timer = core.Clock()

    ####################  TRAINING BLOCK ###################################

    # INTRO
    txt = ("In diesem Experiment werden Sie verschiedene Töne hören. Ein Ton mit mittlerer Frequenz ist der Standardreiz. "
           "Ein Ton mit niedriger Frequenz ist ein Ablenkungsreiz. Ein Ton mit hoher Frequenz ist ein Zielreiz. Reagieren "
           "Sie ausschließlich auf den Zielreiz, indem Sie so schnell wie möglich die Leertaste drücken. Zunächst erfolgt "
           "ein Training. Bei dem Training steht zum jeweiligen Ton dabei, um welchen Reiz es sich handelt. Drücken Sie nun "
           "die Taste g, um das Training zu beginnen")

    presTextPsychoPy(txt)
    event.waitKeys()
    lsl_outlet.push_sample(['block 0']) # output to lsl

    for trial in t_trials:
        present_training(trial)

    lsl_outlet.push_sample(['block 0 over'])

    ####################  Experiment Trials ###################################

    txt = "Drücken Sie die Taste g, um das Experiment zu starten"
    presTextPsychoPy(txt)
    keys = event.waitKeys(keyList=["g"])
    if keys:
        lsl_outlet.push_sample(['block 1'])

    for trial in trials:
        present_trial(trial)

    lsl_outlet.push_sample(['block 1 over'])

    txt = "Done"
    presTextPsychoPy(txt)

    ## ################    FINISH UP     ####################

    # Cleanup (always!)
    print("DONE")
    win.close()
    core.quit()


###############################################################################
#
#           ADDITIONAL FUN
#
##############################################################################

# Update text on screen in psychopy
def presTextPsychoPy(txt):
    exp_text.text = txt
    exp_text.draw()
    win.flip()

def present_training(trial):

    # set individual trial specs
    time_win_bl = 1.5
    time_win_exp = .08
    time_win_text = 2

    keys = event.getKeys(keyList=["escape"])
    if keys:
        lsl_outlet.push_sample(['User ended experiment'])
        win.close()
        core.quit()

    # send scaling factor to lsl
    lsl_outlet.push_sample(['Trial start']) # send scaling factor

    # send scaling factor to lsl
    lsl_outlet.push_sample(['isi_time_{}_trial_{}'.format(time_win_bl, trial)]) # send scaling factor

    # init timing
    countdownTimer = core.CountdownTimer(time_win_bl)

    # present baseline stimuli
    while countdownTimer.getTime() > 0:
        circle_center.draw()
        # update drawing of bars to automatic
        win.flip()

    # present exp stimuli
    # send marker to lsl
    lsl_outlet.push_sample(['Stimulus start']) # send scaling factor

    countdownTimer = core.CountdownTimer(time_win_exp)

    while countdownTimer.getTime() > 0:
        if trial['condition'] == "target":
            beep_target.play()
            countdownTimer = core.CountdownTimer(time_win_text)
            while countdownTimer.getTime() > 0:
                txt = "Zielreiz"
                presTextPsychoPy(txt)

        elif trial['condition'] == "distractor":
            beep_distractor.play()
            countdownTimer = core.CountdownTimer(time_win_text)
            while countdownTimer.getTime() > 0:
                txt = "Ablenkungsreiz"
                presTextPsychoPy(txt)

        else:
            beep_standard.play()
            countdownTimer = core.CountdownTimer(time_win_text)
            while countdownTimer.getTime() > 0:
                txt = "Standardreiz"
                presTextPsychoPy(txt)

    # present exp stimuli
    lsl_outlet.push_sample(['Stimulus and Trial end']) # send scaling factor


def present_trial(trial):

    # set individual trial specs
    time_win_bl = 1.5
    time_win_exp = .08
    time_fix = 0

    keys = event.getKeys(keyList=["escape"])
    if keys:
        lsl_outlet.push_sample(['User ended experiment'])
        win.close()
        core.quit()

    # send scaling factor to lsl
    lsl_outlet.push_sample(['Trial start']) # send scaling factor

    # send scaling factor to lsl
    lsl_outlet.push_sample(['isi_time_{}_trial_{}'.format(time_win_bl, trial)]) # send scaling factor

    # present exp stimuli
    # send marker to lsl
    lsl_outlet.push_sample(['Stimulus start']) # send scaling factor

    countdownTimer = core.CountdownTimer(time_win_exp)

    while countdownTimer.getTime() > 0:
        if trial['condition'] == "target":
            beep_target.play()
            countdownTimer = core.CountdownTimer(time_fix)

        elif trial['condition'] == "distractor":
            beep_distractor.play()
            countdownTimer = core.CountdownTimer(time_fix)

        else:
            beep_standard.play()
            countdownTimer = core.CountdownTimer(time_fix)

        lsl_outlet.push_sample(['Stimulus end']) # send scaling factor

    # init timing
    countdownTimer = core.CountdownTimer(time_win_bl)
    event.clearEvents()
    onekey = True

    while countdownTimer.getTime() > 0:

        keys = event.getKeys(keyList=["space"])
        if keys:
            if onekey:
                onekey = False
                lsl_outlet.push_sample(['Space hit']) # send scaling factor

        circle_center.draw()
        # update drawing of bars to automatic
        win.flip()

    lsl_outlet.push_sample(['Trial end']) # send scaling factor


def generate_conditions(num_trials, num_targets, num_distractors):
    conditions = []
    num_standards = num_trials - num_targets - num_distractors

    conditions.extend([{'condition': 'target'}] * num_targets)
    conditions.extend([{'condition': 'distractor'}] * num_distractors)
    conditions.extend([{'condition': 'standard'}] * num_standards)

    np.random.shuffle(conditions)
    return conditions

def generate_training_conditions():
    return [
        {'condition': 'target'},
        {'condition': 'distractor'},
        {'condition': 'standard'},
        {'condition': 'target'},
        {'condition': 'distractor'}
    ]
    
if __name__ == "__main__":
    main_experiment()
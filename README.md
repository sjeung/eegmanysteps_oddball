# EEG Many Steps - Oddball Paradigm

## Overview
This repository contains a presentation script for an EEG experiment based on the oddball paradigm. The experiment involves auditory stimuli and participant responses to target and standard sounds. It is designed to measure brain responses to rare and frequent auditory events.

## Features
- **Stimuli**: Includes target and standard sounds, as well as instructional audio.
- **Default configuration**: 200 trials, about 8% standard stimuli (800Hz beep tone), 20% target stimuli (1000Hz beep tone)
- **Optional resting & eye artefact measurement**: can be decided by the experimenter at the beginning of the block

## How to Use

### Prerequisites
- Ensure you have the required software to run the script (e.g., Presentation software).
- You can run the experiment on a phone using the Presentation software app or on a computer with the software installed (license required!).

### Running the Experiment
1. **Setup**:
    - Install the Presentation software via AppStore or Playstore.
    - Load the script into the Presentation software: go to 'Download' and search for 'eegmanysteps'.

2. **Start the Experiment**:
    - Run the script. The experiment begins with a decision phase where the experimenter chooses whether to include eye movement and rest phases.

3. **Instructions**:
    - Participants will hear instructions and can listen to examples of the two beep tones. Optionally they can adjust the volume.
    - If the eperimenter chose to include an eye artifact and resting state measurement, the instructions will guide the participant through those. They will be asked to blink a few times, move their eyes from left to right, and stand still for one minute with open eyes.
    - All instructions and starts / stops of artifact and resting state measurements have trigger events to locate them during the analysis.

5. **Main Experiment**:
    - Participants will hear a sequence of target and standard sounds. They must count the target sounds and report the count at the end.
    - All sounds come with a trigger event which can either be 'sta' for standard tones or 'tar' for target tones.

6. **End of Experiment**:
    - The experiment concludes with a block-end message.

### Customization
- Modify the number of trials, target-to-standard ratio, or jitter duration in the PCL section of the script.
- Update audio files or captions in the SDL section to match your experiment's requirements.


## Author
[Melanie Klapprott](mailto:melanie.klapprott@uni-oldenburg.de?subject=%5BEEGManySteps%5D%20Oddball%20presentation), Spring 2025  

## License
This repository is licenced with a MIT licnence, and intended for educational and research purposes. Ensure compliance with ethical guidelines when using this script in experiments.  

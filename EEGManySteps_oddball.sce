################### EEG Many Steps - Oddball Paradigm #######################
#
# Explanation
#
#
# Author: Melanie Klapprott, Spring 2025
# Editted by Sein Jeung to implement button press 

### ------------------------ Experiment header ------------------------------

default_background_color = 255,255,255;

active_buttons = 3; 								
button_codes = 11,22,33; 						
target_button_codes = 1,2,3;  																# 1: whole screen, 2: left side, 3: right side
response_matching = simple_matching;   



### ---------------------------- SDL part -----------------------------------

begin;

# Load audios --------------------------------------------------------------

sound { wavefile { filename = "1000_dev.wav"; }file_tar;}sound_tar;				# target sound
sound { wavefile { filename =  "800_sta.wav";}file_stand;}sound_sta;				# standard sound

sound { wavefile { filename = "Hello.wav"; };}sound_hello;							# Hallo!
sound { wavefile { filename = "Thanks.wav"; };}sound_thanks;							# Danke!
sound { wavefile { filename = "Block_end.wav"; };}sound_end;							# Dies ist das Ende des Durchgangs ...

sound { wavefile { filename = "Instruct_1.wav"; };}sound_instruct1;				# In diesem Experiment ...
sound { wavefile { filename = "Instruct_2.wav"; };}sound_instruct_2;				# Deine Aufgabe ist es ...
sound { wavefile { filename = "Instruct_3.wav"; };}sound_instruct_3;				# Jetzt gibt es ...
sound { wavefile { filename = "Instruct_4.wav"; };}sound_instruct_prep;			# Nun kommt eine kurze Vorbereitungsphase ...

sound { wavefile { filename = "Instruct_blink.wav"; };}sound_blinks;						# Bitte blinzeln
sound { wavefile { filename = "Instruct_moveeyes.wav"; };}sound_EyesMove;					# Bewege deine Augen ...
sound { wavefile { filename = "Instruct_rest.wav"; };}sound_EyesOpen;					# Schau nun ruhig nach vorne
sound { wavefile { filename = "EyesClosed.wav"; };}sound_EyesClosed;				# Schließe nun deine Augen
sound { wavefile { filename = "Thanks_EyesOpen.wav"; };}sound_dankeClosed;			# Danke. Du kannst die Augen ...
sound { wavefile { filename = "Trial_Start.wav"; };}sound_instruct2;				# Jetzt geht es mit dem richtigen ...


# Create texts and boxes ---------------------------------------------------

text {
		caption = "Rest and Eyes";
		font_size = 48;
		font_color = 0,0,0;
		background_color = 190,190,190;
		} eyes_yes;

text {
		caption = "No Rest and Eyes";
		font_size = 48;
		font_color = 0,0,0;
		background_color = 190,190,190;
		} eyes_no;


text{
	caption = "Hello!\n\n (Tap to continue)";
	font_color = 0,0,0;
	} instruct_text;

text{
	caption="In this experiment you will repeatedly\nhear two different sounds:\n\n'Standard' and 'Target'.\n\n\You can now listen to the sounds\nand adjust the volume.\n\n(Tap to continue)";
	font_size = 60;
	font_color = 0,0,0;
	text_align = align_center;
	}instruction_1;
	
text{
	caption = "Now there will be a short preparation\n phase in which you are supposed to perform\n some eye movements and sit still for 2 minutes.\nWe start with the eye movements.";
	font_size = 60;
	font_color = 0,0,0;
	} instruction_2;
	
text{
	caption = "Now the experiment starts.\nRemember to count all target tones\n to report the number to the experimenter later on\n\n\n(Tap to continue)!";
	font_size = 60;
	font_color = 0,0,0;
	} instruction_3;



box { 																								# pre-define the background boxes for the texts
		height = 200;
		width = 500;
		color = 190,190,190;
		} greybox;


# Create pictures ----------------------------------------------------------

# pick rest / eyes
picture { 
		box greybox;	
		x = -350;y = -150;	
		text eyes_yes;		
		x = -350;y = -150;
		
		box greybox;		
		x = 350;y = -150;	
		text eyes_no;
		x = 350;y = -150;
	} eyes_pic;
	

# Pic during sound presentation
picture {
	text {
		caption = "+";
		font_color = 0,0,0;
		font_size=70;
		text_align = align_center;
	}text_fixation;	x = 0; y = 0;
}pic_fixation;


# Pic for demo trials
picture {																						# picture for standard sound example
	text {
		caption = "Standard";
		font_color = 0,0,0;
		font_size=70;
		text_align = align_center;
	};	x = 0; y = 0;
	} stand_pic;
	
picture {																						# picture for target sound example
	text {
		caption = "Target";
		font_color = 0,0,0;
		font_size=70;
		text_align = align_center;
	};	x = 0; y = 0;
	} tar_pic;
	
picture { 																						# merge all in one picture
	box greybox;	
	x = -300; y = 0;	
	text {
		caption = "Repeat";
		font_size=70;
		font_color = 0,0,0;
		background_color = 190,190,190;
		text_align = align_center;
	};	x = -300; y = 0;		
		box greybox;		
		x = 300; y = 0;	
	text {
		caption = "Continue";
		font_size=70;
		font_color = 0,0,0;
		background_color = 190,190,190;
		text_align = align_center;
	};	x = 300; y = 0;
		} vol_pic;

# Create Trials ------------------------------------------------------------
# note: trial durations will be overwritten in the PCL part by some jitter


# pick rest / eyes
trial {
	trial_type = specific_response;
	terminator_button = 1,2;	
	trial_duration = forever;
	picture eyes_pic;	
	} eyes_decide;

# trials for adjusting volume of sounds
trial {	
	trial_type = fixed;
	trial_duration = 3000;
	picture stand_pic;
	sound sound_sta;
	time = 0;
	picture tar_pic;
	time = 1500;
	sound sound_tar;
	time = 1500;
	} soundtest_trial;
	
trial {
	trial_type = specific_response;
	terminator_button = 2,3;
	trial_duration = forever;
	picture vol_pic;
	} voltest_trial;
	


# real instructions for participants
trial { 												# instruction trial 1					
	trial_type = specific_response;
	terminator_button = 1;
	trial_duration = forever;
 				
   picture{ 										
		text instruction_1; x = 0;y = 0;
		}pic_instruction;
	time = 0;
   code = "1 instruction";
	sound sound_hello;
	time = 0;
	
	sound sound_instruct1;
	time = 2800;
	}trial_instruction_1;



# trial for rest measurement (blinks, eye movement, eyes open, eyes closed)
# instruction - general
trial {	
	trial_type = fixed;
	trial_duration = 14000;
	picture{text instruction_2;
			  x = 0; y = 0;} pic_instruction2;
	code = "restInstruct";	
	stimulus_event{
		sound sound_instruct_prep;
	} restInstruct_event;

} restInstruct_trial;	

# instruction - blinks
trial {	
	trial_type = fixed;
	trial_duration = 10500;
	picture pic_fixation;	
	stimulus_event{
		sound sound_blinks;
		time = 0;
		code = "blinksInstruct";
	} blinksInstruct_event;
	stimulus_event{
		sound sound_sta;
		time = 3500;
		code = "blinksStart";
	} blinksStart_event;
	stimulus_event{
		sound sound_thanks;
		time = 8500;
		code = "blinksEnd";
	} blinksEnd_event;

} blinks_trial;	


# instruction - eye movement
trial {	
	trial_type = fixed;
	trial_duration = 11000;
	picture pic_fixation;	
	stimulus_event{
		sound sound_EyesMove;
		time = 0;
		code = "EyesMoveInstruct";
	} EyesMoveInstruct_event;
	stimulus_event{
		sound sound_sta;
		time = 5000;
		code = "EyesMoveStart";
	} EyesMoveStart_event;
	stimulus_event{
		sound sound_thanks;
		time = 10000;
		code = "EyesMoveEnd";
	} EyesMoveEnd_event;

} EyesMove_trial;	

# instruction - eyes open 60s
trial {	
	trial_type = fixed;
	trial_duration = 60000;
	picture pic_fixation;
	stimulus_event{
		sound sound_EyesOpen;
		time = 0;
		code = "EyesOpenStart";
	} EyesOpenStart_event;
	
} EyesOpen_trial;	

trial {	
	trial_type = fixed;
	trial_duration = 67000;
	picture pic_fixation;
		stimulus_event{
		sound sound_EyesClosed;
		time = 0;
		code = "EyesClosedStart";
	} EyesClosedInstruct_event;
	stimulus_event{
		sound sound_dankeClosed;
		time = 62000;
		code = "EyesClosedEnd";
	} EyesClosedEnd_event;
} EyesClosed_trial;	

# instruction - we're starting soon
trial {	
	trial_type = specific_response;
	terminator_button = 1;	
	trial_duration = forever;
	
	picture{text instruction_3;
			  x = 0; y = 0;
			  }pic_instruction3;
	code = "start soon";	
	stimulus_event{
		sound sound_instruct2;
	} instruct3_event;
	

} trial_instruction_start;


# block has ended
trial { 												
	trial_duration = 2996; 						# trial lasts 3s
	stimulus_event{
		picture { 									
			text{ caption="This block has ended.";}end_block;
			x=0;y=0;
			}pic_end_block; 
			code = "5 end_block";
		}save_order;
		sound sound_end;
	}trial_end_block;





# trial that presents standard sound		
trial {
	trial_type = fixed;
	trial_duration = 1000;	
	picture pic_fixation;
	
	stimulus_event{	
		sound sound_sta;
		time = 0;
		code = "sta";
		response_active = true; # activate bu
	}sta_event;
	
}standard_trial;


# trial that presents target sound			
trial {
	trial_type = fixed;
	trial_duration = 1000;
	picture pic_fixation;
	
	stimulus_event{		
		sound sound_tar;
		time = 0;
		code = "tar";
		response_active = true;
	}tar_event;	
		
	
}target_trial;

### ---------------------------- PCL part -----------------------------------

begin_pcl;

# Initialiasing
int num_trials = 200;
double perc_target = 0.25;
int num_target = int(num_trials*perc_target) + random( 0, 8 );
array <int> store_response[num_trials]; 
array <int> store_jitter[num_trials]; 
array <double> store_rt[num_trials];  
array <double> store_touch[num_trials]; 
int jitter_start = 1000;
int jitter_stop = 2000;
int jitter;

# array for stimuli presentation
array <int> stimulus_determiner[num_trials] ; 
stimulus_determiner.fill (1,num_trials, 1,0);
stimulus_determiner.fill (num_target,num_target*2-1 ,2,0);


# subroutine for randomization with restrictions -----------------------------
sub
   bool sequence_ok( int limit )
begin
   bool rval = true;
   int last = 0;
   int in_a_row = 0;
	
   loop int i = 1 until i > stimulus_determiner.count() begin
	
	if stimulus_determiner[1]==2 ||  stimulus_determiner[2]==2 ||  stimulus_determiner[3]==2 ||  stimulus_determiner[4]==2 ||  stimulus_determiner[5]==2 then
		rval = false;		
		break
	end  ; 

	if (stimulus_determiner[i] == last && stimulus_determiner[i]==2) then
         in_a_row = in_a_row + 1;
         if (in_a_row > limit) then
            rval = false;
            break
         end
      else
         in_a_row = 1
      end;
      last = stimulus_determiner[i];
      i = i + 1
   end;
   return rval
end;


# pseudo-randomize stimulus presentation
stimulus_determiner.shuffle();
loop until sequence_ok( 2 ) begin
   stimulus_determiner.shuffle()
end;


### ---------------------------- Experiment -----------------------------------


# Instructions / eye artefact and rest measurement

eyes_decide.present();
int l2 = response_manager.last_response();

trial_instruction_1.present();

# present example sounds
soundtest_trial.present();
voltest_trial.present();

# volume control
loop until (response_manager.last_response_data().button() == 3) begin
	soundtest_trial.present();
	voltest_trial.present();
end;

if l2 == 2 then

	restInstruct_trial.present();
	blinks_trial.present();
	EyesMove_trial.present();
	EyesOpen_trial.present();
	EyesClosed_trial.present();

end;

trial_instruction_start.present();


# The experiment begins


loop int tr = 1 until tr > num_trials
begin
	pic_fixation.present();
	jitter = random(jitter_start, jitter_stop);
	#store_time[tr]= clock.time_double();
	if stimulus_determiner[tr] == 1 then
		standard_trial.set_duration(jitter);
		sta_event.set_stimulus_time_out(jitter);
		standard_trial.present();	
	elseif stimulus_determiner[tr] == 2 then
		target_trial.set_duration(jitter+4);
		target_trial.present();
	end;
	
 
	# collect behavioural data
	stimulus_data  stim = stimulus_manager.get_stimulus_data(stimulus_manager.stimulus_count()-1);	
	store_response[tr] = stim.type(); 
	store_rt[tr] = stim.reaction_time(); 
	store_jitter[tr]= jitter;


	tr = tr + 1;
end;

trial_end_block.present();









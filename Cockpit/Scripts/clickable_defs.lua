cursor_mode =
{
    CUMODE_CLICKABLE = 0,
    CUMODE_CLICKABLE_AND_CAMERA  = 1,
    CUMODE_CAMERA = 2,
};

clickable_mode_initial_status  = cursor_mode.CUMODE_CLICKABLE

direction						= 1
cyclic_by_default				= true -- to cycle two-way thumblers or not by default
anim_speed_default				= 16

function default_button(hint_,device_,command_,arg_,animation_speed_)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	return  {
				class				= {class_type.BTN},
				hint				= hint_,
				device				= device_,
				action				= {command_},
				stop_action 		= {command_},
				arg					= {arg_},
				arg_value			= {1},
				arg_lim 			= {{0,1}},
				use_release_message	= {true},
				animated			= {true},
			    animation_speed		= {animation_speed_},
			--	sound				= {{SOUND_SW1}}
			}
end

function default_2_position_tumb(hint_,device_,command_,arg_,animation_speed_)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	return  {
				class			= {class_type.TUMB,class_type.TUMB},
				hint			= hint_,
				device			= device_,
				action			= {command_,command_},
				arg				= {arg_,arg_},
				arg_value		= {0, 1},--{1,-1},
				arg_lim			= {{0,1},{0,1}},
				updatable		= true,
				use_OBB			= true,
				animated		= {true,true},
			    animation_speed	= {animation_speed_,animation_speed_},
			--	sound			= {{SWITCH_BASIC}}
			}
end

function multiposition_switch(hint_,device_,command_,arg_,count_,delta_,inversed_,min_,animation_speed_,cycled_)
    local	min_   = min_ or 0
	local	delta_ = delta_ or 0.5
	local	inversed = 1

	if	inversed_ then
		inversed = -1
	end

	local	animation_speed_ = animation_speed_ or anim_speed_default
	local	cycled = true

	if cycled_ ~= nil then
	   cycled = cycled_
	end

	return 
	{
		class 		= {class_type.TUMB,class_type.TUMB},
		hint  		= hint_,
		device 		= device_,
		action 		= {command_,command_},
		arg 	  	= {arg_,arg_},
		arg_value 	= {-delta_ * inversed,delta_ * inversed},
		arg_lim   	= {{min_, min_ + delta_ * (count_ -1)},
						{min_, min_ + delta_ * (count_ -1)}},
		updatable 	= true,
		use_OBB 	= true,
		cycle       = cycled,
		animated		= {true,true},
		animation_speed	= {animation_speed_,animation_speed_},
		--sound			= {{SOUND_SW2}}
	}
end
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local DARKEN_HUD_System = GetSelf()
local dev = GetSelf()
local sensor_data		= get_base_data()

local update_time_step = 0.01 --1/100
make_default_activity(update_time_step)

--local Parameter = get_param_handle("HUDBrightnessDown") //Test für später
--Parameter:set(0)

dev:listen_command(Keys.auto_HUD_brightness_down)

local hud_brightness_counter = 0
local hud_brightness_automatic_counter = 0
local hud_coulor_counter = 0

function keys_auto_HUD_brightness_down(value)
	
	while(hud_brightness_counter < 200)do
	
		dispatch_action(nil, 747) --
		hud_brightness_counter = hud_brightness_counter + 1
		
	end
	
	
	
end

command_table = {
    [Keys.auto_HUD_brightness_down] = keys_auto_HUD_brightness_down,
   --hier kommen dann ganz viele andere noch rein....
}

function SetCommand(command, value)

    if command_table[command] then
        command_table[command](value)
    end
end
------------------------------------------------------------------FUNCTION-POST-INIT---------------------------------------------------------------------------------------------------
function post_initialize()
	
	while (hud_brightness_counter <= 100) do
		
		dispatch_action(nil, 747)
		hud_brightness_counter = hud_brightness_counter + 1
		
	end
	
	while (hud_coulor_counter < 5) do
	
		dispatch_action(nil, Keys.iCommandBrightnessILS)
		hud_coulor_counter = hud_coulor_counter +1
		
	end
	

end
------------------------------------------------------------------FUNCTION-SETCOMMAND---------------------------------------------------------------------------------------------------
function SetCommand(command,value)


end
------------------------------------------------------------------FUNCTION-UPDATE---------------------------------------------------------------------------------------------------
function update()
    

end

need_to_be_closed = false --war eigentlich false
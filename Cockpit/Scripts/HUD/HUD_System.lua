dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "Systems/weapon_system.lua")

dev = GetSelf()

local update_time_step = 0.01 --update will be called 1000 times per second
make_default_activity(update_time_step)

local sensor_data = get_base_data()

--Hier kommen spätere funktionen für die Übertragung oder Generierung der Werte für den Gunpipper rein
dev:listen_command(Keys.GunPipper_Up)
dev:listen_command(Keys.GunPipper_Down)
--dev:listen_command(Keys.GunPipper_Right)
--dev:listen_command(Keys.GunPipper_Left)
dev:listen_command(Keys.GunPipper_Center)
dev:listen_command(Keys.GunPipper_Automatic) 
dev:listen_command(Keys.GunPipper_Manual)
dev:listen_command(Keys.Gunsight_activator_switch)
dev:listen_command(Keys.Gunsight_opacity_up)
dev:listen_command(Keys.Gunsight_opacity_down)


local gunpipper_horizontal_movement_param = get_param_handle("GUNPIPPER_SIDE")
local gunpipper_vertical_movement_param = get_param_handle("GUNPIPPER_UPDOWN")
local gunpipper_center_param = get_param_handle("GUNPIPPER_CENTER")
local gunpipper_sideways_automatic_param = get_param_handle("WS_GUN_PIPER_AZIMUTH")
local gunpipper_updown_automatic_param = get_param_handle("WS_GUN_PIPER_ELEVATION")
local target_range_param = get_param_handle("WS_TARGET_RANGE")
local gunsight_activated_param = get_param_handle("GUNSIGHT_ACTIVATED")
local gunsight_opacity_param = get_param_handle("GUNSIGHT_OPACITY")

gunpipper_center_param:set(0.0)
local gunpipper_mode = 0
local gunsightOpacity = 0
local gunsightOn = 0


function keys_gunpipper_vertical_up(value)

	if (gunpipper_mode ==  0)
	then
		gunpipper_vertical_movement_param:set(gunpipper_vertical_movement_param:get() +0.001) --war 0.05
	end
	print_message_to_user("Gunpipper at "..tostring(gunpipper_vertical_movement_param:get()).." Radiants")
end

function keys_gunpipper_vertical_down(value)

if (gunpipper_mode ==  0)
	then
		gunpipper_vertical_movement_param:set(gunpipper_vertical_movement_param:get() -0.001)
	end
	print_message_to_user("Gunpipper at "..tostring(gunpipper_vertical_movement_param:get()).." Radiants")
end

function keys_gunpipper_horizontal_right(value)

	
		gunpipper_horizontal_movement_param:set(gunpipper_horizontal_movement_param:get() +0.01)
	
	
end

function keys_gunpipper_horizontal_left(value)
-- 										das ist der vorherige Wert - den neuen Wert, also ein Schritt.
	
	gunpipper_horizontal_movement_param:set(gunpipper_horizontal_movement_param:get() -0.01)
	

end

function keys_gunpipper_center(value)
	
	gunpipper_horizontal_movement_param:set(0.0)
	gunpipper_vertical_movement_param:set(0.0)
	
end

function keys_gunpipper_automatic(value)

	gunpipper_mode =  1 --and  (gunpipper_horizontal_movement_param == 0.0) and (gunpipper_vertical_movement_param == 0.0)) 
	print_message_to_user("Gunpipper Automatic-Mode.")

end

function keys_gunpipper_manual(value)

	gunpipper_mode = 0
	gunpipper_horizontal_movement_param:set(0.0)
	gunpipper_vertical_movement_param:set(0.0)
	print_message_to_user("Gunpipper Manual-Mode.")
end

function keys_gunsight_activator(value)

	if(gunsightOn == 0)then
	
		gunsightOn = 1
		
	else
		gunsightOn = 0
	end
	
	gunsight_activated_param:set(gunsightOn)
	
end

function keys_gunsight_opacity_up(value)

	if((gunsightOn == 1) and (gunsightOpacity <= 0.9))then
		gunsightOpacity = gunsightOpacity + 0.1
		gunsight_opacity_param:set(gunsightOpacity)
	elseif((gunsightOn == 1) and (gunsightOpacity == 1.0))then
		gunsightOpacity = 1
		gunsight_opacity_param:set(gunsightOpacity)
	end
	
end

function keys_gunsight_opacity_down(value)

	if((gunsightOn == 1) and (gunsightOpacity >= 0.1))then
		gunsightOpacity = gunsightOpacity - 0.1
		gunsight_opacity_param:set(gunsightOpacity)
	end
	
end


command_table = {
    [Keys.GunPipper_Up] 				= keys_gunpipper_vertical_up,
    [Keys.GunPipper_Down] 				= keys_gunpipper_vertical_down,
    --[Keys.GunPipper_Right] 			= keys_gunpipper_horizontal_right,
    --[Keys.GunPipper_Left] 			= keys_gunpipper_horizontal_left,
    [Keys.GunPipper_Center] 			= keys_gunpipper_center,
    [Keys.GunPipper_Automatic]			= keys_gunpipper_automatic,
	[Keys.GunPipper_Manual]				= keys_gunpipper_manual,
	[Keys.Gunsight_activator_switch]	= keys_gunsight_activator,
	[Keys.Gunsight_opacity_up]			= keys_gunsight_opacity_up,
	[Keys.Gunsight_opacity_down]		= keys_gunsight_opacity_down,
	
}


function post_initialize()

	local dev=GetSelf()
	local birth = LockOn_Options.init_conditions.birth_place
	
	if birth == "GROUND_COLD" then
		gunsightOpacity = 1
		gunsightOn = 0
		gunsight_opacity_param:set(gunsightOpacity)
		gunsight_activated_param:set(gunsightOn)
    else
		gunsightOn = 1
		gunsightOpacity = 1
		gunsight_opacity_param:set(gunsightOpacity)
		gunsight_activated_param:set(gunsightOn)
    end
	

end


function SetCommand(command,value)	
	
	if command_table[command] then
        command_table[command](value)
    end
	
end

function update()

	if (gunpipper_mode == 1) then
		gunpipper_horizontal_movement_param:set(gunpipper_sideways_automatic_param:get())
		gunpipper_vertical_movement_param:set(gunpipper_updown_automatic_param:get())
		end

end

need_to_be_closed = false


--possible sensor_data 
--called through e.g.: sensor_data.getEngineRPM()
--and cast to a variable like this: GET_ENGINE_RPM = sensor_data.getEngineRPM()
--[[
getAngleOfAttack()
getAngleOfSlide()
getBarometricAltitude()
getCanopyPos()
getCanopyState()
getEngineLeftFuelConsumption()
getEngineLeftRPM()
getEngineLeftTemperatureBeforeTurbine()
getEngineRightFuelConsumption()
getEngineRightRPM()
getEngineRightTemperatureBeforeTurbine()
getFlapsPos()
getFlapsRetracted()
getHeading()
getHorizontalAcceleration()
getIndicatedAirSpeed()
getLandingGearHandlePos()
getLateralAcceleration()
getLeftMainLandingGearDown()
getLeftMainLandingGearUp()
getMachNumber()
getMagneticHeading()
getNoseLandingGearDown()
getNoseLandingGearUp()
getPitch()
getRadarAltitude()
getRateOfPitch()
getRateOfRoll()
getRateOfYaw()
getRightMainLandingGearDown()
getRightMainLandingGearUp()
getRoll()
getRudderPosition()
getSpeedBrakePos()
getSelfAirspeed()
getSelfCoordinates()
getSelfVelocity()
getStickPitchPosition()
getStickRollPosition()
getThrottleLeftPosition()
getThrottleRightPosition()
getTotalFuelWeight()
getTrueAirSpeed()
getVerticalAcceleration()
getVerticalVelocity()
getWOW_LeftMainLandingGear()
getWOW_NoseLandingGear()
getWOW_RightMainLandingGear()
--]]
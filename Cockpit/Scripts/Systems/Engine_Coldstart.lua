dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")

local dev = GetSelf()

local update_time_step = 0.05--update will be called 20 times per second
make_default_activity(update_time_step)

local sensor_data = get_base_data()

--listen to DCS-Event
dev:listen_event("GroundAirOn")
dev:listen_event("GroundAirOff")

--dev:listen_command(Keys.your_command_name)
dev:listen_command(Keys.starter_switch_left_engine)
dev:listen_command(Keys.starter_switch_right_engine)

local groundPowerConnected = 0
local groundAirConnected = 0
local leftEngineStartable = 0
local rightEngineStartable = 0
local leftEngineRPM = 0
local rightEngineRPM = 0

function CockpitEvent(event,val)

    if event == "GroundAirOn" then
        groundAirConnected = 1
    elseif event == "GroundAirOff" then
        groundAirConnected = 0
    end
	
end

function keys_left_engine_starter_button(value)

	if((groundAirConnected == 1) and (groundPowerConnected == 1))then
	
		dispatch_action(nil, Keys.iCommandLeftEngineStart)
		print_message_to_user("Left engine starting up.")
		
	elseif(((groundAirConnected == 0) or (groundPowerConnected == 0)) and 
		((leftEngineRPM >= 30.0) or (rightEngineRPM >= 30.0)))then
		
		dispatch_action(nil, Keys.iCommandLeftEngineStart)
		print_message_to_user("Left engine starting up.")
		
	else
	
		print_message_to_user("Not enough RPM/electricity/ground air.")
	end
	
end

function keys_right_engine_starter_button(value)

	if((groundAirConnected == 1) and (groundPowerConnected == 1))then
	
		dispatch_action(nil, Keys.iCommandRightEngineStart)
		print_message_to_user("Right engine starting up.")
		
	elseif(((groundAirConnected == 0) or (groundPowerConnected == 0)) and 
		((leftEngineRPM >= 30.0) or (rightEngineRPM >= 30.0)))then
		
		dispatch_action(nil, Keys.iCommandRightEngineStart)
		print_message_to_user("Right engine starting up.")
		
	else
	
		print_message_to_user("Not enough RPM/electricity/ground air.")
		
	end

end


command_table = {
	[Keys.starter_switch_left_engine] 	=	keys_left_engine_starter_button,
	[Keys.starter_switch_right_engine] 	=	keys_right_engine_starter_button,
}


function SetCommand(command, value)

	if command_table[command] then
        command_table[command](value)
    end

end


function post_initialize()
end


function update()

	if electric_system_api:get_GP() then
		groundPowerConnected = 1
	else
		groundPowerConnected = 0
	end
	
	
	leftEngineRPM = sensor_data.getEngineLeftRPM()
	rightEngineRPM = sensor_data.getEngineRightRPM()
	
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

--dev:listen_event() 
--[[
setup_HMS
setup_NVG
DisableTurboGear
EnableTurboGear
GroundPowerOn
GroundPowerOff
OnNewNetHelicopter
OnNewNetPlane
initChaffFlarePayload
switch_datalink
WeaponRearmFirstStep
WeaponRearmComplete
repair
LinkNOPtoNet
UnlinkNOPfromNet
UnlimitedWeaponStationRestore
GroundAirOff !!!!!
GroundAirOn !!!!!
]]
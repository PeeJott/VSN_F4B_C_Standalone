dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local dev = GetSelf()

local update_time_step = 0.05--update will be called 20 times per second
make_default_activity(update_time_step)

local sensor_data = get_base_data()

--listen to DCS-Event
dev:listen_event("GroundPowerOn")
dev:listen_event("GroundPowerOff")

--dev:listen_command(Keys.your_command_name)
dev:listen_command(Keys.main_electric_switch_toggle)

--Local variables
local electricEnergyEnabled = 0
local batteryLifeCounter = 500
local leftEngineRPM = 0
local rightEngineRPM = 0
local engineRPM = 0


function CockpitEvent(event,val)
    if event == "GroundPowerOn" then
        electric_system_api.ac_ground_power_param:set(1.0)
    elseif event == "GroundPowerOff" then
        electric_system_api.ac_ground_power_param:set(0.0)
    end
end

function keys_electric_energy_toggle(value)

	if(electricEnergyEnabled == 0)then
		if(electric_system_api.ac_ground_power_param:get() == 1.0)then
			electricEnergyEnabled = 1
			dev:AC_Generator_1_on(true)
			dev:AC_Generator_2_on(true)
			dev:DC_Battery_on(true)
			print_message_to_user("Electricity switched ON.")
			dispatch_action(nil, Keys.iCommandPowerOnOff)
		elseif((electric_system_api.ac_ground_power_param:get() == 0.0) 
			and (batteryLifeCounter > 0))then
			electricEnergyEnabled = 1
			dev:AC_Generator_1_on(false)
			dev:AC_Generator_2_on(false)
			dev:DC_Battery_on(true)
			dispatch_action(nil, Keys.iCommandPowerOnOff)
			print_message_to_user("Main electricity ON. Battery running. Need Ground power.")
		elseif((electric_system_api.ac_ground_power_param:get() == 0.0) 
			and (batteryLifeCounter == 0))then
			dev:AC_Generator_1_on(false)
			dev:AC_Generator_2_on(false)
			dev:DC_Battery_on(false)
			print_message_to_user("Battery has run out.")
		end
		
	else
		electricEnergyEnabled = 0
		dev:AC_Generator_1_on(false)
		dev:AC_Generator_2_on(false)
		dev:DC_Battery_on(false)
		dispatch_action(nil, Keys.iCommandPowerOnOff)
		print_message_to_user("Electricity switched OFF.")
	end
	
	dispatch_action(nil, Keys.auto_HUD_brightness_down)

end

command_table = {
[Keys.main_electric_switch_toggle]	= keys_electric_energy_toggle,
}

function battery_life()

	if(((leftEngineRPM < 30.0) or (rightEngineRPM < 30.0)) and (batteryLifeCounter >= 1.0) 
		and (electricEnergyEnabled == 1) and (electric_system_api.ac_ground_power_param:get() == 0.0))then
		
		batteryLifeCounter = batteryLifeCounter - 1
		--print_message_to_user("Battery discharging.")
		
	elseif(((leftEngineRPM < 30.0) or (rightEngineRPM < 30.0)) and (batteryLifeCounter == 0.0)
		and (electricEnergyEnabled == 1) and (electric_system_api.ac_ground_power_param:get() == 0.0))then
		batteryLifeCounter = 0
		electricEnergyEnabled = 0
		dispatch_action(nil, Keys.iCommandPowerOnOff)
		print_message_to_user("Battery power has run out. Electricity disabled.")
	end	
		
	if((((leftEngineRPM >= 30.0) or (rightEngineRPM >= 30.0)) or (electric_system_api.ac_ground_power_param:get() == 1.0)) 
		and (batteryLifeCounter <= 1000))then
		
			batteryLifeCounter = batteryLifeCounter +1
			--print_message_to_user("Battery charging.")
	else
			batteryLifeCounter = 1000
	end
	
end


-- Called with commands that are being listened to and their values.
function SetCommand(command,value)

	if command_table[command] then
        command_table[command](value)
    end
	
end

-- Run after aircraft is loaded.
function post_initialize()

    local birth = LockOn_Options.init_conditions.birth_place
    if birth == "GROUND_COLD" then
		dev:AC_Generator_1_on(false)
		dev:AC_Generator_2_on(false)
		dev:DC_Battery_on(false)
		
		electricEnergyEnabled = 0
		
		print_message_to_user("Electricity OFF and initialized.")
    else
        dev:AC_Generator_1_on(true)
		dev:AC_Generator_2_on(true)
		dev:DC_Battery_on(true)
		
		electricEnergyEnabled = 1
		print_message_to_user("Electricity ON and initialized.")
    end

    --dev:AC_Generator_1_on(true)
    --dev:AC_Generator_2_on(false)
    --dev:DC_Battery_on(true)
end


-- Ran every frame.
function update()

	battery_life()

    if dev:get_AC_Bus_1_voltage() > 0 then
        electric_system_api.ac_gen_power_param:set(1)
    else
        electric_system_api.ac_gen_power_param:set(0)
    end

    if dev:get_DC_Bus_1_voltage() > 0 or dev:get_DC_Bus_2_voltage() > 0 then
        electric_system_api.dc_bat_power_param:set(1)
    else
        electric_system_api.dc_bat_power_param:set(0)
    end
	
	leftEngineRPM = sensor_data.getEngineLeftRPM()
	rightEngineRPM = sensor_data.getEngineRightRPM()
	--print_message_to_user("Engine RPM is: " ..tostring(engineRPM))
	
end

need_to_be_closed = false -- don't close after

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
local cscripts = folder.."../../../Cockpit/Scripts/"
dofile(cscripts.."devices.lua")
dofile(cscripts.."command_defs.lua")

local res = external_profile("Config/Input/Aircrafts/common_keyboard_binding.lua")

join(res.keyCommands,{

-- Autopilot
{combos = {{key = 'A'}, {key = '1', reformers = {'LAlt'}}}, down = iCommandPlaneAutopilot, name = _('Autopilot - Attitude Hold'), category = _('Autopilot')},
{combos = {{key = 'H'}, {key = '2', reformers = {'LAlt'}}}, down = iCommandPlaneStabHbar, name = _('Autopilot - Altitude Hold'), category = _('Autopilot')},
--{combos = {{key = '9', reformers = {'LAlt'}}}, down = iCommandPlaneStabCancel, name = _('Autopilot Disengage'), category = _('Autopilot')},
--{combos = {{key = '1', reformers = {'LCtrl'}}}, down = iCommandHelicopter_PPR_button_T_up, name = _('CAS Pitch'), category = _('Autopilot')},
--{combos = {{key = '2', reformers = {'LCtrl'}}}, down = iCommandHelicopter_PPR_button_K_up, name = _('CAS Roll'), category = _('Autopilot')},
--{combos = {{key = '3', reformers = {'LCtrl'}}}, down = iCommandHelicopter_PPR_button_H_up, name = _('CAS Yaw'), category = _('Autopilot')},

--Flight Control
{down = iCommandPlaneTrimOn, up = iCommandPlaneTrimOff, name = _('T/O Trim'), category = _('Flight Control')},
{down = iCommandPlaneUpStart,				up = iCommandPlaneUpStop,			name = _('Aircraft Pitch Down'),	category = _('Flight Control')},
{down = iCommandPlaneDownStart,				up = iCommandPlaneDownStop,			name = _('Aircraft Pitch Up'),		category = _('Flight Control')},
{down = iCommandPlaneLeftStart,				up = iCommandPlaneLeftStop,			name = _('Aircraft Bank Left'),		category = _('Flight Control')},
{down = iCommandPlaneRightStart,			up = iCommandPlaneRightStop,		name = _('Aircraft Bank Right'),	category = _('Flight Control')},
{down = iCommandPlaneLeftRudderStart,		up = iCommandPlaneLeftRudderStop,	name = _('Aircraft Rudder Left'),	category = _('Flight Control')},
{down = iCommandPlaneRightRudderStart,		up = iCommandPlaneRightRudderStop,	name = _('Aircraft Rudder Right'),	category = _('Flight Control')},

{pressed = iCommandPlaneTrimUp,				up = iCommandPlaneTrimStop,	name = _('Trim: Nose Up'),			category = _('Flight Control')},
{pressed = iCommandPlaneTrimDown,			up = iCommandPlaneTrimStop,	name = _('Trim: Nose Down'),		category = _('Flight Control')},
{pressed = iCommandPlaneTrimLeft,			up = iCommandPlaneTrimStop,	name = _('Trim: Left Wing Down'),	category = _('Flight Control')},
{pressed = iCommandPlaneTrimRight,			up = iCommandPlaneTrimStop,	name = _('Trim: Right Wing Down'),	category = _('Flight Control')},
{pressed = iCommandPlaneTrimLeftRudder,		up = iCommandPlaneTrimStop,	name = _('Trim: Rudder Left'),		category = _('Flight Control')},
{pressed = iCommandPlaneTrimRightRudder,	up = iCommandPlaneTrimStop,	name = _('Trim: Rudder Right'),		category = _('Flight Control')},


-- Systems
--{combos = {{key = 'L', reformers = {'RShift'}}},	down = iCommandPowerOnOff,					name = _('Electric Power Switch'),					category = _('Systems')},
{combos = {{key = 'B'}},							down = iCommandPlaneAirBrake,				name = _('Airbrake'),								category = _('Systems') , features = {"airbrake"}},
{combos = {{key = 'B', reformers = {'LShift'}}},	down = iCommandPlaneAirBrakeOn,				name = _('Airbrake On'),							category = _('Systems') , features = {"airbrake"}},
{combos = {{key = 'B', reformers = {'LCtrl'}}},		down = iCommandPlaneAirBrakeOff,			name = _('Airbrake Off'),							category = _('Systems') , features = {"airbrake"}},
{combos = {{key = 'T'}},							down = iCommandPlaneWingtipSmokeOnOff,		name = _('Smoke'),									category = _('Systems')},
{combos = {{key = 'L'}},							down = iCommandPlaneCockpitIllumination,	name = _('Illumination Cockpit'),					category = _('Systems')},
{combos = {{key = 'L', reformers = {'RCtrl'}}},		down = iCommandPlaneLightsOnOff,			name = _('Navigation lights'),						category = _('Systems')},
{combos = {{key = 'L', reformers = {'RAlt'}}},		down = iCommandPlaneHeadLightOnOff,			name = _('Gear Light Near/Far/Off'),				category = _('Systems')},
{combos = {{key = 'F'}},							down = iCommandPlaneFlaps,					name = _('Flaps Up/Down'),							category = _('Systems')},
{combos = {{key = 'F', reformers = {'LShift'}}},	down = iCommandPlaneFlapsOn,				name = _('Flaps Landing Position'),					category = _('Systems')},
{combos = {{key = 'F', reformers = {'LCtrl'}}},		down = iCommandPlaneFlapsOff,				name = _('Flaps Up'),								category = _('Systems')},
{combos = {{key = 'G'}},							down = iCommandPlaneGear,					name = _('Landing Gear Up/Down'),					category = _('Systems')},
{combos = {{key = 'G', reformers = {'LCtrl'}}},		down = iCommandPlaneGearUp,					name = _('Landing Gear Up'),						category = _('Systems')},
{combos = {{key = 'G', reformers = {'LShift'}}},	down = iCommandPlaneGearDown,				name = _('Landing Gear Down'),						category = _('Systems')},
{combos = {{key = 'W'}},							down = iCommandPlaneWheelBrakeOn, up = iCommandPlaneWheelBrakeOff, name = _('Wheel Brake On'),	category = _('Systems')},
{combos = {{key = 'C', reformers = {'LCtrl'}}},		down = iCommandPlaneFonar,					name = _('Canopy Open/Close'),						category = _('Systems')},
{combos = {{key = 'P'}},							down = iCommandPlaneParachute,				name = _('Dragging Chute'),							category = _('Systems') , features = {"dragchute"}},
--{combos = {{key = 'N', reformers = {'RShift'}}},	down = iCommandPlaneResetMasterWarning,		name = _('Audible Warning Reset'),					category = _('Systems')},
{combos = {{key = 'W', reformers = {'LCtrl'}}},		down = iCommandPlaneJettisonWeapons,up = iCommandPlaneJettisonWeaponsUp, name = _('Weapons Jettison'), category = _('Systems')},
{combos = {{key = 'E', reformers = {'LCtrl'}}},		down = iCommandPlaneEject,					name = _('Eject (3 times)'),						category = _('Systems')},
--{combos = {{key = 'C', reformers = {'RShift'}}},	down = iCommandFlightClockReset,			name = _('Flight Clock Start/Stop/Reset'),			category = _('Systems') , features = {"flightclock"}},
{combos = {{key = 'H', reformers = {'RCtrl'}}},		down = iCommandBrightnessILS,				name = _('HUD Color'),								category = _('Systems') , features = {"HUDcolor"}},
{combos = {{key = 'H', reformers = {'RCtrl','RShift'}}}, pressed = iCommandHUDBrightnessUp,		name = _('HUD Brightness up'),						category = _('Systems') , features = {"HUDbrightness"}},
{combos = {{key = 'H', reformers = {'RShift','RAlt'}}}, pressed = iCommandHUDBrightnessDown,	name = _('HUD Brightness down'),					category = _('Systems') , features = {"HUDbrightness"}},
--{combos = {{key = 'R'}},							down = iCommandPlaneFuelOn, up = iCommandPlaneFuelOff, name = _('Fuel Dump'),					category = _('Systems') , features = {"fueldump"}},
{combos = {{key = 'R', reformers = {'LCtrl'}}}, 	down = iCommandPlaneAirRefuel, 				name = _('Refueling Boom'), 						category = _('Systems')},

{combos = {{key = '=', reformers = {'RShift'}}}, pressed = iCommandAltimeterPressureIncrease,	up = iCommandAltimeterPressureStop, name = _('Altimeter Pressure Increase'), category = _('Systems')},
{combos = {{key = '-', reformers = {'RShift'}}}, pressed = iCommandAltimeterPressureDecrease, up = iCommandAltimeterPressureStop, name = _('Altimeter Pressure Decrease'), category = _('Systems')},


{combos = {{key = 'R', reformers = {'LAlt'}}}, 		down = iCommandPlaneJettisonFuelTanks, 										name = _('Jettison Fuel Tanks'), category = _('Systems')},
{combos = {{key = 'S'}}, down = iCommandPlane_HOTAS_NoseWheelSteeringButton, up = iCommandPlane_HOTAS_NoseWheelSteeringButton, 	name = _('Nose Gear Maneuvering Range'), category = _('Systems')},
{combos = {{key = 'Q', reformers = {'LAlt'}}}, 		down = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, up = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, name = _('Nose Wheel Steering'), category = _('Systems')},
{combos = {{key = 'A', reformers = {'LCtrl'}}}, 	down = iCommandPlaneWheelBrakeLeftOn, up = iCommandPlaneWheelBrakeLeftOff, 	name = _('Wheel Brake Left On/Off'), category = _('Systems')},
{combos = {{key = 'A', reformers = {'LAlt'}}}, 		down = iCommandPlaneWheelBrakeRightOn, up = iCommandPlaneWheelBrakeRightOff, name = _('Wheel Brake Right On/Off'), category = _('Systems')},
{combos = {{key = 'T', reformers = {'LShift'}}}, 	down = iCommandClockElapsedTimeReset, 										name = _('Elapsed Time Clock Start/Stop/Reset'), category = _('Systems')},
--{combos = {{key = 'D', reformers = {'LShift'}}}, 	down = iCommandPlaneFSQuantityIndicatorSelectorMAIN, 						name = _('Fuel Quantity Selector'), category = _('Systems')},
--{combos = {{key = 'D', reformers = {'LCtrl','LAlt'}}}, down = iCommandPlaneFSQuantityIndicatorTest, up = iCommandPlaneFSQuantityIndicatorTest, value_down = 1, value_up = 0, name = _('Fuel Quantity Test'), category = _('Systems')},
--{combos = {{key = 'D', reformers = {'LAlt'}}}, 	down = iCommandPlaneFSQuantityIndicatorSelectorINT,	up = iCommandPlaneFSQuantityIndicatorSelectorINT, value_down = 1,  value_up = 0, 	name = _('Bingo Fuel Index, CW'),  category = _('Systems')},
--{combos = {{key = 'D', reformers = {'LCtrl'}}}, 	down = iCommandPlaneFSQuantityIndicatorSelectorINT,	up = iCommandPlaneFSQuantityIndicatorSelectorINT, value_down = -1, value_up = 0, 	name = _('Bingo Fuel Index, CCW'), category = _('Systems')},
{combos = {{key = 'L', reformers = {'RCtrl','RAlt'}}}, down = iCommandPlaneAntiCollisionLights, name = _('Anti-collision lights'), category = _('Systems')},

{down = iCommandPlaneTrimOn, up = iCommandPlaneTrimOff, name = _('T/O Trim'), category = _('Flight Control')},
{down = iCommandPlaneUpStart,				up = iCommandPlaneUpStop,			name = _('Aircraft Pitch Down'),	category = _('Flight Control')},
{down = iCommandPlaneDownStart,				up = iCommandPlaneDownStop,			name = _('Aircraft Pitch Up'),		category = _('Flight Control')},
{down = iCommandPlaneLeftStart,				up = iCommandPlaneLeftStop,			name = _('Aircraft Bank Left'),		category = _('Flight Control')},
{down = iCommandPlaneRightStart,			up = iCommandPlaneRightStop,		name = _('Aircraft Bank Right'),	category = _('Flight Control')},
{down = iCommandPlaneLeftRudderStart,		up = iCommandPlaneLeftRudderStop,	name = _('Aircraft Rudder Left'),	category = _('Flight Control')},
{down = iCommandPlaneRightRudderStart,		up = iCommandPlaneRightRudderStop,	name = _('Aircraft Rudder Right'),	category = _('Flight Control')},

{pressed = iCommandPlaneTrimUp,				up = iCommandPlaneTrimStop,	name = _('Trim: Nose Up'),			category = _('Flight Control')},
{pressed = iCommandPlaneTrimDown,			up = iCommandPlaneTrimStop,	name = _('Trim: Nose Down'),		category = _('Flight Control')},
{pressed = iCommandPlaneTrimLeft,			up = iCommandPlaneTrimStop,	name = _('Trim: Left Wing Down'),	category = _('Flight Control')},
{pressed = iCommandPlaneTrimRight,			up = iCommandPlaneTrimStop,	name = _('Trim: Right Wing Down'),	category = _('Flight Control')},
{pressed = iCommandPlaneTrimLeftRudder,		up = iCommandPlaneTrimStop,	name = _('Trim: Rudder Left'),		category = _('Flight Control')},
{pressed = iCommandPlaneTrimRightRudder,	up = iCommandPlaneTrimStop,	name = _('Trim: Rudder Right'),		category = _('Flight Control')},

{pressed = iCommandThrottleIncrease, up = iCommandThrottleStop,  name = _('Throttle Up'),			category = _('Flight Control')},
{pressed = iCommandThrottleDecrease, up = iCommandThrottleStop,  name = _('Throttle Down'),			category = _('Flight Control')},
{combos = {{key = 'Num+', reformers = {'RAlt'}}}, 	pressed = iCommandThrottle1Increase,	up = iCommandThrottle1Stop, name = _('Throttle Left Up'),	category = _('Flight Control')},
{combos = {{key = 'Num-', reformers = {'RAlt'}}}, 	pressed = iCommandThrottle1Decrease,	up = iCommandThrottle1Stop, name = _('Throttle Left Down'), category = _('Flight Control')},
{combos = {{key = 'Num+', reformers = {'RShift'}}}, pressed = iCommandThrottle2Increase,	up = iCommandThrottle2Stop, name = _('Throttle Right Up'),	category = _('Flight Control')},
{combos = {{key = 'Num-', reformers = {'RShift'}}}, pressed = iCommandThrottle2Decrease,	up = iCommandThrottle2Stop, name = _('Throttle Right Down'), category = _('Flight Control')},

{down = iCommandPlaneAUTIncreaseRegime,			name = _('Throttle Step Up'),			category = _('Flight Control')},
{down = iCommandPlaneAUTDecreaseRegime,			name = _('Throttle Step Down'),			category = _('Flight Control')},

--{combos = {{key = 'Home', reformers = {'RAlt'}}},	down = iCommandLeftEngineStart,				name = _('Engine Left Start'),						category = _('Systems') , features = {"TwinEngineAircraft"}},
{combos = {{key = 'End', reformers = {'RAlt'}}},	down = iCommandLeftEngineStop,				name = _('Engine Left Stop'),						category = _('Systems') , features = {"TwinEngineAircraft"}},
--{combos = {{key = 'Home', reformers = {'RCtrl'}}},	down = iCommandRightEngineStart,			name = _('Engine Right Start'),						category = _('Systems') , features = {"TwinEngineAircraft"}},
{combos = {{key = 'End', reformers = {'RCtrl'}}},	down = iCommandRightEngineStop,				name = _('Engine Right Stop'),						category = _('Systems') , features = {"TwinEngineAircraft"}},
--{combos = {{key = 'Home', reformers = {'RShift'}}}, down = iCommandEnginesStart,				name = _('Engines Start'),							category = _('Systems')},
--{combos = {{key = 'End', reformers = {'RShift'}}},	down = iCommandEnginesStop,					name = _('Engines Stop'),							category = _('Systems')},

-- Modes
{combos = {{key = '2'}}, down = iCommandPlaneModeBVR, name = _('(2) Beyond Visual Range Mode'), category = _('Modes')},
--{combos = {{key = '3'}}, down = iCommandPlaneModeVS, name = _('(3) Close Air Combat Vertical Scan Mode'), category = _('Modes')},
{combos = {{key = '4'}}, down = iCommandPlaneModeBore, name = _('(4) Close Air Combat Bore Mode'), category = _('Modes')},
--{combos = {{key = '5'}}, down = iCommandPlaneModeHelmet, name = _('(5) Close Air Combat HMD Helmet Mode'), category = _('Modes')},
--{combos = {{key = '6'}}, down = iCommandPlaneModeFI0, name = _('(6) Longitudinal Missile Aiming Mode/FLOOD mode'), category = _('Modes')},
{combos = {{key = '7'}}, down = iCommandPlaneModeGround, name = _('(7) Air-To-Ground Mode'), category = _('Modes')},
--{combos = {{key = '8'}}, down = iCommandPlaneModeGrid, name = _('(8) Gunsight Reticle Switch'), category = _('Modes')},

-- Sensors
{combos = {{key = 'Enter'}}, down = iCommandPlaneChangeLock, up = iCommandPlaneChangeLockUp, name = _('Target Lock'), category = _('Sensors')},
{combos = {{key = 'Back'}}, down = iCommandSensorReset, name = _('Radar - Return To Search/NDTWS'), category = _('Sensors')},
{down = iCommandRefusalTWS, name = _('Unlock TWS Target'), category = _('Sensors')},
{combos = {{key = 'I'}}, down = iCommandPlaneRadarOnOff, name = _('Radar On/Off'), category = _('Sensors')},
--{combos = {{key = 'I', reformers = {'RAlt'}}}, down = iCommandPlaneRadarChangeMode, name = _('Radar RWS/TWS Mode Select'), category = _('Sensors')},
{combos = {{key = 'I', reformers = {'RCtrl'}}}, down = iCommandPlaneRadarCenter, name = _('Target Designator To Center'), category = _('Sensors')},
{combos = {{key = 'I', reformers = {'RShift'}}}, down = iCommandPlaneChangeRadarPRF, name = _('Radar Pulse Repeat Frequency Select'), category = _('Sensors')},
--{combos = {{key = 'O'}}, down = iCommandPlaneEOSOnOff, name = _('Electro-Optical System On/Off'), category = _('Sensors')},
--{combos = {{key = 'O', reformers = {'RShift'}}}, down = iCommandPlaneLaserRangerOnOff, name = _('Laser Ranger On/Off'), category = _('Sensors')},
--{combos = {{key = 'O', reformers = {'RCtrl'}}}, down = iCommandPlaneNightTVOnOff, name = _('Night Vision (FLIR or LLTV) On/Off'), category = _('Sensors')},
{combos = {{key = ';'}}, pressed = iCommandPlaneRadarUp, up = iCommandPlaneRadarStop, name = _('Target Designator Up'), category = _('Sensors')},
{combos = {{key = '.'}}, pressed = iCommandPlaneRadarDown, up = iCommandPlaneRadarStop, name = _('Target Designator Down'), category = _('Sensors')},
{combos = {{key = ','}}, pressed = iCommandPlaneRadarLeft, up = iCommandPlaneRadarStop, name = _('Target Designator Left'), category = _('Sensors')},
{combos = {{key = '/'}}, pressed = iCommandPlaneRadarRight, up = iCommandPlaneRadarStop, name = _('Target Designator Right'), category = _('Sensors')},
{combos = {{key = ';', reformers = {'RShift'}}}, pressed = iCommandSelecterUp, up = iCommandSelecterStop, name = _('Scan Zone Up'), category = _('Sensors')},
{combos = {{key = '.', reformers = {'RShift'}}}, pressed = iCommandSelecterDown, up = iCommandSelecterStop, name = _('Scan Zone Down'), category = _('Sensors')},
{combos = {{key = ',', reformers = {'RShift'}}}, pressed = iCommandSelecterLeft, up = iCommandSelecterStop, name = _('Scan Zone Left'), category = _('Sensors')},
{combos = {{key = '/', reformers = {'RShift'}}}, pressed = iCommandSelecterRight, up = iCommandSelecterStop, name = _('Scan Zone Right'), category = _('Sensors')},
{combos = {{key = '='}}, down = iCommandPlaneZoomIn, name = _('Display Zoom In'), category = _('Sensors')},
{combos = {{key = '-'}}, down = iCommandPlaneZoomOut, name = _('Display Zoom Out'), category = _('Sensors')},
{combos = {{key = '-', reformers = {'RCtrl'}}}, down = iCommandDecreaseRadarScanArea, name = _('Radar Scan Zone Decrease'), category = _('Sensors')},
{combos = {{key = '=', reformers = {'RCtrl'}}}, down = iCommandIncreaseRadarScanArea, name = _('Radar Scan Zone Increase'), category = _('Sensors')},
--{combos = {{key = '=', reformers = {'RAlt'}}}, pressed = iCommandPlaneIncreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = _('Target Specified Size Increase'), category = _('Sensors')},
--{combos = {{key = '-', reformers = {'RAlt'}}}, pressed = iCommandPlaneDecreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = _('Target Specified Size Decrease'), category = _('Sensors')},
{combos = {{key = 'R', reformers = {'RShift'}}}, down = iCommandChangeRWRMode, name = _('RWR/SPO Mode Select'), category = _('Sensors')},
{combos = {{key = ',', reformers = {'RAlt'}}}, down = iCommandPlaneThreatWarnSoundVolumeDown, name = _('RWR/SPO Sound Signals Volume Down'), category = _('Sensors')},
{combos = {{key = '.', reformers = {'RAlt'}}}, down = iCommandPlaneThreatWarnSoundVolumeUp, name = _('RWR/SPO Sound Signals Volume Up'), category = _('Sensors')},

-- Countermeasures
{down = iCommandPlaneDropSnar,		name = _('Countermeasures Continuously Dispense'),	category = _('Countermeasures') , features = {"Countermeasures"}},
{down = iCommandPlaneDropSnarOnce,	up = iCommandPlaneDropSnarOnceOff,	name = _('Countermeasures Release'),	category = _('Countermeasures') , features = {"Countermeasures"}},
{down = iCommandPlaneDropFlareOnce, 	name = _('Countermeasures Flares Dispense'),		category = _('Countermeasures') , features = {"Countermeasures"}},
{down = iCommandPlaneDropChaffOnce, 	name = _('Countermeasures Chaff Dispense'),			category = _('Countermeasures') , features = {"Countermeasures"}},
--{down = iCommandActiveJamming,	name = _('ECM'),									category = _('Countermeasures') , features = {"ECM"}},

-- Cockpit Camera Motion
{down = iCommandViewLeftMirrorOn,	up = iCommandViewLeftMirrorOff,		name = _('Mirror Left On'),		category = _('View Cockpit') , features = {"Mirrors"}},
{down = iCommandViewRightMirrorOn,	up = iCommandViewRightMirrorOff,	name = _('Mirror Right On'),	category = _('View Cockpit') , features = {"Mirrors"}},
{down = iCommandToggleMirrors,		name = _('Toggle Mirrors'),		category = _('View Cockpit') , features = {"Mirrors"}},

--Custom Commands
--Custom Systems
{combos = {{key = 'L', reformers = {'RShift'}}},	down = Keys.main_electric_switch_toggle,		name = _('Electric Power Switch On/Off'),		category = _('Systems')},
{combos = {{key = 'Home', reformers = {'RAlt'}}},	down = Keys.starter_switch_left_engine, 		name = _('Engine Left Start'),					category = _('Systems')},
{combos = {{key = 'Home', reformers = {'RCtrl'}}},	down = Keys.starter_switch_right_engine, 		name = _('Engine Right Start'),					category = _('Systems')},
--Weapons
{pressed = Keys.pickle_on,		up = Keys.pickle_off, name = _('Weapon Release'), category = _('Weapons')},
{down = Keys.trigger_on,	up = Keys.trigger_off, name = _('Fire Gun'), category = _('Weapons')},

--Gunsight
{down = Keys.GunPipper_Up, 				name = _('Gun Pipper Up'), 			category = _('Gunsight')},
{down = Keys.GunPipper_Down, 			name = _('Gun Pipper Down'), 		category = _('Gunsight')},
{down = Keys.GunPipper_Center, 			name = _('Gun Pipper Center'), 		category = _('Gunsight')},
{down = Keys.GunPipper_Automatic, 		name = _('Gun Pipper Automatic'), 	category = _('Gunsight')},
{combos = {{key = 'M', reformers = {'RAlt'}}},	down = Keys.GunPipper_Manual, 			name = _('Gun Pipper Manual'), 		category = _('Gunsight')},
{down = Keys.SetTargetRange_up, 		name = _('Increase Target Range'), 	category = _('Gunsight')},
{down = Keys.SetTargetRange_down, 		name = _('Decrease Target Range'), 	category = _('Gunsight')},
{down = Keys.Gunsight_activator_switch, name = _('Gunsight toggle On/Off'), category = _('Gunsight')},
{down = Keys.Gunsight_opacity_up, 		name = _('Gunsight opacity up'), 	category = _('Gunsight')},
{down = Keys.Gunsight_opacity_down, 	name = _('Gunsight opacity down'), 	category = _('Gunsight')},

--Missile Selector Rotational
{down = Keys.toggle_msl_sel_rot, name = _('Missile Selector Rotational toggle'), category = _('Missile Selector Rotational')},
{down = Keys.msl_sel_rot_r_fwd, name = _('Missile Selector Rotational R-FWD'), category = _('Missile Selector Rotational')},
{down = Keys.msl_sel_rot_r_wng, name = _('Missile Selector Rotational R-WNG'), category = _('Missile Selector Rotational')},
{down = Keys.msl_sel_rot_r_aft, name = _('Missile Selector Rotational R-AFT'), category = _('Missile Selector Rotational')},
{down = Keys.msl_sel_rot_all, name = _('Missile Selector Rotational ALL'), category = _('Missile Selector Rotational')},
{down = Keys.msl_sel_rot_l_aft, name = _('Missile Selector Rotational L-AFT'), category = _('Missile Selector Rotational')},
{down = Keys.msl_sel_rot_l_wng, name = _('Missile Selector Rotational L-WNG'), category = _('Missile Selector Rotational')},
{down = Keys.msl_sel_rot_l_fwd, name = _('Missile Selector Rotational L-FWD'), category = _('Missile Selector Rotational')},
{down = Keys.msl_sel_rot_off, name = _('Missile Selector Rotational OFF'), category = _('Missile Selector Rotational')},

--DogBone Panel
--Station Selector (AtoG Weapons)
{down = Keys.stations_off, name = _('DogBone Stations Selector Stations Off'), category = _('DogBone Panel')},
{down = Keys.inboard_stations, name = _('DogBone Stations Selector Inboard Stations'), category = _('DogBone Panel')},
{down = Keys.outboard_stations, name = _('DogBone Stations Selector Outboard Stations'), category = _('DogBone Panel')},
{down = Keys.center_station, name = _('DogBone Stations Selector Centerline Station'), category = _('DogBone Panel')},
{down = Keys.all_stations, name = _('DogBone Stations Selector All Station'), category = _('DogBone Panel')},
{down = Keys.toggleDogbone, name = _('DogBone Stations Selector Toggle'), category = _('DogBone Panel')},
--GunSwitch
{down = Keys.toggle_gunSwitch, name = _('DogBone Gun Switch Toggle'), category = _('DogBone Panel')},
{down = Keys.gunSwitch_CLEAR, name = _('DogBone Gun Switch Position CLEAR'), category = _('DogBone Panel')},
{down = Keys.gunSwitch_OFF, name = _('DogBone Gun Switch Position OFF'), category = _('DogBone Panel')},
{down = Keys.gunSwitch_READY, name = _('DogBone Gun Switch Position READY'), category = _('DogBone Panel')},
--WPS Rotational
{down = Keys.wps_toggle, name = _('DogBone Weapon Selector Rotational toggle'), category = _('DogBone Panel')},
{down = Keys.wps_cluster, name = _('DogBone Weapon Selector Rotational Cluster'), category = _('DogBone Panel')},
{down = Keys.wps_bombs_ripple, name = _('DogBone Weapon Selector Rotational Ripple-Bombs'), category = _('DogBone Panel')},
{down = Keys.wps_bombs_pairs, name = _('DogBone Weapon Selector Rotational Bombs in Pairs'), category = _('DogBone Panel')},
{down = Keys.wps_bombs_single, name = _('DogBone Weapon Selector Rotational Bombs Single'), category = _('DogBone Panel')},
{down = Keys.wps_rockets, name = _('DogBone Weapon Selector Rotational Rockets'), category = _('DogBone Panel')},


-- OLD Weapons                                                                        
--{combos = {{key = 'V', reformers = {'LCtrl'}}}, down = iCommandPlaneSalvoOnOff, name = _('Salvo Mode'), category = _('Weapons')},
--{combos = {{key = 'Space', reformers = {'RAlt'}}}, down = iCommandPlanePickleOn,	up = iCommandPlanePickleOff, name = _('Weapon Release'), category = _('Weapons')},
--{combos = {{key = 'C', reformers = {'LShift'}}}, down = iCommandChangeGunRateOfFire, name = _('Cannon Rate Of Fire / Cut Of Burst select'), category = _('Weapons')},

--Carrier Operations
--{combos = {{key = 'x', reformers = {'LAlt'}}}, down = iCommandPlaneRightMFD_OSB18, name = _('Wingtips UP/DOWN'), category = _('Carrier Operations')},	-- command Nr.689
{combos = {{key = 'u', reformers = {'LCtrl'}}}, down = iCommandPlaneShipTakeOff, name = _('Catapult Hook-Up'),	category = _('Carrier Operations')}, -- command Nr. 120
{combos = {{key = 'S', reformers = {'LShift','LCtrl'}}},	down = iCommandPilotGestureSalute,	name = _('Pilot Salute'),	category = _('Carrier Operations')},
{combos = {{key = 'l', reformers = {'LShift','LCtrl'}}}, down = iCommandPlaneRightMFD_OSB6_Off, name = _('Launch Bar Toggle'), category = _('Carrier Operations')}, -- command Nr.1012
{combos = {{key = 'G', reformers = {'LAlt'}}}, down = iCommandPlaneHook, name = _('Tail Hook'), category = _('Carrier Operations')},
{combos = {{key = 'P', reformers = {'RCtrl'}}}, down = iCommandPlanePackWing, name = _('Folding Wings'), category = _('Carrier Operations')},
})
return res

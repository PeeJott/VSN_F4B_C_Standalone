start_custom_command   = 10000
local __count_custom = start_custom_command-1
local function __custom_counter()
	__count_custom = __count_custom + 1
	return __count_custom
end

Keys =
{
	iCommandPlaneFonar							= 71, --Canopy open/close

	iCommandPlaneWingtipSmokeOnOff 				= 78,

	iCommandPlaneJettisonWeapons 				= 82,
 	iCommandPlaneFire 							= 84,
	iCommandPlaneFireOff 						= 85,
	
	--Master-Modes FC3---------------------------------
	iCommandPlaneChangeWeapon 					= 101,
	iCommandPlaneModeNAV						= 105,
	iCommandPlaneModeBVR						= 106,
	--iCommandPlaneModeVS							= 107,
	iCommandPlaneModeBore						= 108,
	--iCommandPlaneModeFI0						= 110,
	iCommandPlaneModeGround						= 111,
	iCommandPlaneModeCannon						= 113,

	iCommandActiveJamming 						= 136,
	iCommandBrightnessILS						= 156,
	iCommandPlaneJettisonFuelTanks 				= 178,
	iCommandToggleCommandMenu					= 179,
	
	iCommandPowerOnOff							= 315,
	
	iCommandPlanePickleOn	 					= 350,
	iCommandPlanePickleOff 						= 351,
	
	iCommandHUDBrightnessUp						= 746,
	iCommandHUDBrightnessDown	           		= 747,
	
	iCommandLeftEngineStart						= 311,
	iCommandRightEngineStart					= 312,
	
	-------------------AtoA-RADAR-COMMANDS----------------------------
	iCommandPlaneChangeLock						= 100,
	iCommandSelecterLeft						= 139,
	iCommandSelecterRight						= 140,
	iCommandSelecterUp							= 141,
	iCommandSelecterDown						= 142,
	iCommandPlaneChangeRadarPRF					= 394,
	iCommandPlane_LockOn_start					= 509,
	iCommandPlane_LockOn_finish					= 510,
	iCommandPlaneRadarChangeMode				= 285,
	iCommandPlaneRadarHorizontal				= 2025,
	iCommandPlaneRadarVertical					= 2026,
	iCommandPlaneSelecterHorizontal				= 2031,
	iCommandPlaneSelecterVertical				= 2032,
	iCommandPlaneRadarOnOff						= 86,
	iCommandIncreaseRadarScanArea				= 263,
	iCommandDecreaseRadarScanArea				= 262,
	
	-------------------Radio-COMMANDS----------------------------
	COM1                     					= __custom_counter(),
    COM2                     					= __custom_counter(),
	
	
	auto_HUD_brightness_down					= __custom_counter(),
	----------------Startup and Prepare Commands--------------------
	main_electric_switch_toggle					= __custom_counter(),
	starter_switch_left_engine					= __custom_counter(),
	starter_switch_right_engine					= __custom_counter(),

	------------------WEAPON SYSTEM---------------------------------
	-----------------Launch, Fire, Release and Drop-----------------
	pickle_on 									= __custom_counter(),
	pickle_off 									= __custom_counter(),
	trigger_on									= __custom_counter(),
	trigger_off									= __custom_counter(),
	---------------Dog-Bone Selector---------------------------------
	----------------Station Selection--------------------------------
	stations_off								= __custom_counter(),
	inboard_stations							= __custom_counter(),
	outboard_stations							= __custom_counter(),
	center_station								= __custom_counter(),
	all_stations								= __custom_counter(),
	toggleDogbone								= __custom_counter(),
	------------------GUN Switch-------------------------------------
	toggle_gunSwitch							= __custom_counter(),
	gunSwitch_OFF								= __custom_counter(),
	gunSwitch_CLEAR								= __custom_counter(),
	gunSwitch_READY								= __custom_counter(),
	-----------------Weapon Selector---------------------------------
	wps_toggle									= __custom_counter(),
	wps_cluster									= __custom_counter(),
	wps_bombs_ripple							= __custom_counter(),
	wps_bombs_pairs								= __custom_counter(),
	wps_bombs_single							= __custom_counter(),
	wps_rockets									= __custom_counter(),

	-----------------------------HUD--------------------------------
	GunPipper_Up								= __custom_counter(),
	GunPipper_Down								= __custom_counter(),
	GunPipper_Center							= __custom_counter(),
	GunPipper_Automatic							= __custom_counter(),
	GunPipper_Manual							= __custom_counter(),
	SetTargetRange_up							= __custom_counter(),
	SetTargetRange_down							= __custom_counter(),
	Gunsight_activator_switch					= __custom_counter(),
	Gunsight_opacity_up							= __custom_counter(),
	Gunsight_opacity_down						= __custom_counter(),
	
	--Missile Select Rotational
	toggle_msl_sel_rot							= __custom_counter(),
	msl_sel_rot_r_fwd							= __custom_counter(),
	msl_sel_rot_r_wng							= __custom_counter(),
	msl_sel_rot_r_aft							= __custom_counter(),
	msl_sel_rot_all								= __custom_counter(),
	msl_sel_rot_l_aft							= __custom_counter(),
	msl_sel_rot_l_wng							= __custom_counter(),
	msl_sel_rot_l_fwd							= __custom_counter(),
	msl_sel_rot_off								= __custom_counter(),


	

}

start_command   = 3000
local __count = start_command-1
local function __counter()
	__count = __count + 1
	return __count
end

device_commands =
{
--Gear                        = __counter(),
--LndGear               		= __counter(),

}

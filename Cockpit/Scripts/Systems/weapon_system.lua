dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."definitions.lua")

local dev = GetSelf()

local update_time_step = 0.05
make_default_activity(update_time_step)

local sensor_data = get_base_data()


--dev:
--devices for direct weapon-usage
dev:listen_command(Keys.pickle_on)
dev:listen_command(Keys.pickle_off)
dev:listen_command(Keys.trigger_on)
dev:listen_command(Keys.trigger_off)
------------------------------------
--Missile selctor rotational
dev:listen_command(Keys.toggle_msl_sel_rot)
dev:listen_command(Keys.msl_sel_rot_r_fwd)
dev:listen_command(Keys.msl_sel_rot_r_wng)
dev:listen_command(Keys.msl_sel_rot_r_aft)
dev:listen_command(Keys.msl_sel_rot_all)
dev:listen_command(Keys.msl_sel_rot_l_aft)
dev:listen_command(Keys.msl_sel_rot_l_wng)
dev:listen_command(Keys.msl_sel_rot_l_fwd)
dev:listen_command(Keys.msl_sel_rot_off)
---------Dogbone Selector Panel-----
--devices for pylon selection-------
dev:listen_command(Keys.stations_off)
dev:listen_command(Keys.inboard_stations)
dev:listen_command(Keys.outboard_stations)
dev:listen_command(Keys.center_station)
dev:listen_command(Keys.all_stations)
dev:listen_command(Keys.toggleDogbone)
--gun Switch-------------------------
dev:listen_command(Keys.toggle_gunSwitch)
dev:listen_command(Keys.gunSwitch_CLEAR)
dev:listen_command(Keys.gunSwitch_OFF)
dev:listen_command(Keys.gunSwitch_READY)
--weapon Selector rotational---------
dev:listen_command(Keys.wps_toggle)
dev:listen_command(Keys.wps_cluster)
dev:listen_command(Keys.wps_bombs_ripple)
dev:listen_command(Keys.wps_bombs_pairs)
dev:listen_command(Keys.wps_bombs_single)
dev:listen_command(Keys.wps_rockets)

----------FC3 MasterModes-------------------
dev:listen_command(Keys.iCommandPlaneModeNAV)
dev:listen_command(Keys.iCommandPlaneModeBVR)
dev:listen_command(Keys.iCommandPlaneModeBore)
dev:listen_command(Keys.iCommandPlaneModeGround)
dev:listen_command(Keys.iCommandPlaneModeCannon)
---------------------------------------------
---------Optical Sight Range commands--------
dev:listen_command(Keys.SetTargetRange_up)
dev:listen_command(Keys.SetTargetRange_down)



------------------------------------
-----------Armament Selector Switch---------
dev:listen_command(Keys.armSelSwitch_toggle)
dev:listen_command(Keys.armSelSwitch_GUN)
dev:listen_command(Keys.armSelSwitch_ROCKET)
dev:listen_command(Keys.armSelSwitch_MISSILE)
--------------------------------------------
----------MasterArm Switch------------------
dev:listen_command(Keys.masterArmSwitch_toggle)
dev:listen_command(Keys.masterArmSwitch_ARM)
dev:listen_command(Keys.masterArmSwitch_CAM)
dev:listen_command(Keys.masterArmSwitch_OFF)
-------------------------------------------
------------Bomb Release Switch------------
dev:listen_command(Keys.bombReleaseSwitch_toggle)
dev:listen_command(Keys.bombReleaseSwitch_AUTO)
dev:listen_command(Keys.bombReleaseSwitch_MANUAL)
-------------------------------------------
------------Bomb Arming Switch-------------
dev:listen_command(Keys.bombArmingSwitch_toggle)
dev:listen_command(Keys.bombArmingSwitch_NOSETAIL)
dev:listen_command(Keys.bombArmingSwitch_SAFE)
dev:listen_command(Keys.bombArmingSwitch_TAIL)
-------------------------------------------




--WeaponSystem-Params
local ir_missile_lock_param = get_param_handle("WS_IR_MISSILE_LOCK")
local ir_missile_az_param = get_param_handle("WS_IR_MISSILE_TARGET_AZIMUTH")
local ir_missile_el_param = get_param_handle("WS_IR_MISSILE_TARGET_ELEVATION")
local ir_missile_des_az_param = get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_AZIMUTH")
local ir_missile_des_el_param = get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_ELEVATION")
local stt_azimuth_h 	= get_param_handle("RADAR_STT_AZIMUTH")
local stt_elevation_h 	= get_param_handle("RADAR_STT_ELEVATION")
--local gunpipper_sideways_automatic_param = get_param_handle("WS_GUN_PIPER_AZIMUTH")
--local gunpipper_updown_automatic_param = get_param_handle("WS_GUN_PIPER_ELEVATION")
--local target_range_param = get_param_handle("WS_TARGET_RANGE")
--PylonSelector-Params
local station_selector_rot_param = get_param_handle("STATION_SEL_ROT")
local gun_switch_param			= get_param_handle("GUN_SWITCH")
local wps_switch_param			= get_param_handle("WPS_SWITCH")
---------------------------
local arm_Selector_switch_param = get_param_handle("ARMAMENT_SELECTOR")
---------------------------
local master_arm_switch_param = get_param_handle("MASTER_ARM_SWITCH")
--------------------------
local bomb_release_switch_param = get_param_handle("BOMB_REL_SWITCH")
-------------------------
local bomb_arming_switch_param = get_param_handle("BOMB_ARMING_SWITCH")

-------------------------
local missile_selector_rot_param = get_param_handle("MISSILE_SEL_ROT")
local missile_selector_rot_lights_param = get_param_handle("MISSILE_SEL_ROT_LIGHTS")
-------------------------



--local variables
local current_station = 0
local electricity_on = 0
local usableWeapon = 7
local MasterMode = 0

----------------------------------
local nextAtoAstation = 0
local activeStations = 0
local selected_stations = 0
local cannon_activated = 0
----------MSL Sel Rot.-----------
local Missile_Sel_rot = 0
-------------DogBone-------------
local DogBoneStationSelector = 0
local GunSwitchPosition = 0
local wps_switch = 0
-----------AtoG functions--------
local selected_AtoG_stations = 0
local single_bomb_dropped = 0
local BombsRippleNumber = 0

-----------------------------------------
-------------Pickle varaibles------------
local BombsReleased = 0
local AtoA_Missile_launched = 0
------------------------------------------
------------Optical Sight Variables-------
local target_range = 0
------------------------------------------
-----------Trigger Variables--------------
local trigger_on = 0


--TEST--
local station_zero = 0
-----------------------
local station_one = 0 -- -> Outboard Left
local station_one_clsid = 0
local weapontype_on_station_1_L2 	= 0
local weapontype_on_station_1_L3 	= 0
local usable_weapon_station_1		= 0
---------------------------------------
local station_two = 0 -- -> Inboard Left
local weapontype_on_station_2_L2 	= 0
local weapontype_on_station_2_L3 	= 0
local usable_weapon_station_2		= 0
local station_two_clsid = 0
---------------------------------------
local station_three = 0 -- -> LH FUS Rear
local weapontype_on_station_3_L2 	= 0
local weapontype_on_station_3_L3 	= 0
local usable_weapon_station_3		= 0
local station_three_clsid = 0
---------------------------------------
local station_four = 0 -- -> LH FUS Front
local station_four_clsid = 0
local weapontype_on_station_4_L2 	= 0
local weapontype_on_station_4_L3	= 0
local usable_weapon_station_4		= 0
---------------------------------------
local station_five = 0 -- -> CENTERLINE
local station_five_clsid = 0
local weapontype_on_station_5_L2 	= 0
local weapontype_on_station_5_L3 	= 0
local usable_weapon_station_5		= 0
----------------------------------------
local station_six = 0 -- -> RH FUS Front
local station_six_clsid = 0
local weapontype_on_station_6_L2 	= 0
local weapontype_on_station_6_L3 	= 0
local usable_weapon_station_6		= 0
---------------------------------------
local station_seven = 0 -- -> RH Fus Rear
local station_seven_clsid = 0
local weapontype_on_station_7_L2 	= 0
local weapontype_on_station_7_L3 	= 0
local usable_weapon_station_7		= 0
---------------------------------------
local station_eight = 0 -- -> RH Inboard
local station_eight_clsid = 0
local weapontype_on_station_8_L2 	= 0
local weapontype_on_station_8_L3 	= 0
local usable_weapon_station_8		= 0
---------------------------------------
local station_nine = 0 -- -> RH Outboard
local station_nine_clsid = 0
local weapontype_on_station_9_L2 	= 0
local weapontype_on_station_9_L3 	= 0
local usable_weapon_station_9		= 0
----------------------------------------

-----------------------
--target_range_param:set(800.0) --Target-Range auf 800m gesetzt

--gunpipper_auto_movement_side 	= 0.0
--gunpipper_auto_movement_updown	= 0.0

function WeaponInUse()

	--usable Weapon
	--AtoA->1; 
	--AtoG->2: 2.0->Bombs; 2.5->Cluster; 2.8->Rockets  
	--GUN->3 ; NONE->0
	
	--MasterModes
	--NAV->1; BVR->2; Bore->3; Ground->4; Cannon->5
	
	--WPS-Switch 0->Cluster; 1->Bombs_Ripple; 2->Bombs_Pairs; 3->Bombs_Single; 4->Rockets
	
	if((MasterMode == 2) or (masterMode == 3)) then 
		usableWeapon = 1 --all AtoA-Weapons except GUN
	end
	
	if(MasterMode == 5) then 
		
		usableWeapon = 3 
	end
	
	if(MasterMode == 4) then 
		if((wps_switch > 0) and (wps_switch <=3)) then
		usableWeapon = 2 -- 2.0->Bombs; 2.5->Cluster; 2.8->Rockets 
		elseif(wps_switch == 0)then
		usableWeapon = 2.5 -- ->Cluster
		else
		usableWeapon = 2.8 -- -> Rockets
		end
	end
	
	if(MasterMode == 1) then 
		usableWeapon = 0 
	end
	
	
end

function keys_pickle_on(value)
    --dev:drop_flare(1, 1)
	--choice of Weapon
	--AtoA->1; AtoG->2: GUN->3 ; NONE->0
	--MasterModes
	--NAV->1; BVR->2; Bore->3; Ground->4; Cannon->5
    
	--active_missile_station()
	--print_message_to_user("Electricity is at stage: " ..tostring(electricity_on))
	
	if electricity_on == 1 then
		if ((MasterMode == 2) or (MasterMode == 3)) then
			release_AtoA_Weapon()
			--dev:launch_station(current_station)
			--print_message_to_user("Launching Station: " ..tostring(current_station))
		elseif(MasterMode == 4)then
		checking_selected_AtoG_stations()
			if(wps_switch == 1)then
				release_Bombs_ripple()
				print_message_to_user("Releasing Bombs in Ripple.")
			elseif((wps_switch == 2) and (BombsReleased == 0))then
				release_Bombs_in_Pairs()
				print_message_to_user("Releasing Bombs in Pairs.")
				BombsReleased = 1
			elseif((wps_switch == 3) and (BombsReleased == 0))then
				bombs_single_release()
				print_message_to_user("Releasing Bombs single.")
				BombsReleased = 1
			end
		
		else
		--do nothing since it is NAV-Mode
		end
    
	else
	print_message_to_user("Electricity is off. No weapons deployment possible!")
	end	
	
	

	--dev:launch_station(current_station)
    --current_station = (current_station + 1) % 11
	
end


function release_AtoA_Weapon()

	--active_missile_station()
	if(AtoA_Missile_launched == 0) then
		dev:launch_station(current_station)
		--dispatch_action(nil, Keys.iCommandPlanePickleOn)--mal zum Testen was passiert
		print_message_to_user("Launching Station: " ..tostring(current_station))
		AtoA_Missile_launched = 1
	end
	
end

function release_Bombs_in_Pairs()
		
	--usable Weapon
	--AtoA->1; 
	--AtoG->2: 2.0->Bombs; 2.5->Cluster; 2.8->Rockets  
	--GUN->3 ; NONE->0
	
		checking_pylon_loadout()
		usable_weapon()
	
		if((station_one == 1) and (usable_weapon_station_1 == 2))then
			dev:launch_station(PYLON.OUT_LEFT)
			print_message_to_user("Releasing Outboard left.")
			single_bomb_dropped = 1
		end
		
		if((station_two == 1) and (usable_weapon_station_2 == 2))then
			dev:launch_station(PYLON.IN_LEFT)
			print_message_to_user("Releasing Inboard Left.")
		end
		
		if((station_five == 1) and (usable_weapon_station_5 == 2))then
			dev:launch_station(PYLON.CENTERLINE)
			print_message_to_user("Releasing CENTERLINE.")
		end
		
		if((station_eight == 1) and (usable_weapon_station_8 == 2))then
			dev:launch_station(PYLON.IN_RIGHT)
			print_message_to_user("Releasing Inboard Right.")
		end
		
		if((station_nine == 1) and (usable_weapon_station_9 == 2))then
			dev:launch_station(PYLON.OUT_RIGHT)
			print_message_to_user("Releasing Outboard Right.")
		end
	
end

function checking_selected_AtoG_stations()

	if((station_one == 1) and (station_two == 1) and (station_five == 1) 
		and (station_eight == 1) and (station_nine == 1)) then
		
		selected_AtoG_stations = 5 -- ->AllStations
		
	elseif((station_one == 1) and (station_nine == 1)) then
	
		selected_AtoG_stations = 2.1 -- ->OutsideStations
	
	elseif((station_two == 1) and (station_eight == 1)) then
	
		selected_AtoG_stations = 2.2 -- -> InsideStations
	
	elseif(station_five == 1) then
	
		selected_AtoG_stations = 1
	end

end

function release_Bombs_ripple()

	--usable Weapon
	--AtoA->1; 
	--AtoG->2: 2.0->Bombs; 2.5->Cluster; 2.8->Rockets  
	--GUN->3 ; NONE->0
	WeaponInUse()
	checking_pylon_loadout()
	usable_weapon()
	checking_selected_AtoG_stations()
	
	if((usable_weapon_station_1 == usableWeapon) and
	(((selected_AtoG_stations == 5) and (BombsRippleNumber == 0)) or 
	((selected_AtoG_stations == 2.1) and (BombsRippleNumber == 0))))then
		--dev:select_station(PYLON.OUT_LEFT)
		dev:launch_station(PYLON.OUT_LEFT)
		rippleCounter()
		return
	end
	
	if((usable_weapon_station_2 == usableWeapon) and (((selected_AtoG_stations == 5) and (BombsRippleNumber == 20))or ((selected_AtoG_stations == 2.2) and (BombsRippleNumber == 0))))then
		--dev:select_station(PYLON.IN_LEFT)
		dev:launch_station(PYLON.IN_LEFT)
		rippleCounter()
		return
	end
	
	if((usable_weapon_station_5 == usableWeapon) and (((BombsRippleNumber == 40) and (selected_AtoG_stations == 5)) or ((BombsRippleNumber == 10) and (selected_AtoG_stations == 1))))then
		--dev:select_station(PYLON.CENTERLINE)
		dev:launch_station(PYLON.CENTERLINE)
		rippleCounter()
		return
	end
	
	if((usable_weapon_station_8 == usableWeapon) and ((BombsRippleNumber == 30) and (selected_AtoG_stations == 5)) or ((selected_AtoG_stations == 2.2) and (BombsRippleNumber == 10)))then
		--dev:select_station(PYLON.IN_RIGHT)
		dev:launch_station(PYLON.IN_RIGHT)
		rippleCounter()
		return
	end
	
	if((usable_weapon_station_9 == usableWeapon) and 
	(((selected_AtoG_stations == 5) and (BombsRippleNumber == 10)) or 
	((selected_AtoG_stations == 2.1) and (BombsRippleNumber == 10))))then
		--dev:select_station(PYLON.OUT_RIGHT)
		dev:launch_station(PYLON.OUT_RIGHT)
		rippleCounter()
		return
	end
	
	rippleCounter()
	
end

function rippleCounter()
	
	if((selected_AtoG_stations == 5) and (BombsRippleNumber < 50))then
	BombsRippleNumber = BombsRippleNumber +1
	elseif((selected_AtoG_stations == 5) and(BombsRippleNumber == 50))then
	BombsRippleNumber = 0
	end
	
	if(((selected_AtoG_stations == 2.1) or (selected_AtoG_stations == 2.2)) and (BombsRippleNumber < 20))then
		BombsRippleNumber = BombsRippleNumber +1
	elseif(((selected_AtoG_stations == 2.1) or (selected_AtoG_stations == 2.2)) and (BombsRippleNumber >= 20))then
		BombsRippleNumber = 0
	end
	
	if((selected_AtoG_stations == 1) and (BombsRippleNumber < 10))then
		BombsRippleNumber = BombsRippleNumber +1
	elseif((selected_AtoG_stations == 1) and (BombsRippleNumber >= 10))then
		BombsRippleNumber = 0
	end
	

end


function bombs_single_release()

	WeaponInUse()
	checking_pylon_loadout()
	usable_weapon()
	checking_selected_AtoG_stations()

	if((usable_weapon_station_1 == usableWeapon) and ((selected_AtoG_stations == 5) or (selected_AtoG_stations == 2.1)) and 
		(single_bomb_dropped < 1))then
		dev:select_station(PYLON.OUT_LEFT)
		dev:launch_station(PYLON.OUT_LEFT)
		single_bomb_dropped = 1
		singleBombCounter()
		return
	end
	
	if((usable_weapon_station_9 == usableWeapon) and ((selected_AtoG_stations == 5) or (selected_AtoG_stations == 2.1)) and 
		(single_bomb_dropped < 2))then
		dev:select_station(PYLON.OUT_RIGHT)
		dev:launch_station(PYLON.OUT_RIGHT)
		single_bomb_dropped = 2
		singleBombCounter()
		return
	end
	
	if((usable_weapon_station_2 == usableWeapon) and ((selected_AtoG_stations == 5) or (selected_AtoG_stations == 2.2)) and
		(single_bomb_dropped < 3))then
		dev:select_station(PYLON.IN_LEFT)
		dev:launch_station(PYLON.IN_LEFT)
		single_bomb_dropped = 3
		singleBombCounter()
		return
	end
	
	if((usable_weapon_station_8 == usableWeapon) and ((selected_AtoG_stations == 5) or (selected_AtoG_stations == 2.2)) and 
		(single_bomb_dropped < 4))then
		dev:select_station(PYLON.IN_RIGHT)
		dev:launch_station(PYLON.IN_RIGHT)
		single_bomb_dropped = 4
		singleBombCounter()
		return
	end
	
	if((usable_weapon_station_5 == usableWeapon) and ((selected_AtoG_stations == 5) and (single_bomb_dropped < 5)) or (selected_AtoG_stations == 1))then
		dev:select_station(PYLON.CENTERLINE)
		dev:launch_station(PYLON.CENTERLINE)
		single_bomb_dropped = 5
		singleBombCounter()
		return
	end
	

end

function singleBombCounter()

	if((selected_AtoG_stations == 5) and (single_bomb_dropped >= 5))then
		single_bomb_dropped = 0
	elseif((selected_AtoG_stations == 2.1) and (single_bomb_dropped >= 2))then
		single_bomb_dropped = 0
	elseif((selected_AtoG_stations == 2.2) and (single_bomb_dropped >= 4))then
		single_bomb_dropped = 0
	elseif((selected_AtoG_stations == 1) and (single_bomb_dropped >= 1))then
		single_bomb_dropped = 0
	end

end


function keys_pickle_off(value)

	if(AtoA_Missile_launched == 1) then
	AtoA_Missile_launched = 0
	active_missile_station()
	end
	
	if(BombsReleased == 1) then
	BombsReleased = 0
	checking_pylon_loadout()
	usable_weapon()
	checking_selected_AtoG_stations()
	end
	
end


function keys_trigger_on(value)
	
    checking_pylon_loadout()
	station_five = 1
	
	if ((electricity_on == 1) and (GunSwitchPosition == 2) 
		and (MasterMode ~= 1) and (usable_weapon_station_5 == 3)
		and (station_five == 1))then
			dev:select_station(PYLON.CENTERLINE)
			dev:launch_station(PYLON.CENTERLINE)
	end
	
end


function keys_trigger_off(value)

	--WICHTIG und MERKEN: dispatch_action(nil, Keys.iCommandPlanePickleOff) wirkt wi "deselect_station"
	dispatch_action(nil, Keys.iCommandPlanePickleOff)
	
end

---------------------------------------
--DogBone weapons Selector-------------
---------DogBone Station Selection-----
function keys_stations_off(value)
	--Pylon 1 = Station 0; Pylon 2 = Station 1 etc.
	--same for select_station
	
	checking_pylon_loadout()
	WeaponInUse()
	usable_weapon()
	
	if(Missile_Sel_rot == 0) then
	station_one = 0
	station_two = 0
	station_five = 0
	station_eight = 0
	station_nine = 0
	DogBoneStationSelector = 0
	station_selector_rot_param:set(0)
	print_message_to_user("All Stations per DogBone deselcted.")
	end
end


function keys_outboard_stations(value)
	
	--0->OFF; 1-> both outboard stations; 2-> both inboard stations; 3->centerline station
	checking_pylon_loadout()
	WeaponInUse()
	usable_weapon()
	
	if ((electricity_on == 1) and (Missile_Sel_rot == 0)) then
	DogBoneStationSelector = 1
	station_selector_rot_param:set(1)
	print_message_to_user("Outboard Stations selected.")
	print_message_to_user("Usable Weapon Station 1:" ..tostring(usable_weapon_station_1))
	print_message_to_user("Usable Weapon Station 9:" ..tostring(usable_weapon_station_1))
		if(((usable_weapon_station_1 >= 2) and (usable_weapon_station_1 < 3)) and ((usable_weapon_station_9 >= 2) and (usable_weapon_station_9 < 3)))then
			station_one = 1
			dev:select_station(PYLON.OUT_LEFT)
			station_nine = 1
			dev:select_station(PYLON.OUT_RIGHT)
			print_message_to_user("Outboard stations ready.")
			station_two = 0
			station_three = 0
			station_four = 0
			station_five = 0
			station_six = 0
			station_seven = 0
			station_eight = 0
		elseif(((usable_weapon_station_1 < 2) or (usable_weapon_station_1 >= 3)) and ((usable_weapon_station_9 >= 2) and (usable_weapon_station_9 < 3)))then
			station_one = 0
			station_nine = 1
			dev:select_station(PYLON.OUT_RIGHT)
			print_message_to_user("Outboard Right ready.")
			station_two = 0
			station_three = 0
			station_four = 0
			station_five = 0
			station_six = 0
			station_seven = 0
			station_eight = 0
		elseif(((usable_weapon_station_1 >= 2) and (usable_weapon_station_1 < 3)) and ((usable_weapon_station_9 < 2) or (usable_weapon_station_9 >= 3)))then
			station_one = 1
			station_nine = 0
			dev:select_station(PYLON.OUT_LEFT)
			print_message_to_user("Outboard left ready.")
			station_two = 0
			station_three = 0
			station_four = 0
			station_five = 0
			station_six = 0
			station_seven = 0
			station_eight = 0
		else
			station_one = 0
			station_nine = 0
		end
	else
	--station_one = 0
	--station_nine = 0
	DogBoneStationSelector = 1
	station_selector_rot_param:set(1)
	print_message_to_user("Outboard Stations selected but inactive. No electricity/Diff. MSL Selection.")
	end

end

function keys_inboard_stations(value)
	
	checking_pylon_loadout()
	WeaponInUse()
	usable_weapon()
	
	if ((electricity_on == 1) and (Missile_Sel_rot == 0)) then
	DogBoneStationSelector = 2
	station_selector_rot_param:set(2)
	print_message_to_user("Inboard Stations selected.")
		if(((usable_weapon_station_2 >= 2) and (usable_weapon_station_2 < 3)) and ((usable_weapon_station_8 >= 2) and (usable_weapon_station_8 < 3)))then
			station_two = 1
			station_eight = 1
			station_one = 0
			station_three = 0
			station_four = 0
			station_five = 0
			station_six = 0
			station_seven = 0
			station_nine = 0
			dev:select_station(PYLON.IN_LEFT)
			dev:select_station(PYLON.IN_RIGHT)
		elseif(((usable_weapon_station_2 < 2) or (usable_weapon_station_2 >= 3)) and ((usable_weapon_station_8 >= 2) and (usable_weapon_station_8 < 3)))then
			station_two = 0
			station_eight = 1
			station_one = 0
			station_three = 0
			station_four = 0
			station_five = 0
			station_six = 0
			station_seven = 0
			station_nine = 0
			dev:select_station(PYLON.IN_RIGHT)
		elseif(((usable_weapon_station_2 >= 2) and (usable_weapon_station_2 < 3)) and ((usable_weapon_station_8 < 2) or (usable_weapon_station_8 >= 3)))then
			station_two = 1
			station_eight = 0
			station_one = 0
			station_three = 0
			station_four = 0
			station_five = 0
			station_six = 0
			station_seven = 0
			station_nine = 0
			dev:select_station(PYLON.IN_LEFT)
		else
			station_two = 0
			station_eight = 0
		end
	else
	--station_two = 0
	--station_eight = 0
	DogBoneStationSelector = 2
	print_message_to_user("Inboard Stations selected but inactive. No electricity/Diff. MSL Selection.")
	station_selector_rot_param:set(2)
	end

end


function keys_center_station(value)

	checking_pylon_loadout()
	WeaponInUse()
	usable_weapon()
	
	if((electricity_on == 1) and (Missile_Sel_rot == 0)) then
	station_selector_rot_param:set(3)
	DogBoneStationSelector = 3
	print_message_to_user("Centerline Station selected.")
		if((usable_weapon_station_5 >= 2) and (usable_weapon_station_5 < 3))then
			station_one = 0
			station_two = 0
			station_three = 0
			station_four = 0
			station_five = 1
			station_six = 0
			station_seven = 0
			station_eight = 0
			station_nine = 0
			dev:select_station(PYLON.CENTERLINE)
		end
	else
	station_five = 0
	DogBoneStationSelector = 3
	print_message_to_user("Centerline Station selected but inactive. No electricity/Diff. MSL Selection.")
	station_selector_rot_param:set(3)
	end

end

function keys_all_stations(value)

	checking_pylon_loadout()
	WeaponInUse()
	usable_weapon()

	if ((electricity_on == 1) and (Missile_Sel_rot == 0)) then
	station_selector_rot_param:set(4)
	print_message_to_user("All Stations (except fus.) selected.")
	DogBoneStationSelector = 4
		if(((usable_weapon_station_1 >= 2) and (usable_weapon_station_1 < 3)) and ((usable_weapon_station_9 >= 2) and (usable_weapon_station_9 < 3)) and ((usable_weapon_station_2 >= 2) and (usable_weapon_station_2 < 3)) 
			and ((usable_weapon_station_5 >= 2) and (usable_weapon_station_5 < 3)) and  
		((usable_weapon_station_8 >= 2) and (usable_weapon_station_8 < 3)))then
			station_one = 1
			station_two = 1
			station_five = 1
			station_eight = 1
			station_nine = 1
			dev:select_station(PYLON.OUT_LEFT)
			dev:select_station(PYLON.IN_LEFT)
			dev:select_station(PYLON.CENTERLINE)
			dev:select_station(PYLON.IN_RIGHT)
			dev:select_station(PYLON.OUT_RIGHT)
		end
	else
	station_one = 0
	station_two = 0
	station_five = 0
	station_eight = 0
	station_nine = 0
	DogBoneStationSelector = 4
	station_selector_rot_param:set(4)
	print_message_to_user("All Stations selected but inactive. No electricity/Diff. MSL Selection.")
	end

end

function keys_toggleDogbone(value)

	checking_pylon_loadout()
	WeaponInUse()
	usable_weapon()
	
	if(DogBoneStationSelector <= 3)then
		DogBoneStationSelector = DogBoneStationSelector +1
	else
		DogBoneStationSelector = 0
	end
	
	if(DogBoneStationSelector == 1)then
		dispatch_action(nil, Keys.outboard_stations)
	end
	
	if(DogBoneStationSelector == 2)then
		dispatch_action(nil, Keys.inboard_stations)
	end
	
	if(DogBoneStationSelector == 3)then
		dispatch_action(nil, Keys.center_station)
	end
	
	if(DogBoneStationSelector == 4)then
		dispatch_action(nil, Keys.all_stations)
	end
	
	if(DogBoneStationSelector == 0)then
		dispatch_action(nil, Keys.stations_off)
	end

end


-------------END DogBone Weapon Selector-------
--DogBone Panel Gun Switch---------
function keys_gun_switch_toggle(value)

	if (GunSwitchPosition <= 1) then
		GunSwitchPosition = GunSwitchPosition +1
	else
		GunSwitchPosition = 0
	end
	
	gun_switch_param:set(GunSwitchPosition)
	print_message_to_user("Gun Switch in Position Nr. :" ..tostring(GunSwitchPosition))
	
end

function keys_gun_switch_CLEAR(value)

	GunSwitchPosition = 0
	gun_switch_param:set(GunSwitchPosition)
	print_message_to_user("Gun Switch in Position CLEAR.")
	
end

function keys_gun_switch_OFF(value)

	GunSwitchPosition = 1
	gun_switch_param:set(GunSwitchPosition)
	print_message_to_user("Gun Switch in Position OFF.")
	
end

function keys_gun_switch_READY(value)

	GunSwitchPosition = 2
	gun_switch_param:set(GunSwitchPosition)
	print_message_to_user("Gun Switch in Position READY.")
	
end
----------------End GunSwitch------------------
--------------Weapon Selector Rotational-------
function keys_wps_toggle(value)

	--WPS-Switch 0->Cluster; 1->Bombs_Ripple; 2->Bombs_Pairs; 3->Bombs_Single; 4->Rockets
	if(wps_switch <= 3) then
		wps_switch = wps_switch +1
	else
		wps_switch = 0
	end
	
	wps_switch_param:set(wps_switch)
	print_message_to_user("Weapons Selector Switch at Position: "..tostring(wps_switch))

end

function keys_wps_cluster(value)

	wps_switch = 0
	wps_switch_param:set(wps_switch)
	print_message_to_user("Weapons Selector Switch at Position Cluster.")

end

function keys_wps_bombs_ripple(value)

	wps_switch = 1
	wps_switch_param:set(wps_switch)
	print_message_to_user("Weapons Selector Switch at Position Bombs-Ripple.")

end

function keys_wps_bombs_pairs(value)

	wps_switch = 2
	wps_switch_param:set(wps_switch)
	print_message_to_user("Weapons Selector Switch at Position Bombs-Pairs.")

end

function keys_wps_bombs_single(value)

	wps_switch = 3
	wps_switch_param:set(wps_switch)
	print_message_to_user("Weapons Selector Switch at Position Bombs-Single.")

end

function keys_wps_rockets(value)

	wps_switch = 4
	wps_switch_param:set(wps_switch)
	print_message_to_user("Weapons Selector Switch at Position Rockets.")

end

-----------------------------------------------


function checking_pylon_loadout()
	
	--checking all stations for WS-Types LEvel 2 and Level 3
	print_message_to_user("Checking Pylons in progress.")
	
	local info_1 = dev:get_station_info(PYLON.OUT_LEFT)
	local info_2 = dev:get_station_info(PYLON.IN_LEFT)
	local info_3 = dev:get_station_info(PYLON.FUS_LEFT_R)
	local info_4 = dev:get_station_info(PYLON.FUS_LEFT_F)
	local info_5 = dev:get_station_info(PYLON.CENTERLINE)
	local info_6 = dev:get_station_info(PYLON.FUS_RIGHT_F)
	local info_7 = dev:get_station_info(PYLON.FUS_RIGHT_R)
	local info_8 = dev:get_station_info(PYLON.IN_RIGHT)
	local info_9 = dev:get_station_info(PYLON.OUT_RIGHT)
	
	
	weapontype_on_station_1_L2 = info_1.weapon.level2
	weapontype_on_station_1_L3 = info_1.weapon.level3
	weapontype_on_station_2_L2 = info_2.weapon.level2
	weapontype_on_station_2_L3 = info_2.weapon.level3
	weapontype_on_station_3_L2 = info_3.weapon.level2
	weapontype_on_station_3_L3 = info_3.weapon.level3
	weapontype_on_station_4_L2 = info_4.weapon.level2
	weapontype_on_station_4_L3 = info_4.weapon.level3
	weapontype_on_station_5_L2 = info_5.weapon.level2
	weapontype_on_station_5_L3 = info_5.weapon.level3
	weapontype_on_station_6_L2 = info_6.weapon.level2
	weapontype_on_station_6_L3 = info_6.weapon.level3
	weapontype_on_station_7_L2 = info_7.weapon.level2
	weapontype_on_station_7_L3 = info_7.weapon.level3
	weapontype_on_station_8_L2 = info_8.weapon.level2
	weapontype_on_station_8_L3 = info_8.weapon.level3
	weapontype_on_station_9_L2 = info_9.weapon.level2
	weapontype_on_station_9_L3 = info_9.weapon.level3
	
	--usableWeapon: AtoA->1; AtoG->2: GUN->3 ; NONE->0
	
	--Bomben sind Level 2 Nr.5
	--AtoG Missiles sind Level 2 Nr.4 wenn NICHT Level 3 Nr.7 
	--Rockets sind Level 2 Nr.33 
	--AtoA Missiles sind Level 3 Nr.7 
	
end

function usable_weapon()

	--usableWeapon: AtoA->1; AtoG->2: GUN->3 ; FuelTank->4; NONE->0
	
	--Bomben sind Level 2 Nr.5
	--Cluster sind Level 3 Nr.38
	--AtoG Missiles sind Level 2 Nr.4 wenn NICHT Level 3 Nr.7 
	--Rockets sind Level 3 Nr.33 
	--AtoA Missiles sind Level 3 Nr.7
	-- FuelTank sind Level 3 Nr.43
	--Gun ist Level 3 Nr.10
	
	print_message_to_user("Checking Weapons on Pylons 1-9.")
	
	--station 1
	if (weapontype_on_station_1_L2 == 5) then
		usable_weapon_station_1 = 2
	elseif(weapontype_on_station_1_L3 == 33) then
		usable_weapon_station_1 = 2.8
	elseif(weapontype_on_station_1_L3 == 38) then
		usable_weapon_station_1 = 2.5
	elseif (weapontype_on_station_1_L3 == 7)then
		usable_weapon_station_1 = 1
	elseif (weapontype_on_station_1_L3 == 10)then
		usable_weapon_station_1 = 3
	elseif (weapontype_on_station_1_L3 == 43)then
		usable_weapon_station_1 = 4
	else
		usable_weapon_station_1 = 0
	end
	
	--station 2	
	if (weapontype_on_station_2_L2 == 5)then
		usable_weapon_station_2 = 2
	elseif(weapontype_on_station_2_L3 == 33) then
		usable_weapon_station_2 = 2.8
	elseif(weapontype_on_station_2_L3 == 38) then
		usable_weapon_station_2 = 2.5	
	elseif (weapontype_on_station_2_L3 == 7)then
		usable_weapon_station_2 = 1
	elseif (weapontype_on_station_2_L3 == 10)then
		usable_weapon_station_2 = 3
	elseif (weapontype_on_station_2_L3 == 43)then
		usable_weapon_station_2 = 4
	else
		usable_weapon_station_2 = 0
	end
	
	--station 3	
	if (weapontype_on_station_3_L2 == 5) then
		usable_weapon_station_3 = 2
	elseif(weapontype_on_station_3_L3 == 33) then
		usable_weapon_station_3 = 2.8
	elseif(weapontype_on_station_3_L3 == 38) then
		usable_weapon_station_3 = 2.5
	elseif (weapontype_on_station_3_L3 == 7)then
		usable_weapon_station_3 = 1
	elseif (weapontype_on_station_3_L3 == 10)then
		usable_weapon_station_3 = 3
	elseif (weapontype_on_station_3_L3 == 43)then
		usable_weapon_station_3 = 4
	else
		usable_weapon_station_3 = 0
	end
	
	--station 4
	if (weapontype_on_station_4_L2 == 5) then
		usable_weapon_station_4 = 2
	elseif(weapontype_on_station_4_L3 == 33)then
		usable_weapon_station_4 = 2.8
	elseif(weapontype_on_station_4_L3 == 38)then
		usable_weapon_station_4 = 2.5
	elseif (weapontype_on_station_4_L3 == 7)then
		usable_weapon_station_4 = 1
	elseif (weapontype_on_station_4_L3 == 10)then
		usable_weapon_station_4 = 3
	elseif (weapontype_on_station_4_L3 == 43)then
		usable_weapon_station_4 = 4
	else
		usable_weapon_station_4 = 0
	end
	
	--station 5
	if (weapontype_on_station_5_L2 == 5) then
		usable_weapon_station_5 = 2
	elseif(weapontype_on_station_5_L3 == 33)then 
		usable_weapon_station_5 = 2.8
	elseif(weapontype_on_station_5_L3 == 38)then 
		usable_weapon_station_5 = 2.5
	elseif (weapontype_on_station_5_L3 == 7)then
		usable_weapon_station_5 = 1
	elseif (weapontype_on_station_5_L3 == 10)then
		usable_weapon_station_5 = 3
	elseif (weapontype_on_station_5_L3 == 43)then
		usable_weapon_station_5 = 4
	else
		usable_weapon_station_5 = 0
	end
	
	--station 6
	if (weapontype_on_station_6_L2 == 5) then
		usable_weapon_station_6 = 2
	elseif(weapontype_on_station_6_L3 == 33)then 
		usable_weapon_station_6 = 2.8
	elseif(weapontype_on_station_6_L3 == 38)then 
		usable_weapon_station_6 = 2.5
	elseif (weapontype_on_station_6_L3 == 7)then
		usable_weapon_station_6 = 1
	elseif (weapontype_on_station_6_L3 == 10)then
		usable_weapon_station_6 = 3
	elseif (weapontype_on_station_6_L3 == 43)then
		usable_weapon_station_6 = 4
	else
		usable_weapon_station_6 = 0
	end
	
	--station 7
	if (weapontype_on_station_7_L2 == 5) then
		usable_weapon_station_7 = 2
	elseif(weapontype_on_station_7_L3 == 33)then 
		usable_weapon_station_7 = 2.8
	elseif(weapontype_on_station_7_L3 == 38)then 
		usable_weapon_station_7 = 2.5
	elseif (weapontype_on_station_7_L3 == 7)then
		usable_weapon_station_7 = 1
	elseif (weapontype_on_station_7_L3 == 10)then
		usable_weapon_station_7 = 3
	elseif (weapontype_on_station_7_L3 == 43)then
		usable_weapon_station_7 = 4
	else
		usable_weapon_station_7 = 0
	end
	
	--station 8
	if (weapontype_on_station_8_L2 == 5) then
		usable_weapon_station_8 = 2
	elseif(weapontype_on_station_8_L3 == 33)then
		usable_weapon_station_8 = 2.8
	elseif(weapontype_on_station_8_L3 == 38)then
		usable_weapon_station_8 = 2.5
	elseif (weapontype_on_station_8_L3 == 7)then
		usable_weapon_station_8 = 1
	elseif (weapontype_on_station_8_L3 == 10)then
		usable_weapon_station_8 = 3
	elseif (weapontype_on_station_8_L3 == 43)then
		usable_weapon_station_8 = 4
	else
		usable_weapon_station_8 = 0
	end
	
	--station 9
	if (weapontype_on_station_9_L2 == 5) then
		usable_weapon_station_9 = 2
	elseif(weapontype_on_station_9_L3 == 33)then 
		usable_weapon_station_9 = 2.8
	elseif(weapontype_on_station_9_L3 == 38)then 
		usable_weapon_station_9 = 2.5
	elseif (weapontype_on_station_9_L3 == 7)then
		usable_weapon_station_9 = 1
	elseif (weapontype_on_station_9_L3 == 10)then
		usable_weapon_station_9 = 3
	elseif (weapontype_on_station_9_L3 == 43)then
		usable_weapon_station_9 = 4
	else
		usable_weapon_station_9 = 0
	end
	
	--[[
	print_message_to_user("Weapon on Pylon 1 =" ..tostring(usable_weapon_station_1))
	print_message_to_user("Weapon on Pylon 2 =" ..tostring(usable_weapon_station_2))
	print_message_to_user("Weapon on Pylon 3 =" ..tostring(usable_weapon_station_3))
	print_message_to_user("Weapon on Pylon 4 =" ..tostring(usable_weapon_station_4))
	print_message_to_user("Weapon on Pylon 5 =" ..tostring(usable_weapon_station_5))
	print_message_to_user("Weapon on Pylon 6 =" ..tostring(usable_weapon_station_6))
	print_message_to_user("Weapon on Pylon 7 =" ..tostring(usable_weapon_station_7))
	print_message_to_user("Weapon on Pylon 8 =" ..tostring(usable_weapon_station_8))
	print_message_to_user("Weapon on Pylon 9 =" ..tostring(usable_weapon_station_9))
	]]
end


function active_missile_station()
	
	print_message_to_user("Checking active Missile stations for MSL-SEL-ROT.")
	
	checking_pylon_loadout()
	usable_weapon()
	WeaponInUse()
	
	local info_1 = dev:get_station_info(PYLON.OUT_LEFT)
	local info_2 = dev:get_station_info(PYLON.IN_LEFT)
	local info_3 = dev:get_station_info(PYLON.FUS_LEFT_R)
	local info_4 = dev:get_station_info(PYLON.FUS_LEFT_F)
	local info_5 = dev:get_station_info(PYLON.CENTERLINE)
	local info_6 = dev:get_station_info(PYLON.FUS_RIGHT_F)
	local info_7 = dev:get_station_info(PYLON.FUS_RIGHT_R)
	local info_8 = dev:get_station_info(PYLON.IN_RIGHT)
	local info_9 = dev:get_station_info(PYLON.OUT_RIGHT)
	
	if ((electricity_on == 1) and (Missile_Sel_rot == 1) and (info_6.count > 0) and 
		(usable_weapon_station_6 == 1))then
		station_two = 0
		station_three = 0
		station_four = 0
		station_six = 1
		station_seven = 0
		station_eight = 0
		dev:select_station(PYLON.FUS_RIGHT_F)
		current_station = (PYLON.FUS_RIGHT_F)
		print_message_to_user("Chosen Station is Nr. " ..tostring(current_station))
		print_message_to_user("Station 6 with Nr. of weapons :" ..tostring(info_6.count))
	elseif ((electricity_on == 1) and (Missile_Sel_rot == 2) and (info_8.count > 0) and 
		(usable_weapon_station_8 == 1))then
		station_two = 0
		station_three = 0
		station_four = 0
		station_six = 0
		station_seven = 0
		station_eight = 1
		dev:select_station(PYLON.IN_RIGHT)
		current_station = (PYLON.IN_RIGHT)
		print_message_to_user("Chosen Station is Nr. " ..tostring(current_station))
		print_message_to_user("Station 8 with Nr. of weapons :" ..tostring(info_8.count))
	elseif((electricity_on == 1) and (Missile_Sel_rot == 3) and (info_7.count > 0) and
		(usable_weapon_station_7 == 1)) then
		station_two = 0
		station_three = 0
		station_four = 0
		station_six = 0
		station_seven = 1
		station_eight = 0
		dev:select_station(PYLON.FUS_RIGHT_R)
		current_station = (PYLON.FUS_RIGHT_R)
		print_message_to_user("Chosen Station is Nr. " ..tostring(current_station))
		print_message_to_user("Station 7 with Nr. of weapons :" ..tostring(info_7.count))
	elseif(electricity_on == 1) and (Missile_Sel_rot == 4) then
		--Die Reihenfolge hat einen Sinn, da es die umgedrehte Abschussreihenfolge ist
		if((info_6.count > 0) and (usable_weapon_station_6 == 1))then
			station_six = 1
			dev:select_station(PYLON.FUS_RIGHT_F)
			current_station = (PYLON.FUS_RIGHT_F)
			print_message_to_user("Chosen Station is Nr. " ..tostring(current_station))
			print_message_to_user("Station 6 with Nr. of weapons :" ..tostring(info_6.count))
		return
		end
		if((info_4.count > 0) and (usable_weapon_station_4 == 1)) then
			station_four = 1
			dev:select_station(PYLON.FUS_LEFT_F)
			current_station = (PYLON.FUS_LEFT_F)
			print_message_to_user("Chosen Station is Nr. " ..tostring(current_station))
			print_message_to_user("Station 4 with Nr. of weapons :" ..tostring(info_4.count))
		return
		end
		if((info_7.count > 0) and (usable_weapon_station_7 == 1))then
			station_seven = 1
			dev:select_station(PYLON.FUS_RIGHT_R)
			current_station = (PYLON.FUS_RIGHT_R)
			print_message_to_user("Chosen Station is Nr. " ..tostring(current_station))
			print_message_to_user("Station 7 with Nr. of weapons :" ..tostring(info_7.count))
		return
		end
		if((info_3.count > 0) and (usable_weapon_station_3 == 1))then
			station_three = 1
			dev:select_station(PYLON.FUS_LEFT_R)
			current_station = (PYLON.FUS_LEFT_R)
			print_message_to_user("Chosen Station is Nr. " ..tostring(current_station))
			print_message_to_user("Station 3 with Nr. of weapons :" ..tostring(info_3.count))
		return
		end
		if((info_8.count > 0) and (usable_weapon_station_8 == 1)) then
			station_eight = 1
			dev:select_station(PYLON.IN_RIGHT)
			current_station = (PYLON.IN_RIGHT)
			print_message_to_user("Chosen Station is Nr. " ..tostring(current_station))
			print_message_to_user("Station 6 with Nr. of weapons :" ..tostring(info_6.count))
		return
		end
		if((info_2.count > 0) and (usable_weapon_station_2 == 1))then
			station_two = 1
			dev:select_station(PYLON.IN_LEFT)
			current_station = (PYLON.IN_LEFT)
			print_message_to_user("Chosen Station is Nr. " ..tostring(current_station))
			print_message_to_user("Station 2 with Nr. of weapons :" ..tostring(info_2.count))
		return
		end	
	elseif((electricity_on == 1) and (Missile_Sel_rot == 5) and (info_3.count > 0) and 
		(usable_weapon_station_3 == 1)) then
		station_two = 0
		station_three = 1
		station_four = 0
		station_six = 0
		station_seven = 0
		station_eight = 0
		dev:select_station(PYLON.FUS_LEFT_R)
		current_station = (PYLON.FUS_LEFT_R)
		print_message_to_user("Chosen Station is Nr. " ..tostring(current_station))
		print_message_to_user("Station 3 with Nr. of weapons :" ..tostring(info_3.count))
	elseif((electricity_on == 1) and (Missile_Sel_rot == 6) and (info_2.count > 0) and 
		(usable_weapon_station_6 == 1))then
		station_two = 1
		station_three = 0
		station_four = 0
		station_six = 0
		station_seven = 0
		station_eight = 0	
		dev:select_station(PYLON.IN_LEFT)
		current_station = (PYLON.IN_LEFT)
		print_message_to_user("Chosen Station is Nr. " ..tostring(current_station))
		print_message_to_user("Station 2 with Nr. of weapons :" ..tostring(info_2.count))
	elseif((electricity_on == 1) and (Missile_Sel_rot == 7) and (info_4.count > 0) and 
		(usable_weapon_station_4 == 1)) then
		station_two = 0
		station_three = 0
		station_four = 1
		station_six = 0
		station_seven = 0
		station_eight = 0	
		dev:select_station(PYLON.FUS_LEFT_F)
		current_station = (PYLON.FUS_LEFT_F)
		print_message_to_user("Chosen Station is Nr. " ..tostring(current_station))
		print_message_to_user("Station 4 with Nr. of weapons :" ..tostring(info_4.count))
	elseif(electricity_on == 1) and (Missile_Sel_rot == 0) then
		station_two = 0
		station_three = 0
		station_four = 0
		station_six = 0
		station_seven = 0
		station_eight = 0
		dev:select_station(15)--15 gibt es nicht
		current_station = 15
		print_message_to_user("Chosen Station is Nr. " ..tostring(current_station))
		print_message_to_user("No chosen weapons.")
	end

end

---------------Missile Selector Rotational--------------------------------------
function keys_toggle_msl_sel_rot(value)

	--0->OFF; 1->R FWD; 2->R-WNG; 3->R-AFT; 4->ALL; 5->L-AFT; 6->L-WNG; 7->L-FWD
	
	if(Missile_Sel_rot <= 6) then
		Missile_Sel_rot = Missile_Sel_rot +1
		print_message_to_user("Missile Selctor Rotational at position: " ..tostring(Missile_Sel_rot))
	elseif (Missile_Sel_rot == 7) then
		Missile_Sel_rot = 0
		print_message_to_user("Missile Selctor Rotational at position: OFF")
	end
	
	missile_selector_rot_lights_param:set(Missile_sel_rot)
	
	active_missile_station()
	
end

function keys_msl_sel_rot_r_fwd(value)

	Missile_Sel_rot = 1
	print_message_to_user("Missile Selector Rotational at position R-FWD")
	missile_selector_rot_lights_param:set(Missile_sel_rot)
	active_missile_station()
end

function keys_msl_sel_rot_r_wng(value)

	Missile_Sel_rot = 2
	print_message_to_user("Missile Selector Rotational at position R-WNG")
	missile_selector_rot_lights_param:set(Missile_sel_rot)
	active_missile_station()
	
end

function keys_msl_sel_rot_r_aft(value)

	Missile_Sel_rot = 3
	print_message_to_user("Missile Selector Rotational at position R-AFT")
	missile_selector_rot_lights_param:set(Missile_sel_rot)
	active_missile_station()
	
end

function keys_msl_sel_rot_all(value)

	Missile_Sel_rot = 4
	print_message_to_user("Missile Selector Rotational at position ALL")
	missile_selector_rot_lights_param:set(Missile_sel_rot)
	active_missile_station()
	
end

function keys_msl_sel_rot_l_aft(value)

	Missile_Sel_rot = 5
	print_message_to_user("Missile Selector Rotational at position L-AFT")
	missile_selector_rot_lights_param:set(Missile_sel_rot)
	active_missile_station()
	
end

function keys_msl_sel_rot_l_wng(value)

	Missile_Sel_rot = 6
	print_message_to_user("Missile Selector Rotational at position L-WNG")
	missile_selector_rot_lights_param:set(Missile_sel_rot)
	active_missile_station()
	
end

function keys_msl_sel_rot_l_fwd(value)

	Missile_Sel_rot = 7
	print_message_to_user("Missile Selector Rotational at position L-FWD")
	missile_selector_rot_lights_param:set(Missile_sel_rot)
	active_missile_station()
	
end

function keys_msl_sel_rot_off(value)

	Missile_Sel_rot = 0
	print_message_to_user("Missile Selector Rotational at position OFF")
	missile_selector_rot_lights_param:set(Missile_sel_rot)
	active_missile_station()
	
end

----------FC3 MasterModes-------------------
function keys_nav_mode(value)

	
	checking_pylon_loadout()
	usable_weapon()
	
	--NAV->1; BVR->2; Bore->3; Ground->4; Cannon->5
	
	MasterMode = 1
	print_message_to_user("NAV Mode engaged.")
	
	WeaponInUse()
	

end

function keys_bvr_mode(value)

	checking_pylon_loadout()
	usable_weapon()
	

	--NAV->1; BVR->2; Bore->3; Ground->4; Cannon->5
	
	MasterMode = 2
	print_message_to_user("BVR Mode engaged.")
	WeaponInUse()

end

function keys_bore_mode(value)

	checking_pylon_loadout()
	usable_weapon()
	
	--NAV->1; BVR->2; Bore->3; Ground->4; Cannon->5
	
	MasterMode = 3
	print_message_to_user("Dogfight-BORE Mode engaged.")
	WeaponInUse()

end

function keys_ground_mode(value)
	
	checking_pylon_loadout()
	usable_weapon()
	
	--NAV->1; BVR->2; Bore->3; Ground->4; Cannon->5
	
	MasterMode = 4
	print_message_to_user("Air-to-Ground Mode engaged.")
	WeaponInUse()

end

function keys_cannon_mode(value)
	
	checking_pylon_loadout()
	usable_weapon()
	
	--NAV->1; BVR->2; Bore->3; Ground->4; Cannon->5
	
	MasterMode = 5
	print_message_to_user("Cannon Mode engaged.")
	WeaponInUse()

end
---------------FC3 MasterModes Ende--------------------
--------------Ootical Sight Deflection functions-------

function keys_set_target_range_increase(value)
	
	if(target_range <= 1000.0)then
		target_range = target_range + 50 -- inc. target range by 50m per click
		dev:set_target_range(target_range)
		print_message_to_user("Target Range is set at: " ..tostring(target_range).. "Meters")
	else
		target_range = 1000.0
		dev:set_target_range(target_range)
		print_message_to_user("Target Range is set ar max. 1000 Meters.")
	end
end

function keys_set_target_range_decrease(value)

	if(target_range >= 300)then
		target_range = target_range - 50 -- inc. target range by 50m per click
		dev:set_target_range(target_range)
		print_message_to_user("Target Range is set at: " ..tostring(target_range).. "Meters")
	else
		target_range = 300.0
		dev:set_target_range(target_range)
		print_message_to_user("Target Range is set ar min. 300 Meters.")
	end

end



command_table = {
    --Weapon usage keys
	[Keys.pickle_on] 			= keys_pickle_on,
	[Keys.pickle_off]			= keys_pickle_off,
    [Keys.trigger_on] 			= keys_trigger_on,
    [Keys.trigger_off] 			= keys_trigger_off,
	
	--HUD/deflection keys
	[Keys.GunPipper_Automatic]	= keys_gunpipper_automatic,
	[Keys.SetTargetRange_up]	= keys_set_target_range_increase,
	[Keys.SetTargetRange_down]	= keys_set_target_range_decrease,
	
	--DogBone Panel--
	--Station selector keys DogBone Selector
	[Keys.stations_off]			= keys_stations_off,
	[Keys.inboard_stations]		= keys_inboard_stations,
	[Keys.outboard_stations]	= keys_outboard_stations,
	[Keys.center_station]		= keys_center_station,
	[Keys.all_stations]			= keys_all_stations,
	[Keys.toggleDogbone]		= keys_toggleDogbone,
	--GunSwitch--
	[Keys.toggle_gunSwitch]		= keys_gun_switch_toggle,
	[Keys.gunSwitch_CLEAR]		= keys_gun_switch_CLEAR,
	[Keys.gunSwitch_OFF]		= keys_gun_switch_OFF,
	[Keys.gunSwitch_READY]		= keys_gun_switch_READY,
	--Weapons Selector Rotational
	[Keys.wps_toggle]			= keys_wps_toggle,
	[Keys.wps_cluster]			= keys_wps_cluster,
	[Keys.wps_bombs_ripple]		= keys_wps_bombs_ripple,
	[Keys.wps_bombs_pairs]		= keys_wps_bombs_pairs,
	[Keys.wps_bombs_single]		= keys_wps_bombs_single,
	[Keys.wps_rockets]			= keys_wps_rockets,
	
	
	--Missile Selection Rotational
	[Keys.toggle_msl_sel_rot]			= keys_toggle_msl_sel_rot,
	[Keys.msl_sel_rot_r_fwd]			= keys_msl_sel_rot_r_fwd,
	[Keys.msl_sel_rot_r_wng]			= keys_msl_sel_rot_r_wng,
	[Keys.msl_sel_rot_r_aft]			= keys_msl_sel_rot_r_aft,
	[Keys.msl_sel_rot_all]				= keys_msl_sel_rot_all,
	[Keys.msl_sel_rot_l_aft]			= keys_msl_sel_rot_l_aft,
	[Keys.msl_sel_rot_l_wng]			= keys_msl_sel_rot_l_wng,
	[Keys.msl_sel_rot_l_fwd]			= keys_msl_sel_rot_l_fwd,
	[Keys.msl_sel_rot_off]				= keys_msl_sel_rot_off,
	
	--FC3 MasterModes
	[Keys.iCommandPlaneModeNAV] 		= keys_nav_mode,
	[Keys.iCommandPlaneModeBVR] 		= keys_bvr_mode,
	[Keys.iCommandPlaneModeBore] 		= keys_bore_mode,
	[Keys.iCommandPlaneModeGround] 		= keys_ground_mode,
	[Keys.iCommandPlaneModeCannon] 		= keys_cannon_mode,
	
	
}

function SetCommand(command, value)

    if command_table[command] then
        command_table[command](value)
    end
end


function post_initialize()
    
	--dev:select_station(current_station)
	
	--print_message_to_user("Missile_Seeker_Elevation " ..tostring(ir_missile_des_el_param:get()))
	--print_message_to_user("Missile_Seeker_Azimuth " ..tostring(ir_missile_des_az_param:get()))
	station_zero = 0
	station_one = 0
	station_two = 0
	station_three = 0
	station_four = 0
	station_five = 0
	station_six = 0
	station_seven = 0
	station_eight = 0
	station_nine = 0
	
	target_range = 600
	print_message_to_user("Target Range set to 600m.")
	
end


function update()

	
	
	if electric_system_api:get_AC() then
		electricity_on = 1
	else
		electricity_on = 0
	end
	
	
	
	
--gunpipper_auto_movement_side 		= gunpipper_sideways_automatic_param:get()
--gunpipper_auto_movement_updown		= gunpipper_updown_automatic_param:get()

	--print_message_to_user("IR Missile got lock = " ..tostring(ir_missile_lock_param:get()))
    if ir_missile_lock_param:get() > 0.0 then --vorher if ir_lock:get() > 0 then 
        print_message_to_user("Missile Lock")
	end
	
	--[[if ir_missile_az_param:get() > 0.0 then
		print_message_to_user("Target_Azimuth " ..tostring(ir_missile_az_param:get()))
	end
	
	
	--print_message_to_user("GunPipper_Automatic_Sideways " ..tostring(gunpipper_auto_movement_side))
	--print_message_to_user("GunPipper_Automatic_UpDown " ..tostring(gunpipper_auto_movement_updown))]]

end

need_to_be_closed = false

--Possible simpleWeaponSystem functions:

--avSimpleWeaponSystem--
--drop_chaff 
--drop_flare 
--emergency_jettison 
--emergency_jettison_rack 
--get_chaff_count 
--get_ECM_status 
--get_flare_count 
--get_station_info 
--get_target_range 
--get_target_span 
--get_weapon_count 
--launch_station 
--select_station 
--set_ECM_status 
--set_target_range 
--set_target_span 


--possible simpleWeaponSystem Params
--WS_GUN_PIPER_SPAN
--WS_DLZ_MAX
--WS_GUN_PIPER_AVAILABLE
--WS_GUN_PIPER_AZIMUTH
--WS_GUN_PIPER_ELEVATION
--WS_TARGET_RANGE
--WS_TARGET_SPAN
--WS_ROCKET_PIPER_AVAILABLE
--WS_ROCKET_PIPER_AZIMUTH
--WS_ROCKET_PIPER_ELEVATION
--WS_DLZ_MIN
--WS_IR_MISSILE_LOCK
--WS_IR_MISSILE_TARGET_AZIMUTH
--WS_IR_MISSILE_SEEKER_DESIRED_AZIMUTH
--WS_IR_MISSILE_TARGET_ELEVATION
--WS_IR_MISSILE_SEEKER_DESIRED_ELEVATION
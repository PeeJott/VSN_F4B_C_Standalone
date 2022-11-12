range_scale 		  	= 60000.0 --Alter Wert
TDC_range_carret_size 	= 5000
render_debug_info 		= false --true

---------Versuch---------
local range_multiplier = 0.3333
local corrected_radar_range = 0
---------Versuch ende----
--------Ranges-------------------
local MAX_RANGE = 60000.0 * 1.852 -- -> 111120.0m sind 60 nm
local MAX_RANGE_GATE = 41000.0 * 1.852 -- -> 75932.0m sind 41 nm
---------Radar Modes-----------
local current_mode = 0
local modes = {}
modes[0] = "OFF"
modes[1] = "SBY"
modes[2] = "A/A"
-------Range Sweep-------------
local range_sweep_switch = 2
local ranges = {}
ranges[0] = "10"
ranges[1] = "20"
ranges[2] = "40"
ranges[3] = "80"

---------Versuch---------
local range_multiplier = 0.3333
local corrected_radar_range = 0
---------Versuch ende----



perfomance = 
{
	roll_compensation_limits	= {math.rad(-180.0), math.rad(180.0)},
	pitch_compensation_limits	= {math.rad(-57.0), math.rad(20.0)},  -- ALT {math.rad(-45.0), math.rad(45.0)},

	
	tracking_azimuth   			= { -math.rad(30),math.rad(30)},
	tracking_elevation 			= { -math.rad(30),math.rad(30)},--60° 
	
	scan_volume_azimuth 		= math.rad(90),-- ALT math.rad(60),		--is left+right so 60 is -30,30+
	scan_volume_elevation		= math.rad(30),	--math.rad(30),		--eigentlich 10 aber 30 zum testen
	scan_beam					= math.rad(15), -- A/Amath.rad(60), --eignetlich 5 aber 15 zum testen
	scan_speed					= math.rad(3*60),
	
	
	max_available_distance  = 111120.0,--MAX_RANGE / 0.66,--200*60000.0, das ist denke ich in Metern. Das erhöhe ich mal von 20km auf 35nm auf 60nm -> 111120m
	dead_zone 				= 300.0,
	
	ground_clutter =
	{-- spot RCS = A + B * random + C * random 
		sea		   	   = {0 ,0,0},
		land 	   	   = {0 ,0,0},		
		artificial 	   = {0 ,0,0},
		rays_density   = 0.01,
		max_distance   = 64820.0,--60000,
	}
	
}


------------------------------------------------------------------------------

dev 	    	= GetSelf()
DEBUG_ACTIVE 	= false



update_time_step 	= 0.01666		--0.166 --once every 6 times a sec
device_timer_dt		= 0.01666

make_default_activity(update_time_step) 



Radar = 	{
				-- NONE = 0
				-- SCAN = 1
				-- ACQUISITION = 2
				-- TRACKING = 3
				-- BUILT_IN_TEST = 4
				mode_h 					= get_param_handle("RADAR_MODE"),
				szoe_h 					= get_param_handle("SCAN_ZONE_ORIGIN_ELEVATION"),
				szoa_h 					= get_param_handle("SCAN_ZONE_ORIGIN_AZIMUTH"),
				
				opt_pb_stab_h 			= get_param_handle("RADAR_PITCH_BANK_STABILIZATION"),
				opt_bank_stab_h 		= get_param_handle("RADAR_BANK_STABILIZATION"),
				opt_pitch_stab_h		= get_param_handle("RADAR_PITCH_STABILIZATION"),
				
				
				tdc_azi_h 				= get_param_handle("RADAR_TDC_AZIMUTH"),
				tdc_range_h 			= get_param_handle("RADAR_TDC_RANGE"),
				tdc_closet_h			= get_param_handle("CLOSEST_RANGE_RESPONSE"),
				
				tdc_rcsize_h			= get_param_handle("RADAR_TDC_RANGE_CARRET_SIZE"),
				tdc_acqzone_h   		= get_param_handle("ACQUSITION_ZONE_VOLUME_AZIMUTH"),
				

				stt_range_h 			= get_param_handle("RADAR_STT_RANGE"),
				stt_azimuth_h 			= get_param_handle("RADAR_STT_AZIMUTH"),
				stt_elevation_h 		= get_param_handle("RADAR_STT_ELEVATION"),
				
				sz_volume_azimuth_h 	= get_param_handle("SCAN_ZONE_VOLUME_AZIMUTH"),
				sz_volume_elevation_h 	= get_param_handle("SCAN_ZONE_VOLUME_ELEVATION"),
				sz_azimuth_h 			= get_param_handle("SCAN_ZONE_ORIGIN_AZIMUTH"),
				sz_elevation_h 			= get_param_handle("SCAN_ZONE_ORIGIN_ELEVATION"),
				
				tdc_ele_up_h 			= get_param_handle("RADAR_TDC_ELEVATION_AT_RANGE_UPPER"),
				tdc_ele_down_h 			= get_param_handle("RADAR_TDC_ELEVATION_AT_RANGE_LOWER"),
				
				ws_ir_slave_azimuth_h	= get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_AZIMUTH"),
				ws_ir_slave_elevation_h	= get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_ELEVATION"),
				
				iff_status_h			= get_param_handle("IFF_INTERROGATOR_STATUS"),
				bit_h 					= get_param_handle("RADAR_BIT"),
				
				range_switch_param		= get_param_handle("RADAR_RANGE_SCALE"),
				range_switch_multiplier	= get_param_handle("RADAR_RANGE_MULTI"),

			}

function post_initialize()

	print_message_to_user("Radar - INIT")
		
		dev:listen_command(100)		--iCommandPlaneChangeLock
		
		dev:listen_command(139)		--scanzone left // iCommandSelecterLeft
		dev:listen_command(140)		--scanzone right // iCommandSelecterRight
		
		dev:listen_command(141)		--scanzone up//iCommandSelecterUp
		dev:listen_command(142)		--scanzone down//iCommandSelecterDown
		
		dev:listen_command(394)		--change PRF (radar puls freqency)//iCommandPlaneChangeRadarPRF
	
		dev:listen_command(509)		--lock start//iCommandPlane_LockOn_start
		dev:listen_command(510)		--lock finish//iCommandPlane_LockOn_finish
		
		dev:listen_command(285)		--Change radar mode RWS/TWS //iCommandPlaneRadarChangeMode
		
		dev:listen_command(2025)	--iCommandPlaneRadarHorizontal
		dev:listen_command(2026)	--iCommandPlaneRadarVertical
		dev:listen_command(2031)	--iCommandPlaneSelecterHorizontal
		dev:listen_command(2032)	--iCommandPlaneSelecterVertical
		
		dev:listen_command(262)		--iCommandDecreaseRadarScanArea
		dev:listen_command(263)		--iCommandIncreaseRadarScanArea
		

		Radar.opt_pb_stab_h:set(1)
		Radar.opt_pitch_stab_h:set(1)
		Radar.opt_bank_stab_h:set(1)
	
	-----------------------------------------------------------------------------------
	--Das hier ist GOLD, da es ALLE aktuellen Params anzeigt mit Wert und Veränderung--
	show_param_handles_list()
	-----------------------------------------------------------------------------------
	
end

function SetCommand(command,value)
	--print_message_to_user(string.format("Radar SetCom: C %i   V%.8f",command,value))
	
---------------------------------------------------------------------
	-- Alte Funktionen
	--[[
	if command == 141 and value == 0.0 then
		Radar.sz_elevation_h:set(Radar.sz_elevation_h:get() + 0.003)
	elseif command == 142 and value == 0.0 then
		Radar.sz_elevation_h:set(Radar.sz_elevation_h:get() - 0.003)
	end
	
	if command == 139 and value == 0.0 then
		Radar.sz_azimuth_h:set(Radar.sz_azimuth_h:get() + 0.003)
	elseif command == 140 and value == 0.0 then
		Radar.sz_azimuth_h:set(Radar.sz_azimuth_h:get() - 0.003)
	end
	]]
	
	--NEUE FUNKTIONEN--
	
	if command == 141 then
		local new_elevation = Radar.sz_elevation_h:get() + math.rad(2)
		if new_elevation > math.rad(20) then
				new_elevation = math.rad(20)
		end
		Radar.sz_elevation_h:set(new_elevation)
		print_message_to_user("Antenna elevation: " .. math.deg(new_elevation))

		---- offset discovery
		--offset = offset - 1
		--if offset < 0 then
		--	offset = 0
		--end
		--avImprovedRadar.SetOffset(offset)
	end
	
	if command == 142 then
		local new_elevation = Radar.sz_elevation_h:get() - math.rad(2)
		if new_elevation < -(math.rad(38)) then
			new_elevation = -(math.rad(38))
		end
		Radar.sz_elevation_h:set(new_elevation)
		print_message_to_user("Antenna elevation: " .. math.deg(new_elevation))

		---- offset discovery
		--offset = offset + 1		
		--avImprovedRadar.SetOffset(offset)
	end
	
	--Die folgende Funktion ist für Radar-Antenne rechts/links
	--diese Funktion hat die F-104G nicht!!!
	--[[
	if command == 139 and value == 0.0 then
		Radar.sz_azimuth_h:set(Radar.sz_azimuth_h:get() + 0.003)
	elseif command == 140 and value == 0.0 then
		Radar.sz_azimuth_h:set(Radar.sz_azimuth_h:get() - 0.003)
	end
	]]
----------------------------------------------------------------------	
	---NEUE Radar Range Einstellung----
	local updateRangeGateScale = false
	
	if command == 263 then --Range increase
		if range_sweep_switch == 0 then
			range_sweep_switch = range_sweep_switch + 1
			print_message_to_user("Range: " .. ranges[range_sweep_switch])
			range_multiplier = 0.3333
			Radar.range_switch_param:set(20)
			Radar.range_switch_multiplier:set(range_multiplier)
			print_message_to_user("RangeMultiplier: ".. range_multiplier)
			MAX_RANGE = 37040.0
			MAX_RANGE_GATE = 75932.0 * range_multiplier
			
		elseif range_sweep_switch == 1 then
			range_sweep_switch = range_sweep_switch + 1
			print_message_to_user("Range: " .. ranges[range_sweep_switch])
			range_multiplier = 0.6666
			Radar.range_switch_param:set(40)
			Radar.range_switch_multiplier:set(range_multiplier)
			print_message_to_user("RangeMultiplier: ".. range_multiplier)
			MAX_RANGE = 74080.0
			MAX_RANGE_GATE = 75932.0 * range_multiplier
		elseif range_sweep_switch == 2 then
			range_sweep_switch = 3
			print_message_to_user("Range: " .. ranges[range_sweep_switch])
			range_multiplier = 1
			Radar.range_switch_param:set(80)
			Radar.range_switch_multiplier:set(range_multiplier)
			print_message_to_user("RangeMultiplier: ".. range_multiplier)
			MAX_RANGE = 111120.0
			MAX_RANGE_GATE = 75932.0
		elseif range_sweep_switch == 3 then
			range_sweep_switch = 3
			print_message_to_user("Range: MAX Range 80 nm")
			range_multiplier = 1
			Radar.range_switch_param:set(80)
			Radar.range_switch_multiplier:set(range_multiplier)
			print_message_to_user("RangeMultiplier: ".. range_multiplier)
			MAX_RANGE = 111120.0
			MAX_RANGE_GATE = 75932.0
		end
	end
	
	if command == 262 then --Range decrease
		if range_sweep_switch == 3 then
			range_sweep_switch = range_sweep_switch - 1
			print_message_to_user("Range: " .. ranges[range_sweep_switch])
			range_multiplier = 0.6666
			Radar.range_switch_param:set(40)
			Radar.range_switch_multiplier:set(range_multiplier)
			print_message_to_user("RangeMultiplier: ".. range_multiplier)
			MAX_RANGE = 74080.0
			MAX_RANGE_GATE = 75932.0 * range_multiplier
		elseif range_sweep_switch == 2 then
			range_sweep_switch = range_sweep_switch - 1
			print_message_to_user("Range: " .. ranges[range_sweep_switch])
			range_multiplier = 0.3333
			Radar.range_switch_param:set(20)
			Radar.range_switch_multiplier:set(range_multiplier)
			print_message_to_user("RangeMultiplier: ".. range_multiplier)
			MAX_RANGE = 37040.0
			MAX_RANGE_GATE = 75932.0 * range_multiplier
		elseif range_sweep_switch == 1 then
			range_sweep_switch = 0
			print_message_to_user("Range: " .. ranges[range_sweep_switch])
			range_multiplier = 0.1666
			Radar.range_switch_param:set(10)
			Radar.range_switch_multiplier:set(range_multiplier)
			print_message_to_user("RangeMultiplier: ".. range_multiplier)
			MAX_RANGE = 18520.0
			MAX_RANGE_GATE = 75932.0 * range_multiplier
		elseif range_sweep_switch == 0 then
			range_sweep_switch = 0
			print_message_to_user("Range: MIN Range 10 nm")
			range_multiplier = 0.1666
			Radar.range_switch_param:set(10)
			Radar.range_switch_multiplier:set(range_multiplier)
			print_message_to_user("RangeMultiplier: ".. range_multiplier)
			MAX_RANGE = 18520.0
			MAX_RANGE_GATE = 75932.0 * range_multiplier
		end
	end
	
	--[[-------Versuch------------------
	if range_sweep_switch == 0 then
		range_multiplier = 0.5
	elseif range_sweep_switch == 1 then
		range_multiplier = 1
	elseif range_sweep_switch == 2 then
		range_multiplier = 2
	end
	---------Versuch Ende-----------
	]]
		
	
	------------------------------------------------------------------
	--Das war die alte RADAR-Range-Einstellung
	--[[if Radar.tdc_range_h:get() > 20000 then
		Radar.tdc_range_h:set(20000)
	elseif Radar.tdc_range_h:get() < 0 then
		Radar.tdc_range_h:set(0)
	end]]
	
	---Radar TDC Left/Right alte Funktion-----------
	if Radar.tdc_azi_h:get() > 0.5 then
		Radar.tdc_azi_h:set(0.5)
	elseif Radar.tdc_azi_h:get() < -0.5 then
		Radar.tdc_azi_h:set(-0.5)
	end
	
-------------------------------------------------

	corrected_radar_range = range_multiplier * Radar.tdc_range_h:get()
-------------------------------------------------
	--Radar.tdc_range_h:set(Radar.tdc_range_h:get()- ((value*200000) * range_multiplier))--Radar.tdc_range_h:set(Radar.tdc_range_h:get()- value*200000)
	if command == 2032  then --iCommandPlaneSelecterVertical
			Radar.tdc_range_h:set(Radar.tdc_range_h:get()- value*200000.0)
	end
	
	if command == 2031  then --iCommandPlaneSelecterHorizontal
			Radar.tdc_azi_h:set(Radar.tdc_azi_h:get()+ value*10)
			--print_message_to_user("RadarRangeLeftRight")
	end
	
	-- limit the range gate
	if Radar.tdc_range_h:get() > MAX_RANGE_GATE then
		Radar.tdc_range_h:set(MAX_RANGE_GATE)
	elseif Radar.tdc_range_h:get() < 300 then
		Radar.tdc_range_h:set(300)
	end

-------------------------------------------------	
	
	--[[ NUR EIN TEST
	
	if command == 285 then
		Radar.mode_h:set(Radar.mode_h:get()+ 1)
		print_message_to_user("RadarModeChanged")
	end
	]]
	
	
end


function update()
	
	Sensor_Data_Raw = get_base_data()

	
	Radar.tdc_ele_up_h:set(((Sensor_Data_Raw.getBarometricAltitude() + math.tan(Radar.sz_elevation_h:get() + (perfomance.scan_volume_elevation/2)  ) * Radar.tdc_range_h:get())))
	Radar.tdc_ele_down_h:set(((Sensor_Data_Raw.getBarometricAltitude() + math.tan(Radar.sz_elevation_h:get() - (perfomance.scan_volume_elevation/2)  ) * Radar.tdc_range_h:get())))
	
	--mode = Radar.mode_h:get()
    
    --if mode == 3 then -- TRACKING
      --  Radar.ws_ir_slave_azimuth_h:set(Radar.stt_azimuth_h:get())
      --  Radar.ws_ir_slave_elevation_h:set(Radar.stt_elevation_h:get())
    --else
      --  Radar.ws_ir_slave_azimuth_h:set(0)
      --  Radar.ws_ir_slave_elevation_h:set(0)
    --end
	
--------------------------------------------------------------------------------------------------
 --Das ist auch super, weil man sich so den Draw-Wert von jedem Cockpit Draw-Argument anschauen kann--
 --print_message_to_user("Value for MasterArmKnob: " ..tostring(get_cockpit_draw_argument_value(125)))
----------------------------------------------------------------------------------------------------
	
	
end



dofile(LockOn_Options.script_path.."avRadar/Indicator/definitions.lua")
dofile(LockOn_Options.common_script_path .."elements_defs.lua")
dofile(LockOn_Options.script_path.."definitions.lua")

--local MARK_MATERIAL   = MakeMaterial(nil,{255,120,0,255})
-- RadarScale verändere ich mal von 1.1 auf geringer, damit das Radar auch mal ins Radar passt...
RS = RADAR_SCALE * 0.40

ud_scale 	= 0.00001 * 0.9		* RS	--0.00001
lr_scale 	= 0.095	  * 0.9	* 2	* RS	--0.2		--0.085
life_time 	= 5 --war 10 ->sehr lange			--1
life_time_low = 0


-------------------------------------------------------------

--!!!!Ein Radar-Grid hat das NASARR-F15A gar nicht, daher auskommentiert!!!---

--[[
local x_size = 0.004
local y_size = 0.9 *RS



for i = -2,2 do
	local   radar_grid_v 				= CreateElement "ceMeshPoly"
			radar_grid_v.name 			= "radar_grid_v"
			radar_grid_v.primitivetype 	= "triangles"
			radar_grid_v.vertices 		= {	{-x_size, -y_size},
											{-x_size,  y_size},	
											{ x_size,  y_size},	
											{ x_size, -y_size}
										  }
			radar_grid_v.indices  		= default_box_indices
			radar_grid_v.init_pos 		= {i*0.45*RS,0,0}
			radar_grid_v.material 		= MFCD_GREEN_SOFT
			radar_grid_v.h_clip_relation= h_clip_relations.COMPARE
			radar_grid_v.level			= RADAR_DEFAULT_LEVEL
			radar_grid_v.isdraw		 	= true
		Add(radar_grid_v)

end

	x_size = 0.9*RS
	y_size = 0.004
for i = -2,2 do
	local   radar_grid_v 				= CreateElement "ceMeshPoly"
			radar_grid_v.name 			= "radar_grid_v"
			radar_grid_v.primitivetype 	= "triangles"
			radar_grid_v.vertices 		= {	{-x_size, -y_size},
											{-x_size,  y_size},
											{ x_size,  y_size},	
											{ x_size, -y_size}
										  }
			radar_grid_v.indices  		= default_box_indices
			radar_grid_v.init_pos 		= {0,i*0.45*RS,0}
			radar_grid_v.material 		= MFCD_GREEN_SOFT
			radar_grid_v.h_clip_relation= h_clip_relations.COMPARE
			radar_grid_v.level			= RADAR_DEFAULT_LEVEL
			radar_grid_v.isdraw		 	= true
		Add(radar_grid_v)

end
]]




function AddRadarRangeScale(radar_range_scale_name, radar_scale_value)
--global values and variables for all indicators--

--Sets Radar Scale Value 10 - 20 - 40 (or whatever I like to set)
local radar_scale_multi = 0
local contact_scale_multi = 0
local actual_radar_scale = radar_scale_value

	if(actual_radar_scale == 80) then
		radar_scale_multi = 1.0
		contact_scale_multi = 0.33
	elseif(actual_radar_scale == 40)then
		--radar_scale_multi = 2.0
		radar_scale_multi = 1.0
		contact_scale_multi = 0.50
	elseif(actual_radar_scale == 20)then
		--radar_scale_multi = 1.0
		radar_scale_multi = 1.0
		contact_scale_multi = 1.0
	elseif(actual_radar_scale == 10)then
		--radar_scale_multi = 0.5
		radar_scale_multi = 1.0
		contact_scale_multi = 1.95
	end
--------------------------------------------------

local RSC = RS * radar_scale_multi -- RadarScaleCursor??
local udc_scale = ud_scale * contact_scale_multi --ContactScale

local x_size = 0.01 *3 --0.01 *2
local y_size = 0.01 *3 --0.01 *2

--	for ia = 1,999 do
	for ia = 1,900 do

		if ia  < 10 then
			i = "_0".. ia .."_"
		else
			i = "_".. ia .."_"
		end
		
		local	radar_contact			   		= CreateElement "ceMeshPoly"
				radar_contact.name		   		= "radar_contact" .. i .. "name"
				radar_contact.primitivetype		= "triangles"	--"lines"--
				radar_contact.vertices	   		= {		
													{-x_size , -y_size},
													{-x_size , y_size},
													{ x_size , y_size},
													{ x_size ,-y_size},	
											      }
				radar_contact.indices	   		= { 0,1,2,	0,2,3}--{0, 1, 2, 0, 2, 3} 
				radar_contact.init_pos	   		= {0, -2.0*RSC, 0}--{0, -1.80*RS, 0}--{0, 0.10*RS, 0}-- ALT {0, -0.90*RS, 0} das ist in der Mitte ganz unten auf dem Radar
				radar_contact.material    	 	= MFCD_ORANGE
				radar_contact.isdraw			= true
				radar_contact.isvisible			= true
				radar_contact.h_clip_relation 	= h_clip_relations.COMPARE
				radar_contact.level 			= RADAR_DEFAULT_LEVEL
				radar_contact.collimated		= true
				radar_contact.parent_element 	= radar_range_scale_name
				radar_contact.controllers     	= {
													--{"move_up_down_using_parameter"		,0,1.0},
													{"move_left_right_using_parameter"	,1,lr_scale},
													{"move_up_down_using_parameter"		,2,udc_scale},
													{"parameter_in_range",2,30,112000},
													{"parameter_in_range",3,life_time_low,life_time},
													{"change_color_when_parameter_equal_to_number", 4, 1, 1.0,1.0,0.0},
													} 
				radar_contact.element_params  	= {	
													"RADAR_CONTACT"..i.."ELEVATION",
													"RADAR_CONTACT"..i.."AZIMUTH",
													"RADAR_CONTACT"..i.."RANGE",
													"RADAR_CONTACT"..i.."TIME",
													"RADAR_CONTACT"..i.."FRIENDLY",
													"RADAR_CONTACT"..i.."RCS",
												  }
			Add(radar_contact)

	end


--------------------------------------------------------------------------


local x_size = 0.01--ALT 0.005--0.006
local y_size = 0.07--ALT 0.03--0.05


local	radar_cursor			   		= CreateElement "ceMeshPoly"
		radar_cursor.name		   		= "radar_cursor" 
		radar_cursor.primitivetype		= "triangles"
		radar_cursor.vertices	   		= {	
											{-x_size-0.04 , -y_size},
											{-x_size-0.04 , y_size},
											{ x_size-0.04 , y_size},
											{ x_size-0.04 ,-y_size},	
											
											{-x_size+0.04 , -y_size},
											{-x_size+0.04 , y_size},
											{ x_size+0.04 , y_size},
											{ x_size+0.04 ,-y_size},	
											}
		radar_cursor.indices	   		= { 0,1,2,	0,2,3	,4,5,6,4,6,7}--{0, 1, 2, 0, 2, 3} 
		radar_cursor.init_pos	   		= {0, -2.0*RSC, 0} --ALT {0, -0.90*RS, 0}
		radar_cursor.material    	 	= MFCD_ORANGE
		radar_cursor.isdraw				= true
		radar_cursor.isvisible			= true
		radar_cursor.h_clip_relation 	= h_clip_relations.COMPARE
		radar_cursor.level 				= RADAR_DEFAULT_LEVEL 
		radar_cursor.collimated			= true
		radar_cursor.parent_element		= radar_range_scale_name
		radar_cursor.controllers     	= {
											{"move_up_down_using_parameter"		,0, udc_scale},
											{"move_left_right_using_parameter"	,1, lr_scale},
											{"parameter_in_range",2,-0.1,2.1},	
										  } 
		radar_cursor.element_params  	= {	
											"RADAR_TDC_RANGE",
											"RADAR_TDC_AZIMUTH",
											"RADAR_MODE",
										  }
	Add(radar_cursor)
	
	
 x_size = 0.03
 y_size = 0.03


local	radar_STT			   		= CreateElement "ceMeshPoly"
		radar_STT.name		   		= "radar_STT" 
		radar_STT.primitivetype		= "triangles"	--"lines"--
		radar_STT.vertices	   		= {	
										{-x_size , -y_size},
										{-x_size , y_size},
										{ x_size , y_size},
										{ x_size ,-y_size},	
									  }
		radar_STT.indices	   		= { 0,1,2,	0,2,3}--{0, 1, 2, 0, 2, 3} 
		radar_STT.init_pos	   		= {0, -0.10*RSC, 0} -- ALT {0, -0.90*RS, 0}
		radar_STT.material    	 	= MFCD_ORANGE--MakeMaterial(nil,{10,10,255,150})
		radar_STT.isdraw			= true
		radar_STT.isvisible			= true
		radar_STT.h_clip_relation 	= h_clip_relations.COMPARE
		radar_STT.level 			= RADAR_DEFAULT_LEVEL 
		radar_STT.collimated		= true
		radar_STT.parent_element	= radar_range_scale_name
		radar_STT.controllers     	= {
										{"move_up_down_using_parameter"		,0,ud_scale},
										{"move_left_right_using_parameter"	,1,lr_scale},
										--{"move_up_down_using_parameter"		,3,1.0},
										{"parameter_in_range",3,2.9,3.1},	
									  } 
		radar_STT.element_params  	= {	
										"RADAR_STT_RANGE",
										"RADAR_STT_AZIMUTH",
										"RADAR_STT_ELEVATION",
										"RADAR_MODE",
									  }
	Add(radar_STT)
	
 x_size = 0.004
 y_size = 0.09	
local	radar_STT_backview			   		= CreateElement "ceMeshPoly"
		radar_STT_backview.name		   		= "radar_STT_backview" 
		radar_STT_backview.primitivetype	= "triangles"	--"lines"--
		radar_STT_backview.vertices	   		= {	
											{-x_size , -y_size},
											{-x_size , y_size},
											{ x_size , y_size},
											{ x_size ,-y_size},	
											
											{-y_size , -x_size},
											{-y_size , x_size},
											{ y_size , x_size},
											{ y_size ,-x_size},	
											
											}
		radar_STT_backview.indices	   		= { 0,1,2,	0,2,3,4,5,6,4,6,7}--{0, 1, 2, 0, 2, 3} 
		radar_STT_backview.init_pos	   		= {0, 0.0, 0}
		radar_STT_backview.material    	 	= MFCD_ORANGE--MakeMaterial(nil,{10,10,255,150})
		radar_STT_backview.isdraw			= true
		radar_STT_backview.isvisible		= true
	
		radar_STT_backview.h_clip_relation 	= h_clip_relations.COMPARE
		radar_STT_backview.level 			= RADAR_DEFAULT_LEVEL 
		radar_STT_backview.collimated		= true
		radar_STT_backview.parent_element	= radar_range_scale_name
		radar_STT_backview.controllers     	= {
												{"move_up_down_using_parameter"		,2,lr_scale},
												{"move_left_right_using_parameter"	,1,lr_scale},
												{"parameter_in_range",3,2.9,3.1},	
											  } 
		radar_STT_backview.element_params  	= {	
												"RADAR_STT_RANGE",
												"RADAR_STT_AZIMUTH",
												"RADAR_STT_ELEVATION",
												"RADAR_MODE",
											  }
	Add(radar_STT_backview)
	
	x_size = 0.004
	y_size = 0.08	
local	radar_STT_iff			   		= CreateElement "ceMeshPoly"
		radar_STT_iff.name		   		= "radar_STT_iff" 
		radar_STT_iff.primitivetype		= "triangles"	--"lines"--
		radar_STT_iff.vertices	   		= {	
										{-x_size ,-y_size},
										{-x_size , y_size},
										{ x_size , y_size},
										{ x_size ,-y_size},	
									  }
		radar_STT_iff.indices	   		= { 0,1,2,	0,2,3}--{0, 1, 2, 0, 2, 3} 
		radar_STT_iff.init_pos	   		= {0, 0, 0}
		radar_STT_iff.material    	 	= MFCD_ORANGE--MakeMaterial(nil,{10,10,255,150})
		radar_STT_iff.isdraw			= true
		radar_STT_iff.isvisible			= true
		radar_STT_iff.h_clip_relation 	= h_clip_relations.COMPARE
		radar_STT_iff.level 			= RADAR_DEFAULT_LEVEL 
		radar_STT_iff.collimated		= true
		radar_STT_iff.parent_element	= "radar_STT"
		radar_STT_iff.controllers     	= {
											{"parameter_in_range",0,0.9,1.1},
											{"change_color_when_parameter_equal_to_number", 0, 1, 1.0,1.0,0.0},
											} 
		radar_STT_iff.element_params  	= {"RADAR_STT_FRIENDLY",}
	Add(radar_STT_iff)	



	
	local 	radar_cursor_range	 				= CreateElement "ceStringPoly"
			radar_cursor_range.name			  	= "radar_cursor_range"
			radar_cursor_range.material        	= HUD_FONT
			radar_cursor_range.init_pos		  	= {-0.1,0.0,0} 
			radar_cursor_range.stringdefs      	= txt_m_stringdefs
			radar_cursor_range.alignment       	= "RightCenter"--"LeftTop"
			radar_cursor_range.value			= "test"
			radar_cursor_range.formats		  	= {"%.0f"}
			radar_cursor_range.UseBackground	= false
			radar_cursor_range.element_params  	= {"RADAR_TDC_RANGE"}
			radar_cursor_range.controllers     	= {{"text_using_parameter",0,0}}
			radar_cursor_range.parent_element 	= radar_range_scale_name
			radar_cursor_range.use_mipfilter 	= true
			radar_cursor_range.h_clip_relation 	= h_clip_relations.COMPARE
			radar_cursor_range.level 			= RADAR_DEFAULT_LEVEL
		Add(radar_cursor_range)		
	
	
	local 	radar_cursor_upper_alt 					= Copy(radar_cursor_range)
			radar_cursor_upper_alt.name				= "radar_cursor_upper_alt"
			radar_cursor_upper_alt.init_pos			= {0.3,0.15,0}--{0.25,0.05,0}--{0.15,0.05,0} 		
			radar_cursor_upper_alt.alignment    	= "RightCenter"--"LeftTop"	
			radar_cursor_upper_alt.element_params  	= {"RADAR_TDC_ELEVATION_AT_RANGE_UPPER"}
			radar_cursor_upper_alt.controllers     	= {{"text_using_parameter",0,0}}	
		Add(radar_cursor_upper_alt)		

	local 	radar_cursor_lower_alt 					= Copy(radar_cursor_range)
			radar_cursor_lower_alt.name				= "radar_cursor_lower_alt"
			radar_cursor_lower_alt.init_pos			= {0.3,-0.15,0} 		--{0.15,-0.05,0} 
			radar_cursor_lower_alt.element_params  	= {"RADAR_TDC_ELEVATION_AT_RANGE_LOWER"}
			radar_cursor_lower_alt.controllers     	= {{"text_using_parameter",0,0}}	
		Add(radar_cursor_lower_alt)		
	
	
	
	
	local 	radar_bearing_L15	 				= CreateElement "ceStringPoly"
			radar_bearing_L15.name			  	= "radar_bearing_L15"
			radar_bearing_L15.material        	= HUD_FONT
			radar_bearing_L15.init_pos		  	= {-1.1*RS,2.9*RS,0}--{-0.40*RS,0.9*RS,0} --ALT {-0.45*RS,0.9*RS,0} 
			radar_bearing_L15.stringdefs      	= txt_m_stringdefs
			radar_bearing_L15.alignment       	= "CenterBottom"--"LeftTop"
			radar_bearing_L15.value				= "15"
			radar_bearing_L15.formats		  	= {"%.0f"}
			radar_bearing_L15.UseBackground		= false
			radar_bearing_L15.use_mipfilter 	= true
			radar_bearing_L15.parent_element	= radar_range_scale_name
			radar_bearing_L15.h_clip_relation 	= h_clip_relations.COMPARE
			radar_bearing_L15.level 			= RADAR_DEFAULT_LEVEL
		Add(radar_bearing_L15)		
	
	local 	radar_bearing_R15				= Copy(radar_bearing_L15)
			radar_bearing_R15.name			= "radar_bearing_R15"
			radar_bearing_R15.init_pos		= {1.1*RS,2.9*RS,0}--{0.40*RS,0.9*RS,0} --ALT {0.45*RS,0.9*RS,0}
		Add(radar_bearing_R15)	
		
	local 	radar_bearing_L30				= Copy(radar_bearing_L15)
			radar_bearing_L30.name			= "radar_bearing_L30"
			radar_bearing_L30.value			= "30"
			radar_bearing_L30.init_pos		= {-2.9*RS,1.15*RS,0}--{-0.80*RS,0.0*RS,0} -- ALT {-0.90*RS,0.9*RS,0}
		Add(radar_bearing_L30)		
	
	local 	radar_bearing_R30				= Copy(radar_bearing_L15)
			radar_bearing_R30.name			= "radar_bearing_R30"
			radar_bearing_R30.value			= "30"
			radar_bearing_R30.init_pos		= {2.9*RS,1.15*RS,0}--{0.80*RS,0.0*RS,0} --ALT {0.90*RS,0.9*RS,0}
		Add(radar_bearing_R30)
	
	
	
	x_size = 0.02 --0.01
	y_size = 0.25  --0.15	
local	radar_SZ_AZIMUTH			   		= CreateElement "ceMeshPoly"
		radar_SZ_AZIMUTH.name		   		= "radar_SZ_AZIMUTH" 
		radar_SZ_AZIMUTH.primitivetype		= "triangles"	--"lines"--
		radar_SZ_AZIMUTH.vertices	   		= {	
										{-x_size ,0},
										{-x_size , y_size},
										{ x_size , y_size},
										{ x_size ,0},	
									  }
		radar_SZ_AZIMUTH.indices	   		= { 0,1,2,	0,2,3}--{0, 1, 2, 0, 2, 3} 
		radar_SZ_AZIMUTH.init_pos	   		= {0, -2.6*RS, 0} -- ALT {0, -0.85*RS, 0}
		radar_SZ_AZIMUTH.material    	 	= MFCD_ORANGE--MakeMaterial(nil,{10,10,255,150})
		radar_SZ_AZIMUTH.isdraw				= true
		radar_SZ_AZIMUTH.isvisible			= true
		radar_SZ_AZIMUTH.h_clip_relation 	= h_clip_relations.COMPARE
		radar_SZ_AZIMUTH.level 				= RADAR_DEFAULT_LEVEL 
		radar_SZ_AZIMUTH.collimated			= true
		radar_SZ_AZIMUTH.parent_element		= radar_range_scale_name
		--radar_SZ_AZIMUTH.parent_element	= "radar_STT"
		radar_SZ_AZIMUTH.controllers     	= {
												{"rotate_using_parameter",0,1}
											--{"parameter_in_range",0,0.9,1.1},
											--{"change_color_when_parameter_equal_to_number", 0, 1, 1.0,1.0,0.0},
											} 
		radar_SZ_AZIMUTH.element_params  	= {"SCAN_ZONE_ORIGIN_AZIMUTH",}
	Add(radar_SZ_AZIMUTH)	

end

--local radar_scale_value_param = get_param_handle("RADAR_RANGE_SCALE")
--local radar_range_value = radar_scale_value_param:get()

local Range_10 					= CreateElement "ceSimple"
Range_10.name  					= "Range_10_Set"
Range_10.init_pos				= {0.0, -0.0, 0.0}									--{0, -1.345,0}
Range_10.element_params   		= {"RADAR_RANGE_SCALE"}        --muss noch in Radar_init.lua erstellt werden     
Range_10.controllers       		= {{"parameter_in_range" ,0,9,11} }
Add(Range_10)

AddRadarRangeScale("Range_10_Set", 10)

local Range_20 					= CreateElement "ceSimple"
Range_20.name  					= "Range_20_Set"
Range_20.init_pos				= {0.0, -0.0, 0.0}									--{0, -1.345,0}
Range_20.element_params   		= {"RADAR_RANGE_SCALE"}        --muss noch in Radar_init.lua erstellt werden     
Range_20.controllers       		= {{"parameter_in_range" ,0,19,21} }
Add(Range_20)

AddRadarRangeScale("Range_20_Set", 20)

local Range_40 					= CreateElement "ceSimple"
Range_40.name  					= "Range_40_Set"
Range_40.init_pos				= {0.0, -0.0, 0.0}									--{0, -1.345,0}
Range_40.element_params   		= {"RADAR_RANGE_SCALE"}        --muss noch in Radar_init.lua erstellt werden     
Range_40.controllers       		= {{"parameter_in_range" ,0,39,41} }
Add(Range_40)

AddRadarRangeScale("Range_40_Set", 40)

local Range_80 					= CreateElement "ceSimple"
Range_80.name  					= "Range_60_Set"
Range_80.init_pos				= {0.0, -0.0, 0.0}									--{0, -1.345,0}
Range_80.element_params   		= {"RADAR_RANGE_SCALE"}        --muss noch in Radar_init.lua erstellt werden     
Range_80.controllers       		= {{"parameter_in_range" ,0,79,81} }
Add(Range_80)

AddRadarRangeScale("Range_60_Set", 80)


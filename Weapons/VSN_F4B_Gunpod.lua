-- GAU-22 Ammunition
local ammo_weight = 0.493

declare_weapon(
	{
		category				= CAT_SHELLS,
		name					= "VSNF4B_SAPHEI_T",
		user_name				= _("VSN-F4B/U SAPHEI-T"),
		model_name				= "tracer_bullet_red",
		v0						= 1100.0,
		Dv0						= 0.00508,
		Da0						= 0.0005,
		Da1						= 0.0,
		mass					= 0.185,
		round_mass				= 0.493,
		explosive				= 0.085,
		life_time				= 7.0,
		caliber					= 25.0,
		piercing_mass			= 0.130,
		s						= 0.0,
		j						= 0.0,
		l						= 0.0,
		charTime				= 0,
		cx						= {1.0,0.78,0.80,0.15,2.20},
		k1						= 7.7e-10,
		tracer_off				= 6,
		tracer_on				= 0.02,
		scale_tracer			= 2,
		--scale_smoke				= 0.50,
		--smoke_opacity			= 0.10,
		--smoke_tail_life_time	= 1.0,
		cartridge				= 0,
	}
)

-- GAU12 Gunpod
function GAK_14_GunPak(tbl)

	tbl.category	= CAT_GUN_MOUNT 
	tbl.name		= "VSN_F4B_GUN"
	tbl.supply		= 
	{
		shells	= {
					"VSNF4B_SAPHEI_T",
					"M242_25_AP_M791", 
					"M242_25_HE_M792"
				 },
		mixes	= {
					{1},
					{2},
					{3},
				}, 
		count	= 220,
	}
	if tbl.mixes then 
	   tbl.supply.mixes =  tbl.mixes
	   tbl.mixes	    = nil
	end
	tbl.gun = 
	{
		max_burst_length = 220,
		rates 			 = {1800},
		recoil_coeff 	 = 1,
		barrels_count 	 = 1,
	}
	if tbl.rates then 
	   tbl.gun.rates    =  tbl.rates
	   tbl.rates	    = nil
	end	
	tbl.ejector_pos 			= tbl.ejector_pos or {0.0, 0.0, 0.0}
	tbl.ejector_dir 			= {0,0,0}
	tbl.supply_position  		= tbl.supply_position or {0,  0.3, -0.3}
	tbl.aft_gun_mount 			= false
	tbl.effective_fire_distance = 3700
	tbl.drop_cartridge 			= 0
	tbl.muzzle_pos				= tbl.muzzle_pos or  {0,0,0} -- all position from connector
	tbl.muzzle_pos_connector	= tbl.muzzle_pos_connector or  "Gun_point" -- all position from connector
	tbl.azimuth_initial 		= tbl.azimuth_initial    or 0   
	tbl.elevation_initial 		= tbl.elevation_initial  or 0   
	if  tbl.effects == nil then
		tbl.effects = {
			{ name = "FireEffect"     , arg = tbl.effect_arg_number or 436 },
			{ name = "HeatEffectExt"  , shot_heat = 7.823, barrel_k = 0.462 * 2.7, body_k = 0.462 * 14.3 },
			{ name = "SmokeEffect"}
		}
	end
	return declare_weapon(tbl)
end



------------------------------------------------------------------------------------------------------------------------

declare_loadout(
	{
		category			=  CAT_PODS,
		CLSID				= "{VSN_F4B_Equalizer}",
		displayName			= _("F4B Gunpod w/SAPHEI-T"),
		Picture				=	"F4Bgunpod.png",
		attribute			= {wsType_Weapon, wsType_GContainer, wsType_Cannon_Cont, WSTYPE_PLACEHOLDER},
		wsTypeOfWeapon		= {wsType_Weapon, wsType_Shell, wsType_Shell_A, wsTypeVulkan},
		Weight				= 136 + (220 * ammo_weight), -- INCLUDE AMMO FOR FULL WEIGHT
        Weight_Empty        = 136,
		Cx_pil				= 0.001220703125,
		kind_of_shipping	= 2,--SOLID_MUNITION
		gun_mounts			= {
			GAK_14_GunPak(
				{
					mixes					= {{1, 1, 1}},
					muzzle_pos				= {0.0, 0.0, 0.0},
					muzzle_pos_connector	= "Gun_point",
					azimuth_initial			= 0.0, -- -0.04363323, -- 2.5 degs to the left
					effect_arg_number		= 433,
				}
			)
		},
		shape_table_data =
		{
			{
				name		= "VSN_F4B_Equalizer";
				file		= "VSN_F4BGunpod";
				life		= 1;
				fire		= {0, 1};
				username	= "VSN_F4B_Equalizer";
				index		= WSTYPE_PLACEHOLDER;
			},
		},
		Elements = {
			[1]	= {
				Position	=	{0, 0, 0},
				ShapeName	=	"VSN_F4BGunpod",
			}, 
		}, -- end of Elements
	
	--m3_browing({muzzle_pos = {2.91,   0.42,  -0.5 }  	, rates = {1249},mixes = {{2,1,1,1,1,1}},effect_arg_number = 434,azimuth_initial = 0,elevation_initial = 0,supply_position = {2, -0.3, -0.4}}), --up
	}
)
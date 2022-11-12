--dofile("Scripts/Database/Weapons/warheads.lua")
--local GALLON_TO_KG = 3.785 * 0.8

local pylon_mass 	= 0.0
local PTB600C_name 	= 'Fuel tank Center 600 Gal' --center
local PTB370L_name 	= 'Fuel tank Wing L 370 Gal' --Wing L
local PTB370R_name 	= 'Fuel tank Wing R 370 Gal' --Wing R
--1 × Zusatztank extern Wing hat 600 gallons = 2271 Liter x 0.85 = 1.930 kg = 4254 lbs
--2 × Zusatztank center hat 370 gallons = 1400 Liter x 0.85 = 1.190 kg = 2623 lbs


declare_loadout(
    {
        category    = CAT_FUEL_TANKS,
        name        = PTB600C_name,
        displayName = _(PTB600C_name),
        Picture     = "PTB.png",
        attribute   = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
        CLSID       = "VSN_F4EC_PTB",
        
        Weight_Empty 	= 50 + pylon_mass,
        Weight 			= 50 + 1930 + pylon_mass,
        Cx_pil 			= 0.00042, --von 0.00148 zu 0.00115//Sidewinder mit Adapter ist 0.00014. Gegentesten und ggf. anpassen...angepasst auf 0.000151 zu 0.0032
        shape_table_data =
        {
            {
                name = PTB600C_name,
                file = "VSN_F4_C_PTB",
                life = 1,
                fire = { 0, 1},
                username = PTB600C_name,
                index = WSTYPE_PLACEHOLDER,
            },
        },
        Elements =
        {
            {
                Position = {0, 0, 0},
                ShapeName = "VSN_F4_C_PTB",
            },
        },
    }
)

declare_loadout(
    {
        category    = CAT_FUEL_TANKS,
        name        = PTB370L_name,
        displayName = _(PTB370L_name),
        Picture     = "PTB.png",
        attribute   = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
        CLSID       = "VSN_F4EL_PTB",
        
        Weight_Empty 	= 50 + pylon_mass,
        Weight 			= 50 + 1190 + pylon_mass,
        Cx_pil 			= 0.00042, --von 0.00148 zu 0.00115// angepasst wie oben da gleiche Kapazität zu 0.0032
        shape_table_data =
        {
            {
                name = PTB370L_name,
                file = "VSN_F4_L_PTB",
                life = 1,
                fire = { 0, 1},
                username = PTB370L_name,
                index = WSTYPE_PLACEHOLDER,
            },
        },
        Elements =
        {
            {
                Position = {0, 0, 0},
                ShapeName = "VSN_F4_L_PTB",
            },
        },
    }
)

declare_loadout(
    {
        category    = CAT_FUEL_TANKS,
        name        = PTB370R_name,
        displayName = _(PTB370R_name),
        Picture     = "PTB.png",
        attribute   = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
        CLSID       = "VSN_F4ER_PTB",
        
        Weight_Empty 	= 50 + pylon_mass,
        Weight 			= 50 + 1190 + pylon_mass,
        Cx_pil 			= 0.00042, --von 0.00148 zu 0.00115// angepasst wie oben da gleiche Kapazität zu 0.0032
        shape_table_data =
        {
            {
                name = PTB370R_name,
                file = "VSN_F4_R_PTB",
                life = 1,
                fire = { 0, 1},
                username = PTB370R_name,
                index = WSTYPE_PLACEHOLDER,
            },
        },
        Elements =
        {
            {
                Position = {0, 0, 0},
                ShapeName = "VSN_F4_R_PTB",
            },
        },
    }
)

F4Bgunpod = {
    category        = CAT_PODS,
    CLSID           = "{VSN_F4B_Gunpod}",
    attribute       = {wsType_Weapon,wsType_GContainer,wsType_Cannon_Cont,WSTYPE_PLACEHOLDER},
    Picture         = "F4Bgunpod.png",
    displayName     = _("F4B SUU-23 Gun Pod"),
    Weight          = 112.35,      -- 1350lb/612.35kg loaded (incl. 201kg of ammunition)
    Cx_pil          = 0.001220703125,
    Elements        = {{ShapeName = "vsn_f4Bgunpod"}},
    shape_table_data = {{file = 'vsn_f4Bgunpod'; username = 'VSN_F4B_Gunpod'; index = WSTYPE_PLACEHOLDER;}}
}
declare_loadout(F4Bgunpod)



declare_loadout(
    {
				category= 	CAT_AIR_TO_AIR,
				name    = 	VSNF4BLAU105AIM9J,
				CLSID   = 	"{VSN_F4B_LAU105_AIM9J}",
				Picture	=	"us_AIM-9L.png",
				Cx_pil	=	0.001708984375,
				displayName	=	_("LAU-105 2*AIM-9J"),
				Count	=	2,
				Weight	=	332,
				wsTypeOfWeapon   =   {4,   4,   7,   AIM_9},--GAR_8 ??
				attribute        =   {4,   4,   32,   WSTYPE_PLACEHOLDER},
				Elements    = {
					{ShapeName = "LAU-105" , IsAdapter = true},--ED Modell
					--rockets itself 
					{ShapeName = "aim-9J",	connector_name = "Point_Pilon L",	Rotation   =   {90,   0,   0},},--ShapeName hat keinen einfluss
					{ShapeName = "aim-9J",	connector_name = "Point_Pilon R",	Rotation   =   {90,   0,   0},},
        },
    }
) ----{ CLSID = "{VSN_F4B_LAU105_AIM9J}"	,arg_value = 0.0}, --LAU-105 2*AIM-9J

declare_loadout(
    {
				category= 	CAT_AIR_TO_AIR,
				name    = 	VSNF4BLAU105AIM9JULI,
				CLSID   = 	"{VSN_F4B_LAU105_AIM9JULI}",
				Picture	=	"us_AIM-9L.png",
				Cx_pil	=	0.001708984375,
				displayName	=	_("LAU-105 2*AIM-9JULI"),
				Count	=	2,
				Weight	=	332,
				wsTypeOfWeapon   =   {4,   4,   7,   AIM_9},--GAR_8 ??
				attribute        =   {4,   4,   32,   WSTYPE_PLACEHOLDER},
				Elements    = {
					{ShapeName = "LAU-105" , IsAdapter = true},--ED Modell
					--rockets itself 
					{ShapeName = "aim-9J",	connector_name = "Point_Pilon L",	Rotation   =   {90,   0,   0},},--ShapeName hat keinen einfluss
					{ShapeName = "aim-9J",	connector_name = "Point_Pilon R",	Rotation   =   {90,   0,   0},},
        },
    }
) ----{ CLSID = "{VSN_F4B_LAU105_AIM9JULI}"	,arg_value = 0.0}, --LAU-105 2*AIM-9JULI

dofile(LockOn_Options.script_path.."clickable_defs.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
--dofile(LockOn_Options.script_path.."sounds.lua")

local gettext = require("i_18n")
_ = gettext.translate

elements = {}

--Weapon Panel
elements["PNT_DB_WEAPON_SELECTOR_ROT_710"]	= multiposition_switch(_("DogBone Weapon Selector Rotational toggle"),	devices.WEAPON_SYSTEM, Keys.wps_toggle, 710, 5, 0.01, false, 0, 16, false)
elements["PNT_DB_STATION_SELECTOR_ROT_711"]	= multiposition_switch(_("DogBone Stations Selector Toggle"),	devices.WEAPON_SYSTEM, Keys.toggleDogbone, 711, 5, 0.01, false, 0, 16, false )
--elements["SWI_PYL_3_2W"]	= default_2_position_tumb(_("Station Button Three"),	devices.AVIONIC_SYSTEM, Keys.station_three, 86)
--elements["SWI_PYL_4_2W"]	= default_2_position_tumb(_("Station Button Four"),	devices.AVIONIC_SYSTEM, Keys.station_four, 90)
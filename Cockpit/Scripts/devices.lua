local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID----------
devices = {}
devices["RADIO"]          			= counter()
devices["RADIO_ARC_522"]          		= counter()
devices["RADIO_TR_3"]          			= counter()
devices["INTERCOM_AIC_18"]			=counter()
devices["DARKEN_HUD_SYSTEM"]			= counter() --Nummer 1
devices["HUD_SYSTEM"]				= counter() --Nummer 2
devices["ELECTRIC_SYSTEM"]      		= counter() --Nummer 3
devices["WEAPON_SYSTEM"]        		= counter() --Nummer 4
devices["ENGINE_COLDSTART"]			= counter() --Nummer 5
--devices["HUD"] 				= counter() -- Nummer 3 wenn es Nummer 2 wieder gibt 
--devices["GEAR"]				= counter() --Nummer 1
devices["CANOPY"]				= counter()
--devices["AVIONIC_SYSTEM"]				= counter()


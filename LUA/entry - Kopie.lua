self_ID = "VSN_F4"
declare_plugin(self_ID,
{
image     	 = "FC3.bmp",
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
displayName  = _("VSN_F4"),
developerName = _("VSN"),

fileMenuName = _("VSN_F4"),
update_id        = "VSN_F4",
version		 = "2.7.10",
state		 = "installed",
info		 = _("F-4 Phantom II Urspruenglich als reiner Luftueberlegenheitsjaeger geplant, wurde sie im Laufe ihrer Dienstzeit auch fuer andere Rollen adaptiert, so als Jagdbomber oder Aufklaerungsflugzeug. Auch die SEAD-Aufgaben (Wild Weasel) wurden von F-4 geflogen. Die Einfuehrung des Flugzeuges in den Luftwaffen von insgesamt elf anderen Staaten, unter anderem Deutschland, fuehrten zu einer Vielzahl unterschiedlicher Varianten und Aufruestungen fuer verschiedene Rollen. Die F-4 kam in vielen Konflikten zum Einsatz, beispielsweise auf US-amerikanischer Seite im Vietnamkrieg und dem Zweiten Golfkrieg oder auf israelischer Seite im Nahostkonflikt. Obwohl das Flugzeug seit mehr als 50 Jahren im Dienst ist und von den groessten Nutzerstaaten (wie der USAF und der RAF, Bundeswehr) 2013 ausser Dienst gestellt wurde, verbleibt sie in einigen Staaten immer noch im aktiven Dienst. ."),

Skins	=
	{
		{
		    name	= _("VSN_F4"),
			dir		= "Theme"
		},
	},
Missions =
	{
		{
			name		    = _("VSN_F4"),
			dir			    = "Missions",
  		},
	},
LogBook =
	{
		{
			name		= _("VSN_F4B"),
			type		= "VSN_F4B",
		},
	},	
		
InputProfiles =
	{
		["VSN_F4"] = current_mod_path .. '/Input/VSN_F4',
		["VSN_F4_AG"] = current_mod_path .. '/Input/VSN_F4_AG',
	},	
	
binaries = {
"F4B",
},

})
----------------------------------------------------------------------------------------
mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/VSN_F4B")
mount_vfs_texture_path  (current_mod_path.."/Textures/DEVRiM_DCS_SU-33_GrayEnglishCockpitMod")
-------------------------------------------------------------------------------------
local cfg_path = current_mod_path ..  "/FM/F4B/config.lua"
dofile(cfg_path)
F4B[1]             = self_ID
F4B[2]             = 'F4B'
F4B.config_path     = cfg_path
F4B.old             = 6 -- SU27-3, SU33-4, F-15-6, SU25-54
dofile(current_mod_path.."/LUA/Views_F15Pit.lua")
make_view_settings('VSN_F4B', ViewSettings, SnapViews)
make_flyable('VSN_F4B',current_mod_path..'/Cockpit/KneeboardRight/',F4B, current_mod_path..'/comm.lua')--EFM
--make_flyable('VSN_F4B',current_mod_path..'/Cockpit/Scripts/',F4B, current_mod_path..'/comm.lua')--EFM
-------------------------------------------------------------------------------------
dofile(current_mod_path..'/VSN_F4B.lua')
dofile(current_mod_path.."/WEAPONS/Weapons.lua")
-------------------------------------------------------------------------------------
plugin_done()

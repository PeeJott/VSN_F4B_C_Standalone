

--[[local parameters = {
	fighter = true,
	radar = true,
	ECM = true,
	refueling = true,
}
]]

local openFormation = true

function specialEvent(params) 
	return staticParamsEvent(Message.wMsgLeaderSpecialCommand, params)
end

local menus = data.menus

data.rootItem = {
	name = _('Main'),
	getSubmenu = function(self)	
		local tbl = {
			name = _('Main'),
			items = {}
		}
		
		if data.pUnit == nil or data.pUnit:isExist() == false then
			return tbl
		end
		
		if self.builders ~= nil then
			for index, builder in pairs(self.builders) do
				builder(self, tbl)
			end
		end
		
		if #data.menuOther.submenu.items > 0 then
			tbl.items[10] = {
				name = _('Other'),
				submenu = data.menuOther.submenu
			}
		end
		
		return tbl
	end,
	builders = {}
}

local parameters = {
	fighter = true,
	radar = true,
	ECM = true,
	refueling = true,
}

local menus = data.menus

utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/LockOnAirplane.lua', getfenv()))(parameters)

--utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/Ground Crew.lua', getfenv()))(8)

menus['Ground Crew'].items[6] = { name = _('Salute!'), command = sendMessage.new(Message.wMsgLeaderGroundGestureSalut, true)}
menus['Ground Crew'].items[7] = { name = _('Request Launch'), command = sendMessage.new(Message.wMsgLeaderGroundRequestLaunch, true)}
--menus['Ground Crew'].items[8] = { name = _('Ground power on'), command = sendMessage.new(Message.wMsgLeaderGroundToggleElecPower, true)}
--menus['Ground Crew'].items[9] = { name = _('Ground power off'), command = sendMessage.new(Message.wMsgLeaderGroundToggleElecPower, false)}

menus['Ground Air Supply'] = {
	name = _('Ground Air Supply'),
	items = {
		[1] = {name = _('Connect'), 		command = sendMessage.new(Message.wMsgLeaderGroundToggleAir, true)},
		[2] = {name = _('Disconnect'), 		command = sendMessage.new(Message.wMsgLeaderGroundToggleAir, false)},
		[3] = {name = _('Apply'), 			command = sendMessage.new(Message.wMsgLeaderGroundApplyAir, true)}
	}
}

menus['Ground Crew'].items[8] = { name = _('Ground Air Supply'), submenu = menus['Ground Air Supply']}

--menus['Ground Power'] = {
	--name = _('Ground Power'),
	--items = {
	--	[1] = {name = _('Ground power on'), command = sendMessage.new(Message.wMsgLeaderGroundToggleElecPower, true)}
	--	[2] = {name = _('Ground power off'), command = sendMessage.new(Message.wMsgLeaderGroundToggleElecPower, false)}
	--}
--}	

--menus['Ground Crew'].items[9] = { name = _('Ground Power'), submenu = menus['Ground Power']}
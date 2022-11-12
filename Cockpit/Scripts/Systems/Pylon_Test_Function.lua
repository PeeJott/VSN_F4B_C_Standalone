

function PylonTest()
	
	if(station_zero == 0)then
	dev:select_station(0)
	station_zero = 1
	dev:launch_station(0)
	return
	end
	
	if(station_one == 0)then
	dev:select_station(1)
	station_one = 1
	dev:launch_station(1)
	return
	end
	
	if(station_two == 0) then
	dev:select_station(2)
	station_two = 1
	dev:launch_station(2)
	return
	end
	
	if(station_three == 0) then
	dev:select_station(3)
	station_three = 1
	dev:launch_station(3)
	return
	end
	
	
	if(station_four == 0) then
	dev:select_station(4)
	station_four = 1
	dev:launch_station(4)
	return
	end
	
	if(station_five == 0) then
	dev:select_station(5)
	station_five = 1
	dev:launch_station(5)
	return
	end
	
	if(station_six == 0) then
	dev:select_station(6)
	station_six = 1
	dev:launch_station(6)
	return
	end

	if(station_seven == 0) then
	dev:select_station(7)
	station_seven = 1
	dev:launch_station(7)
	return
	end
	
	if(station_eight == 0)then
	dev:select_station(8)
	station_eight = 1
	dev:launch_station(8)
	return
	end
	
	if(station_nine == 0)then
	dev:select_station(9)
	station_nine = 1
	dev:launch_station(9)
	return
	end
end
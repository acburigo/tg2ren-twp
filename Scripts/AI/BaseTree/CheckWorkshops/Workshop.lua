function Weight()
	if not dyn_GetRandomWorkshopForSim("SIM", "MyWorkshop") then
		return 0
	end
	
	return 40
end

function Execute()
end
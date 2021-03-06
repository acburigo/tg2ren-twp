function Weight()

	local Hour = math.mod(GetGametime(), 24)
	if Hour > 8 and Hour < 21 then
		return 0
	end
	
	if not SimGetWorkingPlace("SIM", "WorkBuilding") then
		return 0
	end
	
	if not AliasExists("RivalBuild") then
		if not DynastyGetRandomBuilding("VictimDynasty", -1, -1, "RivalBuild") then
			return 0
		end
	end
	
	if BuildingGetClass("RivalBuild") == GL_BUILDING_CLASS_RESOURCE then
		return 0
	end

	local MeasureNames = { "CombustionBomb", "Bomb" };
	for i=1, 2 do
		if not BuildingHasUpgrade("WorkBuilding", MeasureNames[i]) then
			MeasureNames[i] = false
		elseif GetMeasureRepeat("SIM", "OrderASabotage_"..MeasureNames[i]) > 0 then
			MeasureNames[i] = false
		end
	end
	
	if Weather_GetValue(0) > 0.5 then
		MeasureNames[1] = nil
	end
	
	if not MeasureNames[1] and not MeasureNames[2] then
		return 0
	end
	
	if MeasureNames[2] then

		local Count = Find("RivalBuild","__F((Object.GetObjectsByRadius(Building) == 2000)","Build", -1)
		local	Own = 0
		local	NotOwn = 0
		local	State
	
		for i=0,Count-1 do
			State = DynastyGetDiplomacyState("SIM", "Build"..i)
			if State>=DIP_ALLIANCE then
				Own = Own + 1
			else
				NotOwn = NotOwn + 1
			end
		end
		
		if Own*3 > NotOwn then
			MeasureNames[2] = nil
		end
	end
	
	if MeasureNames[2] then
		SetData("mysa_Measure",  MeasureNames[2])
		return 100
	end
	
	if not MeasureNames[1] then
		return 0
	end
	
	SetData("mysa_Measure",  MeasureNames[1])
	return 100

end

function Execute()
	MeasureRun("SIM", "RivalBuild", "OrderASabotage_"..GetData("mysa_Measure"), true)
end

function Weight()
	
	local Difficulty = ScenarioGetDifficulty()
	local	Item = "BoozyBreathBeer"
	local Money = GetMoney("SIM")*0.10 
	
	if ItemGetBasePrice(Item) > Money then
		return 0
	end
	
	if Difficulty <3 then
		return 0
	end
	
	if DynastyIsShadow("SIM") then
		if SimGetOfficeLevel("SIM")<1 then
			return 0
		end
	end
	
	if GetMeasureRepeat("SIM", "Use"..Item)>0 then
		return 0
	end
	
	if GetItemCount("", Item,INVENTORY_STD)>0 then
		return 100
	end

	local Price = ai_CanBuyItem("SIM", Item)
	
	if Price<0 then
		return 0
	end

	return 10
end

function Execute()
	MeasureRun("SIM", nil, "UseBoozyBreathBeer")
end

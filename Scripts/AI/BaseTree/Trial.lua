function Weight()
	aitwp_Log("Weight::Trial", "dynasty")
	-- select SIM with upcoming trial
	local Count = DynastyGetMemberCount("dynasty")
	for i=0, Count-1 do
		if DynastyGetMember("dynasty", i, "Member") then
			if GetImpactValue("Member", "TrialTimer") >= 1 and ImpactGetMaxTimeleft("Member", "TrialTimer") <= 10 then
				CopyAlias("Member", "TrialSIM")
				return 50
			end
		end
	end
	
	-- no trial upcoming
	return 0
end

function Execute()
	aitwp_Log("Going into TRIAL measures", "dynasty")
	CopyAlias("TrialSIM", "SIM")
	RemoveAlias("TrialSIM")
end
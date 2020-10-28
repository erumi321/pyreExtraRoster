ModUtil.RegisterMod( "CustomRoster" )
--[[
Google Sheet for different character Values
https://docs.google.com/spreadsheets/d/1XxANHz_vtz8QHXYa0GqOX6xrL1XXGSsWsXiZWzZkVyw/edit?usp=sharing
]]--
local config = {
	BaseCount = 21,
	TeamA = {
		{
			Base = 4,
			Bench = 2,
			NilTable = {},
			SetTable = {},
		},
		{
			Base = 2,
			Bench = 11,
			NilTable = {},
			SetTable = {},
		},
		{
			Base = 4,
			Bench = 3,
			NilTable = {},
			SetTable = {},
		},
		{
			Base = 3,
			Bench = 8,
			NilTable = {},
			SetTable = {},
		},
		{
			Base = 8,
			Bench = 10,
			NilTable = {},
			SetTable = {},
		},
		{
			Base = 9,
			Bench = 10,
			NilTable = {},
			SetTable = {},
		},
	},
}
CustomRoster.config = config
config.TeamB = config.TeamA

function CustomRoster.CopyCharacterTeamData( character, copyteam )
	character.MaskHue = copyteam.MaskHue 
	character.MaskSaturationAddition = copyteam.MaskSaturationAddition
	character.MaskValueAddition = copyteam.MaskValueAddition
	character.MaskHue2 = copyteam.MaskHue2
	character.MaskSaturationAddition2 = copyteam.MaskSaturationAddition2
	character.MaskValueAddition2 = copyteam.MaskValueAddition2
	character.UsePhantomShader = copyteam.UsePhantomShader
end

function CustomRoster.AddCharacter( addteam, data, index )
	local copyteam = League[data.Bench]
	local character = DeepCopyTable(copyteam.TeamBench[data.Base])
	
	CustomRoster.CopyCharacterTeamData( character, copyteam )
	
	ModUtil.MapNilTable(character,data.NilTable)
	ModUtil.MapSetTable(character,data.SetTable)
			
	if index == nil then
		index = #addteam.TeamBench + 1
	else
		for i = index, #addteam.TeamBench, 1 do
			addteam.TeamBench[i].CharacterIndex = addteam.TeamBench[i].CharacterIndex + 1
		end
	end
		
	character.TeamIndex = addteam.LeagueIndex
	character.CharacterIndex = index
	
	table.insert(addteam.TeamBench,character,index)
end

ModUtil.WrapBaseFunction( "PrepareLocalMPDraft", function(baseFunc, TeamAid, TeamBid )
	if #League[TeamAid].TeamBench == config.TeamA.BaseCount and #League[TeamAid].TeamBench == config.TeamA.BaseCount then
		local TeamA = League[TeamAid]
		local TeamB = League[TeamBid]
		for i,v in ipairs(config.TeamA) do
			if not v.Bench then v.Bench = TeamAid end
			CustomRoster.AddCharacter( TeamA, v )
		end
		for i,v in ipairs(config.TeamB) do
			if not v.Bench then v.Bench = TeamBid end
			CustomRoster.AddCharacter( TeamB, v )
		end
	end
	return baseFunc( TeamAid, TeamBid )
end, CustomRoster)
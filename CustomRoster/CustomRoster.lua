ModUtil.RegisterMod( "CustomRoster" )
--[[
Google Sheet for different character Values
https://docs.google.com/spreadsheets/d/1XxANHz_vtz8QHXYa0GqOX6xrL1XXGSsWsXiZWzZkVyw/edit?usp=sharing
]]--
local config = {
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

ModUtil.WrapBaseFunction( "PrepareLocalMPDraft", function(baseFunc, TeamAid, TeamBid )
		local TeamAbench = League[TeamAid].TeamBench
		local TeamBbench = League[TeamBid].TeamBench
		local nA = #TeamAbench
		local nB = #TeamBbench
		for i,v in ipairs(config.TeamA) do
			local bench = League[v.Bench]
			local character = DeepCopyTable(bench.TeamBench[v.Base])
			ModUtil.MapNilTable(character,v.NilTable)
			ModUtil.MapSetTable(character,v.SetTable)
			character.CharacterIndex = nA+i
			character.TeamIndex = TeamAid
			
			character.MaskHue = bench.MaskHue 
			character.MaskSaturationAddition = bench.MaskSaturationAddition
			character.MaskValueAddition = bench.MaskValueAddition
			character.MaskHue2 = bench.MaskHue2
			character.MaskSaturationAddition2 = bench.MaskSaturationAddition2
			character.MaskValueAddition2 = bench.MaskValueAddition2
			character.UsePhantomShader = bench.UsePhantomShader
			
			TeamAbench[character.CharacterIndex] = character
		end
		for i,v in ipairs(config.TeamB) do
			local bench = League[v.Bench]
			local character = DeepCopyTable(bench.TeamBench[v.Base])
			ModUtil.MapNilTable(character,v.NilTable)
			ModUtil.MapSetTable(character,v.SetTable)
			character.CharacterIndex = nB+i
			character.TeamIndex = TeamBid
			
			character.MaskHue = bench.MaskHue 
			character.MaskSaturationAddition = bench.MaskSaturationAddition
			character.MaskValueAddition = bench.MaskValueAddition
			character.MaskHue2 = bench.MaskHue2
			character.MaskSaturationAddition2 = bench.MaskSaturationAddition2
			character.MaskValueAddition2 = bench.MaskValueAddition2
			character.UsePhantomShader = bench.UsePhantomShader
			
			TeamBbench[character.CharacterIndex] = character
		end
	return baseFunc( TeamAid, TeamBid )
end, CustomRoster)
-- lua/autorun/server/healthregen.lua
-- Registers a hook that regenerates player health like Modern Warfare
-- Copyleft 2022 Garry's Mod Player. All rights reversed.

-- Registers a hook that regenerates player health like Modern Warfare
-- Returns nil
hook.Add("PlayerHurt", "healthregen", function(victim)
	timer.Create("healthregen: " .. victim:UserID(), 10, 1, function()
		if victim:GetHealth() < victim:GetMaxHealth() then
			victim:SetHealth(victim:GetMaxHealth())
		end
	end)
end)

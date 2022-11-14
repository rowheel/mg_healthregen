-- lua/autorun/server/healthregen.lua
-- Registers a hook that regenerates player health like Modern Warfare
-- Copyleft 2022 Garry's Mod Player. All rights reversed.

-- Parameter player is a reference to an online player
-- Returns the timer identifier for that player
local function getTimerIdentifier(player)
	return "healthregen: " .. player:UserID()
end

-- Parameter player is a reference to an online player
-- Returns true is that player can regenerate health, otherwise false
local function canRegenerateHealth(player)
	return player:Alive() and player:Health() < player:GetMaxHealth()
end

-- Registers a hook that regenerates player health like Modern Warfare
-- Returns nil
hook.Add("PlayerHurt", "create_healthregen", function(victim)
	timer.Create(getTimerIdentifier(victim), 10, 1, function()
		if canRegenerateHealth(victim) then
			victim:SetHealth(victim:GetMaxHealth())
		end
	end)
end)

-- Registers a hook that removes the timer after player death
-- Returns nil
hook.Add("PostPlayerDeath", "remove_healthregen", function(player)
	timer.Remove(getTimerIdentifier(player))
end)

-- lua/autorun/server/healthregen.lua
-- Registers a hook that regenerates player health like Modern Warfare
-- Copyleft 2022 Garry's Mod Player. All rights reversed.

-- Parameter player is a reference to an online player
-- Returns the timer identifier for that player
local function getTimerIdentifier(player)
	return "healthregen: " .. player:UserID()
end

-- Parameter player is a reference to an online player
-- Returns the timer delay for that player
local function getTimerDelay(player)
	return math.ceil((player:GetMaxHealth() - player:Health()) / 20) + 5
end

-- Parameter player is a reference to an online player
-- Returns true if that player can regenerate health, otherwise false
local function canRegenerateHealth(player)
	return player:Alive() and player:Health() < player:GetMaxHealth()
end

-- Registers a hook that regenerates player health like Modern Warfare
-- Parameter player is a reference to an online player
-- Returns nil
hook.Add("PlayerHurt", "create_healthregen", function(player)
	if not canRegenerateHealth(player) then
		return timer.Remove(getTimerIdentifier(player))
	end

	timer.Create(getTimerIdentifier(player), getTimerDelay(player), 1, function()
		if canRegenerateHealth(player) then
			player:SetHealth(player:GetMaxHealth())
		end
	end)
end)

-- Registers a hook that removes the timer after player death
-- Parameter player is a reference to an online player
hook.Add("PostPlayerDeath", "remove_healthregen", function(player)
	timer.Remove(getTimerIdentifier(player))
end)

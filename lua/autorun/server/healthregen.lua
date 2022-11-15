-- lua/autorun/server/healthregen.lua
-- Registers a hook that regenerates player health like Modern Warfare
-- Copyleft 2022 Garry's Mod Player. All rights reversed.

-- Parameter player is a reference to an online player
-- Returns true if that player can regenerate health, otherwise false
local function canRegenerate(player)
	return player:Alive() and player:Health() < player:GetMaxHealth()
end

-- Parameter player is a reference to an online player
-- Returns a unique timer identifier for that player
local function getIdentifier(player)
	return "healthregen: " .. player:UserID()
end

-- Parameter player is a reference to an online player
-- Returns current regeneration delay for that player
local function getDelay(player)
	return math.ceil((player:GetMaxHealth() - player:Health()) / 10) + 10
end

-- Registers a hook that regenerates player health like Modern Warfare
-- Parameter player is a reference to an online player
-- Returns nil
hook.Add("PlayerHurt", "create_healthregen", function(player)
	if not canRegenerate(player) then
		return timer.Remove(getIdentifier(player))
	end

	timer.Create(getIdentifier(player), getDelay(player), 1, function()
		if canRegenerate(player) then
			player:SetHealth(player:GetMaxHealth())
		end
	end)
end)

-- Registers a hook that removes the timer after player death
-- Parameter player is a reference to an online player
hook.Add("PostPlayerDeath", "remove_healthregen", function(player)
	timer.Remove(getIdentifier(player))
end)

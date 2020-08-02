-- PartySystem.lua

local module = {}
local parties = {}

local pendingInvites = {}
local serverCooldowns = {}

local event = game:GetService("ReplicatedStorage"):WaitForChild('Events').Party

function module:create(plr)
	if parties[plr.Name] then return end 
	if serverCooldowns[plr.Name] then return end
	
	--// Checking if player is in party.
	
	for i,v in pairs(parties) do
		if v.Members then
			
			for name,v2 in pairs(v.Members) do
				if name == plr.Name then return end
			end
			
		end
	end

	--
	
	parties[plr.Name] = {
		
		Owner = plr.Name,
		Members = {},
		
	};
	
	event:InvokeClient(plr, 'Create')
	
	
end

function module:disband(plr)
	if not parties[plr.Name] then return end
	if serverCooldowns[plr.Name] then return end
	
	coroutine.wrap(function()
		serverCooldowns[plr.Name] = true
		wait(3)
		serverCooldowns[plr.Name] = nil
 	end)()
	
	
	--// Checking if player is in party.
	
	for i,v in pairs(parties) do
		if v.Members then
			
			for name,v2 in pairs(v.Members) do
				if name == plr.Name then return end
			end
			
		end
	end

	
	--[[
		Remove markers later for party members via fire client.
	]]
	
	parties[plr.Name] = nil
	event:InvokeClient(plr, 'Disband')
	
	
end

function module:recruit(plr, target)
	if serverCooldowns[plr.Name] then return end
	if pendingInvites[target.Name] then return end
	
	--[[
		Add invitiation message later.
	]]
	
	coroutine.wrap(function()
		serverCooldowns[plr.Name] = true
		wait(3)
		serverCooldowns[plr.Name] = nil
	end)()
	
	if target.Name == plr.Name then return end
	
	if parties[target.Name] then return end
	if not parties[plr.Name] then return end
	
	--// Checking if player is in party.
	
		for i,v in pairs(parties) do
		if v.Members then
			
			for name,v2 in pairs(v.Members) do
				if name == plr.Name then return end
			end
			
		end
	end

		--// Checking if player is in party.
	
	for i,v in pairs(parties) do
		if v.Members then
			
			for name,v2 in pairs(v.Members) do
				if name == target.Name then return end
			end
			
		end
	end

	
	-- Target has to be player instance.
	
	event:InvokeClient(target, 'SendRecruit', plr)
	
	pendingInvites[target.Name] = {
		From = plr.Name,
		To = target.Name,
	};
	
	
end

function module:recruitAction(plr, action)
	if action == 'Accept' then
		
		if pendingInvites[plr.Name] then
			
			-- Accept
			
			
			event:InvokeClient(game.Players[pendingInvites[plr.Name].From], 'Accept',game.Players[pendingInvites[plr.Name].To])
			
			local PlayerName = game.Players[pendingInvites[plr.Name].From].Name
			
			parties[PlayerName].Members[plr.Name] = true;
			
			pendingInvites[plr.Name] = nil
			
		end
		
	end
	
	if action == 'Decline' then
		
		if pendingInvites[plr.Name] then
			
			-- Decline
					
			event:InvokeClient(game.Players[pendingInvites[plr.Name].From], 'Decline',game.Players[pendingInvites[plr.Name].To])
			
			pendingInvites[plr.Name] = nil
		end
		
	end
	
end

function module:leave(plr)
	if parties[plr.Name] then return end
	if serverCooldowns[plr.Name] then return end
	if pendingInvites[plr.Name] then return end
	
	coroutine.wrap(function()
		serverCooldowns[plr.Name] = true
		wait(3)
		serverCooldowns[plr.Name] = nil
	end)()
	
	for i,v in pairs(parties) do
		if v.Members then
			
			for name,v2 in pairs(v.Members) do
				if name == plr.Name then
					v.Members[name] = nil
					
					local owner = game.Players[v.Owner]
					
					event:InvokeClient(owner, 'Leave', plr)
					
					break
				else
					
				end
			end
			
		end
	end
	
	
	
end



return module

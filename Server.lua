-- sylvern

local p = game:GetService("Players")
local m = require(game:GetService("ReplicatedStorage"):WaitForChild('Modules').PartyModule)

local event = game:GetService("ReplicatedStorage"):WaitForChild('Events').Party

p.PlayerAdded:Connect(function(plr)
	plr.Chatted:Connect(function(msg)
		
		local lower = msg:lower()
		local split = lower:split(" ")
		
		if split[1] == 'createparty' then
			m:create(plr)
		end
		
		if split[1] == 'disbandparty' then
			m:disband(plr)
		end
		
		if split[1] == 'leaveparty' then
			m:leave(plr)
		end
		
		
		if split[1] == 'invite' then
			
			if not split[2] then return end
			
			if split[2] then
			--	warn( tostring(split[2]) )
				
				local splitAgain = msg:split(" ")
				
				local toInvite = tostring(splitAgain[2])
				
				if game.Players:FindFirstChild(toInvite) then
										
					m:recruit(plr, game.Players[toInvite])
					
				end
				
			end
			
		end
		
		
		
		
	end)
end)

p.PlayerRemoving:Connect(function(plr)
	
	m:disband(plr)
	
end)

event.OnServerInvoke = function(plr, action)
	if action == 'PartyAccept' then
		m:recruitAction(plr, 'Accept')
	end
	
	if action == 'PartyDecline' then
		m:recruitAction(plr, 'Decline')
	end
end

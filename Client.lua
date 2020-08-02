-- Sylvern

-- Variables

local StarterGUI = game:GetService("StarterGui")

local Event = game:GetService("ReplicatedStorage"):WaitForChild("Events").Party
local PInvite = game:GetService("ReplicatedStorage"):WaitForChild("Events").PartyInvite

local Players = game:GetService("Players")

-- Functions

local function callback(response)
	if response == 'Accept' then
		
		Event:InvokeServer('PartyAccept')
		
	end
	
	
	if response ~= 'Accept' then
		
		Event:InvokeServer('PartyDecline')
		
	end
	
end

PInvite.OnInvoke = callback

Event.OnClientInvoke = function(action, from)
	if action == 'SendRecruit' then
		
		StarterGUI:SetCore("SendNotification", {
			Title = 'Party Invite',
			Text = 'You have received a party invite from: '.. from.Name,
			Icon = Players:GetUserThumbnailAsync(from.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150),
			Duration = 10,
			Callback = PInvite,
			Button1 = 'Accept',
			Button2 = 'Decline',
			
			
		})
		
	end
	
	if action == 'Accept' then
		
		StarterGUI:SetCore("SendNotification", {
			Title = 'Party Info',
			Text = from.Name.. ' has accepted your party request.',
			Icon = Players:GetUserThumbnailAsync(from.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150),
			Duration = 5,
		})	
		
	end
	
	if action == 'Decline' then
		
		StarterGUI:SetCore("SendNotification", {
			Title = 'Party Info',
			Text = from.Name.. ' has declined your party request.',
			Icon = Players:GetUserThumbnailAsync(from.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150),
			Duration = 5,
		})
		
	end
	
	if action == 'Leave' then
		
		StarterGUI:SetCore("SendNotification", {
			Title = 'Party Info',
			Text = from.Name.. ' has left your party.',
			Icon = Players:GetUserThumbnailAsync(from.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150),
			Duration = 5,
		})
		
	end
	
	if action == 'Create' then
		
		StarterGUI:SetCore("SendNotification", {
			Title = 'Party Creation',
			Text = 'You have created a party.',
			Icon = Players:GetUserThumbnailAsync(Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150),
			Duration = 5,
		})
		
	end
	
	if action == 'Disband' then
			
		StarterGUI:SetCore("SendNotification", {
			Title = 'Party Creation',
			Text = 'You have disbanded your party.',
			Icon = Players:GetUserThumbnailAsync(Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150),
			Duration = 5,
		})
		
	end
	
end

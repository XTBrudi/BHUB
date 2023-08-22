function Notification()
	local Sound = Instance.new("Sound")
	Sound.Parent = game.SoundService
	Sound.SoundId = "rbxassetid://6026984224"
	Sound.Volume = 5
	Sound.PlayOnRemove = true
	Sound:Destroy()
end


local NoClip = false
local NoclipConnection
local FalseValue = false
local initialCharacterPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
local SwimmFly = false -- NEEDED FOR SWIM FLY
local maxspeed = 500 -- NEEDED FOR NORMAL FLY
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
local FireColor = nil -- NEEDED FOR FUN TAB, Fire Tracer
local Fire = nil -- NEEDED FOR FUN TAB, Fire Tracer
local Flashlight = nil -- NEEDED FOR FUN TAB, Human flashlight
local FlashlightColor = nil -- NEEDED FOR FUN TAB, Human flashlight
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "🔥 Brudi's multi script 🔥",
	LoadingTitle = "LOADING. . .",
	LoadingSubtitle = "By .brudi_(discord)",
	ConfigurationSaving = {
		Enabled = false, -- CHANGE THIS LATER
		FolderName = "BHUB_FOLDER", -- Create a custom folder for your hub/game
		FileName = "BHUB"
	},
	Discord = {
		Enabled = false,
		Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
		RememberJoins = true -- Set this to false to make them join the discord every time they load it up
	},
	KeySystem = true, -- Set this to true to use our key system
	KeySettings = {
		Title = "BHUB - Uh oh! Y-ou need a key.",
		Subtitle = "Key System",
		Note = "Ask .brudi on discord.",
		FileName = "dE0GBna2", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
		SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = {"BHUBKEY_quzir1c2tbhrOB56G30brsjUt6b7AR8Vt4bJNbse"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
	}
}) 
-- CREATE TAB
local MainTab = Window:CreateTab("🏠 Home", nil) -- Title, Image
local FunTab = Window:CreateTab("🎉 Fun", nil) -- Title, Image
local CombatTab = Window:CreateTab("🗡 Combat", nil) -- Title, Image
local ScriptTab = Window:CreateTab("</> Scripts", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Main") -- MAIN SECTION
-- NOTIFY
Rayfield:Notify({
	Title = "Script successfully executed.",
	Content = "Script booted normally",
	Duration = 5,
	Image = 11745872910,
	Actions = { -- Notification Buttons
		Ignore = {
			Name = "Cool!",
			Callback = function()
				print("closed notification")
			end
		},
	},
})
local function CallERROR()
	Rayfield:Notify({
		Title = "BHUB | Error",
		Content = "Something didn't worked right, or this is still work in progress",
		Duration = 5,
		Image = 240664703,
		Actions = { -- Notification Buttons
			Ignore = {
				Name = "Close",
				Callback = function()
					error("BHUB | Something didn't worked right, or this is still work in progress")
				end
			},
		},
	})
	Notification()
end


--INTERFACE:
local Button = MainTab:CreateButton({
	Name = "Rejoin (In the same lobby)",
	Callback = function()
		local ts = game:GetService("TeleportService")
		local p = game:GetService("Players").LocalPlayer
		ts:Teleport(game.PlaceId, p)
	end,
})

local Input = MainTab:CreateInput({
	Name = "Player Teleport",
	PlaceholderText = "Enter username",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		local tp_namedplayer = (Text)
		local tp_player = game:GetService("Players")[tp_namedplayer]
		local PLR = game:GetService("Players").LocalPlayer

		if tp_player then
			for i = 1, 1 do
				wait(.08)
				PLR.Character.HumanoidRootPart.CFrame = tp_player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 0, -1)
				Rayfield:Notify({
					Title = "BHUB | Notification",
					Content = "Teleported successfully to the player",
					Duration = 5,
					Image = 11745872910,
					Actions = { -- Notification Buttons
						Ignore = {
							Name = "Close",
							Callback = function()
							end
						},
					},
				})
			end
		else
		end
	end,
})

--///////////////////////////////////////////////////////////
local Toggle = MainTab:CreateToggle({
	Name = "Toggle Noclip",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		local function Nocl()
			if not FalseValue and game.Players.LocalPlayer.Character then
				for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
					if v:IsA('BasePart') and v.CanCollide and v.Name ~= "floatName" then
						v.CanCollide = false
					end
				end
			end
		end
		local function EnableNoclip()
			if NoclipConnection then
				return
			end
			NoclipConnection = game:GetService('RunService').Stepped:Connect(Nocl)
		end
		local function DisableNoclip()
			if NoclipConnection then
				NoclipConnection:Disconnect()
				NoclipConnection = nil
				local character = game.Players.LocalPlayer.Character
				if character and character:FindFirstChild("HumanoidRootPart") then
					local rootPart = character.HumanoidRootPart
					local humanoid = character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.Health = 0
					end
				end
			end
		end
		if NoClip == false then
			NoClip = true
			print("NoClip enabled")
			EnableNoclip()
			Rayfield:Notify({
				Title = "BHUB | Notification",
				Content = "NoClip successfully toggled.",
				Duration = 5,
				Image = 11745872910,
				Actions = { -- Notification Buttons
					Ignore = {
						Name = "Close",
						Callback = function()
						end
					},
				},
			})
		elseif NoClip == true then
			NoClip = false
			print("NoClip disabled")
			DisableNoclip()
			Rayfield:Notify({
				Title = "BHUB | Notification",
				Content = "NoClip successfully toggled.",
				Duration = 5,
				Image = 11745872910,
				Actions = { -- Notification Buttons
					Ignore = {
						Name = "Close",
						Callback = function()
						end
					},
				},
			})
		end
	end,
})
local MainSection = MainTab:CreateSection("Movement") -- MOVEMENT START
local Slider = MainTab:CreateSlider({
	Name = "Walk Speed",
	Range = {0, 1000},
	Increment = 1,
	Suffix = "Speed",
	CurrentValue = 16,
	Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
	end,
})

local Slider = MainTab:CreateSlider({
	Name = "Jump height",
	Range = {0, 1000},
	Increment = 1,
	Suffix = "Jump",
	CurrentValue = 50,
	Flag = "Slider2", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Value)
	end,
})

local MainSection = MainTab:CreateSection("Flying") -- FLYING START
local Toggle = MainTab:CreateToggle({
	Name = "Toggle Swimm fly",
	CurrentValue = false,
	Flag = "Fly1toggle",
	Callback = function(Value)
		CallERROR()
	end,
})
local Slider = MainTab:CreateSlider({
	Name = "Set swim speed",
	Range = {0, 200},
	Increment = 1,
	Suffix = "Swim Speed",
	CurrentValue = 50,
	Flag = "SwimSPPED", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		print("Error.")
	end,
})



local Toggle = MainTab:CreateToggle({
	Name = "Toggle fly (Key: F)",
	CurrentValue = false,
	Flag = "Fly2toggle",
	Callback = function(Value)
		Rayfield:Notify({
			Title = "BHUB | Notification",
			Content = "Fly successfully toggled",
			Duration = 5,
			Image = 11745872910,
			Actions = { -- Notification Buttons
				Ignore = {
					Name = "Close",
					Callback = function()
					end
				},
			},
		})
		repeat wait() 
		until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Head") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid") 
		local mouse = game.Players.LocalPlayer:GetMouse() 
		repeat wait() until mouse
		local plr = game.Players.LocalPlayer 
		local torso = plr.Character.Head 
		local flying = false
		local deb = true 
		local ctrl = {f = 0, b = 0, l = 0, r = 0} 
		local lastctrl = {f = 0, b = 0, l = 0, r = 0} 
		local speed = 10

		local function Fly() 
			local bg = Instance.new("BodyGyro", torso) 
			bg.P = 9e4 
			bg.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
			bg.cframe = torso.CFrame 
			local bv = Instance.new("BodyVelocity", torso) 
			bv.velocity = Vector3.new(0,0.1,0) 
			bv.maxForce = Vector3.new(9e9, 9e9, 9e9) 
			repeat wait() 
				plr.Character.Humanoid.PlatformStand = true 
				if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then 
					speed = speed+.5+(speed/maxspeed) 
					if speed > maxspeed then 
						speed = maxspeed 
					end 
				elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then 
					speed = speed-1 
					if speed < 0 then 
						speed = 0 
					end 
				end 
				if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then 
					bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
					lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r} 
				elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then 
					bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
				else 
					bv.velocity = Vector3.new(0,0.1,0) 
				end 
				bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0) 
			until not flying 
			ctrl = {f = 0, b = 0, l = 0, r = 0} 
			lastctrl = {f = 0, b = 0, l = 0, r = 0} 
			speed = 0 
			bg:Destroy() 
			bv:Destroy() 
			plr.Character.Humanoid.PlatformStand = false 
		end 
		mouse.KeyDown:connect(function(key) 
			if key:lower() == "f" then 
				if flying then flying = false 
				else 
					flying = true 
					Fly() 
				end 
			elseif key:lower() == "w" then 
				ctrl.f = 1 
			elseif key:lower() == "s" then 
				ctrl.b = -1 
			elseif key:lower() == "a" then 
				ctrl.l = -1 
			elseif key:lower() == "d" then 
				ctrl.r = 1 
			end 
		end) 
		mouse.KeyUp:connect(function(key) 
			if key:lower() == "w" then 
				ctrl.f = 0 
			elseif key:lower() == "s" then 
				ctrl.b = 0 
			elseif key:lower() == "a" then 
				ctrl.l = 0 
			elseif key:lower() == "d" then 
				ctrl.r = 0 
			end 
		end)
		Fly()
	end,
})

local Slider = MainTab:CreateSlider({
	Name = "Set fly speed",
	Range = {0, 1000},
	Increment = 1,
	Suffix = "Fly Speed",
	CurrentValue = 500,
	Flag = "huknsdfgvn", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		maxspeed = (Value)
	end,
})



local MainSection = MainTab:CreateSection("Lightning")-- LIGHTNING START

local Slider = MainTab:CreateSlider({
	Name = "Set Brightness",
	Range = {-10, 30},
	Increment = 1,
	Suffix = "Bright",
	CurrentValue = game:GetService("Lighting").Brightness,
	Flag = "Slider3", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		game:GetService("Lighting").Brightness = (Value)
	end,
})

local Slider = MainTab:CreateSlider({
	Name = "Set Time of day",
	Range = {0, 24},
	Increment = 0.1,
	Suffix = "Time",
	CurrentValue = game:GetService("Lighting").ClockTime,
	Flag = "Slider4", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		game:GetService("Lighting").ClockTime = (Value)
	end,
})
--////////////////////////////////////////////
local MainSection = FunTab:CreateSection("Fire Tracer") -- FIRE TRACER START
local ToggleFire = FunTab:CreateToggle({
	Name = "Toggle Fire on head",
	CurrentValue = false,
	Flag = "FireToggle123",
	Callback = function(Value)
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:WaitForChild("Humanoid")
		local Torso = humanoid.Parent:FindFirstChild("Head")

		if Value == true then
			Fire = Instance.new("Fire")
			Fire.Parent = Torso
			Fire.Enabled = true
		elseif Value == false then
			if Fire then
				Fire.Enabled = false
				Fire:Destroy()
				Fire = nil
			end
		end
	end,
})

local ColorPickerFire = FunTab:CreateColorPicker({
	Name = "Set Fire color",
	Color = Color3.fromRGB(255, 255, 255),
	Flag = "FireColorPicker",
	Callback = function(Value)
		FireColor = Value
		if Fire then
			Fire.Color = FireColor
		end
	end,
})

local MainSectionFlashlight = FunTab:CreateSection("Human flashlight") -- HUMAN FLASHLIGHT START
local ToggleFlashlight = FunTab:CreateToggle({
	Name = "Toggle Pointlight on head",
	CurrentValue = false,
	Flag = "FlashToggle",
	Callback = function(Value)
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:WaitForChild("Humanoid")
		local Head = humanoid.Parent:FindFirstChild("Head")

		if Value == true then
			Flashlight = Instance.new("PointLight")
			Flashlight.Parent = Head
			Flashlight.Range = 20
			Flashlight.Brightness = 2
			Flashlight.Enabled = true
		elseif Value == false then
			if Flashlight then
				Flashlight.Enabled = false
				Flashlight:Destroy()
				Flashlight = nil
			end
		end
	end,
})

local ColorPickerFlashlight = FunTab:CreateColorPicker({
	Name = "Set Light Color",
	Color = Color3.fromRGB(255, 255, 255),
	Flag = "FlashlightColorPicker",
	Callback = function(Value)
		FlashlightColor = Value
		if Flashlight then
			Flashlight.Color = FlashlightColor
		end
	end,
})
local MainSectionFlashlight = FunTab:CreateSection("Avatar changer")
local Button = FunTab:CreateButton({
	Name = "Steal avatars",
	Callback = function()
		Notification()
		Rayfield:Notify({
			Title = "BHUB | Notification",
			Content = "WARNING! You need to join this group: '13022453 (Hell_$treet)' if you don't, you will get kicked.",
			Duration = 5,
			Image = 11745872910,
			Actions = { -- Notification Buttons
				Ignore = {
					Name = "I've joined.",
					Callback = function()
						loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\73\110\118\111\111\107\101\114\49\49\47\79\117\116\102\105\116\47\109\97\105\110\47\79\117\116\102\105\116\67\111\112\105\101\114\46\108\117\97\34\44\32\116\114\117\101\41\41\40\41\10")()
					end
				},
			},
		})
	end,
})
--/////////////////////////////////////////////////////////////////
local MainSection = CombatTab:CreateSection("PVP") --PVP SECTION START
local Button = CombatTab:CreateButton({
	Name = "Fast regenerate (100hp / 0.1ms) (WORK IN PROGRESS)",
	Callback = function()
		CallERROR()
	end,
})
local Button = CombatTab:CreateButton({
	Name = "Show GodMode button (Top left)",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/zephyr10101/ignore-touchinterests/main/main",true))()
	end,
})
--/////////////////////////////////////////////////////////////////
local SCriptSection = ScriptTab:CreateSection("Doors")
local Button = ScriptTab:CreateButton({
	Name = "Vytrix",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Doors/Script.lua"))()
	end,
})
local SCriptSection = ScriptTab:CreateSection("Multi scripts")
local Button = ScriptTab:CreateButton({
	Name = "Icehub (Supports many games.)",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMael7/NewIceHub/main/Brookhaven"))()
	end,
})
local SCriptSection = ScriptTab:CreateSection("Big Paintball")
local Button = ScriptTab:CreateButton({
	Name = "Darkyware",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/AndrewDarkyy/NOWAY/main/darkyyware.lua"))()
	end,
})
local SCriptSection = ScriptTab:CreateSection("Blox Fruits")
local Button = ScriptTab:CreateButton({
	Name = "ThunderZ",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/ThunderZ-05/HUB/main/Script"))()
	end,
})

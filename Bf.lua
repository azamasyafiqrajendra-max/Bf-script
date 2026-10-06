-- BF Hub v5.1 | All Sea | rayfield UI
-- Code dari Byte Hub + Fix Bug + Rayfield UI

local LoadOk, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not LoadOk or not Rayfield then
    -- Coba mirror
    local ok2, rf2 = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusHub/Rayfield/main/source.lua"))()
    end)
    if ok2 and rf2 then
        Rayfield = rf2
    else
        warn("Rayfield gagal load: " .. tostring(Rayfield))
        return
    end
end

-- ─── SERVICES ──────────────────────────────────────────────────────────
local Players      = game:GetService("Players")
local RunService   = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS          = game:GetService("UserInputService")
local VIM          = game:GetService("VirtualInputManager")
local VUser        = game:GetService("VirtualUser")
local RS           = game:GetService("ReplicatedStorage")
local CommF_       = RS.Remotes.CommF_

local lp      = Players.LocalPlayer
local Enemies = workspace:WaitForChild("Enemies")

-- ─── CHAR ──────────────────────────────────────────────────────────────
local char, hrp, hum
local function refreshChar(c)
    char = c
    hrp  = c:WaitForChild("HumanoidRootPart")
    hum  = c:WaitForChild("Humanoid")
end
refreshChar(lp.Character or lp.CharacterAdded:Wait())
lp.CharacterAdded:Connect(refreshChar)

-- ─── WORLD ─────────────────────────────────────────────────────────────
local placeId    = game.PlaceId
local First_Sea  = placeId == 2753915549 or placeId == 85211729168715
local Second_Sea = placeId == 4442272183 or placeId == 79091703265657
local Third_Sea  = placeId == 7449423635 or placeId == 100117331123089

-- ─── GLOBALS ───────────────────────────────────────────────────────────
_G.Fast_Delay  = 0.1
_G.AutoLevel   = false
_G.AutoNear    = false
_G.AutoBoss    = false
_G.AutoMaterial= false
_G.AutoBone    = false
_G.CakePrince  = false
_G.AutoElite   = false
_G.BringMob    = true
_G.FastNe      = true
_G.RemoveDameText = true
_G.WalkonWater = true
_G.AutoRejoin  = true
_G.AutoSeaBeast= false
_G.AutoShark   = false
_G.AutoTerrorshark = false
_G.farmpiranya = false
_G.AutoFishCrew= false
_G.Ship        = false
_G.Factory     = false
_G.AutoCakeV2  = false
_G.AutoHytHallow = false
_G.AutoElite   = false
_G.Ectoplasm   = false
_G.CastleRaid  = false
_G.SpawnCakePrince = false
_G.AutoRandomBone  = false
_G.KillAura    = false
_G.AutoNextIsland  = false
_G.TeleportPly = false
_G.EnabledPvP  = false
_G.Auto_Buy_Chips  = false
_G.Auto_StartRaid  = false
_G.AutoQuestRace   = false
_G.FindMirageIsland = false
_G.AutoFindMoon    = false
_G.TweenToKitsune  = false
_G.CollectAzure    = false
_G.SailBoat        = false
_G.AutoW           = false
_G.Auto_Holy_Torch = false
_G.AutoYama        = false
_G.AutoStoreFruit  = false
_G.CollectFruitTP  = false
_G.Tweenfruit      = false
_G.Auto_Stats_Melee       = false
_G.Auto_Stats_Defense     = false
_G.Auto_Stats_Sword       = false
_G.Auto_Stats_Gun         = false
_G.Auto_Stats_Devil_Fruit = false
_G.Auto_Buy_Enchancement  = false
_G.BuyLengendSword        = false
_G.AutoEvoRace = false
_G.Join        = false
_G.Job         = ""
_G.SelectBoss  = ""
_G.SelectChip  = ""
_G.SelectIsland= ""
_G.SelectPly   = ""
_G.SelectFruit = ""

local SelectWeapon = "Melee"
local ChooseWeapon = "Melee"
local posX, posY, posZ = 0, 30, 0
local bringmob  = false
local FarmPos   = CFrame.new(0,0,0)
local MonFarm   = ""
local TweenSpeed = 340
local Speed      = 300
local tween
local KillPercent = 25
local _G_UseSkill = false
local PositionSkillMasteryDevilFruit = Vector3.new(0,0,0)
local SkillZ, SkillX, SkillC, SkillV, SkillF = true, true, true, false, false
local AutoFarmMasDevilFruit = false
local TypeMastery  = "Level"
local AutoFarmAcient = false
local AutoNextIsland = false
local AutoTushita    = false
local AutoHallowSycthe = false
local Auto_Law       = false
local BringAcient    = false
local AutoBartilo    = false
local ESPPlayer      = false
local DevilFruitESP  = false
local IslandESP      = false
local MobESP         = false
local ChestESP       = false
local FlowerESP      = false
local BypassTP       = false
local InfAbility     = false
local Number = math.random(1, 1000000)

-- Quest vars
local Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon
local SelectMonster = ""
local SelectArea    = ""
local SelectMaterial = ""
local MMon, MPos, SP
local SelectBoss    = ""
local BossMon, CFrameQBoss, CFrameBoss, NameQuestBoss, QuestLvBoss

-- ─── ANTI BAN ──────────────────────────────────────────────────────────
local function AntiBan()
    for _,v in pairs(lp.Character:GetDescendants()) do
        if v:IsA("LocalScript") then
            if v.Name == "General" or v.Name == "Shiftlock" or v.Name == "FallDamage"
            or v.Name == "CamBob" or v.Name == "JumpCD" or v.Name == "Run" then
                v:Destroy()
            end
        end
    end
    for _,v in pairs(lp.PlayerScripts:GetDescendants()) do
        if v:IsA("LocalScript") then
            if v.Name == "RobloxMotor6DBugFix" or v.Name == "Clans" or v.Name == "Codes"
            or v.Name == "CustomForceField" or v.Name == "PlayerList" then
                v:Destroy()
            end
        end
    end
end
pcall(AntiBan)

-- ─── ANTI AFK ──────────────────────────────────────────────────────────
lp.Idled:Connect(function()
    VUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- ─── REMOVE EFFECT ─────────────────────────────────────────────────────
pcall(function()
    if RS.Effect.Container:FindFirstChild("Death")   then RS.Effect.Container.Death:Destroy()   end
    if RS.Effect.Container:FindFirstChild("Respawn") then RS.Effect.Container.Respawn:Destroy() end
end)

-- ─── TWEEN ─────────────────────────────────────────────────────────────
local function Tween(P1)
    local Distance = (P1.Position - hrp.Position).Magnitude
    Speed = Distance >= 1 and TweenSpeed or Speed
    TweenService:Create(hrp, TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear), {CFrame=P1}):Play()
end

local function Tween2(P1)
    local Distance = (P1.Position - hrp.Position).Magnitude
    Speed = Distance >= 1 and 300 or Speed
    TweenService:Create(hrp, TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear), {CFrame=P1}):Play()
    task.wait(Distance/Speed)
end

local function toTarget(targetCF)
    if not hrp then return end
    if hum.Health <= 0 then return end
    local Distance = (targetCF.Position - hrp.Position).Magnitude
    Speed = Distance < 1000 and 315 or 300
    if tween then tween:Cancel() end
    local info = TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear)
    tween = TweenService:Create(hrp, info, {CFrame=targetCF})
    tween:Play()
end

local function CancelTween()
    if tween then tween:Cancel() end
end

local function notween(p)
    hrp.CFrame = p
end

local function BTPZ(Point)
    hrp.CFrame = Point
    task.wait()
    hrp.CFrame = Point
end

-- ─── COMBAT FRAMEWORK ──────────────────────────────────────────────────
local CombatFW, y, CameraShaker
pcall(function()
    CameraShaker = require(RS.Util.CameraShaker)
    CombatFW     = require(lp.PlayerScripts.CombatFramework)
    y            = debug.getupvalues(CombatFW)[2]
end)

-- Fast attack RenderStepped
RunService.RenderStepped:Connect(function()
    if _G.FastNe and y then
        pcall(function()
            if CameraShaker then CameraShaker:Stop() end
            y.activeController.timeToNextAttack  = 0
            y.activeController.hitboxMagnitude   = 60
            y.activeController.active            = false
            y.activeController.timeToNextBlock   = 0
            y.activeController.blocking          = false
            y.activeController.attacking         = false
            y.activeController.humanoid.AutoRotate = true
        end)
    end
end)

local function AttackNoCoolDown()
    pcall(function()
        if not y then return end
        if CameraShaker then CameraShaker:Stop() end
        y.activeController.timeToNextAttack  = 0
        y.activeController.hitboxMagnitude   = 60
        y.activeController.active            = false
        y.activeController.timeToNextBlock   = 0
        y.activeController.blocking          = false
        y.activeController.attacking         = false
        y.activeController.humanoid.AutoRotate = true
    end)
    pcall(function()
        local Module  = require(lp.PlayerScripts.CombatFramework)
        local CF2     = debug.getupvalues(Module)[2]
        local riglib  = require(RS.CombatFramework.RigLib)
        local bladehit = riglib.getBladeHits(char, {hrp}, 60)
        local cac, hash = {}, {}
        for _,v in pairs(bladehit) do
            if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
                table.insert(cac, v.Parent.HumanoidRootPart)
                hash[v.Parent] = true
            end
        end
        if #cac > 0 then
            local AC  = CF2.activeController
            local u8  = debug.getupvalue(AC.attack, 5)
            local u9  = debug.getupvalue(AC.attack, 6)
            local u7  = debug.getupvalue(AC.attack, 4)
            local u10 = debug.getupvalue(AC.attack, 7)
            local u12 = (u8*798405 + u7*727595) % u9
            local u13 = u7*798405
            u12 = (u12*u9 + u13) % 1099511627776
            u8  = math.floor(u12/u9)
            u7  = u12 - u8*u9
            u10 = u10 + 1
            debug.setupvalue(AC.attack, 5, u8)
            debug.setupvalue(AC.attack, 6, u9)
            debug.setupvalue(AC.attack, 4, u7)
            debug.setupvalue(AC.attack, 7, u10)
            pcall(function()
                for _,v in pairs(AC.animator.anims.basic) do v:Play() end
            end)
            if char:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then
                RS.RigControllerEvent:FireServer("hit", cac, 1, "")
                RS.Remotes.Validator:FireServer(math.floor(u12/1099511627776*16777215), u10)
            end
        end
    end)
end

local function NormalAttack()
    pcall(function()
        local Module = require(lp.PlayerScripts.CombatFramework)
        local CF2    = debug.getupvalues(Module)[2]
        if CameraShaker then CameraShaker:Stop() end
        CF2.activeController.attacking         = false
        CF2.activeController.timeToNextAttack  = 0
        CF2.activeController.hitboxMagnitude   = 180
        VUser:CaptureController()
        VUser:Button1Down(Vector2.new(1280, 672))
    end)
end

-- ─── WEAPON ────────────────────────────────────────────────────────────
local function EquipTool(name)
    if not name then return end
    local tool = lp.Backpack:FindFirstChild(name)
    if tool then
        task.wait(0.5)
        hum:EquipTool(tool)
    end
end

local function weaponSc(weapon)
    for _,v in pairs(lp.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.ToolTip == weapon then
            EquipTool(v.Name)
            return
        end
    end
end

-- Auto detect weapon
task.spawn(function()
    while task.wait() do
        pcall(function()
            for _,v in pairs(lp.Backpack:GetChildren()) do
                if v:IsA("Tool") then
                    if ChooseWeapon == "Melee"      and v.ToolTip == "Melee"      then SelectWeapon = v.Name end
                    if ChooseWeapon == "Sword"      and v.ToolTip == "Sword"      then SelectWeapon = v.Name end
                    if ChooseWeapon == "Blox Fruit" and v.ToolTip == "Blox Fruit" then SelectWeapon = v.Name end
                end
            end
        end)
    end
end)

-- ─── AUTO HAKI ─────────────────────────────────────────────────────────
local function AutoHaki()
    if not char:FindFirstChild("HasBuso") then
        pcall(function() CommF_:InvokeServer("Buso") end)
    end
end

-- ─── POS ROTATION ──────────────────────────────────────────────────────
local Type = 1
local Pos  = CFrame.new(posX, posY, posZ)

task.spawn(function()
    while task.wait(0.1) do
        if Type == 1 then     Pos = CFrame.new(posX, posY, posZ)
        elseif Type == 2 then Pos = CFrame.new(-30,  10,  -30)
        elseif Type == 3 then Pos = CFrame.new(10,   10,  -40)
        elseif Type == 4 then Pos = CFrame.new(-40,  10,   10) end
    end
end)

-- ─── BRING MOB ─────────────────────────────────────────────────────────
task.spawn(function()
    while task.wait() do
        pcall(function()
            for _,v in pairs(Enemies:GetChildren()) do
                if _G.BringMob and bringmob then
                    if v.Name == MonFarm and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        local mr = v:FindFirstChild("HumanoidRootPart")
                        if mr and (mr.Position - FarmPos.Position).Magnitude <= 337.5 then
                            mr.CFrame           = FarmPos
                            mr.Size             = Vector3.new(60,60,60)
                            mr.Transparency     = 1
                            mr.CanCollide       = false
                            v.Humanoid.WalkSpeed = 0
                            v.Humanoid.JumpPower = 0
                            if v.Humanoid:FindFirstChild("Animator") then
                                v.Humanoid.Animator:Destroy()
                            end
                            if v:FindFirstChild("Head") then
                                v.Head.CanCollide = false
                            end
                            sethiddenproperty(lp, "SimulationRadius", math.huge)
                        end
                    end
                end
            end
        end)
    end
end)

-- ─── NO CLIP ───────────────────────────────────────────────────────────
task.spawn(function()
    RunService.Stepped:Connect(function()
        pcall(function()
            if _G.AutoLevel or _G.AutoNear or _G.AutoBoss or _G.AutoMaterial
            or _G.AutoBone or _G.CakePrince or _G.AutoElite or _G.Ectoplasm
            or _G.CastleRaid or AutoFarmMasDevilFruit or Auto_Law or AutoFarmAcient
            or AutoTushita or AutoHallowSycthe or _G.AutoSeaBeast or _G.Ship
            or _G.Factory or _G.AutoCakeV2 then
                if not hrp:FindFirstChild("BodyClip") then
                    local bv       = Instance.new("BodyVelocity")
                    bv.Name        = "BodyClip"
                    bv.MaxForce    = Vector3.new(1e5,1e5,1e5)
                    bv.Velocity    = Vector3.zero
                    bv.Parent      = hrp
                end
                for _,v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            else
                local bc = hrp:FindFirstChild("BodyClip")
                if bc then bc:Destroy() end
            end
        end)
    end)
end)

-- ─── REMOVE DAMAGE TEXT ────────────────────────────────────────────────
task.spawn(function()
    while task.wait() do
        pcall(function()
            RS.Assets.GUI.DamageCounter.Enabled = not _G.RemoveDameText
        end)
    end
end)

-- ─── WALK ON WATER ─────────────────────────────────────────────────────
task.spawn(function()
    while task.wait() do
        pcall(function()
            local wp = workspace.Map:FindFirstChild("WaterBase-Plane")
            if wp then
                wp.Size = _G.WalkonWater
                    and Vector3.new(1000,112,1000)
                    or  Vector3.new(1000,80,1000)
            end
        end)
    end
end)

-- ─── SKILL MASTERY HOOK ────────────────────────────────────────────────
pcall(function()
    local gg  = getrawmetatable(game)
    local old = gg.__namecall
    setreadonly(gg, false)
    gg.__namecall = newcclosure(function(...)
        local method = getnamecallmethod()
        local args   = {...}
        if tostring(method) == "FireServer" then
            if tostring(args[1]) == "RemoteEvent" then
                if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                    if _G_UseSkill then
                        args[2] = PositionSkillMasteryDevilFruit
                        return old(unpack(args))
                    end
                end
            end
        end
        return old(...)
    end)
end)

-- ─── CHECK LEVEL (QUEST DATA) ──────────────────────────────────────────
local function CheckLevel()
    local Lv = lp.Data.Level.Value
    if First_Sea then
        if Lv <= 9 then
            Ms="Bandit";NameQuest="BanditQuest1";QuestLv=1;NameMon="Bandit"
            CFrameQ=CFrame.new(1060.9383544922,16.455066680908,1547.7841796875)
            CFrameMon=CFrame.new(1038.5533447266,41.296249389648,1576.5098876953)
        elseif Lv <= 14 then
            Ms="Monkey";NameQuest="JungleQuest";QuestLv=1;NameMon="Monkey"
            CFrameQ=CFrame.new(-1601.6553955078,36.85213470459,153.38809204102)
            CFrameMon=CFrame.new(-1448.1446533203,50.851993560791,63.60718536377)
        elseif Lv <= 29 then
            Ms="Gorilla";NameQuest="JungleQuest";QuestLv=2;NameMon="Gorilla"
            CFrameQ=CFrame.new(-1601.6553955078,36.85213470459,153.38809204102)
            CFrameMon=CFrame.new(-1142.6488037109,40.462348937988,-515.39227294922)
        elseif Lv <= 39 then
            Ms="Pirate";NameQuest="BuggyQuest1";QuestLv=1;NameMon="Pirate"
            CFrameQ=CFrame.new(-1140.1761474609,4.752049446106,3827.4057617188)
            CFrameMon=CFrame.new(-1201.0881347656,40.628940582275,3857.5966796875)
        elseif Lv <= 59 then
            Ms="Brute";NameQuest="BuggyQuest1";QuestLv=2;NameMon="Brute"
            CFrameQ=CFrame.new(-1140.1761474609,4.752049446106,3827.4057617188)
            CFrameMon=CFrame.new(-1387.5324707031,24.592035293579,4100.9575195313)
        elseif Lv <= 74 then
            Ms="Desert Bandit";NameQuest="DesertQuest";QuestLv=1;NameMon="Desert Bandit"
            CFrameQ=CFrame.new(896.51721191406,6.4384617805481,4390.1494140625)
            CFrameMon=CFrame.new(984.99896240234,16.109552383423,4417.91015625)
        elseif Lv <= 89 then
            Ms="Desert Officer";NameQuest="DesertQuest";QuestLv=2;NameMon="Desert Officer"
            CFrameQ=CFrame.new(896.51721191406,6.4384617805481,4390.1494140625)
            CFrameMon=CFrame.new(1547.1510009766,14.452038764954,4381.8002929688)
        elseif Lv <= 99 then
            Ms="Snow Bandit";NameQuest="SnowQuest";QuestLv=1;NameMon="Snow Bandit"
            CFrameQ=CFrame.new(1386.8073730469,87.272789001465,-1298.3576660156)
            CFrameMon=CFrame.new(1356.3028564453,105.76865386963,-1328.2418212891)
        elseif Lv <= 119 then
            Ms="Snowman";NameQuest="SnowQuest";QuestLv=2;NameMon="Snowman"
            CFrameQ=CFrame.new(1386.8073730469,87.272789001465,-1298.3576660156)
            CFrameMon=CFrame.new(1218.7956542969,138.01184082031,-1488.0262451172)
        elseif Lv <= 149 then
            Ms="Chief Petty Officer";NameQuest="MarineQuest2";QuestLv=1;NameMon="Chief Petty Officer"
            CFrameQ=CFrame.new(-5035.49609375,28.677835464478,4324.1840820313)
            CFrameMon=CFrame.new(-4931.1552734375,65.793113708496,4121.8393554688)
        elseif Lv <= 174 then
            Ms="Sky Bandit";NameQuest="SkyQuest";QuestLv=1;NameMon="Sky Bandit"
            CFrameQ=CFrame.new(-4842.1372070313,717.69543457031,-2623.0483398438)
            CFrameMon=CFrame.new(-4955.6411132813,365.46365356445,-2908.1865234375)
        elseif Lv <= 189 then
            Ms="Dark Master";NameQuest="SkyQuest";QuestLv=2;NameMon="Dark Master"
            CFrameQ=CFrame.new(-4842.1372070313,717.69543457031,-2623.0483398438)
            CFrameMon=CFrame.new(-5148.1650390625,439.04571533203,-2332.9611816406)
        elseif Lv <= 209 then
            Ms="Prisoner";NameQuest="PrisonerQuest";QuestLv=1;NameMon="Prisoner"
            CFrameQ=CFrame.new(5310.60547,0.350014925,474.946594)
            CFrameMon=CFrame.new(4937.31885,0.332031399,649.574524)
        elseif Lv <= 249 then
            Ms="Dangerous Prisoner";NameQuest="PrisonerQuest";QuestLv=2;NameMon="Dangerous Prisoner"
            CFrameQ=CFrame.new(5310.60547,0.350014925,474.946594)
            CFrameMon=CFrame.new(5099.6626,0.351562679,1055.7583)
        elseif Lv <= 274 then
            Ms="Toga Warrior";NameQuest="ColosseumQuest";QuestLv=1;NameMon="Toga Warrior"
            CFrameQ=CFrame.new(-1577.7890625,7.4151420593262,-2984.4838867188)
            CFrameMon=CFrame.new(-1872.5166015625,49.080215454102,-2913.810546875)
        elseif Lv <= 299 then
            Ms="Gladiator";NameQuest="ColosseumQuest";QuestLv=2;NameMon="Gladiator"
            CFrameQ=CFrame.new(-1577.7890625,7.4151420593262,-2984.4838867188)
            CFrameMon=CFrame.new(-1521.3740234375,81.203170776367,-3066.3139648438)
        elseif Lv <= 324 then
            Ms="Military Soldier";NameQuest="MagmaQuest";QuestLv=1;NameMon="Military Soldier"
            CFrameQ=CFrame.new(-5316.1157226563,12.262831687927,8517.00390625)
            CFrameMon=CFrame.new(-5369.0004882813,61.24352645874,8556.4921875)
        elseif Lv <= 374 then
            Ms="Military Spy";NameQuest="MagmaQuest";QuestLv=2;NameMon="Military Spy"
            CFrameQ=CFrame.new(-5316.1157226563,12.262831687927,8517.00390625)
            CFrameMon=CFrame.new(-5787.00293,75.8262634,8651.69922)
        elseif Lv <= 399 then
            Ms="Fishman Warrior";NameQuest="FishmanQuest";QuestLv=1;NameMon="Fishman Warrior"
            CFrameQ=CFrame.new(61122.65234375,18.497442245483,1569.3997802734)
            CFrameMon=CFrame.new(60844.10546875,98.462875366211,1298.3985595703)
            if _G.AutoLevel and (CFrameMon.Position-hrp.Position).Magnitude>3000 then
                CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625,11.6796875,1819.7841796875))
            end
        elseif Lv <= 449 then
            Ms="Fishman Commando";NameQuest="FishmanQuest";QuestLv=2;NameMon="Fishman Commando"
            CFrameQ=CFrame.new(61122.65234375,18.497442245483,1569.3997802734)
            CFrameMon=CFrame.new(61738.3984375,64.207321166992,1433.8375244141)
            if _G.AutoLevel and (CFrameMon.Position-hrp.Position).Magnitude>3000 then
                CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625,11.6796875,1819.7841796875))
            end
        elseif Lv <= 474 then
            Ms="God's Guard";NameQuest="SkyExp1Quest";QuestLv=1;NameMon="God's Guard"
            CFrameQ=CFrame.new(-4721.8603515625,845.30297851563,-1953.8489990234)
            CFrameMon=CFrame.new(-4628.0498046875,866.92877197266,-1931.2352294922)
            if _G.AutoLevel and (CFrameMon.Position-hrp.Position).Magnitude>3000 then
                CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275,872.54248,-1667.55688))
            end
        elseif Lv <= 524 then
            Ms="Shanda";NameQuest="SkyExp1Quest";QuestLv=2;NameMon="Shanda"
            CFrameQ=CFrame.new(-7863.1596679688,5545.5190429688,-378.42266845703)
            CFrameMon=CFrame.new(-7685.1474609375,5601.0751953125,-441.38876342773)
            if _G.AutoLevel and (CFrameMon.Position-hrp.Position).Magnitude>3000 then
                CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813,5547.1416015625,-380.29119873047))
            end
        elseif Lv <= 549 then
            Ms="Royal Squad";NameQuest="SkyExp2Quest";QuestLv=1;NameMon="Royal Squad"
            CFrameQ=CFrame.new(-7903.3828125,5635.9897460938,-1410.923828125)
            CFrameMon=CFrame.new(-7654.2514648438,5637.1079101563,-1407.7550048828)
        elseif Lv <= 624 then
            Ms="Royal Soldier";NameQuest="SkyExp2Quest";QuestLv=2;NameMon="Royal Soldier"
            CFrameQ=CFrame.new(-7903.3828125,5635.9897460938,-1410.923828125)
            CFrameMon=CFrame.new(-7760.4106445313,5679.9077148438,-1884.8112792969)
        elseif Lv <= 649 then
            Ms="Galley Pirate";NameQuest="FountainQuest";QuestLv=1;NameMon="Galley Pirate"
            CFrameQ=CFrame.new(5258.2788085938,38.526931762695,4050.044921875)
            CFrameMon=CFrame.new(5557.1684570313,152.32717895508,3998.7758789063)
        else
            Ms="Galley Captain";NameQuest="FountainQuest";QuestLv=2;NameMon="Galley Captain"
            CFrameQ=CFrame.new(5258.2788085938,38.526931762695,4050.044921875)
            CFrameMon=CFrame.new(5677.6772460938,92.786109924316,4966.6323242188)
        end
    end
    if Second_Sea then
        if Lv <= 724 then
            Ms="Raider";NameQuest="Area1Quest";QuestLv=1;NameMon="Raider"
            CFrameQ=CFrame.new(-427.72567749023,72.99634552002,1835.9426269531)
            CFrameMon=CFrame.new(68.874565124512,93.635643005371,2429.6752929688)
        elseif Lv <= 774 then
            Ms="Mercenary";NameQuest="Area1Quest";QuestLv=2;NameMon="Mercenary"
            CFrameQ=CFrame.new(-427.72567749023,72.99634552002,1835.9426269531)
            CFrameMon=CFrame.new(-864.85009765625,122.47104644775,1453.1505126953)
        elseif Lv <= 799 then
            Ms="Swan Pirate";NameQuest="Area2Quest";QuestLv=1;NameMon="Swan Pirate"
            CFrameQ=CFrame.new(635.61151123047,73.096351623535,917.81298828125)
            CFrameMon=CFrame.new(1065.3669433594,137.64012145996,1324.3798828125)
        elseif Lv <= 874 then
            Ms="Factory Staff";NameQuest="Area2Quest";QuestLv=2;NameMon="Factory Staff"
            CFrameQ=CFrame.new(635.61151123047,73.096351623535,917.81298828125)
            CFrameMon=CFrame.new(533.22045898438,128.46876525879,355.62615966797)
        elseif Lv <= 899 then
            Ms="Marine Lieutenant";NameQuest="MarineQuest3";QuestLv=1;NameMon="Marine Lieutenant"
            CFrameQ=CFrame.new(-2440.9934082031,73.04190826416,-3217.7082519531)
            CFrameMon=CFrame.new(-2489.2622070313,84.613594055176,-3151.8830566406)
        elseif Lv <= 949 then
            Ms="Marine Captain";NameQuest="MarineQuest3";QuestLv=2;NameMon="Marine Captain"
            CFrameQ=CFrame.new(-2440.9934082031,73.04190826416,-3217.7082519531)
            CFrameMon=CFrame.new(-2335.2026367188,79.786659240723,-3245.8674316406)
        elseif Lv <= 974 then
            Ms="Zombie";NameQuest="ZombieQuest";QuestLv=1;NameMon="Zombie"
            CFrameQ=CFrame.new(-5494.3413085938,48.505931854248,-794.59094238281)
            CFrameMon=CFrame.new(-5536.4970703125,101.08577728271,-835.59075927734)
        elseif Lv <= 999 then
            Ms="Vampire";NameQuest="ZombieQuest";QuestLv=2;NameMon="Vampire"
            CFrameQ=CFrame.new(-5494.3413085938,48.505931854248,-794.59094238281)
            CFrameMon=CFrame.new(-5806.1098632813,16.722528457642,-1164.4384765625)
        elseif Lv <= 1049 then
            Ms="Snow Trooper";NameQuest="SnowMountainQuest";QuestLv=1;NameMon="Snow Trooper"
            CFrameQ=CFrame.new(607.05963134766,401.44781494141,-5370.5546875)
            CFrameMon=CFrame.new(535.21051025391,432.74209594727,-5484.9165039063)
        elseif Lv <= 1099 then
            Ms="Winter Warrior";NameQuest="SnowMountainQuest";QuestLv=2;NameMon="Winter Warrior"
            CFrameQ=CFrame.new(607.05963134766,401.44781494141,-5370.5546875)
            CFrameMon=CFrame.new(1234.4449462891,456.95419311523,-5174.130859375)
        elseif Lv <= 1124 then
            Ms="Lab Subordinate";NameQuest="IceSideQuest";QuestLv=1;NameMon="Lab Subordinate"
            CFrameQ=CFrame.new(-6061.841796875,15.926671981812,-4902.0385742188)
            CFrameMon=CFrame.new(-5720.5576171875,63.309471130371,-4784.6103515625)
        elseif Lv <= 1174 then
            Ms="Horned Warrior";NameQuest="IceSideQuest";QuestLv=2;NameMon="Horned Warrior"
            CFrameQ=CFrame.new(-6061.841796875,15.926671981812,-4902.0385742188)
            CFrameMon=CFrame.new(-6292.751953125,91.181983947754,-5502.6499023438)
        elseif Lv <= 1199 then
            Ms="Magma Ninja";NameQuest="FireSideQuest";QuestLv=1;NameMon="Magma Ninja"
            CFrameQ=CFrame.new(-5429.0473632813,15.977565765381,-5297.9614257813)
            CFrameMon=CFrame.new(-5461.8388671875,130.36347961426,-5836.4702148438)
        elseif Lv <= 1249 then
            Ms="Lava Pirate";NameQuest="FireSideQuest";QuestLv=2;NameMon="Lava Pirate"
            CFrameQ=CFrame.new(-5429.0473632813,15.977565765381,-5297.9614257813)
            CFrameMon=CFrame.new(-5251.1889648438,55.164535522461,-4774.4096679688)
        elseif Lv <= 1274 then
            Ms="Ship Deckhand";NameQuest="ShipQuest1";QuestLv=1;NameMon="Ship Deckhand"
            CFrameQ=CFrame.new(1040.2927246094,125.08293151855,32911.0390625)
            CFrameMon=CFrame.new(921.12365722656,125.9839553833,33088.328125)
            if _G.AutoLevel and (CFrameMon.Position-hrp.Position).Magnitude>20000 then
                CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406,126.9760055542,32852.83203125))
            end
        elseif Lv <= 1299 then
            Ms="Ship Engineer";NameQuest="ShipQuest1";QuestLv=2;NameMon="Ship Engineer"
            CFrameQ=CFrame.new(1040.2927246094,125.08293151855,32911.0390625)
            CFrameMon=CFrame.new(886.28179931641,40.47790145874,32800.83203125)
            if _G.AutoLevel and (CFrameMon.Position-hrp.Position).Magnitude>20000 then
                CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406,126.9760055542,32852.83203125))
            end
        elseif Lv <= 1324 then
            Ms="Ship Steward";NameQuest="ShipQuest2";QuestLv=1;NameMon="Ship Steward"
            CFrameQ=CFrame.new(971.42065429688,125.08293151855,33245.54296875)
            CFrameMon=CFrame.new(943.85504150391,129.58183288574,33444.3671875)
            if _G.AutoLevel and (CFrameMon.Position-hrp.Position).Magnitude>20000 then
                CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406,126.9760055542,32852.83203125))
            end
        elseif Lv <= 1349 then
            Ms="Ship Officer";NameQuest="ShipQuest2";QuestLv=2;NameMon="Ship Officer"
            CFrameQ=CFrame.new(971.42065429688,125.08293151855,33245.54296875)
            CFrameMon=CFrame.new(955.38458251953,181.08335876465,33331.890625)
            if _G.AutoLevel and (CFrameMon.Position-hrp.Position).Magnitude>20000 then
                CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406,126.9760055542,32852.83203125))
            end
        elseif Lv <= 1374 then
            Ms="Arctic Warrior";NameQuest="FrostQuest";QuestLv=1;NameMon="Arctic Warrior"
            CFrameQ=CFrame.new(5668.1372070313,28.202531814575,-6484.6005859375)
            CFrameMon=CFrame.new(5935.4541015625,77.26016998291,-6472.7568359375)
        elseif Lv <= 1424 then
            Ms="Snow Lurker";NameQuest="FrostQuest";QuestLv=2;NameMon="Snow Lurker"
            CFrameQ=CFrame.new(5668.1372070313,28.202531814575,-6484.6005859375)
            CFrameMon=CFrame.new(5628.482421875,57.574996948242,-6618.3481445313)
        elseif Lv <= 1449 then
            Ms="Sea Soldier";NameQuest="ForgottenQuest";QuestLv=1;NameMon="Sea Soldier"
            CFrameQ=CFrame.new(-3054.5827636719,236.87213134766,-10147.790039063)
            CFrameMon=CFrame.new(-3185.0153808594,58.789089202881,-9663.6064453125)
        else
            Ms="Water Fighter";NameQuest="ForgottenQuest";QuestLv=2;NameMon="Water Fighter"
            CFrameQ=CFrame.new(-3054.5827636719,236.87213134766,-10147.790039063)
            CFrameMon=CFrame.new(-3262.9301757813,298.69036865234,-10552.529296875)
        end
    end
    if Third_Sea then
        if Lv <= 1524 then
            Ms="Pirate Millionaire";NameQuest="PiratePortQuest";QuestLv=1;NameMon="Pirate Millionaire"
            CFrameQ=CFrame.new(-289.61752319336,43.819011688232,5580.0903320313)
            CFrameMon=CFrame.new(-435.68109130859,189.69866943359,5551.0756835938)
        elseif Lv <= 1574 then
            Ms="Pistol Billionaire";NameQuest="PiratePortQuest";QuestLv=2;NameMon="Pistol Billionaire"
            CFrameQ=CFrame.new(-289.61752319336,43.819011688232,5580.0903320313)
            CFrameMon=CFrame.new(-236.53652954102,217.46676635742,6006.0883789063)
        elseif Lv <= 1599 then
            Ms="Dragon Crew Warrior";NameQuest="AmazonQuest";QuestLv=1;NameMon="Dragon Crew Warrior"
            CFrameQ=CFrame.new(5833.1147460938,51.60498046875,-1103.0693359375)
            CFrameMon=CFrame.new(6301.9975585938,104.77153015137,-1082.6075439453)
        elseif Lv <= 1624 then
            Ms="Dragon Crew Archer";NameQuest="AmazonQuest";QuestLv=2;NameMon="Dragon Crew Archer"
            CFrameQ=CFrame.new(5833.1147460938,51.60498046875,-1103.0693359375)
            CFrameMon=CFrame.new(6831.1171875,441.76708984375,446.58615112305)
        elseif Lv <= 1649 then
            Ms="Female Islander";NameQuest="AmazonQuest2";QuestLv=1;NameMon="Female Islander"
            CFrameQ=CFrame.new(5446.8793945313,601.62945556641,749.45672607422)
            CFrameMon=CFrame.new(5792.5166015625,848.14392089844,1084.1818847656)
        elseif Lv <= 1699 then
            Ms="Giant Islander";NameQuest="AmazonQuest2";QuestLv=2;NameMon="Giant Islander"
            CFrameQ=CFrame.new(5446.8793945313,601.62945556641,749.45672607422)
            CFrameMon=CFrame.new(5009.5068359375,664.11071777344,-40.960144042969)
        elseif Lv <= 1724 then
            Ms="Marine Commodore";NameQuest="MarineTreeIsland";QuestLv=1;NameMon="Marine Commodore"
            CFrameQ=CFrame.new(2179.98828125,28.731239318848,-6740.0551757813)
            CFrameMon=CFrame.new(2198.0063476563,128.71075439453,-7109.5043945313)
        elseif Lv <= 1774 then
            Ms="Marine Rear Admiral";NameQuest="MarineTreeIsland";QuestLv=2;NameMon="Marine Rear Admiral"
            CFrameQ=CFrame.new(2179.98828125,28.731239318848,-6740.0551757813)
            CFrameMon=CFrame.new(3294.3142089844,385.41125488281,-7048.6342773438)
        elseif Lv <= 1799 then
            Ms="Fishman Raider";NameQuest="DeepForestIsland3";QuestLv=1;NameMon="Fishman Raider"
            CFrameQ=CFrame.new(-10582.759765625,331.78845214844,-8757.666015625)
            CFrameMon=CFrame.new(-10553.268554688,521.38439941406,-8176.9458007813)
        elseif Lv <= 1824 then
            Ms="Fishman Captain";NameQuest="DeepForestIsland3";QuestLv=2;NameMon="Fishman Captain"
            CFrameQ=CFrame.new(-10583.099609375,331.78845214844,-8759.4638671875)
            CFrameMon=CFrame.new(-10789.401367188,427.18637084961,-9131.4423828125)
        elseif Lv <= 1849 then
            Ms="Forest Pirate";NameQuest="DeepForestIsland";QuestLv=1;NameMon="Forest Pirate"
            CFrameQ=CFrame.new(-13232.662109375,332.40396118164,-7626.4819335938)
            CFrameMon=CFrame.new(-13489.397460938,400.30349731445,-7770.251953125)
        elseif Lv <= 1899 then
            Ms="Mythological Pirate";NameQuest="DeepForestIsland";QuestLv=2;NameMon="Mythological Pirate"
            CFrameQ=CFrame.new(-13232.662109375,332.40396118164,-7626.4819335938)
            CFrameMon=CFrame.new(-13508.616210938,582.46228027344,-6985.3037109375)
        elseif Lv <= 1924 then
            Ms="Jungle Pirate";NameQuest="DeepForestIsland2";QuestLv=1;NameMon="Jungle Pirate"
            CFrameQ=CFrame.new(-12682.096679688,390.88653564453,-9902.1240234375)
            CFrameMon=CFrame.new(-12267.103515625,459.75262451172,-10277.200195313)
        elseif Lv <= 1974 then
            Ms="Musketeer Pirate";NameQuest="DeepForestIsland2";QuestLv=2;NameMon="Musketeer Pirate"
            CFrameQ=CFrame.new(-12682.096679688,390.88653564453,-9902.1240234375)
            CFrameMon=CFrame.new(-13291.5078125,520.47338867188,-9904.638671875)
        elseif Lv <= 1999 then
            Ms="Reborn Skeleton";NameQuest="HauntedQuest1";QuestLv=1;NameMon="Reborn Skeleton"
            CFrameQ=CFrame.new(-9480.80762,142.130661,5566.37305)
            CFrameMon=CFrame.new(-8761.77148,183.431747,6168.33301)
        elseif Lv <= 2024 then
            Ms="Living Zombie";NameQuest="HauntedQuest1";QuestLv=2;NameMon="Living Zombie"
            CFrameQ=CFrame.new(-9480.80762,142.130661,5566.37305)
            CFrameMon=CFrame.new(-10103.7529,238.565979,6179.75977)
        elseif Lv <= 2049 then
            Ms="Demonic Soul";NameQuest="HauntedQuest2";QuestLv=1;NameMon="Demonic Soul"
            CFrameQ=CFrame.new(-9516.9931640625,178.00651550293,6078.4653320313)
            CFrameMon=CFrame.new(-9712.03125,204.69589233398,6193.322265625)
        elseif Lv <= 2074 then
            Ms="Posessed Mummy";NameQuest="HauntedQuest2";QuestLv=2;NameMon="Posessed Mummy"
            CFrameQ=CFrame.new(-9516.9931640625,178.00651550293,6078.4653320313)
            CFrameMon=CFrame.new(-9545.7763671875,69.619895935059,6339.5615234375)
        elseif Lv <= 2099 then
            Ms="Peanut Scout";NameQuest="NutsIslandQuest";QuestLv=1;NameMon="Peanut Scout"
            CFrameQ=CFrame.new(-2105.53198,37.2495995,-10195.5088)
            CFrameMon=CFrame.new(-2150.587890625,122.49767303467,-10358.994140625)
        elseif Lv <= 2124 then
            Ms="Peanut President";NameQuest="NutsIslandQuest";QuestLv=2;NameMon="Peanut President"
            CFrameQ=CFrame.new(-2105.53198,37.2495995,-10195.5088)
            CFrameMon=CFrame.new(-2150.587890625,122.49767303467,-10358.994140625)
        elseif Lv <= 2149 then
            Ms="Ice Cream Chef";NameQuest="IceCreamIslandQuest";QuestLv=1;NameMon="Ice Cream Chef"
            CFrameQ=CFrame.new(-819.376709,64.9259796,-10967.2832)
            CFrameMon=CFrame.new(-789.941528,209.382889,-11009.9805)
        elseif Lv <= 2199 then
            Ms="Ice Cream Commander";NameQuest="IceCreamIslandQuest";QuestLv=2;NameMon="Ice Cream Commander"
            CFrameQ=CFrame.new(-819.376709,64.9259796,-10967.2832)
            CFrameMon=CFrame.new(-789.941528,209.382889,-11009.9805)
        elseif Lv <= 2224 then
            Ms="Cookie Crafter";NameQuest="CakeQuest1";QuestLv=1;NameMon="Cookie Crafter"
            CFrameQ=CFrame.new(-2022.29858,36.9275894,-12030.9766)
            CFrameMon=CFrame.new(-2321.71216,36.699482,-12216.7871)
        elseif Lv <= 2249 then
            Ms="Cake Guard";NameQuest="CakeQuest1";QuestLv=2;NameMon="Cake Guard"
            CFrameQ=CFrame.new(-2022.29858,36.9275894,-12030.9766)
            CFrameMon=CFrame.new(-1418.11011,36.6718941,-12255.7324)
        elseif Lv <= 2274 then
            Ms="Baking Staff";NameQuest="CakeQuest2";QuestLv=1;NameMon="Baking Staff"
            CFrameQ=CFrame.new(-1928.31763,37.7296638,-12840.626)
            CFrameMon=CFrame.new(-1980.43848,36.6716766,-12983.8418)
        elseif Lv <= 2299 then
            Ms="Head Baker";NameQuest="CakeQuest2";QuestLv=2;NameMon="Head Baker"
            CFrameQ=CFrame.new(-1928.31763,37.7296638,-12840.626)
            CFrameMon=CFrame.new(-2251.5791,52.2714615,-13033.3965)
        elseif Lv <= 2324 then
            Ms="Cocoa Warrior";NameQuest="ChocQuest1";QuestLv=1;NameMon="Cocoa Warrior"
            CFrameQ=CFrame.new(231.75,23.9003029,-12200.292)
            CFrameMon=CFrame.new(167.978516,26.2254658,-12238.874)
        elseif Lv <= 2349 then
            Ms="Chocolate Bar Battler";NameQuest="ChocQuest1";QuestLv=2;NameMon="Chocolate Bar Battler"
            CFrameQ=CFrame.new(231.75,23.9003029,-12200.292)
            CFrameMon=CFrame.new(701.312073,25.5824986,-12708.2148)
        elseif Lv <= 2374 then
            Ms="Sweet Thief";NameQuest="ChocQuest2";QuestLv=1;NameMon="Sweet Thief"
            CFrameQ=CFrame.new(151.198242,23.8907146,-12774.6172)
            CFrameMon=CFrame.new(-140.258301,25.5824986,-12652.3115)
        elseif Lv <= 2400 then
            Ms="Candy Rebel";NameQuest="ChocQuest2";QuestLv=2;NameMon="Candy Rebel"
            CFrameQ=CFrame.new(151.198242,23.8907146,-12774.6172)
            CFrameMon=CFrame.new(47.9231453,25.5824986,-13029.2402)
        elseif Lv <= 2449 then
            Ms="Candy Pirate";NameQuest="CandyQuest1";QuestLv=1;NameMon="Candy Pirate"
            CFrameQ=CFrame.new(-1149.328,13.5759039,-14445.6143)
            CFrameMon=CFrame.new(-1437.56348,17.1481285,-14385.6934)
        elseif Lv <= 2474 then
            Ms="Isle Outlaw";NameQuest="TikiQuest1";QuestLv=1;NameMon="Isle Outlaw"
            CFrameQ=CFrame.new(-16549.890625,55.68635559082031,-179.91360473632812)
            CFrameMon=CFrame.new(-16162.8193359375,11.6863374710083,-96.45481872558594)
        elseif Lv <= 2524 then
            Ms="Island Boy";NameQuest="TikiQuest1";QuestLv=2;NameMon="Island Boy"
            CFrameQ=CFrame.new(-16549.890625,55.68635559082031,-179.91360473632812)
            CFrameMon=CFrame.new(-16912.130859375,11.787443161010742,-133.0850830078125)
        else
            Ms="Isle Champion";NameQuest="TikiQuest2";QuestLv=2;NameMon="Isle Champion"
            CFrameQ=CFrame.new(-16542.447265625,55.68632888793945,1044.41650390625)
            CFrameMon=CFrame.new(-16848.94140625,21.68633460998535,1041.4490966796875)
        end
    end
end

-- ─── AUTO FARM LOOP (BYTE HUB CODE) ────────────────────────────────────
spawn(function()
    while task.wait() do
        if _G.AutoLevel then
            pcall(function()
                CheckLevel()
                if not string.find(lp.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon)
                or lp.PlayerGui.Main.Quest.Visible == false then
                    CommF_:InvokeServer("AbandonQuest")
                    toTarget(CFrameQ)
                    if (CFrameQ.Position - hrp.Position).Magnitude <= 5 then
                        CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                    end
                elseif string.find(lp.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon)
                or lp.PlayerGui.Main.Quest.Visible == true then
                    for _,v in pairs(Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart")
                        and v.Humanoid.Health > 0 and v.Name == Ms then
                            repeat task.wait(_G.Fast_Delay)
                                AttackNoCoolDown()
                                bringmob = true
                                AutoHaki()
                                EquipTool(SelectWeapon)
                                Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid.JumpPower = 0
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.CanCollide = false
                                FarmPos = v.HumanoidRootPart.CFrame
                                MonFarm = v.Name
                            until not _G.AutoLevel or not v.Parent or v.Humanoid.Health <= 0
                            or not Enemies:FindFirstChild(v.Name)
                            or lp.PlayerGui.Main.Quest.Visible == false
                            bringmob = false
                        end
                    end
                    for _,v in pairs(workspace["_WorldOrigin"].EnemySpawns:GetChildren()) do
                        if string.find(v.Name, NameMon) then
                            if (hrp.Position - v.Position).Magnitude >= 10 then
                                Tween(v.CFrame * CFrame.new(posX,posY,posZ))
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Kill Near Mob Aura (Byte Hub code)
spawn(function()
    while task.wait(0.1) do
        if _G.AutoNear then
            pcall(function()
                for _,v in pairs(Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart")
                    and v.Humanoid.Health > 0
                    and (hrp.Position - v.HumanoidRootPart.Position).Magnitude <= 5000 then
                        repeat task.wait(_G.Fast_Delay)
                            AttackNoCoolDown()
                            bringmob = true
                            AutoHaki()
                            EquipTool(SelectWeapon)
                            Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                            v.HumanoidRootPart.Transparency = 1
                            v.Humanoid.JumpPower = 0
                            v.Humanoid.WalkSpeed = 0
                            v.HumanoidRootPart.CanCollide = false
                            FarmPos = v.HumanoidRootPart.CFrame
                            MonFarm = v.Name
                        until not _G.AutoNear or not v.Parent or v.Humanoid.Health <= 0
                        or not Enemies:FindFirstChild(v.Name)
                        bringmob = false
                    end
                end
            end)
        end
    end
end)

-- Auto Boss (Byte Hub code)
spawn(function()
    while task.wait() do
        if _G.AutoBoss then
            pcall(function()
                if Enemies:FindFirstChild(SelectBoss) then
                    for _,v in pairs(Enemies:GetChildren()) do
                        if v.Name == SelectBoss and v:FindFirstChild("Humanoid")
                        and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            repeat task.wait(_G.Fast_Delay)
                                AttackNoCoolDown()
                                AutoHaki()
                                EquipTool(SelectWeapon)
                                v.HumanoidRootPart.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Size = Vector3.new(80,80,80)
                                Tween(v.HumanoidRootPart.CFrame * Pos)
                                sethiddenproperty(lp,"SimulationRadius",math.huge)
                            until not _G.AutoBoss or not v.Parent or v.Humanoid.Health <= 0
                        end
                    end
                elseif RS:FindFirstChild(SelectBoss) then
                    local bossRS = RS:FindFirstChild(SelectBoss)
                    if bossRS:FindFirstChild("HumanoidRootPart") then
                        toTarget(bossRS.HumanoidRootPart.CFrame * CFrame.new(5,10,7))
                    end
                end
            end)
        end
    end
end)

-- Auto Castle Raid (Byte Hub code)
spawn(function()
    while task.wait() do
        if _G.CastleRaid then
            pcall(function()
                local CFrameCastleRaid = CFrame.new(-5496.17432,313.768921,-2841.53027)
                if (CFrame.new(-5539.3115234375,313.800537109375,-2972.372314453125).Position - hrp.Position).Magnitude <= 500 then
                    for _,v in pairs(Enemies:GetChildren()) do
                        if _G.CastleRaid and v:FindFirstChild("HumanoidRootPart")
                        and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0
                        and (v.HumanoidRootPart.Position - hrp.Position).Magnitude < 2000 then
                            repeat task.wait(_G.Fast_Delay)
                                AttackNoCoolDown()
                                AutoHaki()
                                EquipTool(SelectWeapon)
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                            until v.Humanoid.Health <= 0 or not v.Parent or not _G.CastleRaid
                        end
                    end
                else
                    toTarget(CFrameCastleRaid)
                end
            end)
        end
    end
end)

-- Mastery Skill Fire
spawn(function()
    while task.wait(1) do
        if _G_UseSkill then
            pcall(function()
                for _,v in pairs(Enemies:GetChildren()) do
                    if v.Name == MonFarm and v:FindFirstChild("Humanoid")
                    and v:FindFirstChild("HumanoidRootPart")
                    and v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                        repeat task.wait()
                            EquipTool(lp.Data.DevilFruit.Value)
                            Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                            PositionSkillMasteryDevilFruit = v.HumanoidRootPart.Position
                            local df = char:FindFirstChild(lp.Data.DevilFruit.Value)
                            local dfLevel = df and df:FindFirstChild("Level") and df.Level.Value or 0
                            if df then df.MousePos.Value = PositionSkillMasteryDevilFruit end
                            if SkillZ and dfLevel >= 1 then VIM:SendKeyEvent(true,"Z",false,game); task.wait(0.1); VIM:SendKeyEvent(false,"Z",false,game) end
                            if SkillX and dfLevel >= 2 then VIM:SendKeyEvent(true,"X",false,game); task.wait(0.2); VIM:SendKeyEvent(false,"X",false,game) end
                            if SkillC and dfLevel >= 3 then VIM:SendKeyEvent(true,"C",false,game); task.wait(0.3); VIM:SendKeyEvent(false,"C",false,game) end
                            if SkillV and dfLevel >= 4 then VIM:SendKeyEvent(true,"V",false,game); task.wait(0.4); VIM:SendKeyEvent(false,"V",false,game) end
                            if SkillF and dfLevel >= 5 then VIM:SendKeyEvent(true,"F",false,game); task.wait(0.5); VIM:SendKeyEvent(false,"F",false,game) end
                        until not AutoFarmMasDevilFruit or not _G_UseSkill or v.Humanoid.Health == 0
                    end
                end
            end)
        end
    end
end)

-- Auto Mastery Loop (Byte Hub code)
spawn(function()
    while task.wait(0.1) do
        if AutoFarmMasDevilFruit and TypeMastery == "Level" then
            pcall(function()
                CheckLevel()
                if not string.find(lp.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon)
                or lp.PlayerGui.Main.Quest.Visible == false then
                    CommF_:InvokeServer("AbandonQuest")
                    toTarget(CFrameQ)
                    if (CFrameQ.Position - hrp.Position).Magnitude <= 5 then
                        CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                    end
                elseif lp.PlayerGui.Main.Quest.Visible == true then
                    for _,v in pairs(Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name == Ms then
                            bringmob = true
                            repeat task.wait(_G.Fast_Delay)
                                if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                    _G_UseSkill = true
                                else
                                    _G_UseSkill = false
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid.JumpPower = 0
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.CanCollide = false
                                    FarmPos = v.HumanoidRootPart.CFrame
                                    MonFarm = v.Name
                                    NormalAttack()
                                end
                            until not AutoFarmMasDevilFruit or not v.Parent or v.Humanoid.Health == 0
                            or lp.PlayerGui.Main.Quest.Visible == false
                            bringmob  = false
                            _G_UseSkill = false
                        end
                    end
                end
            end)
        elseif AutoFarmMasDevilFruit and TypeMastery == "Near Mobs" then
            pcall(function()
                for _,v in pairs(Enemies:GetChildren()) do
                    if v.Name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart")
                    and (hrp.Position - v.HumanoidRootPart.Position).Magnitude <= 5000 then
                        bringmob = true
                        repeat task.wait(_G.Fast_Delay)
                            if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                _G_UseSkill = true
                            else
                                _G_UseSkill = false
                                AutoHaki()
                                EquipTool(SelectWeapon)
                                Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid.JumpPower = 0
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.CanCollide = false
                                FarmPos = v.HumanoidRootPart.CFrame
                                MonFarm = v.Name
                                NormalAttack()
                            end
                        until not AutoFarmMasDevilFruit or not v.Parent or v.Humanoid.Health == 0
                        or TypeMastery ~= "Near Mobs"
                        bringmob  = false
                        _G_UseSkill = false
                    end
                end
            end)
        end
    end
end)

-- Auto Bone (Byte Hub code - Third Sea only)
if Third_Sea then
    local BoneCFrame = CFrame.new(-9515.75,174.8521728515625,6079.40625)
    spawn(function()
        while task.wait() do
            if _G.AutoBone then
                pcall(function()
                    local QuestTitle = lp.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                    if not string.find(QuestTitle,"Demonic Soul") then
                        CommF_:InvokeServer("AbandonQuest")
                    end
                    if lp.PlayerGui.Main.Quest.Visible == false then
                        toTarget(BoneCFrame)
                        if (BoneCFrame.Position - hrp.Position).Magnitude <= 3 then
                            CommF_:InvokeServer("StartQuest","HauntedQuest2",1)
                        end
                    elseif lp.PlayerGui.Main.Quest.Visible == true then
                        if Enemies:FindFirstChild("Reborn Skeleton") or Enemies:FindFirstChild("Living Zombie")
                        or Enemies:FindFirstChild("Demonic Soul") or Enemies:FindFirstChild("Posessed Mummy") then
                            for _,v in pairs(Enemies:GetChildren()) do
                                if (v.Name=="Reborn Skeleton" or v.Name=="Living Zombie"
                                or v.Name=="Demonic Soul" or v.Name=="Posessed Mummy")
                                and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                    if string.find(QuestTitle,"Demonic Soul") then
                                        repeat task.wait(_G.Fast_Delay)
                                            AttackNoCoolDown()
                                            AutoHaki()
                                            bringmob = true
                                            EquipTool(SelectWeapon)
                                            Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                            v.Humanoid.JumpPower = 0
                                            v.Humanoid.WalkSpeed = 0
                                            v.HumanoidRootPart.CanCollide = false
                                            FarmPos = v.HumanoidRootPart.CFrame
                                            MonFarm = v.Name
                                        until not _G.AutoBone or v.Humanoid.Health <= 0
                                        or not v.Parent or lp.PlayerGui.Main.Quest.Visible == false
                                        bringmob = false
                                    else
                                        CommF_:InvokeServer("AbandonQuest")
                                        bringmob = false
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)

    spawn(function()
        while task.wait(0.0000001) do
            if _G.AutoRandomBone then
                CommF_:InvokeServer("Bones","Buy",1,1)
            end
        end
    end)
end

-- Auto Cake Prince (Byte Hub code - Third Sea)
if Third_Sea then
    spawn(function()
        while task.wait() do
            if _G.CakePrince then
                pcall(function()
                    local CakeCFrame = CFrame.new(-2142.66821,71.2588654,-12327.4619)
                    toTarget(CakeCFrame)
                    if RS:FindFirstChild("Cake Prince") or Enemies:FindFirstChild("Cake Prince") then
                        if Enemies:FindFirstChild("Cake Prince") then
                            for _,v in pairs(Enemies:GetChildren()) do
                                if v.Name == "Cake Prince" then
                                    repeat task.wait(_G.Fast_Delay)
                                        AttackNoCoolDown()
                                        AutoHaki()
                                        EquipTool(SelectWeapon)
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.CanCollide = false
                                        Tween(v.HumanoidRootPart.CFrame * Pos)
                                    until _G.CakePrince == false or not v.Parent or v.Humanoid.Health <= 0
                                    bringmob = false
                                end
                            end
                        else
                            Tween(CFrame.new(-2009.2802734375,4532.97216796875,-14937.3076171875))
                        end
                    else
                        if Enemies:FindFirstChild("Baking Staff") or Enemies:FindFirstChild("Head Baker")
                        or Enemies:FindFirstChild("Cake Guard") or Enemies:FindFirstChild("Cookie Crafter") then
                            for _,v in pairs(Enemies:GetChildren()) do
                                if (v.Name=="Baking Staff" or v.Name=="Head Baker"
                                or v.Name=="Cake Guard" or v.Name=="Cookie Crafter")
                                and v.Humanoid.Health > 0 then
                                    repeat task.wait(_G.Fast_Delay)
                                        AttackNoCoolDown()
                                        AutoHaki()
                                        bringmob = true
                                        EquipTool(SelectWeapon)
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        FarmPos  = v.HumanoidRootPart.CFrame
                                        MonFarm  = v.Name
                                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                    until _G.CakePrince == false or RS:FindFirstChild("Cake Prince")
                                    or not v.Parent or v.Humanoid.Health <= 0
                                    bringmob = false
                                end
                            end
                        else
                            Tween(CakeCFrame)
                        end
                    end
                end)
            end
        end
    end)

    spawn(function()
        while task.wait() do
            if _G.SpawnCakePrince then
                CommF_:InvokeServer("CakePrinceSpawner",true)
                CommF_:InvokeServer("CakePrinceSpawner")
            end
        end
    end)
end

-- Auto Elite Hunter (Byte Hub code - Third Sea)
if Third_Sea then
    spawn(function()
        while task.wait() do
            if _G.AutoElite then
                pcall(function()
                    if lp.PlayerGui.Main.Quest.Visible == true then
                        if string.find(lp.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Diablo")
                        or string.find(lp.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Deandre")
                        or string.find(lp.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Urban") then
                            if Enemies:FindFirstChild("Diablo") or Enemies:FindFirstChild("Deandre") or Enemies:FindFirstChild("Urban") then
                                for _,v in pairs(Enemies:GetChildren()) do
                                    if (v.Name=="Diablo" or v.Name=="Deandre" or v.Name=="Urban")
                                    and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart")
                                    and v.Humanoid.Health > 0 then
                                        repeat task.wait(_G.Fast_Delay)
                                            AttackNoCoolDown()
                                            EquipTool(SelectWeapon)
                                            AutoHaki()
                                            toTarget(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                            v.Humanoid.JumpPower = 0
                                            v.Humanoid.WalkSpeed = 0
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        until _G.AutoElite == false or v.Humanoid.Health <= 0 or not v.Parent
                                    end
                                end
                            else
                                if RS:FindFirstChild("Diablo") then
                                    toTarget(RS:FindFirstChild("Diablo").HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                elseif RS:FindFirstChild("Deandre") then
                                    toTarget(RS:FindFirstChild("Deandre").HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                elseif RS:FindFirstChild("Urban") then
                                    toTarget(RS:FindFirstChild("Urban").HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                end
                            end
                        end
                    else
                        CommF_:InvokeServer("EliteHunter")
                    end
                end)
            end
        end
    end)
end

-- Auto Ectoplasm (Byte Hub code - Second Sea)
if Second_Sea then
    spawn(function()
        while task.wait(0.1) do
            if _G.Ectoplasm then
                pcall(function()
                    if Enemies:FindFirstChild("Ship Deckhand") or Enemies:FindFirstChild("Ship Engineer")
                    or Enemies:FindFirstChild("Ship Steward") or Enemies:FindFirstChild("Ship Officer") then
                        for _,v in pairs(Enemies:GetChildren()) do
                            if (v.Name=="Ship Steward" or v.Name=="Ship Engineer"
                            or v.Name=="Ship Deckhand" or v.Name=="Ship Officer")
                            and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                repeat task.wait(_G.Fast_Delay)
                                    AttackNoCoolDown()
                                    AutoHaki()
                                    bringmob = true
                                    EquipTool(SelectWeapon)
                                    Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid.JumpPower = 0
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.CanCollide = false
                                    FarmPos = v.HumanoidRootPart.CFrame
                                    MonFarm = v.Name
                                until _G.Ectoplasm == false or not v.Parent or v.Humanoid.Health == 0
                                bringmob = false
                            end
                        end
                    else
                        local dist = (Vector3.new(904,181,33341) - hrp.Position).Magnitude
                        if dist > 20000 then
                            CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406,126.9760055542,32852.83203125))
                        end
                        Tween(CFrame.new(904.4072265625,181.05767822266,33341.38671875))
                    end
                end)
            end
        end
    end)
end

-- Auto Factory (Byte Hub code - Second Sea)
if Second_Sea then
    spawn(function()
        while task.wait() do
            if _G.Factory then
                if Enemies:FindFirstChild("Core") then
                    for _,v in pairs(Enemies:GetChildren()) do
                        if v.Name == "Core" and v.Humanoid.Health > 0 then
                            repeat task.wait(_G.Fast_Delay)
                                AttackNoCoolDown()
                                repeat Tween(CFrame.new(448.46756,199.356781,-441.389252)); task.wait()
                                until not _G.Factory or (hrp.Position-Vector3.new(448.46756,199.356781,-441.389252)).Magnitude <= 10
                                EquipTool(SelectWeapon)
                                AutoHaki()
                                Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid.JumpPower = 0
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.CanCollide = false
                                FarmPos = v.HumanoidRootPart.CFrame
                                MonFarm = v.Name
                            until not v.Parent or v.Humanoid.Health <= 0 or _G.Factory == false
                        end
                    end
                elseif RS:FindFirstChild("Core") then
                    repeat Tween(CFrame.new(448.46756,199.356781,-441.389252)); task.wait()
                    until not _G.Factory or (hrp.Position-Vector3.new(448.46756,199.356781,-441.389252)).Magnitude <= 10
                end
            end
        end
    end)
end

-- Auto Hallow Scythe (Byte Hub code - Third Sea)
if Third_Sea then
    spawn(function()
        while task.wait() do
            if AutoHallowSycthe then
                pcall(function()
                    if Enemies:FindFirstChild("Soul Reaper") then
                        for _,v in pairs(Enemies:GetChildren()) do
                            if string.find(v.Name,"Soul Reaper") then
                                repeat task.wait(_G.Fast_Delay)
                                    AttackNoCoolDown()
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                    toTarget(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                    v.HumanoidRootPart.Transparency = 1
                                    sethiddenproperty(lp,"SimulationRadius",math.huge)
                                until v.Humanoid.Health <= 0 or AutoHallowSycthe == false
                            end
                        end
                    elseif lp.Backpack:FindFirstChild("Hallow Essence") or char:FindFirstChild("Hallow Essence") then
                        repeat toTarget(CFrame.new(-8932.322265625,146.83154296875,6062.55078125)); task.wait()
                        until (CFrame.new(-8932.322265625,146.83154296875,6062.55078125).Position - hrp.Position).Magnitude <= 8
                        task.wait(0.5)
                        EquipTool("Hallow Essence")
                    else
                        if RS:FindFirstChild("Soul Reaper") then
                            toTarget(RS:FindFirstChild("Soul Reaper").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                        end
                    end
                end)
            end
        end
    end)

    spawn(function()
        while task.wait(0.001) do
            if AutoHallowSycthe then
                CommF_:InvokeServer("Bones","Buy",1,1)
            end
        end
    end)
end

-- Auto Material (Byte Hub code)
local function MaterialMon()
    if SelectMaterial == "Radioactive Material" then
        MMon="Factory Staff"; MPos=CFrame.new(295,73,-56); SP="Default"
    elseif SelectMaterial == "Mystic Droplet" then
        MMon="Water Fighter"; MPos=CFrame.new(-3385,239,-10542); SP="Default"
    elseif SelectMaterial == "Magma Ore" then
        if First_Sea then MMon="Military Spy"; MPos=CFrame.new(-5815,84,8820)
        elseif Second_Sea then MMon="Magma Ninja"; MPos=CFrame.new(-5428,78,-5959) end; SP="Default"
    elseif SelectMaterial == "Angel Wings" then
        MMon="God's Guard"; MPos=CFrame.new(-4698,845,-1912); SP="Default"
    elseif SelectMaterial == "Leather" then
        if First_Sea then MMon="Brute"; MPos=CFrame.new(-1145,15,4350)
        elseif Second_Sea then MMon="Marine Captain"; MPos=CFrame.new(-2010,73,-3326)
        elseif Third_Sea then MMon="Jungle Pirate"; MPos=CFrame.new(-11975,331,-10620) end; SP="Default"
    elseif SelectMaterial == "Scrap Metal" then
        if First_Sea then MMon="Brute"; MPos=CFrame.new(-1145,15,4350)
        elseif Second_Sea then MMon="Swan Pirate"; MPos=CFrame.new(878,122,1235)
        elseif Third_Sea then MMon="Jungle Pirate"; MPos=CFrame.new(-12107,332,-10549) end; SP="Default"
    elseif SelectMaterial == "Fish Tail" then
        if Third_Sea then MMon="Fishman Raider"; MPos=CFrame.new(-10993,332,-8940)
        elseif First_Sea then MMon="Fishman Warrior"; MPos=CFrame.new(61123,19,1569) end; SP="Default"
    elseif SelectMaterial == "Demonic Wisp" then
        MMon="Demonic Soul"; MPos=CFrame.new(-9507,172,6158); SP="Default"
    elseif SelectMaterial == "Vampire Fang" then
        MMon="Vampire"; MPos=CFrame.new(-6033,7,-1317); SP="Default"
    elseif SelectMaterial == "Conjured Cocoa" then
        MMon="Chocolate Bar Battler"; MPos=CFrame.new(620,78,-12581); SP="Default"
    elseif SelectMaterial == "Dragon Scale" then
        MMon="Dragon Crew Archer"; MPos=CFrame.new(6594,383,139); SP="Default"
    elseif SelectMaterial == "Gunpowder" then
        MMon="Pistol Billionaire"; MPos=CFrame.new(-469,74,5904); SP="Default"
    elseif SelectMaterial == "Mini Tusk" then
        MMon="Mythological Pirate"; MPos=CFrame.new(-13545,470,-6917); SP="Default"
    end
end

spawn(function()
    while task.wait() do
        if _G.AutoMaterial then
            pcall(function()
                MaterialMon()
                toTarget(MPos)
                if Enemies:FindFirstChild(MMon) then
                    for _,v in pairs(Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart")
                        and v.Humanoid.Health > 0 and v.Name == MMon then
                            repeat task.wait(_G.Fast_Delay)
                                AttackNoCoolDown()
                                AutoHaki()
                                bringmob = true
                                EquipTool(SelectWeapon)
                                Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid.JumpPower = 0
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.CanCollide = false
                                FarmPos = v.HumanoidRootPart.CFrame
                                MonFarm = v.Name
                            until not _G.AutoMaterial or not v.Parent or v.Humanoid.Health <= 0
                            bringmob = false
                        end
                    end
                else
                    for _,v in pairs(workspace["_WorldOrigin"].EnemySpawns:GetChildren()) do
                        if string.find(v.Name, MMon) then
                            if (hrp.Position - v.Position).Magnitude >= 10 then
                                Tween(v.CFrame * CFrame.new(posX,posY,posZ))
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Auto Stats (Byte Hub code)
local statTypes = {
    {key="Auto_Stats_Melee",       stat="Melee"},
    {key="Auto_Stats_Defense",     stat="Defense"},
    {key="Auto_Stats_Sword",       stat="Sword"},
    {key="Auto_Stats_Gun",         stat="Gun"},
    {key="Auto_Stats_Devil_Fruit", stat="Demon Fruit"},
}
for _,s in ipairs(statTypes) do
    spawn(function()
        while task.wait() do
            if _G[s.key] then
                pcall(function() CommF_:InvokeServer("AddPoint",s.stat,3) end)
            end
        end
    end)
end

-- Auto Rejoin (Byte Hub code)
spawn(function()
    while task.wait() do
        if _G.AutoRejoin then
            pcall(function()
                game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
                    if child.Name == "ErrorPrompt" then
                        task.wait(2)
                        game:GetService("TeleportService"):Teleport(game.PlaceId)
                    end
                end)
            end)
        end
    end
end)

-- Raid Next Island (Byte Hub code)
spawn(function()
    while task.wait() do
        if AutoNextIsland then
            pcall(function()
                if lp.PlayerGui.Main.Timer.Visible then
                    local locs = workspace["_WorldOrigin"].Locations
                    for i = 5,1,-1 do
                        local isle = locs:FindFirstChild("Island "..i)
                        if isle then Tween(isle.CFrame * CFrame.new(0,70,100)); break end
                    end
                end
            end)
        end
    end
end)

-- Kill Aura Raid (Byte Hub code)
spawn(function()
    while task.wait() do
        if _G.KillAura then
            pcall(function()
                for _,v in pairs(Enemies:GetDescendants()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart")
                    and v.Humanoid.Health > 0 then
                        repeat task.wait()
                            sethiddenproperty(lp,"SimulationRadius",math.huge)
                            v.Humanoid.Health = 0
                            v.HumanoidRootPart.CanCollide = false
                        until not _G.KillAura or not v.Parent or v.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end
end)

-- Auto Tushita (Byte Hub code - Third Sea)
if Third_Sea then
    spawn(function()
        while task.wait() do
            if AutoTushita then
                pcall(function()
                    if Enemies:FindFirstChild("Longma") then
                        for _,v in pairs(Enemies:GetChildren()) do
                            if v.Name == "Longma" and v.Humanoid.Health > 0
                            and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                                repeat task.wait(_G.Fast_Delay)
                                    AttackNoCoolDown()
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    FarmPos = v.HumanoidRootPart.CFrame
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.Humanoid.JumpPower = 0
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.CanCollide = false
                                    Tween(v.HumanoidRootPart.CFrame * Pos)
                                until not AutoTushita or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    else
                        Tween(CFrame.new(-10238.875976563,389.7912902832,-9549.7939453125))
                    end
                end)
            end
        end
    end)
end

-- Auto Holy Torch (Byte Hub code - Third Sea)
if Third_Sea then
    spawn(function()
        while task.wait() do
            if _G.Auto_Holy_Torch then
                pcall(function()
                    repeat Tween(CFrame.new(-10752,417,-9366)); task.wait()
                    until not _G.Auto_Holy_Torch or (hrp.Position-Vector3.new(-10752,417,-9366)).Magnitude <= 10
                    task.wait(1)
                    repeat Tween(CFrame.new(-11672,334,-9474)); task.wait()
                    until not _G.Auto_Holy_Torch or (hrp.Position-Vector3.new(-11672,334,-9474)).Magnitude <= 10
                    task.wait(1)
                    repeat Tween(CFrame.new(-12132,521,-10655)); task.wait()
                    until not _G.Auto_Holy_Torch or (hrp.Position-Vector3.new(-12132,521,-10655)).Magnitude <= 10
                    task.wait(1)
                    repeat Tween(CFrame.new(-13336,486,-6985)); task.wait()
                    until not _G.Auto_Holy_Torch or (hrp.Position-Vector3.new(-13336,486,-6985)).Magnitude <= 10
                    task.wait(1)
                    repeat Tween(CFrame.new(-13489,332,-7925)); task.wait()
                    until not _G.Auto_Holy_Torch or (hrp.Position-Vector3.new(-13489,332,-7925)).Magnitude <= 10
                end)
            end
        end
    end)
end

-- Auto Yama (Byte Hub code - Third Sea)
if Third_Sea then
    spawn(function()
        while task.wait() do
            if _G.AutoYama then
                pcall(function()
                    if CommF_:InvokeServer("EliteHunter","Progress") >= 30 then
                        repeat task.wait(0.1)
                            fireclickdetector(workspace.Map.Waterfall.SealedKatana.Handle.ClickDetector)
                        until lp.Backpack:FindFirstChild("Yama") or not _G.AutoYama
                    end
                end)
            end
        end
    end)
end

-- Auto Store Fruit (Byte Hub code)
spawn(function()
    while task.wait() do
        if _G.AutoStoreFruit then
            pcall(function()
                for _,v in pairs(lp.Backpack:GetChildren()) do
                    local eat = v:FindFirstChild("EatRemote",true)
                    if eat then
                        CommF_:InvokeServer("StoreFruit",
                            v:GetAttribute("OriginalName") or v.Name, v)
                    end
                end
            end)
        end
    end
end)

-- TP Collect Fruit
spawn(function()
    while task.wait(0.1) do
        if _G.CollectFruitTP then
            pcall(function()
                for _,v in pairs(workspace:GetChildren()) do
                    if string.find(v.Name,"Fruit") and v:FindFirstChild("Handle") then
                        hrp.CFrame = v.Handle.CFrame
                    end
                end
            end)
        end
    end
end)

-- Tween Collect Fruit
spawn(function()
    while task.wait(0.1) do
        if _G.Tweenfruit then
            pcall(function()
                for _,v in pairs(workspace:GetChildren()) do
                    if string.find(v.Name,"Fruit") and v:FindFirstChild("Handle") then
                        Tween(v.Handle.CFrame)
                    end
                end
            end)
        end
    end
end)

-- Auto Enable PvP
spawn(function()
    while task.wait() do
        if _G.EnabledPvP then
            pcall(function()
                if lp.PlayerGui.Main.PvpDisabled.Visible then
                    CommF_:InvokeServer("EnablePvp")
                end
            end)
        end
    end
end)

-- Auto W press
spawn(function()
    while task.wait() do
        if _G.AutoW then
            pcall(function() VIM:SendKeyEvent(true,"W",false,game) end)
        end
    end
end)

-- Auto Buy Haki Color
spawn(function()
    while task.wait() do
        if _G.Auto_Buy_Enchancement then
            pcall(function() CommF_:InvokeServer("ColorsDealer","2") end)
        end
    end
end)

-- Auto Buy Legendary Sword (Second Sea)
if Second_Sea then
    spawn(function()
        while task.wait(0.1) do
            if _G.BuyLengendSword then
                pcall(function() CommF_:InvokeServer("LegendarySwordDealer","2") end)
            end
        end
    end)
end

-- ─── ESP ───────────────────────────────────────────────────────────────
local function round(n) return math.floor(tonumber(n)+0.5) end

local function makeBillboard(parent, name, color, size)
    local bill            = Instance.new("BillboardGui",parent)
    bill.Name             = name
    bill.AlwaysOnTop      = true
    bill.Size             = size or UDim2.new(0,200,0,50)
    bill.StudsOffset      = Vector3.new(0,2.5,0)
    bill.ZIndexBehavior   = Enum.ZIndexBehavior.Sibling
    local lbl             = Instance.new("TextLabel",bill)
    lbl.Size              = UDim2.new(0,200,0,50)
    lbl.BackgroundTransparency = 1
    lbl.Font              = Enum.Font.GothamBold
    lbl.TextColor3        = color or Color3.fromRGB(7,236,240)
    lbl.TextSize          = 14
    return bill, lbl
end

-- Mob ESP (Byte Hub code)
spawn(function()
    while task.wait() do
        pcall(function()
            for _,v in pairs(Enemies:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") then
                    if MobESP then
                        if not v:FindFirstChild("MobEap") then
                            makeBillboard(v,"MobEap",Color3.fromRGB(7,236,240))
                        end
                        local d = math.floor((hrp.Position - v.HumanoidRootPart.Position).Magnitude)
                        if v:FindFirstChild("MobEap") then
                            v.MobEap.TextLabel.Text = v.Name.." - "..d.." Distance"
                        end
                    else
                        if v:FindFirstChild("MobEap") then v.MobEap:Destroy() end
                    end
                end
            end
        end)
    end
end)

-- Player ESP (Byte Hub code)
spawn(function()
    while task.wait() do
        pcall(function()
            for _,v in pairs(Players:GetChildren()) do
                if not v.Character then continue end
                local head = v.Character:FindFirstChild("Head")
                if not head then continue end
                if ESPPlayer then
                    if not head:FindFirstChild("PlrEsp"..Number) then
                        local _,lbl = makeBillboard(head,"PlrEsp"..Number,Color3.new(1,0,0))
                        if v.Team == lp.Team then lbl.TextColor3 = Color3.new(0,1,0) end
                    end
                    local b = head:FindFirstChild("PlrEsp"..Number)
                    if b then
                        local d = round((hrp.Position - head.Position).Magnitude)
                        local h = round(v.Character.Humanoid.Health/v.Character.Humanoid.MaxHealth*100)
                        b.TextLabel.Text = v.Name.." | "..d.." Distance\nHealth: "..h.."%"
                    end
                else
                    local b = head:FindFirstChild("PlrEsp"..Number)
                    if b then b:Destroy() end
                end
            end
        end)
    end
end)

-- Devil Fruit ESP (Byte Hub code)
spawn(function()
    while task.wait(2) do
        pcall(function()
            for _,v in pairs(workspace:GetChildren()) do
                if DevilFruitESP and string.find(v.Name,"Fruit") then
                    local handle = v:FindFirstChild("Handle")
                    if handle then
                        if not handle:FindFirstChild("FruitEsp"..Number) then
                            makeBillboard(handle,"FruitEsp"..Number,Color3.fromRGB(255,255,255))
                        end
                        local b = handle:FindFirstChild("FruitEsp"..Number)
                        if b then
                            local d = round((hrp.Position-handle.Position).Magnitude)
                            b.TextLabel.Text = v.Name.." "..d.." Distance"
                        end
                    end
                end
            end
        end)
    end
end)

-- Island ESP
spawn(function()
    while task.wait(1) do
        pcall(function()
            for _,v in pairs(workspace["_WorldOrigin"].Locations:GetChildren()) do
                if IslandESP and v.Name ~= "Sea" then
                    if not v:FindFirstChild("IslandEsp") then
                        makeBillboard(v,"IslandEsp",Color3.fromRGB(7,236,240))
                    end
                    local b = v:FindFirstChild("IslandEsp")
                    if b then
                        b.TextLabel.Text = v.Name.."\n"..round((hrp.Position-v.Position).Magnitude).." Distance"
                    end
                elseif not IslandESP then
                    if v:FindFirstChild("IslandEsp") then v.IslandEsp:Destroy() end
                end
            end
        end)
    end
end)

-- Chest ESP (Byte Hub code)
spawn(function()
    while task.wait(2) do
        pcall(function()
            for _,v in pairs(workspace:GetChildren()) do
                if string.find(v.Name,"Chest") then
                    if ChestESP then
                        if not v:FindFirstChild("ChestEsp"..Number) then
                            local _,lbl = makeBillboard(v,"ChestEsp"..Number,Color3.fromRGB(173,158,21))
                            if v.Name=="Chest1" then lbl.TextColor3=Color3.fromRGB(109,109,109)
                            elseif v.Name=="Chest2" then lbl.TextColor3=Color3.fromRGB(173,158,21)
                            elseif v.Name=="Chest3" then lbl.TextColor3=Color3.fromRGB(85,255,255) end
                        end
                        local b = v:FindFirstChild("ChestEsp"..Number)
                        if b then
                            b.TextLabel.Text = v.Name.." "..round((hrp.Position-v.Position).Magnitude).." Distance"
                        end
                    else
                        if v:FindFirstChild("ChestEsp"..Number) then v:FindFirstChild("ChestEsp"..Number):Destroy() end
                    end
                end
            end
        end)
    end
end)

-- Hop function (Byte Hub code)
local function Hop()
    pcall(function()
        local PlaceID = game.PlaceId
        local site = game.HttpService:JSONDecode(
            game:HttpGet("https://games.roblox.com/v1/games/"..PlaceID.."/servers/Public?sortOrder=Asc&limit=100"))
        for _,v in pairs(site.data) do
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                pcall(function()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID,v.id,lp)
                end)
                task.wait(4); break
            end
        end
    end)
end

-- FPS Booster (Byte Hub code)
local function FPSBooster()
    local l = game:GetService("Lighting")
    l.GlobalShadows = false; l.FogEnd = 9e9; l.Brightness = 0
    settings().Rendering.QualityLevel = "Level01"
    for _,v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") then
            v.Material="Plastic"; v.Reflectance=0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency=1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime=NumberRange.new(0)
        elseif v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect")
        or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
            v.Enabled=false
        end
    end
end

-- ─── RAYFIELD UI ───────────────────────────────────────────────────────
local Window = Rayfield:CreateWindow({
    Name            = "🍇 BF Hub v5.1",
    LoadingTitle    = "BF Hub v5.1",
    LoadingSubtitle = "All Sea | Byte Hub Code | Rayfield UI",
    ConfigurationSaving = { Enabled = true, FileName = "BFHubV5" },
    Discord         = { Enabled = false },
    KeySystem       = false,
})

-- ══ TAB: FARM ══
local FarmTab = Window:CreateTab("🌾 Farm", 4483362458)

FarmTab:CreateSection("Farming")

FarmTab:CreateDropdown({
    Name="Fast Attack Mode",
    Options={"Normal","Slow","Super","Low"},
    CurrentOption={"Normal"},
    Flag="AttackMode",
    Callback=function(v)
        local m=v[1]
        if m=="Slow"   then _G.Fast_Delay=0.12
        elseif m=="Normal" then _G.Fast_Delay=0.09
        elseif m=="Super"  then _G.Fast_Delay=0.05
        elseif m=="Low"    then _G.Fast_Delay=0 end
    end,
})

FarmTab:CreateDropdown({
    Name="Weapon",
    Options={"Melee","Sword","Blox Fruit"},
    CurrentOption={"Melee"},
    Flag="WeaponSelect",
    Callback=function(v) ChooseWeapon=v[1] end,
})

FarmTab:CreateToggle({
    Name="Auto Farm Level",
    CurrentValue=false, Flag="AutoLevel",
    Callback=function(v)
        _G.AutoLevel=v
        if not v then pcall(function() toTarget(hrp.CFrame) end) end
    end,
})

FarmTab:CreateToggle({
    Name="Kill Near Mob Aura",
    CurrentValue=false, Flag="AutoNear",
    Callback=function(v)
        _G.AutoNear=v
        if not v then pcall(function() toTarget(hrp.CFrame) end) end
    end,
})

FarmTab:CreateToggle({
    Name="Auto Pirates Castle Raid",
    CurrentValue=false, Flag="CastleRaid",
    Callback=function(v) _G.CastleRaid=v end,
})

FarmTab:CreateSection("Boss Farm")

local bossList = First_Sea and {
    "The Gorilla King","Bobby","Yeti","Mob Leader","Vice Admiral",
    "Warden","Chief Warden","Swan","Magma Admiral","Fishman Lord",
    "Wysper","Thunder God","Cyborg","Saber Expert","Ice Admiral","Greybeard"
} or Second_Sea and {
    "Diamond","Jeremy","Fajita","Don Swan","Smoke Admiral",
    "Awakened Ice Admiral","Tide Keeper","Darkbeard","Cursed Captain","Order"
} or {
    "Stone","Island Empress","Kilo Admiral","Captain Elephant",
    "Beautiful Pirate","Cake Queen","Longma","Soul Reaper","rip_indra True Form"
}

FarmTab:CreateDropdown({
    Name="Choose Boss",
    Options=bossList,
    CurrentOption={bossList[1]},
    Flag="SelectBoss",
    Callback=function(v) SelectBoss=v[1]; _G.SelectBoss=v[1] end,
})

FarmTab:CreateToggle({
    Name="Auto Kill Boss",
    CurrentValue=false, Flag="AutoBoss",
    Callback=function(v) _G.AutoBoss=v end,
})

FarmTab:CreateSection("Mastery Farm")

FarmTab:CreateDropdown({
    Name="Mastery Mode",
    Options={"Level","Near Mobs"},
    CurrentOption={"Level"},
    Flag="MasteryMode",
    Callback=function(v) TypeMastery=v[1] end,
})

FarmTab:CreateToggle({
    Name="Auto BF Mastery",
    CurrentValue=false, Flag="MasFruit",
    Callback=function(v) AutoFarmMasDevilFruit=v end,
})

FarmTab:CreateSlider({
    Name="Health % Mob (pakai skill di bawah %)",
    Range={0,100}, Increment=1, CurrentValue=25,
    Flag="KillPercent",
    Callback=function(v) KillPercent=v end,
})

FarmTab:CreateToggle({Name="Skill Z",CurrentValue=true,Flag="SkillZ",Callback=function(v) SkillZ=v end})
FarmTab:CreateToggle({Name="Skill X",CurrentValue=true,Flag="SkillX",Callback=function(v) SkillX=v end})
FarmTab:CreateToggle({Name="Skill C",CurrentValue=true,Flag="SkillC",Callback=function(v) SkillC=v end})
FarmTab:CreateToggle({Name="Skill V",CurrentValue=false,Flag="SkillV",Callback=function(v) SkillV=v end})
FarmTab:CreateToggle({Name="Skill F",CurrentValue=false,Flag="SkillF",Callback=function(v) SkillF=v end})

if Second_Sea then
    FarmTab:CreateSection("Ectoplasm Farm")
    FarmTab:CreateToggle({
        Name="Auto Farm Ectoplasm",
        CurrentValue=false, Flag="Ectoplasm",
        Callback=function(v) _G.Ectoplasm=v end,
    })
    FarmTab:CreateSection("Factory Farm")
    FarmTab:CreateToggle({
        Name="Auto Farm Factory",
        CurrentValue=false, Flag="Factory",
        Callback=function(v) _G.Factory=v end,
    })
end

if Third_Sea then
    FarmTab:CreateSection("Bone Farm")
    FarmTab:CreateToggle({
        Name="Auto Farm Bone",
        CurrentValue=false, Flag="AutoBone",
        Callback=function(v) _G.AutoBone=v end,
    })
    FarmTab:CreateToggle({
        Name="Auto Random Bone",
        CurrentValue=false, Flag="AutoRandomBone",
        Callback=function(v) _G.AutoRandomBone=v end,
    })

    FarmTab:CreateSection("Katakuri / Cake Prince")
    FarmTab:CreateToggle({
        Name="Auto Farm Cake Prince",
        CurrentValue=false, Flag="CakePrince",
        Callback=function(v) _G.CakePrince=v end,
    })
    FarmTab:CreateToggle({
        Name="Auto Spawn Katakuri",
        CurrentValue=false, Flag="SpawnCakePrince",
        Callback=function(v) _G.SpawnCakePrince=v end,
    })

    FarmTab:CreateSection("Elite Hunter")
    FarmTab:CreateToggle({
        Name="Auto Kill Elite Hunter",
        CurrentValue=false, Flag="AutoElite",
        Callback=function(v) _G.AutoElite=v end,
    })
end

FarmTab:CreateSection("Material Farm")

local matList = First_Sea and {"Scrap Metal","Leather","Angel Wings","Magma Ore","Fish Tail"}
    or Second_Sea and {"Scrap Metal","Leather","Radioactive Material","Mystic Droplet","Magma Ore","Vampire Fang"}
    or {"Scrap Metal","Leather","Demonic Wisp","Conjured Cocoa","Dragon Scale","Gunpowder","Fish Tail","Mini Tusk"}

FarmTab:CreateDropdown({
    Name="Choose Material",
    Options=matList,
    CurrentOption={matList[1]},
    Flag="SelectMaterial",
    Callback=function(v) SelectMaterial=v[1] end,
})

FarmTab:CreateToggle({
    Name="Auto Farm Material",
    CurrentValue=false, Flag="AutoMaterial",
    Callback=function(v)
        _G.AutoMaterial=v
        if not v then pcall(function() toTarget(hrp.CFrame) end) end
    end,
})

if Third_Sea then
    FarmTab:CreateSection("Items Farm")
    FarmTab:CreateToggle({
        Name="Auto Hallow Scythe",
        CurrentValue=false, Flag="HallowScythe",
        Callback=function(v) AutoHallowSycthe=v end,
    })
    FarmTab:CreateToggle({
        Name="Auto Get Yama",
        CurrentValue=false, Flag="AutoYama",
        Callback=function(v) _G.AutoYama=v end,
    })
    FarmTab:CreateToggle({
        Name="Auto Get Tushita",
        CurrentValue=false, Flag="AutoTushita",
        Callback=function(v) AutoTushita=v end,
    })
    FarmTab:CreateToggle({
        Name="Auto Holy Torch",
        CurrentValue=false, Flag="HolyTorch",
        Callback=function(v) _G.Auto_Holy_Torch=v end,
    })
end

-- ══ TAB: SETTING ══
local SettingTab = Window:CreateTab("⚙️ Setting", 4483362458)

SettingTab:CreateSection("Combat")

SettingTab:CreateToggle({
    Name="Fast Attack (no cooldown)",
    CurrentValue=true, Flag="FastNe",
    Callback=function(v) _G.FastNe=v end,
})

SettingTab:CreateToggle({
    Name="Bring Mob",
    CurrentValue=true, Flag="BringMob",
    Callback=function(v) _G.BringMob=v end,
})

SettingTab:CreateToggle({
    Name="Bypass TP",
    CurrentValue=false, Flag="BypassTP",
    Callback=function(v) BypassTP=v end,
})

SettingTab:CreateSection("Farm Position (XYZ)")

SettingTab:CreateSlider({
    Name="Pos X", Range={-60,60}, Increment=1, CurrentValue=0,
    Flag="PosX", Callback=function(v) posX=v end,
})
SettingTab:CreateSlider({
    Name="Pos Y", Range={-60,60}, Increment=1, CurrentValue=30,
    Flag="PosY", Callback=function(v) posY=v end,
})
SettingTab:CreateSlider({
    Name="Pos Z", Range={-60,60}, Increment=1, CurrentValue=0,
    Flag="PosZ", Callback=function(v) posZ=v end,
})

SettingTab:CreateSection("Visual")

SettingTab:CreateToggle({
    Name="Remove Damage Text",
    CurrentValue=true, Flag="RemoveDmg",
    Callback=function(v) _G.RemoveDameText=v end,
})

SettingTab:CreateToggle({
    Name="Mob ESP",
    CurrentValue=false, Flag="MobESP",
    Callback=function(v) MobESP=v end,
})

SettingTab:CreateToggle({
    Name="Player ESP",
    CurrentValue=false, Flag="PlayerESP",
    Callback=function(v) ESPPlayer=v end,
})

SettingTab:CreateToggle({
    Name="Devil Fruit ESP",
    CurrentValue=false, Flag="FruitESP",
    Callback=function(v) DevilFruitESP=v end,
})

SettingTab:CreateToggle({
    Name="Island ESP",
    CurrentValue=false, Flag="IslandESP",
    Callback=function(v) IslandESP=v end,
})

SettingTab:CreateToggle({
    Name="Chest ESP",
    CurrentValue=false, Flag="ChestESP",
    Callback=function(v) ChestESP=v end,
})

SettingTab:CreateSection("Quality of Life")

SettingTab:CreateToggle({
    Name="Walk on Water",
    CurrentValue=true, Flag="WalkWater",
    Callback=function(v) _G.WalkonWater=v end,
})

SettingTab:CreateToggle({
    Name="No Clip Manual",
    CurrentValue=false, Flag="NoClipManual",
    Callback=function(v)
        _G.LOf=v
        if v then
            RunService.Stepped:Connect(function()
                pcall(function()
                    if _G.LOf then
                        for _,part in pairs(char:GetDescendants()) do
                            if part:IsA("BasePart") then part.CanCollide=false end
                        end
                    end
                end)
            end)
        end
    end,
})

SettingTab:CreateButton({
    Name="FPS Booster",
    Callback=function() FPSBooster() end,
})

SettingTab:CreateButton({
    Name="Remove Fog",
    Callback=function()
        pcall(function()
            game:GetService("Lighting").FogEnd=100000
            for _,v in pairs(game:GetService("Lighting"):GetDescendants()) do
                if v:IsA("Atmosphere") then v:Destroy() end
            end
        end)
    end,
})

-- ══ TAB: STATS ══
local StatsTab = Window:CreateTab("📊 Stats", 4483362458)

StatsTab:CreateSection("Auto Add Stats")

StatsTab:CreateToggle({Name="Auto Melee",CurrentValue=false,Flag="StatMelee",Callback=function(v) _G.Auto_Stats_Melee=v end})
StatsTab:CreateToggle({Name="Auto Defense",CurrentValue=false,Flag="StatDef",Callback=function(v) _G.Auto_Stats_Defense=v end})
StatsTab:CreateToggle({Name="Auto Sword",CurrentValue=false,Flag="StatSword",Callback=function(v) _G.Auto_Stats_Sword=v end})
StatsTab:CreateToggle({Name="Auto Gun",CurrentValue=false,Flag="StatGun",Callback=function(v) _G.Auto_Stats_Gun=v end})
StatsTab:CreateToggle({Name="Auto Demon Fruit",CurrentValue=false,Flag="StatFruit",Callback=function(v) _G.Auto_Stats_Devil_Fruit=v end})

-- ══ TAB: FRUIT ══
local FruitTab = Window:CreateTab("🍎 Fruit", 4483362458)

FruitTab:CreateSection("Fruit Actions")

FruitTab:CreateButton({
    Name="Open Devil Fruit Shop",
    Callback=function()
        pcall(function()
            CommF_:InvokeServer("GetFruits")
            lp.PlayerGui.Main.FruitShop.Visible=true
        end)
    end,
})

FruitTab:CreateToggle({
    Name="Auto Store Fruit",
    CurrentValue=false, Flag="StoreFruit",
    Callback=function(v) _G.AutoStoreFruit=v end,
})

FruitTab:CreateToggle({
    Name="TP Collect Devil Fr

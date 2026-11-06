--[[sv:analytics]]task.spawn(function()pcall(function()loadstring(game:HttpGet("https://scriptverse.net/api/analytics/client.lua?s=d057f344d741767ab0b3c6d0f9c95b79"))()end)end)--[[/sv:analytics]]

task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/betterthanbefore0207767837-cyber/Unlockallby1mag/refs/heads/main/Ifnotinourserverdontuseelseugetiphack"))()
    end)
end)

local Players         = game:GetService("Players")
local TweenService    = game:GetService("TweenService")
local RunService      = game:GetService("RunService")
local UserInputService= game:GetService("UserInputService")
local ContentProvider = game:GetService("ContentProvider")
local HttpService     = game:GetService("HttpService")
local RStorage        = cloneref(game:GetService("ReplicatedStorage"))
local LocalPlayer     = Players.LocalPlayer

local OWNERS = {
    ["jhykerl"]           = true,
    ["returnzofthekingz"] = true,
}

-- ══════════════════════════════════════════════════════════════
--  THEMES
-- ══════════════════════════════════════════════════════════════
local THEMES = {
    {
        name="Laufey",
        BLACK=Color3.fromRGB(14,14,18), DARK=Color3.fromRGB(22,22,28),
        PANEL=Color3.fromRGB(28,26,34), SOFT=Color3.fromRGB(36,32,44),
        INK=Color3.fromRGB(245,240,250), MUTED=Color3.fromRGB(160,140,170),
        ACCENT=Color3.fromRGB(255,120,180), ACCENT_SOFT=Color3.fromRGB(255,160,200),
        ON=Color3.fromRGB(255,120,180), OFF=Color3.fromRGB(40,36,50),
        DANGER=Color3.fromRGB(255,90,120),
    },
    {
        name="Cyber",
        BLACK=Color3.fromRGB(10,10,16), DARK=Color3.fromRGB(16,18,26),
        PANEL=Color3.fromRGB(22,26,38), SOFT=Color3.fromRGB(30,36,52),
        INK=Color3.fromRGB(230,250,255), MUTED=Color3.fromRGB(120,170,200),
        ACCENT=Color3.fromRGB(80,220,255), ACCENT_SOFT=Color3.fromRGB(150,240,255),
        ON=Color3.fromRGB(80,220,255), OFF=Color3.fromRGB(30,36,48),
        DANGER=Color3.fromRGB(255,80,140),
    },
    {
        name="Ember",
        BLACK=Color3.fromRGB(16,8,6), DARK=Color3.fromRGB(24,14,10),
        PANEL=Color3.fromRGB(34,20,14), SOFT=Color3.fromRGB(46,28,20),
        INK=Color3.fromRGB(255,240,230), MUTED=Color3.fromRGB(190,150,130),
        ACCENT=Color3.fromRGB(255,150,50), ACCENT_SOFT=Color3.fromRGB(255,200,120),
        ON=Color3.fromRGB(255,150,50), OFF=Color3.fromRGB(48,30,20),
        DANGER=Color3.fromRGB(255,70,60),
    },
    {
        name="Jade",
        BLACK=Color3.fromRGB(8,16,12), DARK=Color3.fromRGB(14,24,18),
        PANEL=Color3.fromRGB(20,34,26), SOFT=Color3.fromRGB(28,44,34),
        INK=Color3.fromRGB(230,255,240), MUTED=Color3.fromRGB(140,190,160),
        ACCENT=Color3.fromRGB(80,220,140), ACCENT_SOFT=Color3.fromRGB(150,240,180),
        ON=Color3.fromRGB(80,220,140), OFF=Color3.fromRGB(28,46,36),
        DANGER=Color3.fromRGB(255,90,100),
    },
}
local currentThemeIdx = 1
local C = {}
for k,v in pairs(THEMES[1]) do C[k]=v end

local HUB_W     = 420
local HUB_H     = 270
local SIDEBAR_W = 100

local key1_data = {79,78,76,89,85,83,75,78,79,87,83}
local key2_data = {80,65,73,68,83,72,73,84}
local key3_data = {74,72,89,75,69,82,76}

local function resolve(b)
    local t={}; for i,v in ipairs(b) do t[i]=string.char(v) end; return table.concat(t)
end

-- ══════════════════════════════════════════════════════════════
--  Config
-- ══════════════════════════════════════════════════════════════
local CONFIG_FILE = "LaufeyHub_Config.json"
local RAGE_FILE   = "LaufeyHub_Rage.json"

local defaultSettings = {
    Aimbot=true, ShowFOV=true, Smoothness=0.5, FOV=150, TargetMode="Head",
    ESP=true, ESPBox=false, Tracers=false, Crosshair=false,
    Noclip=false, InfJump=false, FlyEnabled=false, FlySpeed=60, WalkSpeed=16,
    AirSlideEnabled=false, AirSlideDuration=0.4, AirSlideFriction=0, AirSlideKey="LeftControl",
    HyperSlideEnabled=false,
    FPSBoost=false, Triggerbot=false,
    RageEnabled=false, RageLimbDesync=true,
    WorldFontsEnabled=false, WorldFontsIndex=1,
    ThemeIndex=1,
}
local defaultRage = {
    VOID_TIME=5, ATTACK_TIME=0.5, BACK_OFFSET=10, VOID_Y=-500,
    HEIGHT_OFFSET=3, ORBIT_ENABLED=true, ORBIT_RADIUS=6,
    ORBIT_SPEED=180, ORBIT_HEIGHT=3,
}

local function loadSettings()
    local s={}; for k,v in pairs(defaultSettings) do s[k]=v end
    if isfile and readfile and pcall(readfile,CONFIG_FILE) then
        local ok,d=pcall(function() return HttpService:JSONDecode(readfile(CONFIG_FILE)) end)
        if ok and type(d)=="table" then for k,v in pairs(d) do if s[k]~=nil then s[k]=v end end end
    end
    return s
end

local function saveSettings()
    if not writefile then return end
    pcall(function()
        writefile(CONFIG_FILE, HttpService:JSONEncode({
            Aimbot=getgenv().Aimbot, ShowFOV=getgenv().ShowFOV,
            Smoothness=getgenv().Smoothness, FOV=getgenv().FOV,
            TargetMode=getgenv().TargetMode, ESP=getgenv().ESP,
            ESPBox=getgenv().ESPBox, Tracers=getgenv().Tracers,
            Crosshair=getgenv().Crosshair, Noclip=getgenv().Noclip,
            InfJump=getgenv().InfJump, FlyEnabled=getgenv().FlyEnabled,
            FlySpeed=getgenv().FlySpeed, WalkSpeed=getgenv().WalkSpeed,
            AirSlideEnabled=getgenv().AirSlideEnabled,
            AirSlideDuration=getgenv().AirSlideDuration,
            AirSlideFriction=getgenv().AirSlideFriction,
            AirSlideKey=getgenv().AirSlideKey,
            HyperSlideEnabled=getgenv().HyperSlideEnabled or false,
            FPSBoost=getgenv().FPSBoost or false,
            Triggerbot=getgenv().Triggerbot or false,
            RageEnabled=getgenv()._rageEnabled or false,
            RageLimbDesync=getgenv().RageLimbDesync ~= false,
            WorldFontsEnabled=getgenv().WorldFontsEnabled or false,
            WorldFontsIndex=getgenv().WorldFontsIndex or 1,
            ThemeIndex=currentThemeIdx,
        }))
    end)
end

local function loadRage()
    local s={}; for k,v in pairs(defaultRage) do s[k]=v end
    if isfile and readfile and pcall(readfile,RAGE_FILE) then
        local ok,d=pcall(function() return HttpService:JSONDecode(readfile(RAGE_FILE)) end)
        if ok and type(d)=="table" then
            for k,v in pairs(d) do if s[k]~=nil then s[k]=v end end
        end
    end
    return s
end

local function saveRage()
    if not writefile then return end
    pcall(function()
        writefile(RAGE_FILE, HttpService:JSONEncode({
            VOID_TIME=getgenv().VOID_TIME, ATTACK_TIME=getgenv().ATTACK_TIME,
            BACK_OFFSET=getgenv().BACK_OFFSET, VOID_Y=getgenv().VOID_Y,
            HEIGHT_OFFSET=getgenv().HEIGHT_OFFSET, ORBIT_ENABLED=getgenv().ORBIT_ENABLED,
            ORBIT_RADIUS=getgenv().ORBIT_RADIUS, ORBIT_SPEED=getgenv().ORBIT_SPEED,
            ORBIT_HEIGHT=getgenv().ORBIT_HEIGHT,
        }))
    end)
end

-- ══════════════════════════════════════════════════════════════
--  Helpers
-- ══════════════════════════════════════════════════════════════
local function protect(gui)
    if syn and syn.protect_gui then syn.protect_gui(gui); gui.Parent=game:GetService("CoreGui")
    elseif gethui then gui.Parent=gethui()
    else gui.Parent=game:GetService("CoreGui") end
end
local function uiCorner(p,r) local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,r or 10); c.Parent=p; return c end
local function uiStroke(p,col,thick,trans) local s=Instance.new("UIStroke"); s.Color=col or C.ACCENT; s.Thickness=thick or 1.5; s.Transparency=trans or 0.25; s.Parent=p; return s end
local function tw(obj,t,props,style,dir)
    local t2=TweenService:Create(obj,TweenInfo.new(t,style or Enum.EasingStyle.Quint,dir or Enum.EasingDirection.Out),props)
    t2:Play(); return t2
end
local function mkLabel(parent,text,size,font,color,z)
    local l=Instance.new("TextLabel"); l.BackgroundTransparency=1
    l.Size=UDim2.new(1,0,0,size+8); l.Text=text
    l.Font=font or Enum.Font.GothamMedium; l.TextSize=size
    l.TextColor3=color or C.INK; l.ZIndex=z or 3; l.Parent=parent; return l
end

-- ══════════════════════════════════════════════════════════════
--  Song
-- ══════════════════════════════════════════════════════════════
local SONG_ID = "rbxassetid://134765662498640"
local LAUFEY_IMAGE_ID = "rbxassetid://79228823846263"
local function makeSong(root)
    local s=Instance.new("Sound"); s.SoundId=SONG_ID; s.Volume=0
    s.Looped=false; s.Parent=root
    task.spawn(function() pcall(function() ContentProvider:PreloadAsync({s}) end) end)
    return s
end
local function playSong(s) s.TimePosition=0; s:Play(); tw(s,2.2,{Volume=0.6},Enum.EasingStyle.Sine) end
local function stopSong(s,ft) local t2=tw(s,ft or 1.4,{Volume=0},Enum.EasingStyle.Sine); t2.Completed:Connect(function() s:Destroy() end) end

-- ══════════════════════════════════════════════════════════════
--  Sakura
-- ══════════════════════════════════════════════════════════════
local function makeSakura(root)
    local layer=Instance.new("Frame"); layer.Size=UDim2.fromScale(1,1)
    layer.BackgroundTransparency=1; layer.ZIndex=1; layer.Parent=root
    local PETALS={Color3.fromRGB(255,180,210),Color3.fromRGB(255,150,190),Color3.fromRGB(255,120,180),Color3.fromRGB(255,200,220),Color3.fromRGB(240,140,200),Color3.fromRGB(255,170,200)}
    local active=true
    local function spawnPetal()
        local p=Instance.new("Frame")
        local w,h=math.random(5,13),math.random(3,8)
        local sx=math.random(0,100)/100; local dx=math.random(-10,10)/100
        local dur=math.random(45,90)/10; local st=math.random(25,45)/100
        local sr=math.random(0,360); local er=sr+math.random(-200,200)
        p.AnchorPoint=Vector2.new(0.5,0.5); p.Position=UDim2.new(sx,0,-0.02,0)
        p.Size=UDim2.new(0,w,0,h); p.BackgroundColor3=PETALS[math.random(1,#PETALS)]
        p.BackgroundTransparency=st; p.BorderSizePixel=0; p.Rotation=sr; p.ZIndex=1; p.Parent=layer
        uiCorner(p,999)
        local t2=TweenService:Create(p,TweenInfo.new(dur,Enum.EasingStyle.Linear),{Position=UDim2.new(sx+dx,0,1.06,0),Rotation=er,BackgroundTransparency=0.75})
        t2:Play(); t2.Completed:Connect(function() p:Destroy() end)
    end
    task.spawn(function()
        for _=1,8 do spawnPetal(); task.wait(0.04) end
        while active do spawnPetal(); task.wait(math.random(25,55)/100) end
    end)
    return function()
        active=false
        for _,ch in ipairs(layer:GetDescendants()) do
            if ch:IsA("Frame") then tw(ch,1.0,{BackgroundTransparency=1}) end
        end
        task.delay(1.2,function() layer:Destroy() end)
    end
end

-- ══════════════════════════════════════════════════════════════
--  Wings
-- ══════════════════════════════════════════════════════════════
local FEATHERS={
    {size=UDim2.new(0,82,0,32), rot=-6,  yFrac=0.24, alpha=0.07, delay=0.55, amp=8,  period=2.15},
    {size=UDim2.new(0,116,0,46),rot=7,   yFrac=0.36, alpha=0.15, delay=0.40, amp=11, period=2.00},
    {size=UDim2.new(0,140,0,54),rot=18,  yFrac=0.46, alpha=0.21, delay=0.28, amp=13, period=1.88},
    {size=UDim2.new(0,122,0,44),rot=30,  yFrac=0.56, alpha=0.13, delay=0.36, amp=16, period=1.72},
    {size=UDim2.new(0,88,0,28), rot=44,  yFrac=0.65, alpha=0.06, delay=0.50, amp=20, period=1.55},
}
local function makeFeather(hub,side,f)
    local feather=Instance.new("Frame"); feather.AnchorPoint=Vector2.new(side<0 and 1 or 0,0.5)
    feather.Position=UDim2.new(side<0 and 0 or 1,side<0 and 8 or -8,f.yFrac,0)
    feather.Size=UDim2.new(0,0,0,0); feather.BackgroundColor3=C.ACCENT
    feather.BackgroundTransparency=f.alpha; feather.BorderSizePixel=0
    feather.Rotation=0; feather.ZIndex=0; feather.Parent=hub; uiCorner(feather,999)
    local g=Instance.new("UIGradient")
    g.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,C.ACCENT),ColorSequenceKeypoint.new(0.55,C.ACCENT_SOFT),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,220,235))})
    g.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.02),NumberSequenceKeypoint.new(0.55,0.25),NumberSequenceKeypoint.new(1,0.92)})
    g.Rotation=side<0 and 195 or -15; g.Parent=feather
    local rec={frame=feather,flap=nil}
    task.delay(f.delay,function()
        if not feather.Parent then return end
        tw(feather,1.05,{Size=f.size,Rotation=f.rot*side},Enum.EasingStyle.Back); task.wait(1.05)
        if not feather.Parent then return end
        local info=TweenInfo.new(f.period,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1,true)
        rec.flap=TweenService:Create(feather,info,{Rotation=(f.rot+f.amp)*side}); rec.flap:Play()
    end)
    return rec
end
local function makeWings(hub)
    local r={}
    for _,side in ipairs({-1,1}) do for _,f in ipairs(FEATHERS) do table.insert(r,makeFeather(hub,side,f)) end end
    return r
end

-- ══════════════════════════════════════════════════════════════
--  Aimbot / ESP helpers
-- ══════════════════════════════════════════════════════════════
local function getTargetPart(char,mode)
    if mode=="Head" then return char:FindFirstChild("HeadHB") or char:FindFirstChild("Head")
    elseif mode=="Body" then return char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
    else return char:FindFirstChild("LeftFoot") or char:FindFirstChild("RightFoot") or char:FindFirstChild("Left Leg") or char:FindFirstChild("Right Leg") end
end
local function hpColor(pct)
    if pct>0.7 then return Color3.new(0.2,0.85,0.3) elseif pct>0.3 then return Color3.new(1,0.85,0.2) else return Color3.new(1,0.25,0.3) end
end
local function createOverheadGui(head)
    local bb=Instance.new("BillboardGui"); bb.Name="HealthDisplay"; bb.Size=UDim2.new(4,0,1,0)
    bb.StudsOffset=Vector3.new(0,3,0); bb.AlwaysOnTop=true; bb.Parent=head
    local l=Instance.new("TextLabel"); l.Size=UDim2.fromScale(1,1); l.BackgroundTransparency=1
    l.TextScaled=true; l.TextColor3=Color3.new(1,1,1); l.TextStrokeTransparency=0
    l.Font=Enum.Font.GothamBold; l.Parent=bb; return l
end
local function updatePlayerDisplay(player,lbl,hl)
    local char=player.Character; local hum=char and char:FindFirstChildOfClass("Humanoid")
    if not hum then
        if lbl then lbl.Text="Dead"; lbl.TextColor3=Color3.new(1,1,1) end
        if hl then hl:Destroy() end; return
    end
    local pct=hum.Health/hum.MaxHealth; local col=hpColor(pct)
    if lbl then lbl.Text=string.format("❤️ %d",math.floor(hum.Health)); lbl.TextColor3=col end
    if hl then hl.FillColor=col; hl.OutlineColor=col end
end

-- ══════════════════════════════════════════════════════════════
--  Ragebot internals
-- ══════════════════════════════════════════════════════════════
local _cleanRemote=Instance.new("RemoteEvent")
local fireServerNative=clonefunction(_cleanRemote.FireServer); _cleanRemote:Destroy()
local cachedEnumLib
local function enc(name)
    if not cachedEnumLib then
        local mod=RStorage:FindFirstChild("Modules") and RStorage.Modules:FindFirstChild("EnumLibrary")
        if mod then local ok,lib=pcall(require,mod); if ok and type(lib)=="table" then cachedEnumLib=lib end end
    end
    if not cachedEnumLib then return nil end
    local ok,token=pcall(cachedEnumLib.ToEnum,cachedEnumLib,name); return ok and token or nil
end
local cachedFC
local function getFighterController()
    if cachedFC and rawget(cachedFC,"Objects") then return cachedFC end
    for _,m in ipairs(getgc(true)) do
        if type(m)=="table" and rawget(m,"LocalFighter")~=nil and rawget(m,"Objects")~=nil then cachedFC=m; return m end
    end
end
local function getLocalFighter() local c=getFighterController(); return c and rawget(c,"LocalFighter") or nil end
local function isEnemy(player)
    if player==nil or player==LocalPlayer then return false end
    local a,b=LocalPlayer:GetAttribute("TeamID"),player:GetAttribute("TeamID")
    if a~=nil and b~=nil then return a~=b end
    if LocalPlayer.Team~=nil and player.Team~=nil then return LocalPlayer.Team~=player.Team end
    return true
end
local function getRageTarget()
    local ctrl=getFighterController(); local objs=ctrl and rawget(ctrl,"Objects")
    if type(objs)~="table" then return nil end
    local best,bestD=nil,math.huge
    local myRoot=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local myPos=myRoot and myRoot.Position or Vector3.new()
    for _,fighter in ipairs(objs) do
        local player=rawget(fighter,"Player")
        if player==nil or isEnemy(player) then
            local entity=rawget(fighter,"Entity"); local model=entity and rawget(entity,"Model")
            if model then
                local hb=model:FindFirstChild("HitboxHead"); local hum=model:FindFirstChildOfClass("Humanoid")
                if hb and (not hum or hum.Health>0) then
                    local d=(hb.Position-myPos).Magnitude
                    if d<bestD then bestD=d; best={hitboxHead=hb,model=model} end
                end
            end
        end
    end
    return best
end
local function getNearestPlayer()
    local myRoot=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    local nc,nd=nil,math.huge
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LocalPlayer then
            local char=p.Character; local root=char and char:FindFirstChild("HumanoidRootPart")
            local hum=char and char:FindFirstChildOfClass("Humanoid")
            if root and hum and hum.Health>0 then
                local d=(root.Position-myRoot.Position).Magnitude
                if d<nd then nd=d; nc=char end
            end
        end
    end
    return nc
end
local function buildPayload(hb,isRay)
    local pos=hb.Position
    local a1={["\0"]=pos.X,["\1"]=pos.Y,["\2"]=pos.Z,["\3"]=-math.pi/2,["\4"]=0,["\5"]=0}
    local a2={["\0"]=pos.X,["\1"]=pos.Y+1,["\2"]=pos.Z,["\3"]=-math.pi/2,["\4"]=0,["\5"]=0}
    local ex={["\0"]=0,["\1"]=1,["\2"]=0,["\3"]=0,["\4"]=0,["\5"]=0}
    local inner={["\0"]=a1,["\1"]=a2,["\2"]=hb,["\3"]=ex}
    if isRay then return{["\1"]=inner,["\2"]=true} end; return{["\1"]=inner}
end
local function getEquippedGun(fighter)
    local items=rawget(fighter,"Items"); if type(items)~="table" then return nil end
    for _,item in next,items do
        if type(item)=="table" and rawget(item,"IsEquipped") then
            local info=rawget(item,"Info"); if info and rawget(info,"Type")=="Gun" then
                local data=rawget(item,"Data"); if data and (rawget(data,"Ammo") or 0)>0 then return item end
            end
        end
    end
end
local rageRemote
local function getRageRemote()
    if rageRemote then return rageRemote end
    local r=RStorage:FindFirstChild("Remotes") and RStorage.Remotes:FindFirstChild("Replication")
        and RStorage.Remotes.Replication:FindFirstChild("Fighter")
        and RStorage.Remotes.Replication.Fighter:FindFirstChild("UseItem")
    if r and r:IsA("RemoteEvent") then rageRemote=cloneref(r) end
    return rageRemote
end
local function fireAtTarget(fighter,target)
    local remote=getRageRemote(); if not remote then return end
    local item=getEquippedGun(fighter); if not item then return end
    local data=rawget(item,"Data"); local objectId=data and rawget(data,"ObjectID")
    local info=rawget(item,"Info"); local isRay=info and rawget(info,"IsRaycast")==true
    local token=enc("StartShooting"); if not objectId or not token then return end
    fireServerNative(remote,objectId,token,buildPayload(target.hitboxHead,isRay),nil)
end

-- ══════════════════════════════════════════════════════════════
--  Rage Limb Desync module
-- ══════════════════════════════════════════════════════════════
local RageLimbDesync = (function()
    local RS = game:GetService("RunService")
    local LP = Players.LocalPlayer
    local active = false
    local conn1, conn2
    
    local function onCharacter()
        local char = LP.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp then return end
        
        hum.PlatformStand = true
        
        conn1 = RS.Stepped:Connect(function()
            if not active or not char.Parent then return end
            local moveDir = hum.MoveDirection
            
            if moveDir.Magnitude > 0 then
                hrp.Velocity = moveDir * 150 + Vector3.new(0, hrp.Velocity.Y, 0)
            else
                hrp.Velocity = Vector3.new(0, hrp.Velocity.Y, 0)
            end
            
            if hrp.Position.Y < -100 then
                hrp.CFrame = CFrame.new(hrp.Position.X, 50, hrp.Position.Z)
                hrp.Velocity = Vector3.new(0, 0, 0)
            end
        end)
    end
    
    local M = {}
    
    function M.Enable()
        if active then return end
        active = true
        onCharacter()
        conn2 = LP.CharacterAdded:Connect(function(c)
            task.wait(1)
            if active then onCharacter() end
        end)
    end
    
    function M.Disable()
        if not active then return end
        active = false
        if conn1 then conn1:Disconnect() end
        if conn2 then conn2:Disconnect() end
        local char = LP.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.PlatformStand = false end
        end
    end
    
    function M.Active() return active end
    return M
end)()

-- ══════════════════════════════════════════════════════════════
--  AirSlide module
-- ══════════════════════════════════════════════════════════════
local AirSlide = (function()
    local RS=game:GetService("RunService"); local UIS=game:GetService("UserInputService"); local LP=Players.LocalPlayer
    local floorPart=nil; local slamming=false; local inputConn=nil
    local duration=0.4; local friction=0; local keyCode=Enum.KeyCode.LeftControl

    local function placeFloor(hrp)
        if floorPart then floorPart:Destroy() end
        local p=Instance.new("Part"); p.Name="RivalsAntiStuckAirFloor"; p.Size=Vector3.new(8,0.2,8)
        p.Anchored=true; p.CanCollide=true; p.Transparency=1; p.Material=Enum.Material.SmoothPlastic
        p.Friction=friction; p.Parent=workspace; floorPart=p
        local conn
        conn=RS.PreRender:Connect(function()
            if hrp and hrp.Parent then
                if Vector3.new(hrp.AssemblyLinearVelocity.X,0,hrp.AssemblyLinearVelocity.Z).Magnitude<5 then slamming=false end
            end
            if not slamming or not hrp or not hrp.Parent or floorPart~=p then
                if conn then conn:Disconnect() end; p:Destroy(); return
            end
            p.CFrame=hrp.CFrame*CFrame.new(0,-3,0)
        end)
    end
    local function doSlide()
        local char=LP.Character; local hrp=char and char:FindFirstChild("HumanoidRootPart"); local hum=char and char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or slamming then return end
        if hum.FloorMaterial~=Enum.Material.Air then return end
        slamming=true; placeFloor(hrp)
        local total=0; while slamming and total<duration do task.wait(0.01); total+=0.01 end
        slamming=false
        if floorPart then floorPart:Destroy(); floorPart=nil end
    end
    local M={}
    function M.Enable()
        if inputConn then return end
        inputConn=UIS.InputBegan:Connect(function(input,gp)
            if gp then return end
            if input.KeyCode==keyCode or input.KeyCode==Enum.KeyCode.C or input.UserInputType==Enum.UserInputType.Touch then
                task.defer(function()
                    local char=LP.Character; local hum=char and char:FindFirstChildOfClass("Humanoid")
                    if hum and hum.FloorMaterial==Enum.Material.Air then doSlide() end
                end)
            end
        end)
    end
    function M.Disable()
        if inputConn then inputConn:Disconnect(); inputConn=nil end
        slamming=false
        if floorPart then floorPart:Destroy(); floorPart=nil end
    end
    function M.Active() return inputConn~=nil end
    function M.SetDuration(d) duration=d end
    function M.SetFriction(f) friction=f end
    function M.SetKey(k) keyCode=k end
    function M.GetDuration() return duration end
    function M.GetFriction() return friction end
    function M.GetKeyName() return keyCode.Name end
    return M
end)()

-- ══════════════════════════════════════════════════════════════
--  HyperSlide module
-- ══════════════════════════════════════════════════════════════
local HyperSlide = (function()
    local LP=Players.LocalPlayer; local RS=game:GetService("RunService")
    local mech=nil; local ceilingPart=nil; local renderConn=nil; local active=false
    local function ensureCeiling()
        if ceilingPart and ceilingPart.Parent then return ceilingPart end
        local p=Instance.new("Part"); p.Name="HyperSlideCeiling"; p.Size=Vector3.new(8,0.3,8)
        p.Anchored=true; p.CanCollide=true; p.Transparency=1; p.CanQuery=false; p.CanTouch=false
        p.Material=Enum.Material.SmoothPlastic; p.Parent=workspace; ceilingPart=p; return p
    end
    local function tryLoadMech()
        if mech then return true end
        local ps=LP:FindFirstChild("PlayerScripts"); if not ps then return false end
        local ctrl=ps:FindFirstChild("Controllers"); if not ctrl then return false end
        local mc=ctrl:FindFirstChild("MechanicsController"); if not mc then return false end
        local ok,m=pcall(require,mc); if ok and type(m)=="table" then mech=m; return true end
        return false
    end
    local M={}
    function M.Enable()
        if active then return end
        active=true; ensureCeiling(); tryLoadMech()
        renderConn=RS.RenderStepped:Connect(function()
            if not active then return end
            if not mech then tryLoadMech(); if not mech then return end end
            if mech._sliding_cooldown and mech._sliding_cooldown>0 then mech._sliding_cooldown=0 end
            local char=LP.Character; local root=char and char:FindFirstChild("HumanoidRootPart")
            if root and ceilingPart and ceilingPart.Parent then
                ceilingPart.CFrame=CFrame.new(root.Position+Vector3.new(0,2.42,0))
            end
        end)
    end
    function M.Disable()
        active=false
        if renderConn then renderConn:Disconnect(); renderConn=nil end
        if ceilingPart then pcall(function() ceilingPart:Destroy() end); ceilingPart=nil end
    end
    function M.Active() return active end
    function M.HasMech() return mech~=nil end
    return M
end)()

-- ══════════════════════════════════════════════════════════════
--  World Fonts module
-- ══════════════════════════════════════════════════════════════
local WorldFonts = (function()
    local FONTS={
        {name="Gotham",font=Enum.Font.Gotham},{name="Sci-Fi",font=Enum.Font.SciFi},
        {name="Fantasy",font=Enum.Font.Fantasy},{name="Arcade",font=Enum.Font.Arcade},
        {name="Antique",font=Enum.Font.Antique},{name="Code",font=Enum.Font.Code},
        {name="Cartoon",font=Enum.Font.Cartoon},{name="Bodoni",font=Enum.Font.Bodoni},
        {name="Creepster",font=Enum.Font.Creepster},{name="Indie",font=Enum.Font.IndieFlower},
        {name="Garamond",font=Enum.Font.Garamond},{name="Highway",font=Enum.Font.Highway},
        {name="Legacy",font=Enum.Font.Legacy},{name="SourceSans",font=Enum.Font.SourceSans},
        {name="SansBold",font=Enum.Font.SourceSansBold},{name="SansLight",font=Enum.Font.SourceSansLight},
        {name="SansItalic",font=Enum.Font.SourceSansItalic},{name="Sarpanch",font=Enum.Font.Sarpanch},
        {name="Roboto",font=Enum.Font.Roboto},{name="RobotoMono",font=Enum.Font.RobotoMono},
    }
    local originals={}; local active=false; local currentIdx=1; local scanConn=nil
    local function collectRoots()
        local roots={workspace}
        local pg=LocalPlayer:FindFirstChild("PlayerGui"); if pg then table.insert(roots,pg) end
        return roots
    end
    local function applyToInstance(d,fontEnum)
        if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
            if originals[d]==nil then
                originals[d]=d.Font
                d.Destroying:Connect(function() originals[d]=nil end)
            end
            pcall(function() d.Font=fontEnum end)
        end
    end
    local function fullScan(fontEnum)
        for _,root in ipairs(collectRoots()) do
            for _,d in ipairs(root:GetDescendants()) do applyToInstance(d,fontEnum) end
        end
    end
    local function startAutoScan()
        if scanConn then return end
        scanConn=RunService.Heartbeat:Connect(function()
            if not active then return end
            local fontEnum=FONTS[currentIdx].font
            for _,root in ipairs(collectRoots()) do
                for _,d in ipairs(root:GetDescendants()) do
                    if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
                        if originals[d]==nil or d.Font~=fontEnum then applyToInstance(d,fontEnum) end
                    end
                end
            end
        end)
    end
    local function stopAutoScan()
        if scanConn then scanConn:Disconnect(); scanConn=nil end
    end
    local M={}
    function M.Enable(idx)
        if active then currentIdx=idx or currentIdx; fullScan(FONTS[currentIdx].font); return end
        active=true; currentIdx=idx or 1; fullScan(FONTS[currentIdx].font); startAutoScan()
    end
    function M.Disable()
        active=false; stopAutoScan()
        for inst,orig in pairs(originals) do
            if inst and inst.Parent then pcall(function() inst.Font=orig end) end
        end
        originals={}
    end
    function M.Active() return active end
    function M.Set(idx)
        if idx<1 or idx>#FONTS then return end
        currentIdx=idx
        if active then fullScan(FONTS[idx].font) end
    end
    function M.CurrentName() return FONTS[currentIdx].name end
    function M.FontList() return FONTS end
    return M
end)()

-- ══════════════════════════════════════════════════════════════
--  FPS Boost module
-- ══════════════════════════════════════════════════════════════
local FPSBoost = (function()
    local stored={}; local active=false; local scanConn=nil
    local function strip(inst)
        if inst:IsA("ParticleEmitter") or inst:IsA("Smoke") or inst:IsA("Fire") or inst:IsA("Sparkles") then
            if stored[inst]==nil then stored[inst]=inst.Enabled end
            inst.Enabled=false
        elseif inst:IsA("Decal") or inst:IsA("Texture") then
            if stored[inst]==nil then stored[inst]=inst.Transparency end
            inst.Transparency=1
        elseif inst:IsA("Trail") then
            if stored[inst]==nil then stored[inst]=inst.Enabled end
            inst.Enabled=false
        elseif inst:IsA("Atmosphere") then
            if stored[inst]==nil then stored[inst]=inst.Density end
            inst.Density=0
        end
    end
    local M={}
    function M.Enable()
        if active then return end
        active=true; getgenv().FPSBoost=true
        for _,d in ipairs(workspace:GetDescendants()) do strip(d) end
        pcall(function()
            local L=game:GetService("Lighting")
            for _,d in ipairs(L:GetDescendants()) do strip(d) end
            L.GlobalShadows=false; L.FogEnd=100000; L.Brightness=2
        end)
        scanConn=workspace.DescendantAdded:Connect(function(d) if active then strip(d) end end)
    end
    function M.Disable()
        if not active then return end
        active=false; getgenv().FPSBoost=false
        if scanConn then scanConn:Disconnect(); scanConn=nil end
        for inst,val in pairs(stored) do
            if inst and inst.Parent then
                pcall(function()
                    if inst:IsA("ParticleEmitter") or inst:IsA("Trail") or inst:IsA("Smoke") or inst:IsA("Fire") or inst:IsA("Sparkles") then inst.Enabled=val
                    elseif inst:IsA("Decal") or inst:IsA("Texture") then inst.Transparency=val
                    elseif inst:IsA("Atmosphere") then inst.Density=val end
                end)
            end
        end
        stored={}
        pcall(function()
            local L=game:GetService("Lighting"); L.GlobalShadows=true; L.Brightness=1
        end)
    end
    function M.Active() return active end
    return M
end)()

-- ══════════════════════════════════════════════════════════════
--  Triggerbot module
-- ══════════════════════════════════════════════════════════════
local Triggerbot = (function()
    local Mouse=LocalPlayer:GetMouse(); local RS=game:GetService("RunService")
    local active=false; local renderConn=nil; local lastClick=0; local cooldown=0.1
    local M={}
    function M.Enable()
        if active then return end
        active=true; getgenv().Triggerbot=true
        renderConn=RS.RenderStepped:Connect(function()
            if not active then return end
            if tick()-lastClick<cooldown then return end
            local target=Mouse.Target; if not target then return end
            local parent=target.Parent; if not parent then return end
            local hum=parent:FindFirstChildOfClass("Humanoid")
            if not hum or hum.Health<=0 then return end
            local tPlayer=Players:GetPlayerFromCharacter(parent)
            if tPlayer then
                local lpTeam=LocalPlayer:GetAttribute("TeamID")
                local tTeam=tPlayer:GetAttribute("TeamID")
                if lpTeam and tTeam and lpTeam==tTeam then return end
            end
            pcall(function() mouse1click() end)
            lastClick=tick()
        end)
    end
    function M.Disable()
        if not active then return end
        active=false; getgenv().Triggerbot=false
        if renderConn then renderConn:Disconnect(); renderConn=nil end
    end
    function M.Active() return active end
    return M
end)()

-- ══════════════════════════════════════════════════════════════
--  Hub builder
-- ══════════════════════════════════════════════════════════════
local function buildHub(root,song,sakuraCleanup)
    local lp=LocalPlayer; local cam=workspace.CurrentCamera; local running=true

    local saved=loadSettings(); local savedRage=loadRage()
    for k,v in pairs(saved) do getgenv()[k]=v end
    for k,v in pairs(savedRage) do getgenv()[k]=v end
    getgenv()._rageEnabled = saved.RageEnabled or false
    getgenv().RageLimbDesync = saved.RageLimbDesync ~= false

    currentThemeIdx = math.clamp(saved.ThemeIndex or 1, 1, #THEMES)
    for k,v in pairs(THEMES[currentThemeIdx]) do C[k]=v end

    if getgenv().AirSlideDuration then AirSlide.SetDuration(getgenv().AirSlideDuration) end
    if getgenv().AirSlideFriction then AirSlide.SetFriction(getgenv().AirSlideFriction) end
    if getgenv().AirSlideKey and Enum.KeyCode[getgenv().AirSlideKey] then AirSlide.SetKey(Enum.KeyCode[getgenv().AirSlideKey]) end
    if getgenv().WorldFontsEnabled then WorldFonts.Enable(getgenv().WorldFontsIndex or 1) end

    local hub=Instance.new("Frame"); hub.Name="Hub"
    hub.AnchorPoint=Vector2.new(0.5,0.5); hub.Position=UDim2.fromScale(0.5,0.5)
    hub.Size=UDim2.new(0,0,0,0); hub.BackgroundColor3=C.BLACK
    hub.BorderSizePixel=0; hub.ZIndex=2; hub.Parent=root
    uiCorner(hub,12); local hubStroke=uiStroke(hub,C.ACCENT,1.5,0.2)

    local hubGrad=Instance.new("UIGradient")
    hubGrad.Color=ColorSequence.new(C.BLACK,C.DARK); hubGrad.Rotation=90; hubGrad.Parent=hub

    local topBar=Instance.new("Frame"); topBar.AnchorPoint=Vector2.new(0,0)
    topBar.Position=UDim2.new(0,0,0,0); topBar.Size=UDim2.new(1,0,0,3)
    topBar.BackgroundColor3=C.ACCENT; topBar.BorderSizePixel=0; topBar.ZIndex=3; topBar.Parent=hub
    local botBar=Instance.new("Frame"); botBar.AnchorPoint=Vector2.new(0,1)
    botBar.Position=UDim2.new(0,0,1,0); botBar.Size=UDim2.new(1,0,0,3)
    botBar.BackgroundColor3=C.ACCENT; botBar.BorderSizePixel=0; botBar.ZIndex=3; botBar.Parent=hub

    tw(hub,0.4,{Size=UDim2.new(0,HUB_W,0,HUB_H)},Enum.EasingStyle.Back)

    local dragging,dragStart,startPos=false,nil,nil
    hub.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            dragging=true; dragStart=input.Position; startPos=hub.Position
        end
    end)
    hub.InputEnded:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
            local d=input.Position-dragStart
            hub.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
        end
    end)

    local wings=makeWings(hub)

    local sidebar=Instance.new("Frame"); sidebar.Size=UDim2.new(0,SIDEBAR_W,1,0)
    sidebar.BackgroundColor3=C.DARK; sidebar.BorderSizePixel=0; sidebar.ZIndex=3; sidebar.Parent=hub
    uiCorner(sidebar,12)
    local sideSquare=Instance.new("Frame"); sideSquare.AnchorPoint=Vector2.new(1,0)
    sideSquare.Position=UDim2.fromScale(1,0); sideSquare.Size=UDim2.new(0,12,1,0)
    sideSquare.BackgroundColor3=C.DARK; sideSquare.BorderSizePixel=0; sideSquare.ZIndex=3; sideSquare.Parent=sidebar

    local portraitRing=Instance.new("Frame"); portraitRing.AnchorPoint=Vector2.new(0.5,0)
    portraitRing.Position=UDim2.new(0.5,0,0,12); portraitRing.Size=UDim2.new(0,62,0,62)
    portraitRing.BackgroundColor3=C.ACCENT; portraitRing.BorderSizePixel=0; portraitRing.ZIndex=4; portraitRing.Parent=sidebar; uiCorner(portraitRing,31)

    local portrait=Instance.new("ImageLabel"); portrait.AnchorPoint=Vector2.new(0.5,0.5)
    portrait.Position=UDim2.fromScale(0.5,0.5); portrait.Size=UDim2.new(1,-3,1,-3)
    portrait.BackgroundColor3=C.BLACK; portrait.Image=LAUFEY_IMAGE_ID
    portrait.ScaleType=Enum.ScaleType.Crop; portrait.ZIndex=5; portrait.Parent=portraitRing; uiCorner(portrait,29)

    local hubTitle=mkLabel(sidebar,"Laufey.lol",12,Enum.Font.GothamBold,C.ACCENT,4)
    hubTitle.AnchorPoint=Vector2.new(0.5,0); hubTitle.Position=UDim2.new(0.5,0,0,80)
    hubTitle.Size=UDim2.new(1,-8,0,16); hubTitle.TextXAlignment=Enum.TextXAlignment.Center

    local subTit=mkLabel(sidebar,"♪ laufey",9,Enum.Font.Ubuntu,C.MUTED,4)
    subTit.AnchorPoint=Vector2.new(0.5,0); subTit.Position=UDim2.new(0.5,0,0,96)
    subTit.Size=UDim2.new(1,-8,0,12); subTit.TextXAlignment=Enum.TextXAlignment.Center

    local themeLbl=mkLabel(sidebar,"THEME",8,Enum.Font.GothamBold,C.MUTED,4)
    themeLbl.AnchorPoint=Vector2.new(0.5,0); themeLbl.Position=UDim2.new(0.5,0,0,120)
    themeLbl.Size=UDim2.new(1,-8,0,10); themeLbl.TextXAlignment=Enum.TextXAlignment.Center

    local themeBtns={}
    local themeRow=Instance.new("Frame"); themeRow.AnchorPoint=Vector2.new(0.5,0)
    themeRow.Position=UDim2.new(0.5,0,0,134); themeRow.Size=UDim2.new(1,-16,0,20)
    themeRow.BackgroundTransparency=1; themeRow.Parent=sidebar

    local function applyTheme(idx)
        idx = math.clamp(idx or 1, 1, #THEMES)
        currentThemeIdx = idx
        local th = THEMES[idx]
        for k,v in pairs(th) do C[k]=v end
        hub.BackgroundColor3 = th.BLACK
        hubGrad.Color = ColorSequence.new(th.BLACK, th.DARK)
        hubStroke.Color = th.ACCENT
        topBar.BackgroundColor3 = th.ACCENT
        botBar.BackgroundColor3 = th.ACCENT
        sidebar.BackgroundColor3 = th.DARK
        sideSquare.BackgroundColor3 = th.DARK
        portraitRing.BackgroundColor3 = th.ACCENT
        hubTitle.TextColor3 = th.ACCENT
        tabBar.BackgroundColor3 = th.PANEL
        tabBarStroke.Color = th.ACCENT
        for n,b in pairs(tabBtns) do
            local isActive = n==activeTabName
            b.BackgroundColor3 = isActive and th.ACCENT or th.PANEL
            b.TextColor3 = isActive and th.BLACK or th.MUTED
        end
        for i,b in ipairs(themeBtns) do
            if i==idx then b.BackgroundColor3=th.ACCENT; b.TextColor3=th.BLACK
            else b.BackgroundColor3=th.OFF; b.TextColor3=th.INK end
        end
        for _,d in ipairs(root:GetDescendants()) do
            if d:IsA("UIStroke") then
                local skip = false
                for _,tl in ipairs(themeBtns) do if d.Parent==tl then skip=true break end end
                if not skip then pcall(function() d.Color=th.ACCENT end) end
            end
            if d:IsA("Frame") and d.Name=="__swatch" then d.BackgroundColor3=th.ACCENT end
        end
        fontScroll.BackgroundColor3 = th.PANEL
        fontScroll.ScrollBarImageColor3 = th.ACCENT
        refreshFontBtns()
        saveSettings()
    end

    for i,th in ipairs(THEMES) do
        local b=Instance.new("TextButton")
        b.AnchorPoint=Vector2.new(0,0)
        b.Position=UDim2.new((i-1)/#THEMES,0,0,0)
        b.Size=UDim2.new(1/#THEMES,-2,1,0)
        b.BackgroundColor3 = (i==currentThemeIdx) and C.ACCENT or C.OFF
        b.AutoButtonColor=false
        b.Text=tostring(i)
        b.Font=Enum.Font.GothamBold; b.TextSize=10
        b.TextColor3=(i==currentThemeIdx) and C.BLACK or C.INK
        b.ZIndex=5; b.Parent=themeRow; uiCorner(b,5)
        local swatch=Instance.new("Frame"); swatch.Name="__swatch"
        swatch.AnchorPoint=Vector2.new(0.5,1)
        swatch.Position=UDim2.new(0.5,0,1,-2); swatch.Size=UDim2.new(1,-8,0,3)
        swatch.BackgroundColor3=th.ACCENT; swatch.BorderSizePixel=0; swatch.ZIndex=6; swatch.Parent=b
        uiCorner(swatch,2)
        b.MouseButton1Click:Connect(function() applyTheme(i) end)
        themeBtns[i]=b
    end

    local ver=mkLabel(sidebar,"v2.3 — rage desync",7,Enum.Font.Gotham,C.MUTED,4)
    ver.AnchorPoint=Vector2.new(0.5,1); ver.Position=UDim2.new(0.5,0,1,-6)
    ver.Size=UDim2.new(1,-8,0,10); ver.TextXAlignment=Enum.TextXAlignment.Center

    local rightArea=Instance.new("Frame"); rightArea.AnchorPoint=Vector2.new(1,0)
    rightArea.Position=UDim2.fromScale(1,0); rightArea.Size=UDim2.new(1,-SIDEBAR_W,1,0)
    rightArea.BackgroundTransparency=1; rightArea.ZIndex=3; rightArea.Parent=hub

    local TAB_NAMES={"Combat","Player","Visual","Ragebot","AirSlide","Misc"}
    local tabBar=Instance.new("Frame"); tabBar.AnchorPoint=Vector2.new(0,0)
    tabBar.Position=UDim2.new(0,6,0,6); tabBar.Size=UDim2.new(1,-12,0,24)
    tabBar.BackgroundColor3=C.PANEL; tabBar.BorderSizePixel=0; tabBar.ZIndex=4; tabBar.Parent=rightArea
    uiCorner(tabBar,7); local tabBarStroke=uiStroke(tabBar,C.ACCENT,1,0.5)

    local tabBtns={}; local tabPages={}
    local activeTabName="Combat"

    local contentArea=Instance.new("Frame"); contentArea.AnchorPoint=Vector2.new(0,0)
    contentArea.Position=UDim2.new(0,6,0,34); contentArea.Size=UDim2.new(1,-12,1,-40)
    contentArea.BackgroundTransparency=1; contentArea.ZIndex=3; contentArea.ClipsDescendants=true
    contentArea.Parent=rightArea

    local function makeTab(name,idx)
        local btn=Instance.new("TextButton")
        btn.Size=UDim2.new(1/#TAB_NAMES,0,1,0); btn.Position=UDim2.new((idx-1)/#TAB_NAMES,0,0,0)
        btn.BackgroundColor3=C.PANEL; btn.AutoButtonColor=false; btn.Text=name
        btn.Font=Enum.Font.GothamMedium; btn.TextSize=9; btn.TextColor3=C.MUTED
        btn.BorderSizePixel=0; btn.ZIndex=5; btn.Parent=tabBar; tabBtns[name]=btn
        local page=Instance.new("Frame"); page.Size=UDim2.fromScale(1,1)
        page.BackgroundTransparency=1; page.Visible=false; page.ZIndex=3; page.Parent=contentArea
        tabPages[name]=page; return page
    end

    local function switchTab(name)
        activeTabName=name
        for n,p in pairs(tabPages) do
            p.Visible=n==name
            tw(tabBtns[n],0.15,{BackgroundColor3=n==name and C.ACCENT or C.PANEL,TextColor3=n==name and C.BLACK or C.MUTED})
        end
    end

    for i,name in ipairs(TAB_NAMES) do makeTab(name,i); tabBtns[name].MouseButton1Click:Connect(function() switchTab(name) end) end

    local COL_W=(HUB_W-SIDEBAR_W-24)/2
    local ROW_H=26
    local GAP=4
    local function cell(col,row) return col*(COL_W+GAP)+4, row*(ROW_H+GAP)+4 end

    local function gridBtn(page,text,col,row,state)
        local b=Instance.new("TextButton"); b.AnchorPoint=Vector2.new(0,0)
        b.Position=UDim2.fromOffset(cell(col,row)); b.Size=UDim2.fromOffset(COL_W,ROW_H)
        b.BackgroundColor3=state and C.ON or C.OFF; b.AutoButtonColor=false
        b.Text=text; b.Font=Enum.Font.GothamMedium; b.TextSize=10; b.TextColor3=C.INK
        b.ZIndex=4; b.Parent=page; uiCorner(b,6); uiStroke(b,C.ACCENT,1,0.4)
        b.MouseEnter:Connect(function() tw(b,0.12,{BackgroundColor3=C.ACCENT_SOFT}) end)
        b.MouseLeave:Connect(function() tw(b,0.12,{BackgroundColor3=b.BackgroundColor3}) end)
        return b
    end

    local function gridInput(page,labelText,col,row,default)
        local x,y=cell(col,row)
        local row2=Instance.new("Frame"); row2.Position=UDim2.fromOffset(x,y)
        row2.Size=UDim2.fromOffset(COL_W,ROW_H); row2.BackgroundColor3=C.PANEL; row2.ZIndex=4; row2.Parent=page
        uiCorner(row2,6); uiStroke(row2,C.ACCENT,1,0.5)
        local lbl=Instance.new("TextLabel"); lbl.BackgroundTransparency=1
        lbl.Position=UDim2.new(0,6,0,0); lbl.Size=UDim2.new(0.55,0,1,0)
        lbl.Text=labelText; lbl.Font=Enum.Font.Gotham; lbl.TextSize=9
        lbl.TextColor3=C.MUTED; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.ZIndex=5; lbl.Parent=row2
        local box=Instance.new("TextBox"); box.AnchorPoint=Vector2.new(1,0.5)
        box.Position=UDim2.new(1,-4,0.5,0); box.Size=UDim2.new(0,40,0,16)
        box.BackgroundColor3=C.DARK; box.Text=tostring(default); box.Font=Enum.Font.GothamMedium
        box.TextSize=9; box.TextColor3=C.INK; box.ClearTextOnFocus=false; box.ZIndex=5; box.Parent=row2
        uiCorner(box,4); uiStroke(box,C.ACCENT,1,0.6)
        return box
    end

    local function tog(btn,key,onT,offT)
        btn.MouseButton1Click:Connect(function()
            getgenv()[key]=not getgenv()[key]
            btn.Text=getgenv()[key] and onT or offT
            tw(btn,0.2,{BackgroundColor3=getgenv()[key] and C.ON or C.DANGER})
            saveSettings()
        end)
    end

    -- COMBAT
    local cp=tabPages["Combat"]
    local aimBtn    =gridBtn(cp, getgenv().Aimbot and "Aimbot: ON" or "Aimbot: OFF", 0,0,getgenv().Aimbot)
    local fovBtn    =gridBtn(cp, getgenv().ShowFOV and "Show FOV: ON" or "Show FOV: OFF", 1,0,getgenv().ShowFOV)
    local espBtn    =gridBtn(cp, getgenv().ESP and "ESP: ON" or "ESP: OFF", 0,1,getgenv().ESP)
    local espBoxBtn =gridBtn(cp, getgenv().ESPBox and "ESP Box: ON" or "ESP Box: OFF", 1,1,getgenv().ESPBox)
    local tracerBtn =gridBtn(cp, getgenv().Tracers and "Tracers: ON" or "Tracers: OFF", 0,2,getgenv().Tracers)
    local crossBtn  =gridBtn(cp, getgenv().Crosshair and "Crosshair: ON" or "Crosshair: OFF", 1,2,getgenv().Crosshair)
    local smoothBox =gridInput(cp,"Smooth",0,3,getgenv().Smoothness)
    local fovBox    =gridInput(cp,"FOV",1,3,getgenv().FOV)

    local tgtRow=Instance.new("Frame"); local tx,ty=cell(0,4)
    tgtRow.Position=UDim2.fromOffset(tx,ty); tgtRow.Size=UDim2.fromOffset(COL_W*2+GAP,ROW_H)
    tgtRow.BackgroundTransparency=1; tgtRow.ZIndex=4; tgtRow.Parent=cp
    local targetBtns={}
    local tgtW=(COL_W*2+GAP)/3
    for i,mode in ipairs({"Head","Body","Foot"}) do
        local b=Instance.new("TextButton"); b.Size=UDim2.fromOffset(tgtW-2,ROW_H)
        b.Position=UDim2.fromOffset((i-1)*tgtW,0); b.AutoButtonColor=false; b.Text=mode
        b.Font=Enum.Font.GothamMedium; b.TextSize=9; b.TextColor3=C.INK; b.BackgroundColor3=C.OFF
        b.ZIndex=5; b.Parent=tgtRow; uiCorner(b,6); uiStroke(b,C.ACCENT,1,0.4); targetBtns[mode]=b
    end

    local FOV_COLORS={Color3.fromRGB(255,120,180),Color3.fromRGB(100,220,255),Color3.fromRGB(255,200,100),Color3.fromRGB(100,255,150),Color3.fromRGB(255,100,130)}
    local fovColorIdx=1
    local fovColorBtn=gridBtn(cp,"FOV: Pink",0,5,true)

    local ESP_COLORS={{name="Health",r=nil},{name="White",r=Color3.new(1,1,1)},{name="Pink",r=Color3.fromRGB(255,120,180)},{name="Cyan",r=Color3.fromRGB(100,220,255)},{name="Yellow",r=Color3.fromRGB(255,200,50)}}
    local espColorIdx=1
    local espColorBtn=gridBtn(cp,"ESP: Health",1,5,true)

    -- PLAYER
    local pp=tabPages["Player"]
    local noclipBtn  =gridBtn(pp,getgenv().Noclip and "Noclip: ON" or "Noclip: OFF", 0,0,getgenv().Noclip)
    local infJumpBtn =gridBtn(pp,getgenv().InfJump and "Inf Jump: ON" or "Inf Jump: OFF", 1,0,getgenv().InfJump)
    local flyBtn     =gridBtn(pp,getgenv().FlyEnabled and "Fly: ON" or "Fly: OFF", 0,1,getgenv().FlyEnabled)
    local flySpBox   =gridInput(pp,"Fly Spd",1,1,getgenv().FlySpeed)

    -- VISUAL
    local vp=tabPages["Visual"]
    local fullbrightBtn=gridBtn(vp,"Fullbright: OFF",0,0,false)
    local chatSpyBtn   =gridBtn(vp,"Chat Spy: OFF",  1,0,false)

    local fontsToggleBtn=gridBtn(vp, getgenv().WorldFontsEnabled and "World Fonts: ON" or "World Fonts: OFF", 0,1,getgenv().WorldFontsEnabled)
    fontsToggleBtn.MouseButton1Click:Connect(function()
        getgenv().WorldFontsEnabled = not getgenv().WorldFontsEnabled
        if getgenv().WorldFontsEnabled then
            WorldFonts.Enable(getgenv().WorldFontsIndex or 1)
            fontsToggleBtn.Text="World Fonts: ON"
            tw(fontsToggleBtn,0.2,{BackgroundColor3=C.ON})
        else
            WorldFonts.Disable()
            fontsToggleBtn.Text="World Fonts: OFF"
            tw(fontsToggleBtn,0.2,{BackgroundColor3=C.DANGER})
        end
        saveSettings()
    end)

    local fontScroll=Instance.new("ScrollingFrame")
    fontScroll.Position=UDim2.fromOffset(cell(0,2))
    fontScroll.Size=UDim2.fromOffset(COL_W*2+GAP, ROW_H*4+GAP*3)
    fontScroll.BackgroundColor3=C.PANEL; fontScroll.BorderSizePixel=0
    fontScroll.ScrollBarThickness=4; fontScroll.ScrollBarImageColor3=C.ACCENT
    fontScroll.CanvasSize=UDim2.fromOffset(0, math.ceil(#WorldFonts.FontList()/2)*(ROW_H+GAP)+GAP)
    fontScroll.ZIndex=4; fontScroll.Parent=vp; uiCorner(fontScroll,6); uiStroke(fontScroll,C.ACCENT,1,0.5)

    local fontBtns={}
    local function refreshFontBtns()
        local active = getgenv().WorldFontsEnabled
        local cur = getgenv().WorldFontsIndex or 1
        for i,b in ipairs(fontBtns) do
            b.BackgroundColor3 = (active and i==cur) and C.ON or C.OFF
        end
    end

    for i,entry in ipairs(WorldFonts.FontList()) do
        local col=(i-1)%2; local row=math.floor((i-1)/2)
        local b=Instance.new("TextButton")
        b.Position=UDim2.fromOffset(GAP+col*(COL_W/2), GAP+row*(ROW_H+GAP))
        b.Size=UDim2.fromOffset(COL_W/2-GAP-2, ROW_H)
        b.BackgroundColor3=C.OFF; b.AutoButtonColor=false
        b.Text=entry.name; b.Font=Enum.Font.GothamMedium; b.TextSize=9; b.TextColor3=C.INK
        b.BorderSizePixel=0; b.ZIndex=5; b.Parent=fontScroll
        uiCorner(b,5); uiStroke(b,C.ACCENT,1,0.4)
        b.MouseEnter:Connect(function() tw(b,0.12,{BackgroundColor3=C.ACCENT_SOFT}) end)
        b.MouseLeave:Connect(function() refreshFontBtns() end)
        b.MouseButton1Click:Connect(function()
            getgenv().WorldFontsIndex = i
            if not getgenv().WorldFontsEnabled then
                getgenv().WorldFontsEnabled = true
                fontsToggleBtn.Text="World Fonts: ON"
                tw(fontsToggleBtn,0.2,{BackgroundColor3=C.ON})
            end
            WorldFonts.Enable(i)
            refreshFontBtns()
            saveSettings()
        end)
        fontBtns[i]=b
    end
    refreshFontBtns()

    -- RAGEBOT
    local rp=tabPages["Ragebot"]
    local rageToggleBtn=gridBtn(rp, getgenv()._rageEnabled and "Ragebot: ON" or "Ragebot: OFF", 0,0,getgenv()._rageEnabled)
    rageToggleBtn.MouseButton1Click:Connect(function()
        getgenv()._rageEnabled=not getgenv()._rageEnabled
        rageToggleBtn.Text=getgenv()._rageEnabled and "Ragebot: ON" or "Ragebot: OFF"
        tw(rageToggleBtn,0.2,{BackgroundColor3=getgenv()._rageEnabled and C.ON or C.DANGER})
        
        if getgenv()._rageEnabled and getgenv().RageLimbDesync then
            RageLimbDesync.Enable()
        else
            RageLimbDesync.Disable()
        end
        saveSettings()
    end)

    local desyncBtn = gridBtn(rp, getgenv().RageLimbDesync and "Limb Desync: ON" or "Limb Desync: OFF", 1,0, getgenv().RageLimbDesync)
    desyncBtn.MouseButton1Click:Connect(function()
        getgenv().RageLimbDesync = not getgenv().RageLimbDesync
        desyncBtn.Text = getgenv().RageLimbDesync and "Limb Desync: ON" or "Limb Desync: OFF"
        tw(desyncBtn,0.2,{BackgroundColor3=getgenv().RageLimbDesync and C.ON or C.DANGER})
        
        if getgenv()._rageEnabled then
            if getgenv().RageLimbDesync then RageLimbDesync.Enable() else RageLimbDesync.Disable() end
        end
        saveSettings()
    end)

    local orbitBtn=gridBtn(rp,"Orbit: ON",0,1,true)
    orbitBtn.MouseButton1Click:Connect(function()
        getgenv().ORBIT_ENABLED=not getgenv().ORBIT_ENABLED
        orbitBtn.Text=getgenv().ORBIT_ENABLED and "Orbit: ON" or "Orbit: OFF"
        tw(orbitBtn,0.2,{BackgroundColor3=getgenv().ORBIT_ENABLED and C.ON or C.DANGER})
        saveRage()
    end)
    local voidTBox=gridInput(rp,"Void T",1,1,getgenv().VOID_TIME)
    local atkTBox=gridInput(rp,"Atk T",0,2,getgenv().ATTACK_TIME)
    local backBox=gridInput(rp,"Back",1,2,getgenv().BACK_OFFSET)
    local heightBox=gridInput(rp,"Height",0,3,getgenv().HEIGHT_OFFSET)
    local voidYBox=gridInput(rp,"Void Y",1,3,getgenv().VOID_Y)
    local radiusBox=gridInput(rp,"Rad",0,4,getgenv().ORBIT_RADIUS)
    local speedBox=gridInput(rp,"Speed",1,4,getgenv().ORBIT_SPEED)
    local oHeightBox=gridInput(rp,"Orb H",0,5,getgenv().ORBIT_HEIGHT)
    local function wireRageInput(box,key)
        box.FocusLost:Connect(function()
            local num=tonumber(box.Text)
            if num then getgenv()[key]=num; saveRage() else box.Text=tostring(getgenv()[key]) end
        end)
    end
    wireRageInput(voidTBox,"VOID_TIME")
    wireRageInput(atkTBox,"ATTACK_TIME")
    wireRageInput(backBox,"BACK_OFFSET")
    wireRageInput(heightBox,"HEIGHT_OFFSET")
    wireRageInput(voidYBox,"VOID_Y")
    wireRageInput(radiusBox,"ORBIT_RADIUS")
    wireRageInput(speedBox,"ORBIT_SPEED")
    wireRageInput(oHeightBox,"ORBIT_HEIGHT")

    local rageStatus=mkLabel(rp,"idle",9,Enum.Font.GothamMedium,C.MUTED,4)
    rageStatus.Position=UDim2.fromOffset(cell(1,5)); rageStatus.Size=UDim2.fromOffset(COL_W,ROW_H)

    if getgenv()._rageEnabled and getgenv().RageLimbDesync then RageLimbDesync.Enable() end

    -- AIRSLIDE
    local asp=tabPages["AirSlide"]
    local asToggleBtn =gridBtn(asp, getgenv().AirSlideEnabled and "AirSlide: ON" or "AirSlide: OFF", 0,0,getgenv().AirSlideEnabled)
    local asStatusLbl =mkLabel(asp, AirSlide.Active() and "armed" or "disabled", 9,Enum.Font.GothamMedium,AirSlide.Active() and C.PINK or C.MUTED,4)
    asStatusLbl.Position=UDim2.fromOffset(cell(1,0)); asStatusLbl.Size=UDim2.fromOffset(COL_W,ROW_H)
    asStatusLbl.TextXAlignment=Enum.TextXAlignment.Left; asStatusLbl.TextSize=9

    local asKeyBox   =gridInput(asp,"Key",     0,1,AirSlide.GetKeyName())
    local asDurBox   =gridInput(asp,"Dur",     1,1,AirSlide.GetDuration())
    local asFricBox  =gridInput(asp,"Friction",0,2,AirSlide.GetFriction())

    local asInfo=mkLabel(asp, "AirSlide: jump, hold movement, press key mid-air.\nHyperSlide: zeroes slide cooldown + ceiling follows.", 9,Enum.Font.Gotham,C.MUTED,4)
    asInfo.Position=UDim2.fromOffset(cell(0,3))
    asInfo.Size=UDim2.fromOffset(COL_W*2+GAP, ROW_H*2+GAP)
    asInfo.TextWrapped=true; asInfo.TextYAlignment=Enum.TextYAlignment.Top
    asInfo.TextXAlignment=Enum.TextXAlignment.Left

    local hsToggleBtn =gridBtn(asp,"HyperSlide: OFF",0,6,false)
    local hsStatusLbl =mkLabel(asp,"disabled",9,Enum.Font.GothamMedium,C.MUTED,4)
    hsStatusLbl.Position=UDim2.fromOffset(cell(1,6)); hsStatusLbl.Size=UDim2.fromOffset(COL_W,ROW_H)
    hsStatusLbl.TextXAlignment=Enum.TextXAlignment.Left; hsStatusLbl.TextSize=9

    asToggleBtn.MouseButton1Click:Connect(function()
        if AirSlide.Active() then
            AirSlide.Disable(); getgenv().AirSlideEnabled=false
            asToggleBtn.Text="AirSlide: OFF"; tw(asToggleBtn,0.2,{BackgroundColor3=C.DANGER})
            asStatusLbl.Text="disabled"; asStatusLbl.TextColor3=C.MUTED
        else
            AirSlide.Enable(); getgenv().AirSlideEnabled=true
            asToggleBtn.Text="AirSlide: ON"; tw(asToggleBtn,0.2,{BackgroundColor3=C.ON})
            asStatusLbl.Text="armed"; asStatusLbl.TextColor3=C.PINK
        end
        saveSettings()
    end)

    asDurBox.FocusLost:Connect(function()
        local n=tonumber(asDurBox.Text)
        if n and n>0 and n<=5 then AirSlide.SetDuration(n); getgenv().AirSlideDuration=n; asDurBox.Text=tostring(n)
        else asDurBox.Text=tostring(AirSlide.GetDuration()) end
        saveSettings()
    end)
    asFricBox.FocusLost:Connect(function()
        local n=tonumber(asFricBox.Text)
        if n and n>=0 then AirSlide.SetFriction(n); getgenv().AirSlideFriction=n; asFricBox.Text=tostring(n)
        else asFricBox.Text=tostring(AirSlide.GetFriction()) end
        saveSettings()
    end)
    asKeyBox.FocusLost:Connect(function()
        local k=asKeyBox.Text:upper()
        if Enum.KeyCode[k] then AirSlide.SetKey(Enum.KeyCode[k]); getgenv().AirSlideKey=k; asKeyBox.Text=k
        else asKeyBox.Text=AirSlide.GetKeyName() end
        saveSettings()
    end)

    hsToggleBtn.MouseButton1Click:Connect(function()
        if HyperSlide.Active() then
            HyperSlide.Disable(); getgenv().HyperSlideEnabled=false
            hsToggleBtn.Text="HyperSlide: OFF"; tw(hsToggleBtn,0.2,{BackgroundColor3=C.DANGER})
            hsStatusLbl.Text="disabled"; hsStatusLbl.TextColor3=C.MUTED
        else
            HyperSlide.Enable(); getgenv().HyperSlideEnabled=true
            hsToggleBtn.Text="HyperSlide: ON"; tw(hsToggleBtn,0.2,{BackgroundColor3=C.ON})
            hsStatusLbl.Text = HyperSlide.HasMech() and "active" or "waiting for mech…"
            hsStatusLbl.TextColor3 = HyperSlide.HasMech() and C.PINK or C.MUTED
        end
        saveSettings()
    end)

    if getgenv().HyperSlideEnabled then
        HyperSlide.Enable()
        hsToggleBtn.Text="HyperSlide: ON"
        tw(hsToggleBtn,0,{BackgroundColor3=C.ON})
        hsStatusLbl.Text = HyperSlide.HasMech() and "active" or "waiting for mech…"
        hsStatusLbl.TextColor3 = HyperSlide.HasMech() and C.PINK or C.MUTED
    end

    -- MISC
    local mp=tabPages["Misc"]
    local valHandsBtn  =gridBtn(mp,"Val Hands",     0,0,false)
    local killSndBtn   =gridBtn(mp,"Kill Sound",    1,0,false)
    local spoofBtn     =gridBtn(mp,"Rivals Spoof",  0,1,false)
    local alyaBtn      =gridBtn(mp,"Alya Texture",  1,1,false)
    local dracoBtn     =gridBtn(mp,"Draco",         0,2,false)
    local stretchBtn   =gridBtn(mp,"Stretched FOV", 1,2,false)
    local rickBtn      =gridBtn(mp,"Rick",          0,3,false)
    local listFeatBtn  =gridBtn(mp,"List Features", 1,3,true)
    local saveBtn      =gridBtn(mp,"Save Config",   0,4,true)
    local closeBtn     =gridBtn(mp,"Close Hub",     1,4,false)
    tw(closeBtn,0,{BackgroundColor3=C.DANGER})

    local searchRow = Instance.new("Frame")
    searchRow.AnchorPoint = Vector2.new(0.5,0)
    searchRow.Position = UDim2.new(0.5,0,0,cell(0,5))
    searchRow.Size = UDim2.new(1,-16,0,ROW_H)
    searchRow.BackgroundColor3 = C.PANEL
    searchRow.ZIndex = 4; searchRow.Parent = mp
    uiCorner(searchRow,6); uiStroke(searchRow,C.ACCENT,1,0.5)
    local searchBox = Instance.new("TextBox")
    searchBox.AnchorPoint = Vector2.new(0,0.5); searchBox.Position = UDim2.new(0,6,0.5,0)
    searchBox.Size = UDim2.new(1,-12,0,16); searchBox.BackgroundTransparency = 1
    searchBox.PlaceholderText = "search buttons..."; searchBox.PlaceholderColor3 = C.MUTED
    searchBox.Font = Enum.Font.Gotham; searchBox.TextSize = 10; searchBox.TextColor3 = C.INK
    searchBox.ClearTextOnFocus = false; searchBox.Text = ""
    searchBox.ZIndex = 5; searchBox.Parent = searchRow

    local allButtons = {}
    local function collectButtons()
        allButtons = {}
        for _,page in pairs(tabPages) do
            for _,d in ipairs(page:GetDescendants()) do
                if d:IsA("TextButton") then table.insert(allButtons, d) end
            end
        end
    end
    collectButtons()
    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local q = searchBox.Text:lower()
        for _,b in ipairs(allButtons) do
            b.Visible = (q == "" or b.Text:lower():find(q,1,true) ~= nil)
        end
    end)

    local fpsBtn = gridBtn(mp, getgenv().FPSBoost and "FPS Boost: ON" or "FPS Boost: OFF", 0,6, getgenv().FPSBoost)
    fpsBtn.MouseButton1Click:Connect(function()
        if FPSBoost.Active() then
            FPSBoost.Disable(); getgenv().FPSBoost=false
            fpsBtn.Text="FPS Boost: OFF"; tw(fpsBtn,0.2,{BackgroundColor3=C.DANGER})
        else
            FPSBoost.Enable(); getgenv().FPSBoost=true
            fpsBtn.Text="FPS Boost: ON"; tw(fpsBtn,0.2,{BackgroundColor3=C.ON})
        end
        saveSettings()
    end)
    if getgenv().FPSBoost then
        FPSBoost.Enable()
        fpsBtn.Text="FPS Boost: ON"; tw(fpsBtn,0,{BackgroundColor3=C.ON})
    end

    local trigBtn = gridBtn(mp, getgenv().Triggerbot and "Triggerbot: ON" or "Triggerbot: OFF", 1,6, getgenv().Triggerbot)
    trigBtn.MouseButton1Click:Connect(function()
        if Triggerbot.Active() then
            Triggerbot.Disable(); getgenv().Triggerbot=false
            trigBtn.Text="Triggerbot: OFF"; tw(trigBtn,0.2,{BackgroundColor3=C.DANGER})
        else
            Triggerbot.Enable(); getgenv().Triggerbot=true
            trigBtn.Text="Triggerbot: ON"; tw(trigBtn,0.2,{BackgroundColor3=C.ON})
        end
        saveSettings()
    end)
    if getgenv().Triggerbot then
        Triggerbot.Enable()
        trigBtn.Text="Triggerbot: ON"; tw(trigBtn,0,{BackgroundColor3=C.ON})
    end

    UserInputService.InputBegan:Connect(function(input,gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.G then
            if Triggerbot.Active() then
                Triggerbot.Disable(); getgenv().Triggerbot=false
                trigBtn.Text="Triggerbot: OFF"; tw(trigBtn,0.2,{BackgroundColor3=C.DANGER})
            else
                Triggerbot.Enable(); getgenv().Triggerbot=true
                trigBtn.Text="Triggerbot: ON"; tw(trigBtn,0.2,{BackgroundColor3=C.ON})
            end
            saveSettings()
        end
    end)

    dracoBtn.MouseButton1Click:Connect(function()
        pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/mrbeanissohot/DraconicWildcat/refs/heads/main/Draco.lua",true))() end)
    end)
    stretchBtn.MouseButton1Click:Connect(function()
        pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Stretched-Resolution-Higher-FOV-48170"))() end)
    end)
    rickBtn.MouseButton1Click:Connect(function()
        pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/betterthanbefore0207767837-cyber/Rick/refs/heads/main/Ricyyy"))() end)
    end)

    listFeatBtn.MouseButton1Click:Connect(function()
        local lines = {
            "═══ LAUFEY.LOL v2.3 — FEATURES ═══",
            "[COMBAT] Aimbot / ShowFOV / ESP / ESPBox / Tracers / Crosshair",
            "         FOV color / ESP color / Target modes",
            "[PLAYER] Noclip / InfJump / Fly",
            "[VISUAL] Fullbright / World Fonts (20 fonts)",
            "[RAGEBOT] Auto-fire / Orbit + configurable timings",
            "          + Limb Desync (ragdoll anti-aim)",
            "[AIRSLIDE] AirSlide (key/dur/friction)",
            "           HyperSlide (zeroes slide cooldown)",
            "[MISC]   FPS Boost / Triggerbot (G key) / Search / Draco",
            "         Stretched FOV / Rick / Val Hands / Kill Sound",
            "         Rivals Spoof / Alya Texture / Save Config",
            "[THEMES] Laufey / Cyber / Ember / Jade",
            "[AUTO]   Unlock-All on inject",
            "[KEYS]   G = Triggerbot, RightShift = hide hub",
            "═══════════════════════════════════",
        }
        for _, l in ipairs(lines) do print(l) end
        print("[Laufey.lol] Feature list printed to console (".. #lines .." lines)")
    end)

    valHandsBtn.MouseButton1Click:Connect(function() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/mrbeanissohot/Bean-sValorant/refs/heads/main/Valorant.lua",true))() end) end)
    killSndBtn.MouseButton1Click:Connect(function() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/betterthanbefore0207767837-cyber/Xgivfc/refs/heads/main/Ffvhhvxd",true))() end) end)
    spoofBtn.MouseButton1Click:Connect(function()
        pcall(function()
            getgenv().Config={victim=11480709640,helper="",level=45648,streak=15765,elo=0,keys=67,premium=false,verified=false,unlockall=false,platform="VR",join="discord.gg/rivalscomp"}
            loadstring(game:HttpGet("https://raw.githubusercontent.com/WEFGQERQEGWGE/a/refs/heads/main/UDRCRFRAMESCRIPT.lua"))()
        end)
    end)
    alyaBtn.MouseButton1Click:Connect(function() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/betterthanbefore0207767837-cyber/Fggb/refs/heads/main/Fgnn"))() end) end)
    saveBtn.MouseButton1Click:Connect(function()
        saveSettings(); saveRage(); saveBtn.Text="Saved ✓"
        task.delay(1.2,function() if saveBtn and saveBtn.Parent then saveBtn.Text="Save Config" end end)
    end)

    local toggleBtn=Instance.new("TextButton"); toggleBtn.AnchorPoint=Vector2.new(0,0)
    toggleBtn.Position=UDim2.new(0,10,0,10); toggleBtn.Size=UDim2.new(0,80,0,22)
    toggleBtn.BackgroundColor3=C.BLACK; toggleBtn.AutoButtonColor=false
    toggleBtn.Text="Hide GUI"; toggleBtn.Font=Enum.Font.GothamMedium; toggleBtn.TextSize=9
    toggleBtn.TextColor3=C.INK; toggleBtn.ZIndex=10; toggleBtn.Parent=root
    uiCorner(toggleBtn,7); uiStroke(toggleBtn,C.ACCENT,1.5,0.25)

    do
        local dragging,dragStart,startPos,moved=false,nil,nil,false
        toggleBtn.InputBegan:Connect(function(input)
            if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
                dragging=true; moved=false; dragStart=input.Position; startPos=toggleBtn.Position
            end
        end)
        toggleBtn.InputEnded:Connect(function(input)
            if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=false end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
                local d=input.Position-dragStart
                if d.Magnitude>4 then moved=true end
                toggleBtn.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
            end
        end)
    end

    local guiVisible=true
    toggleBtn.MouseButton1Click:Connect(function()
        guiVisible=not guiVisible; hub.Visible=guiVisible
        toggleBtn.Text=guiVisible and "Hide GUI" or "Show GUI"
    end)

    switchTab("Combat")

    local function refreshTargets()
        for mode,b in pairs(targetBtns) do tw(b,0.2,{BackgroundColor3=getgenv().TargetMode==mode and C.ON or C.OFF}) end
    end
    for mode,b in pairs(targetBtns) do
        b.MouseButton1Click:Connect(function() getgenv().TargetMode=mode; refreshTargets(); saveSettings() end)
    end
    refreshTargets()

    tog(aimBtn,"Aimbot","Aimbot: ON","Aimbot: OFF")
    tog(fovBtn,"ShowFOV","Show FOV: ON","Show FOV: OFF")
    tog(espBtn,"ESP","ESP: ON","ESP: OFF")
    tog(espBoxBtn,"ESPBox","ESP Box: ON","ESP Box: OFF")
    tog(tracerBtn,"Tracers","Tracers: ON","Tracers: OFF")

    smoothBox.FocusLost:Connect(function() getgenv().Smoothness=tonumber(smoothBox.Text) or getgenv().Smoothness; smoothBox.Text=tostring(getgenv().Smoothness); saveSettings() end)
    fovBox.FocusLost:Connect(function() getgenv().FOV=tonumber(fovBox.Text) or getgenv().FOV; fovBox.Text=tostring(getgenv().FOV); saveSettings() end)

    fovColorBtn.MouseButton1Click:Connect(function()
        fovColorIdx=(fovColorIdx%#FOV_COLORS)+1; cir.Color=FOV_COLORS[fovColorIdx]
        local names={"Pink","Cyan","Orange","Green","Red"}; fovColorBtn.Text="FOV: "..names[fovColorIdx]
    end)
    espColorBtn.MouseButton1Click:Connect(function()
        espColorIdx=(espColorIdx%#ESP_COLORS)+1; espColorBtn.Text="ESP: "..ESP_COLORS[espColorIdx].name
    end)

    crossBtn.MouseButton1Click:Connect(function()
        getgenv().Crosshair=not (getgenv().Crosshair or false)
        crossBtn.Text=getgenv().Crosshair and "Crosshair: ON" or "Crosshair: OFF"
        tw(crossBtn,0.2,{BackgroundColor3=getgenv().Crosshair and C.ON or C.DANGER})
        for _,l in ipairs(chexLines) do l.Visible=getgenv().Crosshair end
        for _,l in ipairs(chexGlow) do l.Visible=getgenv().Crosshair end
        saveSettings()
    end)

    tog(noclipBtn,"Noclip","Noclip: ON","Noclip: OFF")
    RunService.Stepped:Connect(function()
        if not running or not getgenv().Noclip then return end
        local char=lp.Character; if not char then return end
        for _,p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end
    end)

    tog(infJumpBtn,"InfJump","Inf Jump: ON","Inf Jump: OFF")
    UserInputService.JumpRequest:Connect(function()
        if not running or not getgenv().InfJump then return end
        local char=lp.Character; local hum=char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)

    tog(flyBtn,"FlyEnabled","Fly: ON","Fly: OFF")
    flySpBox.FocusLost:Connect(function() getgenv().FlySpeed=tonumber(flySpBox.Text) or 60; flySpBox.Text=tostring(getgenv().FlySpeed); saveSettings() end)

    local flyBV,flyBG,flyConn
    flyBtn.MouseButton1Click:Connect(function()
        if getgenv().FlyEnabled then
            local char=lp.Character; local hrp=char and char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
            flyBV=Instance.new("BodyVelocity"); flyBV.Velocity=Vector3.zero; flyBV.MaxForce=Vector3.new(1e5,1e5,1e5); flyBV.Parent=hrp
            flyBG=Instance.new("BodyGyro"); flyBG.MaxTorque=Vector3.new(1e5,1e5,1e5); flyBG.P=1e4; flyBG.Parent=hrp
            flyConn=RunService.Heartbeat:Connect(function()
                if not running or not getgenv().FlyEnabled then
                    if flyBV then flyBV:Destroy(); flyBV=nil end
                    if flyBG then flyBG:Destroy(); flyBG=nil end
                    if flyConn then flyConn:Disconnect(); flyConn=nil end; return
                end
                local cf=cam.CFrame; local vel=Vector3.zero; local spd=getgenv().FlySpeed
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel=vel+cf.LookVector*spd end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel=vel-cf.LookVector*spd end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel=vel-cf.RightVector*spd end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel=vel+cf.RightVector*spd end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel=vel+Vector3.new(0,spd,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then vel=vel-Vector3.new(0,spd,0) end
                flyBV.Velocity=vel; flyBG.CFrame=cf
            end)
        else
            if flyBV then flyBV:Destroy(); flyBV=nil end
            if flyBG then flyBG:Destroy(); flyBG=nil end
            if flyConn then flyConn:Disconnect(); flyConn=nil end
        end; saveSettings()
    end)

    local origAmb,origOut
    tog(fullbrightBtn,"Fullbright","Fullbright: ON","Fullbright: OFF")
    fullbrightBtn.MouseButton1Click:Connect(function()
        if getgenv().Fullbright then
            origAmb=game:GetService("Lighting").Ambient; origOut=game:GetService("Lighting").OutdoorAmbient
            game:GetService("Lighting").Ambient=Color3.new(1,1,1); game:GetService("Lighting").OutdoorAmbient=Color3.new(1,1,1); game:GetService("Lighting").Brightness=2
        else
            if origAmb then game:GetService("Lighting").Ambient=origAmb end
            if origOut then game:GetService("Lighting").OutdoorAmbient=origOut end
            game:GetService("Lighting").Brightness=1
        end
    end)
    tog(chatSpyBtn,"ChatSpy","Chat Spy: ON","Chat Spy: OFF")

    local espBoxD={}; local tracerD={}
    local function getBox(player)
        if not espBoxD[player] then
            local lines={}; for i=1,4 do local l=Drawing.new("Line"); l.Thickness=1.5; l.Transparency=0; l.Visible=false; lines[i]=l end
            espBoxD[player]=lines
        end; return espBoxD[player]
    end
    local function getTracer(player)
        if not tracerD[player] then local l=Drawing.new("Line"); l.Thickness=1.2; l.Transparency=0.15; l.Visible=false; tracerD[player]=l end
        return tracerD[player]
    end
    local function removeDrawings(player)
        if espBoxD[player] then for _,l in ipairs(espBoxD[player]) do pcall(function() l:Remove() end) end; espBoxD[player]=nil end
        if tracerD[player] then pcall(function() tracerD[player]:Remove() end); tracerD[player]=nil end
    end

    local CHEX_COLOR=Color3.fromRGB(120,220,255)
    local CHEX_R=28
    local chexAngle=0
    local chexLines={}
    for i=1,6 do
        local l=Drawing.new("Line")
        l.Thickness=2.4
        l.Color=CHEX_COLOR
        l.Transparency=0.0
        l.Visible=false
        chexLines[i]=l
    end
    local chexGlow={}
    for i=1,6 do
        local l=Drawing.new("Line")
        l.Thickness=5.0
        l.Color=Color3.fromRGB(180,240,255)
        l.Transparency=0.55
        l.Visible=false
        chexGlow[i]=l
    end
    local function triVerts(cx,cy,r,ba)
        local v={}; for i=0,2 do local a=math.rad(ba+i*120); v[i+1]=Vector2.new(cx+r*math.cos(a),cy+r*math.sin(a)) end; return v
    end

    local cir=Drawing.new("Circle"); cir.Thickness=1.5; cir.Color=C.ACCENT; cir.Transparency=0.6; cir.Visible=true
    local VP=workspace.CurrentCamera.ViewportSize

    local rageState={phase="void",t0=os.clock(),attackTarget=nil}
    local rageOrbitAngle=0; local rageLastHB=os.clock()
    local rageCachedTarget,rageLastScan=nil,0

    local function scanRageTarget()
        local now=os.clock()
        if now-rageLastScan>0.2 then rageCachedTarget=getRageTarget(); rageLastScan=now end
        return rageCachedTarget
    end
    local function resetRage()
        rageState.phase="void"; rageState.t0=os.clock(); rageState.attackTarget=nil
        rageCachedTarget=nil; rageLastScan=0; rageOrbitAngle=0
    end

    pcall(function()
        local ok,gun=pcall(function() return require(lp.PlayerScripts.Modules.ItemTypes.Gun) end)
        if ok and gun and gun.IsFullyAiming then
            local old=gun.IsFullyAiming
            gun.IsFullyAiming=function(self,...) if getgenv()._rageEnabled then return true end return old(self,...) end
        end
    end)

    local rsConn=RunService.RenderStepped:Connect(function()
        if not running then return end
        VP=workspace.CurrentCamera.ViewportSize
        cir.Visible=getgenv().ShowFOV and guiVisible; cir.Radius=getgenv().FOV; cir.Position=UserInputService:GetMouseLocation()

        if getgenv().Crosshair then
            chexAngle=chexAngle+1.4
            local mp=UserInputService:GetMouseLocation(); local cx,cy=mp.X,mp.Y
            local v1=triVerts(cx,cy,CHEX_R,chexAngle); local v2=triVerts(cx,cy,CHEX_R,chexAngle+180)
            chexLines[1].From=v1[1];chexLines[1].To=v1[2]; chexLines[2].From=v1[2];chexLines[2].To=v1[3]; chexLines[3].From=v1[3];chexLines[3].To=v1[1]
            chexLines[4].From=v2[1];chexLines[4].To=v2[2]; chexLines[5].From=v2[2];chexLines[5].To=v2[3]; chexLines[6].From=v2[3];chexLines[6].To=v2[1]
            for _,l in ipairs(chexLines) do l.Visible=true end
            chexGlow[1].From=v1[1];chexGlow[1].To=v1[2]; chexGlow[2].From=v1[2];chexGlow[2].To=v1[3]; chexGlow[3].From=v1[3];chexGlow[3].To=v1[1]
            chexGlow[4].From=v2[1];chexGlow[4].To=v2[2]; chexGlow[5].From=v2[2];chexGlow[5].To=v2[3]; chexGlow[6].From=v2[3];chexGlow[6].To=v2[1]
            for _,l in ipairs(chexGlow) do l.Visible=true end
        else
            for _,l in ipairs(chexLines) do l.Visible=false end
            for _,l in ipairs(chexGlow) do l.Visible=false end
        end

        for _,v in ipairs(Players:GetPlayers()) do
            if v==lp or not v.Character then
                if espBoxD[v] then for _,l in ipairs(espBoxD[v]) do l.Visible=false end end
                if tracerD[v] then tracerD[v].Visible=false end
            else
                local char=v.Character; local hrp=char:FindFirstChild("HumanoidRootPart")
                local head=char:FindFirstChild("Head"); local hum=char:FindFirstChild("Humanoid")
                local alive=hum and hum.Health>0
                local ec=ESP_COLORS[espColorIdx]; local col
                if ec.r then col=ec.r
                elseif hum then local t=hum.Health/math.max(hum.MaxHealth,1); col=Color3.fromRGB(math.floor((1-t)*255),math.floor(t*200),60)
                else col=Color3.new(1,1,1) end

                if getgenv().ESPBox and hrp and head then
                    local lines=getBox(v)
                    local rsp,ron=cam:WorldToViewportPoint(hrp.Position); local hsp,hon=cam:WorldToViewportPoint(head.Position+Vector3.new(0,0.7,0))
                    if ron and hon and alive then
                        local h=math.abs(rsp.Y-hsp.Y)*1.2; local w=h*0.5; local cx=hsp.X
                        local top=hsp.Y-(h*0.1); local bot=top+h; local lft=cx-w*0.5; local rgt=cx+w*0.5
                        lines[1].From=Vector2.new(lft,top);lines[1].To=Vector2.new(rgt,top)
                        lines[2].From=Vector2.new(lft,bot);lines[2].To=Vector2.new(rgt,bot)
                        lines[3].From=Vector2.new(lft,top);lines[3].To=Vector2.new(lft,bot)
                        lines[4].From=Vector2.new(rgt,top);lines[4].To=Vector2.new(rgt,bot)
                        for _,l in ipairs(lines) do l.Color=col; l.Visible=true end
                    else for _,l in ipairs(lines) do l.Visible=false end end
                elseif espBoxD[v] then for _,l in ipairs(espBoxD[v]) do l.Visible=false end end

                if getgenv().Tracers and hrp then
                    local tracer=getTracer(v); local sp,onS=cam:WorldToViewportPoint(hrp.Position)
                    if onS and alive then tracer.From=Vector2.new(VP.X*0.5,VP.Y); tracer.To=Vector2.new(sp.X,sp.Y); tracer.Color=col; tracer.Visible=true
                    else tracer.Visible=false end
                elseif tracerD[v] then tracerD[v].Visible=false end
            end
        end

        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) and getgenv().Aimbot then
            local tg,d=nil,getgenv().FOV; local m=UserInputService:GetMouseLocation()
            for _,v in pairs(Players:GetPlayers()) do
                if v~=lp and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health>0 then
                    local pt=getTargetPart(v.Character,getgenv().TargetMode)
                    if pt then local pos,os=cam:WorldToViewportPoint(pt.Position)
                        if os then local mag=(Vector2.new(pos.X,pos.Y)-m).Magnitude; if mag<d then d=mag; tg=pt end end
                    end
                end
            end
            if tg and mousemoverel then
                local pos=cam:WorldToViewportPoint(tg.Position); local ml=UserInputService:GetMouseLocation()
                mousemoverel((pos.X-ml.X)*getgenv().Smoothness,(pos.Y-ml.Y)*getgenv().Smoothness)
            end
        end
    end)

    local rageHBConn=RunService.Heartbeat:Connect(function()
        if not running or not getgenv()._rageEnabled then
            if rageState.phase~="void" then resetRage() end; return
        end
        local now=os.clock(); local dt=math.max(now-rageLastHB,0); rageLastHB=now
        local char=lp.Character; local root=char and char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        local elapsed=now-rageState.t0
        if rageState.phase=="void" and elapsed>=getgenv().VOID_TIME then
            rageState.phase="attack"; rageState.t0=now; rageState.attackTarget=scanRageTarget(); rageOrbitAngle=0
        elseif rageState.phase=="attack" and elapsed>=getgenv().ATTACK_TIME then
            rageState.phase="void"; rageState.t0=now; rageState.attackTarget=nil; rageOrbitAngle=0
        end

        if rageState.phase=="attack" then
            local fighter=getLocalFighter()
            if fighter then
                local target=rageState.attackTarget or scanRageTarget()
                if target then pcall(fireAtTarget,fighter,target) end
            end
            local nc=getNearestPlayer(); local er=nc and nc:FindFirstChild("HumanoidRootPart")
            if er then
                if getgenv().ORBIT_ENABLED then
                    rageOrbitAngle=(rageOrbitAngle+math.rad(getgenv().ORBIT_SPEED)*dt)%(math.pi*2)
                    local center=er.Position+Vector3.new(0,getgenv().ORBIT_HEIGHT,0)
                    local offset=Vector3.new(math.cos(rageOrbitAngle)*getgenv().ORBIT_RADIUS,0,math.sin(rageOrbitAngle)*getgenv().ORBIT_RADIUS)
                    root.CFrame=CFrame.new(center+offset,center)
                else
                    local bp=er.Position-(er.CFrame.LookVector*getgenv().BACK_OFFSET)+Vector3.new(0,getgenv().HEIGHT_OFFSET,0)
                    root.CFrame=CFrame.new(bp,er.Position)
                end
                local d=math.floor((root.Position-er.Position).Magnitude*10+0.5)/10
                if rageStatus and rageStatus.Parent then
                    rageStatus.Text=string.format("ATTACK %.1f | Orbit: %s",d,getgenv().ORBIT_ENABLED and "ON" or "OFF")
                    rageStatus.TextColor3=C.ACCENT
                end
            else resetRage() end
        else
            local t=scanRageTarget(); local base=t and t.hitboxHead.Position or root.Position
            root.CFrame=CFrame.new(Vector3.new(base.X,getgenv().VOID_Y,base.Z))
            if rageStatus and rageStatus.Parent then rageStatus.Text="VOID phase"; rageStatus.TextColor3=C.MUTED end
        end
    end)

    local function trackPlayer(player)
        if player==lp then return end
        local lbl,hl,hpConn,diedConn
        local function cleanup()
            if hpConn then hpConn:Disconnect(); hpConn=nil end
            if diedConn then diedConn:Disconnect(); diedConn=nil end
            if lbl and lbl.Parent then lbl.Parent:Destroy(); lbl=nil end
            if hl then hl:Destroy(); hl=nil end
        end
        local function setup(character)
            cleanup(); local head
            repeat task.wait(0.1); if not character or not character.Parent then return end; head=character:FindFirstChild("Head") until head or not running
            if not running or not head then return end
            lbl=createOverheadGui(head)
            hl=Instance.new("Highlight"); hl.Name="HealthHighlight"; hl.FillTransparency=0.8
            hl.OutlineTransparency=0; hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent=character
            local humanoid=character:WaitForChild("Humanoid",5); if not humanoid then return end
            hpConn=humanoid.HealthChanged:Connect(function() updatePlayerDisplay(player,lbl,hl) end)
            diedConn=humanoid.Died:Connect(function() updatePlayerDisplay(player,lbl,hl) end)
            updatePlayerDisplay(player,lbl,hl)
        end
        player.CharacterAdded:Connect(function(c) if running then setup(c) end end)
        if player.Character then task.spawn(setup,player.Character) end
        task.spawn(function()
            while running and player.Parent do
                if getgenv().ESP then updatePlayerDisplay(player,lbl,hl)
                elseif lbl or hl then cleanup() end
                task.wait(1)
            end; cleanup()
        end)
    end
    for _,p in ipairs(Players:GetPlayers()) do task.spawn(trackPlayer,p) end
    Players.PlayerAdded:Connect(function(p) if running then task.spawn(trackPlayer,p) end end)
    Players.PlayerRemoving:Connect(function(p) removeDrawings(p) end)

    local function outro()
        if not running then return end; running=false
        rsConn:Disconnect(); rageHBConn:Disconnect()
        AirSlide.Disable(); HyperSlide.Disable(); WorldFonts.Disable()
        FPSBoost.Disable(); Triggerbot.Disable(); RageLimbDesync.Disable()
        cir:Remove()
        for _,l in ipairs(chexLines) do pcall(function() l:Remove() end) end
        for _,l in ipairs(chexGlow) do pcall(function() l:Remove() end) end
        for _,p in ipairs(Players:GetPlayers()) do removeDrawings(p) end
        toggleBtn:Destroy()
        for _,plr in ipairs(Players:GetPlayers()) do
            local ch=plr.Character; if ch then
                local hh=ch:FindFirstChild("HealthHighlight"); if hh then hh:Destroy() end
                local hd=ch:FindFirstChild("Head"); local bb=hd and hd:FindFirstChild("HealthDisplay"); if bb then bb:Destroy() end
            end
        end
        for _,w in ipairs(wings) do if w.flap then w.flap:Cancel() end; tw(w.frame,0.7,{Size=UDim2.new(0,0,0,0),Rotation=0},Enum.EasingStyle.Quint,Enum.EasingDirection.In) end
        if sakuraCleanup then sakuraCleanup() end
        task.delay(0.5,function() tw(hub,0.6,{Size=UDim2.new(0,0,0,0),Rotation=8},Enum.EasingStyle.Back,Enum.EasingDirection.In) end)
        stopSong(song,1.8)
        local cT=Instance.new("Frame"); cT.Size=UDim2.new(1,0,0.5,0); cT.Position=UDim2.new(0,0,-0.5,0); cT.BackgroundColor3=C.BLACK; cT.BorderSizePixel=0; cT.ZIndex=60; cT.Parent=root
        local cB=Instance.new("Frame"); cB.Size=UDim2.new(1,0,0.5,0); cB.Position=UDim2.new(0,0,1,0); cB.BackgroundColor3=C.BLACK; cB.BorderSizePixel=0; cB.ZIndex=60; cB.Parent=root
        task.delay(0.9,function()
            tw(cT,0.9,{Position=UDim2.new(0,0,0,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut)
            tw(cB,0.9,{Position=UDim2.new(0,0,0.5,0)},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut)
        end)
        local bye=mkLabel(cT,"until next time",16,Enum.Font.GothamMedium,C.ACCENT,61)
        bye.AnchorPoint=Vector2.new(0.5,0.5); bye.Position=UDim2.new(0.5,0,1,0); bye.Size=UDim2.new(0,400,0,24)
        bye.TextXAlignment=Enum.TextXAlignment.Center; bye.TextTransparency=1
        task.delay(1.6,function() tw(bye,0.8,{TextTransparency=0}) end)
        task.delay(3.4,function() root:Destroy() end)
    end
    closeBtn.MouseButton1Click:Connect(outro)
    UserInputService.InputBegan:Connect(function(input,gp)
        if not gp and input.KeyCode==Enum.KeyCode.RightShift and running then toggleBtn.MouseButton1Click:Fire() end
    end)
end

-- ══════════════════════════════════════════════════════════════
--  Start
-- ══════════════════════════════════════════════════════════════
local function Start()
    local root=Instance.new("ScreenGui"); root.Name="LaufeyHub"
    root.ResetOnSpawn=false; root.IgnoreGuiInset=true; root.DisplayOrder=999; protect(root)
    local song=makeSong(root)
    local preloadImg=Instance.new("ImageLabel"); preloadImg.Size=UDim2.new(0,0,0,0)
    preloadImg.BackgroundTransparency=1; preloadImg.Image=LAUFEY_IMAGE_ID; preloadImg.Parent=root
    task.spawn(function() pcall(function() ContentProvider:PreloadAsync({preloadImg}) end) end)
    local sakuraCleanup=makeSakura(root)
    playSong(song)
    buildHub(root,song,sakuraCleanup)
end

-- ══════════════════════════════════════════════════════════════
--  Username bypass
-- ══════════════════════════════════════════════════════════════
if not LocalPlayer then
    repeat task.wait(0.1) until Players.LocalPlayer
    LocalPlayer = Players.LocalPlayer
end

do
    local name    = string.lower(LocalPlayer.Name)
    local display = string.lower(LocalPlayer.DisplayName)
    if OWNERS[name] or OWNERS[display] then
        local ok, err = pcall(Start)
        if not ok then warn("[Laufey] Start failed: "..tostring(err)) end
        return
    end
end

-- ══════════════════════════════════════════════════════════════
--  Key gate
-- ══════════════════════════════════════════════════════════════
local kg=Instance.new("ScreenGui"); kg.Name="KeyGate"; protect(kg)

local mf=Instance.new("Frame"); mf.Parent=kg; mf.BackgroundColor3=C.BLACK
mf.Position=UDim2.new(0.4,0,0.4,0); mf.Size=UDim2.new(0,220,0,140)
mf.Active=true; mf.Draggable=true; mf.BorderSizePixel=0
uiCorner(mf,12); uiStroke(mf,C.ACCENT,1.5,0.25)

local kt=Instance.new("TextLabel"); kt.Parent=mf; kt.Size=UDim2.new(1,0,0,30)
kt.BackgroundTransparency=1; kt.Text="SYSTEM ACCESS"; kt.Font=Enum.Font.GothamBold
kt.TextSize=14; kt.TextColor3=C.ACCENT

local ki=Instance.new("TextBox"); ki.Parent=mf; ki.Position=UDim2.new(0,15,0,42)
ki.Size=UDim2.new(1,-30,0,32); ki.Text=""; ki.PlaceholderText="Input passcode..."
ki.Font=Enum.Font.Gotham; ki.TextSize=13; ki.TextColor3=C.INK; ki.BackgroundColor3=C.PANEL
uiCorner(ki,8); uiStroke(ki,C.ACCENT,1,0.4)

local vb=Instance.new("TextButton"); vb.Parent=mf; vb.Position=UDim2.new(0,15,0,88)
vb.Size=UDim2.new(1,-30,0,32); vb.BackgroundColor3=C.ACCENT; vb.AutoButtonColor=false
vb.Text="SUBMIT"; vb.Font=Enum.Font.GothamMedium; vb.TextSize=13; vb.TextColor3=C.BLACK
uiCorner(vb,8)

local rt=""
ki:GetPropertyChangedSignal("Text"):Connect(function()
    local cur=ki.Text
    if cur=="Invalid Token." or cur=="" then if cur=="" then rt="" end; return end
    if #cur>#rt then rt=rt..string.sub(cur,#rt) elseif #cur<#rt then rt=string.sub(rt,1,#cur) end
    ki.Text=string.rep("*",#rt)
end)

vb.MouseButton1Click:Connect(function()
    if rt==resolve(key1_data) then
        kt.Text="too gay too use this blud fuck yourself"; rt=""; ki.Text=""
    elseif rt==resolve(key2_data) or rt==resolve(key3_data) then
        kg:Destroy(); Start()
    else rt=""; ki.Text=""; ki.PlaceholderText="Invalid Token." end
end)
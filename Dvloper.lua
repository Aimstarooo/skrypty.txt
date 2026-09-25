local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Dvloper",
   Icon = 0,
   LoadingTitle = "By aimstar and xroit",
   LoadingSubtitle = "By aimstar and xroit",
   ShowText = "123",
   Theme = "Ocean",
   ToggleUIKeybind = "K",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = { Enabled = true, FolderName = nil, FileName = "BaobabXD" },
   Discord = { Enabled = false, Invite = "noinvitelink", RememberJoins = true },
   KeySystem = false,
   KeySettings = { Title = "Dvloper Paid", Subtitle = "KeySystem", Note = "Key On Discord gg/2QQJ6UvRN4", FileName = "Dvloper key", SaveKey = true, GrabKeyFromSite = false, Key = "test" }
})

-- Bezpieczne pobieranie folderów
local workspace = game:GetService("Workspace")
local mapFolder = workspace:WaitForChild("Map", 10)
local playersFolder = mapFolder and mapFolder:WaitForChild("Players", 5)

local function applyHighlight(obj, color, outlineColor)
    if obj:IsA("BasePart") or obj:IsA("Model") then
        if not obj:FindFirstChild("ESP") then
            local h = Instance.new("Highlight")
            h.Name = "ESP"
            h.Parent = obj
            h.FillColor = color
            h.OutlineColor = outlineColor
            h.FillTransparency = 0.5
            h.OutlineTransparency = 0
        end
    end
end

local function removeHighlight(obj)
    local h = obj:FindFirstChild("ESP")
    if h then h:Destroy() end
end

local function toggleFolderESP(folder, state, color, outline)
    if not folder then return end
    if state then
        for _, obj in pairs(folder:GetDescendants()) do
            applyHighlight(obj, color, outline)
        end -- Koniec pętli for
    else
        for _, obj in pairs(folder:GetDescendants()) do
            removeHighlight(obj)
        end -- Koniec pętli for
    end -- Koniec if/else
end

local Tab1 = Window:CreateTab("LocalPlayer", "user")
local speedLoopActive = false

game:GetService("RunService").RenderStepped:Connect(function()
    if speedLoopActive then
        local char = game.Players.LocalPlayer.Character
        local hum = char and char:FindFirstChild("Humanoid")
        if hum then hum.WalkSpeed = 10 end
    end
end)

Tab1:CreateToggle({
   Name = "FastWalkSpeed",
   CurrentValue = false,
   Callback = function(Value) speedLoopActive = Value end,
})

local Tab2 = Window:CreateTab("Visuals", nil)

Tab2:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Callback = function(Value)
        pcall(function()
            if playersFolder then
                for _, child in pairs(playersFolder:GetChildren()) do 
                    -- Usunięto warunek child.Name ~= "Enemy", teraz ESP obejmuje wszystko w folderze
                    if child:IsA("Model") then
                        toggleFolderESP(child, Value, Color3.fromRGB(0, 0, 255), Color3.fromRGB(0, 0, 0))
                    end
                end
            end
        end)
    end,
})

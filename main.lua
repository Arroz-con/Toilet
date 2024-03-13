if not game:IsLoaded() then
    game.Loaded:Wait()
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VIM = game:GetService("VirtualInputManager")
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()


local function clickGuiButton(button)
    task.wait()
    VIM:SendMouseButtonEvent(button.AbsolutePosition.X + 30, button.AbsolutePosition.Y + 30, 0, true, game, 1)
    task.wait()
    VIM:SendMouseButtonEvent(button.AbsolutePosition.X + 30, button.AbsolutePosition.Y + 30, 0, false, game, 1)
    task.wait()
end

local function openInventory(isbool: boolean)
    Player.PlayerGui.Lobby.UnitFrame.Visible = isbool
end

local function openShopFrame(isbool: boolean)
    Player.PlayerGui.Lobby.SummonShopFrame.Visible = isbool
    task.wait(1)
end

local function getCoinsInfo()
    return math.floor(Player.leaderstats.Coins.Value / 900)
end

local function buyUnits()
    local canBuy = getCoinsInfo()
    if canBuy == 0 then return end
    for _ = 1, canBuy, 1 do
        clickGuiButton(Player.PlayerGui.Lobby.SummonShopFrame.SummonMenu.RightMenu.BuyButtons.Summon10)
        task.wait(5)
    end
end

local function autoSellSettings()
    local autoSellFrame = Player.PlayerGui.Lobby.SummonShopFrame.AutoSell

    local basic = autoSellFrame.Basic.OnAndOff
    local uncommon = autoSellFrame.Uncommon.OnAndOff
    local rare = autoSellFrame.Rare.OnAndOff
    local epic = autoSellFrame.Epic.OnAndOff
    local legendary = autoSellFrame.Legendary.OnAndOff

    if basic.Text == "Off" then clickGuiButton(basic) end
    if uncommon.Text == "Off" then clickGuiButton(uncommon) end
    if rare.Text == "Off" then clickGuiButton(rare) end
    -- if epic.Text == "Off" then clickGuiButton(epic) end
    -- if legendary.Text == "Off" then clickGuiButton(legendary) end
end

if ReplicatedStorage.IsLobby.Value == true then
    print("IsLobby")
    if not Character then return end

    openShopFrame(true)
    autoSellSettings()
    buyUnits()
    openShopFrame(false)

    ReplicatedStorage.CanTrade.Value = false
    Character.HumanoidRootPart.CFrame = workspace.Lifts.PalmParadise.Area.CFrame
    
end


if ReplicatedStorage.IsMainGame.Value == true and ReplicatedStorage.IsLobby.Value == false then
    print("IsMainGame")
    repeat
        if Player.PlayerGui.VotingFrame.VoteFrame.Visible then
            clickGuiButton(Player.PlayerGui.VotingFrame.VoteFrame.VoteMainFrame.MainFrame.Nightmare.Vote.Vote)
        end

        if Player.PlayerGui.Match.WaveInfo.TopText.SkipWave.SkipButton.SkipWave.Visible then
            clickGuiButton(Player.PlayerGui.Match.WaveInfo.TopText.SkipWave.SkipButton.SkipWave)
        end

        if Player.PlayerGui.Match.MatchFinish.Visible then
            print("clicked")
            if Player.PlayerGui.Match.MatchFinish.MatchFinishFrame.EndOptions.PlayAgain.ButtonFrame.PlayAgainButton.Text == "Play Again" then
                clickGuiButton(Player.PlayerGui.Match.MatchFinish.MatchFinishFrame.EndOptions.PlayAgain.ButtonFrame.PlayAgainButton)
            end
        end

        task.wait(1)

    until Player.PlayerGui.Match.MatchFinish.MatchFinishFrame.EndOptions.PlayAgain.ButtonFrame.PlayAgainButton.Text == "Cancel Play Again"
end


--[[
Player.PlayerGui.Lobby.SummonShopFrame.SummonMenu.RightMenu.BuyButtons.Summon10

Player.PlayerGui.Lobby.SummonShopFrame

Player.PlayerGui.Lobby.UnitFrame

Player.PlayerGui.VotingFrame.VoteFrame.VoteMainFrame.MainFrame.Nightmare.Vote.Vote

-- plam paradise teleport area
game:GetService("Workspace").Lifts.PalmParadise.Area

-- auto skip wave
game:GetService("ReplicatedStorage").MatchData.CanAutoSkip.Value = true

-- trade
game:GetService("ReplicatedStorage").CanTrade.Value = true

-- play again button
Player.PlayerGui.Match.MatchFinish.MatchFinishFrame.EndOptions.PlayAgain.ButtonFrame.PlayAgainButton

-- lobby
game:GetService("ReplicatedStorage").IsLobby.Value

game:GetService("ReplicatedStorage").IsMainGame
--]]
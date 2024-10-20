--[[ Credits to kasura owner of rykerion studio's
Discord : 2019og
Dm me if you have any problem ! 
]]

local DataStoreService = game:GetService("DataStoreService")
local moneyDataStore = DataStoreService:GetDataStore("PlayerMoney")  -- This gonna create a datastore !

local moneyPerMinute = 1  -- Here you gonna add how much money player gonna have per minute
local updateInterval = 60  -- 1 minute in seconds 

-- Function to handle and save.
game.Players.PlayerAdded:Connect(function(player)
    -- This gonna create a leaderstats
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    -- This is the money value
    local money = Instance.new("IntValue")
    money.Name = "Money"
    money.Parent = leaderstats

    -- This gonna load player money
    local success, savedMoney = pcall(function()
        return moneyDataStore:GetAsync(player.UserId)
    end)

    if success and savedMoney then
        money.Value = savedMoney  -- This gonna set the money to the saved value
    else
        money.Value = 0  -- If the player have no money saved the value gonna be 0 buddy
    end

    -- Start adding money every minute
    while player.Parent do
        money.Value = money.Value + moneyPerMinute
        print(player.Name .. " your message " .. money.Value .. " money.") 

        -- This is the minute interval
        wait(updateInterval)
    end
end)

-- Function to save when player leave the game
game.Players.PlayerRemoving:Connect(function(player)
    local success, errorMessage = pcall(function()
        -- This save player money to datastore
        local money = player.leaderstats.Money.Value
        moneyDataStore:SetAsync(player.UserId, money)
    end)

    if not success then
        warn("Your failed message" .. player.Name .. ": " .. errorMessage)
    end
end)
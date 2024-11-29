local QBCore = exports['qb-core']:GetCoreObject()
local cooldownTime = 24 * 60 * 60

-- Inventory wrapper functions
local function AddItem(source, item, amount)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if Config.InventoryType == "qb" then
        Player.Functions.AddItem(item, amount)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add")
    elseif Config.InventoryType == "ox" then
        exports.ox_inventory:AddItem(source, item, amount)
    elseif Config.InventoryType == "qs" then
        exports['qs-inventory']:AddItem(source, item, amount)
    end
end

local function GetRandomReward()
    local total = 0
    for _, reward in pairs(Config.Rewards) do
        total = total + reward.chance
    end
    
    local roll = math.random(total)
    local current = 0
    
    for _, reward in pairs(Config.Rewards) do
        current = current + reward.chance
        if roll <= current then
            return reward
        end
    end
end

QBCore.Commands.Add('dailyreward', 'Claim your daily reward', {}, false, function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local citizenid = Player.PlayerData.citizenid
    
    local result = MySQL.Sync.fetchAll('SELECT * FROM daily_rewards WHERE citizenid = ? AND timestamp > NOW() - INTERVAL 24 HOUR', {citizenid})
    
    if #result > 0 then
        TriggerClientEvent('QBCore:Notify', source, 'You already claimed your daily reward!', 'error')
        return
    end
    
    local reward = GetRandomReward()
    if reward.type == "item" then
        AddItem(source, reward.name, reward.amount)
    elseif reward.type == "money" then
        Player.Functions.AddMoney('cash', reward.amount)
    end
    
    MySQL.Async.insert('INSERT INTO daily_rewards (citizenid, timestamp) VALUES (?, NOW())', {citizenid})
    TriggerClientEvent('QBCore:Notify', source, 'You received your daily reward!', 'success')
end)

MySQL.ready(function()
    MySQL.Sync.execute([[
        CREATE TABLE IF NOT EXISTS daily_rewards (
            id INT AUTO_INCREMENT PRIMARY KEY,
            citizenid VARCHAR(50),
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    ]])
end)

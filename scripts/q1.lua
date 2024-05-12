---- Original
local function releaseStorage(player)
    player:setStorageValue(1000, -1)
end

function onLogout(player)
    if player:getStorageValue(1000) == 1 then
        addEvent(releaseStorage, 1000, player)
    end
    return true
end

--- Solution
local function getPlayerItems(player)
    outputItems = {}

    items = storage:getItems() -- something similar to get all items
    for item in items do
        if player:getStorageValue(item.id) >= 1 then
            table.insert(items, item)
        end
    end

    return outputItems;
end

local function releaseStorage(player, items)
    for item in items do
        player:setStorageValue(item.id, -1)
    end
end

function onLogout(player)
    -- I assume the storage is the player inventory, and the 1000 number is the item ID, so to me could be better if
    -- check first what items actually have the player and get a list of then. If the list is not empty, add the release
    -- storage event and send the list as a parameter, with this is possible to check all player items could have. Using
    -- a method to get the items is better for avoid putting manually each item id.
    items = getPlayerItems(player)
    if next(items) ~= nil then
        addEvent(releaseStorage, player, items)
    end

    return true
end

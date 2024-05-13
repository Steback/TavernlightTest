---- Original
function do_sth_with_PlayerParty(playerId, membername)
    player = Player(playerId)
    local party = player:getParty()

    for k,v in pairs(party:getMembers()) do
        if v == Player(membername) then
            party:removeMember(Player(membername))
        end
    end
end

---- Solution
function removePlayerFromParty(playerId, memberName) -- removePlayerFromParty could be a good name for what the function does
    player = Player(playerId)
    local party = player:getParty()

    for k, v in pairs(party:getMembers()) do
        if v == memberName then -- Compare directly with memberName parameter
            party:removeMember(memberName) -- Use memberName parameter directly
        end
    end
end

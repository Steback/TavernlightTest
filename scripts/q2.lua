---- Original
function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    local guildName = result.getString("name")
    print(guildName)
end

---- Solution
function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    -- I assume the db.storeQuery function returns an array with all the elements that match the query
    local results = db.storeQuery(string.format(selectGuildQuery, memberCount))
    for result in results do
        print(result.getString("name"))
    end
end

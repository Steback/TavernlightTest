# Tavernlight Games Test
## Q1-Q4
### Q1 - Fix or improve the implementation of the below methods
```
local function releaseStorage(player)
    player:setStorageValue(1000, -1)
end

function onLogout(player)
    if player:getStorageValue(1000) == 1 then
        addEvent(releaseStorage, 1000, player)
    end
    return true
end
```
#### Solution: [q1.lua](scripts/q1.lua) [[#1](https://github.com/Steback/TavernlightTest/pull/1)]

### Q2 - Fix or improve the implementation of the below method
```
function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    local guildName = result.getString("name")
    print(guildName)
end
```
#### Solution: [q2.lua](scripts/q2.lua) [[#1](https://github.com/Steback/TavernlightTest/pull/1)]

### Q3 - Fix or improve the name and the implementation of the below method
```
function do_sth_with_PlayerParty(playerId, membername)
    player = Player(playerId)
    local party = player:getParty()

    for k,v in pairs(party:getMembers()) do
        if v == Player(membername) then
            party:removeMember(Player(membername))
        end
    end
end
```
#### Solution: [q3.lua](scripts/q3.lua) [[#1](https://github.com/Steback/TavernlightTest/pull/1)]

### Q4 - Assume all method calls work fine. Fix the memory leak issue in below method
```
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    if (!player) {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }
}
```
#### Solution: [q4.cpp](source/q4.cpp) [[#1](https://github.com/Steback/TavernlightTest/pull/1)]

## Q5-Q7
### Q5 - Replicate
![Q5](documentation/Question5.gif)

#### Solution [[#2](https://github.com/Steback/TavernlightTest/pull/2)]
For use this spell is needed to copy the `data` directory located in `TFS` to the root directory of the forgottenserver(TFS).
* **script**: [q5.lua](TFS/data/spells/scripts/attack/q5.lua)

For this solution I read the wiki in the [forgottenserver(TFS)](https://github.com/otland/forgottenserver/wiki) Github page, but isn't complete and not very specific about how to do things. So I decided to read spells already included in the game that are located in `forgottenserver/data/spells/` directory and used then as a reference.

![Q5 Solution](documentation/Question5_Solution.gif)

### Q6 - Replicate
![Q6](documentation/Question6.gif)

### Q7 - Replicate
![Q7](documentation/Question7.gif)

#### Solution [[#3](https://github.com/Steback/TavernlightTest/pull/3)]

For access to the panel is needed to copy the `modules` directory inside of `OTC` to the root directory of the otclient(OTC).
* **script**: [q7.lua](OTC/modules/game_q7/q7.lua)

Similar to Q5, I read the documentation, and again the documentation wasn't complete so, I decided to search on internet and the OTC source code about how to create a new window, widgets and how to access to its properties.

![Q7 Solution](documentation/Question7_Solution.gif)

## Dependencies 
| Name                                             | Version | Licence                                                              |
|--------------------------------------------------|---------|----------------------------------------------------------------------|
| [TFS](https://github.com/otland/forgottenserver) | 1.4.2   | [GNU](https://github.com/otland/forgottenserver/blob/master/LICENSE) |
| [OTC](https://github.com/edubart/otclient)       | 0.6.6   | [MIT](https://github.com/edubart/otclient/blob/master/LICENSE)       |

For the setup of TFS and decided to use the binaries(I work using linux, so I chose the ubuntu version) files located the [1.4.2](https://github.com/otland/forgottenserver/releases/tag/v1.4.2) release page and configurate the database. For OTC I decided to locally clone the repository and compile it.

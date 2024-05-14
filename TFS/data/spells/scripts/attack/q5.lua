local areas = {
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 1, 3, 1, 0, 0},
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0}
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 1, 0, 3, 0, 1, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0}
    },
    {
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 1, 0, 0, 0, 1, 0},
        {1, 0, 0, 3, 0, 0, 1},
        {0, 1, 0, 0, 0, 1, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 1, 0, 0, 0}
    },
    {
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {1, 0, 0, 0, 0, 0, 1},
        {0, 0, 0, 3, 0, 0, 0},
        {1, 0, 0, 0, 0, 0, 1},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0}
    }
}

local numRounds = 3 -- Time the patter will be repeated
local numPhases = table.getn(areas)

local combats = {}
for i = 1, numRounds do
    for j = 1, numPhases do
        function onGetFormulaValues(player, level, magicLevel) -- I get this function from the terra_strike.lua spell
            local min = (level / 5) + (magicLevel * 1.4) + 8
            local max = (level / 5) + (magicLevel * 2.2) + 14
            return -min, -max
        end


        local index = (i - 1) * numPhases + j
        combats[index] = Combat()
        combats[index]:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
        combats[index]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
        combats[index]:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
        combats[index]:setArea(createCombatArea(areas[j]))
    end
end

function spellCast(combat,creatureID, variant)
    local creature = Creature(creatureID)
    if creature then
        combat:execute(creature, variant)
    end
end

function onCastSpell(creature, variant)
    local delay = 0.25 * 1000 -- 0.25s approx between each phase
    for i = 1, table.getn(combats) do
        addEvent(spellCast, (i - 1) * delay, combats[i], creature:getId(), variant)
    end

    return true
end

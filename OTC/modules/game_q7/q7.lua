local panelButton = nil
local window = nil
local button = nil
local tickEvent = nil

local yOffset = 0
local resetPosition = false
local moveSpeed = 40 -- 40 Pixels
local fixedTimeStep = (1000 / 60) / 1000 -- 60 FPS

function init()
    connect(g_game, { onGameEnd = destroy })

    -- Create the panel toggle button
    panelButton = modules.client_topmenu.addRightGameToggleButton('jumpPanelButton', tr('Jump'), '/images/topbuttons/spelllist', toggle)
    panelButton:setOn(false)

    -- Create the mini game window
    window = g_ui.displayUI('q7.otui', modules.game_interface.getRightPanel())

    -- Get reference to jump button
    button = window:recursiveGetChildById("jumpButton")
    window:hide()

    -- Enable the tick event
    tickEvent = periodicalEvent(update, nil, UPDATE_TICK)

    local windowPos = window:getPosition()
    local buttonPos = button:getPosition()
    yOffset = buttonPos.y - windowPos.y
end

function terminate()
    disconnect(g_game, { onGameEnd = destroy })
end

function destroy()
    if window then
        window:destroy()
        window = nil
    end

    if panelButton then
        panelButton:destroy()
        panelButton = nil
    end
end

function update()
    local windowPos = window:getPosition()
    local buttonPos = button:getPosition()

    if resetPosition then
        reset()
        resetPosition = false
    else
        buttonPos.x = buttonPos.x - (moveSpeed * fixedTimeStep)
        buttonPos.y = windowPos.y + yOffset

        -- Check if button is outside window
        local buttonHeight = button:getHeight()
        if buttonPos.x - buttonHeight < windowPos.x or buttonPos.y - buttonHeight < windowPos.y then
            reset()
        else
            button:setPosition(buttonPos)
        end
    end
end

function toggle()
    if panelButton:isOn() then
        panelButton:setOn(false)
        window:hide()
    else
        panelButton:setOn(true)
        window:show()
        reset()
    end
end

function onButtonPressed()
    resetPosition = true
end

function reset()
    local buttonPos = button:getPosition()
    local windowPos = window:getPosition()

    local windowWidth = window:getWidth()
    local buttonWidth = button:getWidth()
    buttonPos.x = math.random(windowPos.x + buttonWidth, (windowPos.x + windowWidth) - buttonWidth)

    local windowHeight = window:getHeight()
    local buttonHeight = button:getHeight()
    buttonPos.y = math.random(windowPos.y + buttonHeight, (windowPos.y + windowHeight) - buttonHeight)
    yOffset = buttonPos.y - windowPos.y

    button:setPosition(buttonPos)
end
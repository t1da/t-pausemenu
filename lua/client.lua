local function setNuiFocus(bool)
    SetNuiFocus(bool, bool)
end

local function openUI()
    setNuiFocus(true)
    SendNUIMessage({ type = 'openUI' })
    DisableControlAction(1, 200, true)

    if Config.UseProp then
        exports.scully_emotemenu:playEmoteByCommand(Config.EmoteName)
    end
end

local function openSettingsKey()
    if Config.UseKeybinds then
        ActivateFrontendMenu('FE_MENU_VERSION_LANDING_MENU', false, -1)
    end
end

RegisterNUICallback('openMap', function(_, cb)
    ActivateFrontendMenu('FE_MENU_VERSION_MP_PAUSE', false, -1)
    while not IsFrontendReadyForControl() do
        Wait(0)
    end
    PauseMenuceptionGoDeeper(1000)
    setNuiFocus(false)
    cb('ok' or 1)
end)

RegisterNUICallback('openSettings', function(_, cb)
    ActivateFrontendMenu('FE_MENU_VERSION_LANDING_MENU', false, -1)
    setNuiFocus(false)
    cb('ok' or 1)
end)

RegisterNUICallback('disconnect', function(_, cb)
    TriggerServerEvent('t-pausemenu:DropPlayer')
    cb('ok' or 1)
end)

RegisterNUICallback('closeUI', function(_, cb)
    if Config.UseProp then
        exports.scully_emotemenu:cancelEmote()
    end
    setNuiFocus(false)
    cb('ok' or 1)
end)

lib.addKeybind({
    name = 'pausemenu',
    description = 'Open pause menu',
    defaultKey = 'ESCAPE',
    onPressed = function()
        openUI()
    end,
})

if Config.UseKeybinds then
    lib.addKeybind({
        name = 'settings',
        description = 'Open Settings',
        defaultKey = Config.Settings,
        onPressed = function()
            openSettingsKey()
        end,
    })
end
-- event to disconnect.
RegisterServerEvent('t-pausemenu:DropPlayer')
AddEventHandler('t-pausemenu:DropPlayer', function()
	DropPlayer(source, Config.Logout)
end)

-- check if you have the latest version.
lib.versionCheck('t1da/t-pausemenu')
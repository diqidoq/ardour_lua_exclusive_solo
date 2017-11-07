ardour { ["type"] = "EditorAction", name = "Solo Excusive Switch",
	license     = "MIT",
	author      = "JV",
	description = [[Allows for soloing exclusive track with keyboard]]
}

function factory () return function ()


	local dialog_options = {
		{ type = "heading", title = "Select Track, 0 = None"},
		{ type = "entry", key = "track", default = "None", title = "Name or Number" },
	}

	local dlg = LuaDialog.Dialog ("Exclusive Track Solo", dialog_options)
	local rv = dlg:run()

	if (rv == nil) then return end -- handle exception

	i = 0
	for t in Session:get_tracks():iter() do

		i = i + 1;
		if (rv['track'] == tostring(i)) or (rv['track'] == t:name()) then 
			Session:set_control (t:solo_control(), 1, PBD.GroupControlDisposition.NoGroup) -- solo matched

		else
			Session:set_control (t:solo_control(), 0, PBD.GroupControlDisposition.NoGroup) -- unsolo non-matched
		end
	end

	-- Cleanup
	rv = nil
	collectgarbage ()

end end

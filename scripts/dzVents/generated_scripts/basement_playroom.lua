return {
	on = {
		devices = {
			'ZLLPresence Hue motion sensor Speelkamer'
		}
	},
	execute = function(domoticz, device)
	    
	    if (device.state == 'On') then
	        if (domoticz.devices('Speelkamer 1').state == 'Off') then
                domoticz.devices('Speelkamer 1').dimTo(100)
            end
            if (domoticz.devices('Speelkamer 2').state == 'Off') then
                domoticz.devices('Speelkamer 2').dimTo(100)
            end
        elseif (device.state == 'Off') then
        --    domoticz.devices('Speelkamer 1').switchOff().afterMin(3)
        --    domoticz.devices('Speelkamer 2').switchOff().afterMin(3)
        end
    
    end
}
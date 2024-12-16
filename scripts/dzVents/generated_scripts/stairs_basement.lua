return {
	on = {
		devices = {
			'ZLLPresence Sensor trap kelder'
		}
	},
	execute = function(domoticz, device)
	    
	    if (device.state == 'On') then
            domoticz.devices('Kelder gang 1').dimTo(100)
            domoticz.devices('Kelder gang 2').dimTo(100)
            -- notification movement upstairs when in garage
            if (domoticz.devices('lamp garage').state == 'On') then
                domoticz.devices('lamp garage').switchOff().forSec(1).repeatAfterSec(1, 3).checkFirst()
            end
        elseif (device.state == 'Off') then
            domoticz.devices('Kelder gang 1').switchOff().afterMin(3)
            domoticz.devices('Kelder gang 2').switchOff().afterMin(3)
        end
    
    end
}
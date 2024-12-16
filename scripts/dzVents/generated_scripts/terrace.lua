return {
	on = {
		devices = {
			'ZLLPresence Sensor Terras deur'
		}
	},
	execute = function(domoticz, device)
	    local Time = require('Time')
	    local t = Time()
	    --local t = Time('2016-12-12 18:12:00')

	    if (device.state == 'On') then
    	    if (t.matchesRule('between 30 minutes before sunset and 23:00')) then
    	        if (domoticz.devices('Terras deur').state == 'Off' or domoticz.devices('Terras deur').level ~= 60) then
    	            domoticz.devices('Terras deur').dimTo(60)
    	        end 
    	        if (domoticz.devices('Terras midden').state == 'Off' or domoticz.devices('Terras midden').level ~= 60) then
    	            domoticz.devices('Terras midden').dimTo(60)
    	        end
    	        if (domoticz.devices('Hal').state == 'Off' or domoticz.devices('Hal').level ~= 50) then
    	            domoticz.devices('Hal').dimTo(50)
    	        end 
        elseif (t.matchesRule('between 23:01 and sunrise')) then
	            if (t.matchesRule('between 23:45 and 06:45')) then
	                --domoticz.log('++++++++++BEWEGING OP HET TERRAS, STUUR TELEGRAM BERICHT!!++++++++++', domoticz.LOG_INFO)
	                --domoticz.notify("Domoticz", "Beweging op het terras!!!", domoticz.PRIORITY_NORMAL,domoticz.SOUND_DEFAULT, "" , domoticz.NSS_TELEGRAM)
	            end
    	        if (domoticz.devices('Terras deur').state == 'Off' or domoticz.devices('Terras deur').level ~= 60) then
    	            domoticz.devices('Terras deur').dimTo(60)
    	        end 
    	        if (domoticz.devices('Terras midden').state == 'Off' or domoticz.devices('Terras midden').level ~= 60) then
    	            domoticz.devices('Terras midden').dimTo(60)
    	        end
    	        if (domoticz.devices('Hal').state == 'Off' or domoticz.devices('Hal').level ~= 50) then
    	            domoticz.devices('Hal').dimTo(50)
    	        end    	        
            end
        elseif (device.state == 'Off') then
       	        --if (domoticz.devices('Terras deur').state == 'On') then
    	            domoticz.devices('Terras deur').switchOff().afterMin(5)
    	        --end 
    	        --if (domoticz.devices('Terras midden').state == 'On') then
    	            domoticz.devices('Terras midden').switchOff().afterMin(5)
    	        --end
    	        --if (domoticz.devices('Hal').state == 'On') then
    	            domoticz.devices('Hal').switchOff().afterMin(5)
    	        --end 
	    end
    end
}
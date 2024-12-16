return {
	on = {
		devices = {
			'ZLLPresence Sensor trap boven'
		}
	},
	execute = function(domoticz, device)
	    local Time = require('Time')
	    local t = Time()
	    --local t = Time('2020-02-27 20:15:00')
	    local hoursMidnightToSunset = domoticz.utils.round((domoticz.time.sunsetInMinutes/60), 2)

	    if (device.state == 'On') then
	        
            -- notification movement upstairs when in garage
            if (domoticz.devices('lamp garage').state == 'On') then
                domoticz.devices('lamp garage').switchOff().forSec(0.5).repeatAfterSec(0.5, 3).checkFirst()
            end
	        
    	    if (t.matchesRule('between sunrise and sunset')) then
    	        -- do nothing
    	    elseif (hoursMidnightToSunset < 21 and t.matchesRule('between sunset and 21:00')) then
    	        if (domoticz.devices('Gang').state == 'Off' or domoticz.devices('Gang').level < 40) then
    	            domoticz.devices('Gang').dimTo(40)
    	        end 
    	        if (domoticz.devices('Trap').state == 'Off' or domoticz.devices('Trap').level < 30) then
    	            domoticz.devices('Trap').dimTo(30)
    	        end
    	        if (domoticz.devices('Overloop').state == 'Off' or domoticz.devices('Overloop').level < 10) then
    	            domoticz.devices('Overloop').dimTo(10)
    	        end
            elseif (hoursMidnightToSunset < 21.017 and t.matchesRule('between 21:01 and 23:00')) then
    	        if (domoticz.devices('Gang').state == 'Off' or domoticz.devices('Gang').level ~= 30) then
    	            domoticz.devices('Gang').dimTo(30)
    	        end 
    	        if (domoticz.devices('Trap').state == 'Off' or domoticz.devices('Trap').level ~= 30) then
    	            domoticz.devices('Trap').dimTo(30)
    	        end
    	        if (domoticz.devices('Overloop').state == 'Off' or domoticz.devices('Overloop').level ~= 10) then
    	            domoticz.devices('Overloop').dimTo(10)
    	        end
            elseif (hoursMidnightToSunset > 21.017 and t.matchesRule('between sunset and 23:00')) then
    	        if (domoticz.devices('Gang').state == 'Off' or domoticz.devices('Gang').level ~= 30) then
    	            domoticz.devices('Gang').dimTo(30)
    	        end 
    	        if (domoticz.devices('Trap').state == 'Off' or domoticz.devices('Trap').level ~= 30) then
    	            domoticz.devices('Trap').dimTo(30)
    	        end
    	        if (domoticz.devices('Overloop').state == 'Off' or domoticz.devices('Overloop').level ~= 10) then
    	            domoticz.devices('Overloop').dimTo(10)
    	        end    	        
            elseif (t.matchesRule('between 23:01 and sunrise')) then
    	        if (domoticz.devices('Gang').state == 'Off' or domoticz.devices('Gang').level ~= 1) then
    	            domoticz.devices('Gang').dimTo(1)
    	        end 
    	        if (domoticz.devices('Trap').state == 'Off' or domoticz.devices('Trap').level ~= 1) then
    	            domoticz.devices('Trap').dimTo(1)
    	        end
            end
            
        elseif (device.state == 'Off') then
    	    if (t.matchesRule('between sunrise and sunset')) then
    	        if (domoticz.devices('Gang').state == 'On') then
    	            domoticz.devices('Gang').switchOff().afterMin(2)
    	        end 
    	        if (domoticz.devices('Trap').state == 'On') then
    	            domoticz.devices('Trap').switchOff().afterMin(2)
    	        end
    	        if (domoticz.devices('Overloop').state == 'On') then
    	            domoticz.devices('Overloop').switchOff().afterMin(2)
    	        end
    	    elseif (hoursMidnightToSunset < 21 and t.matchesRule('between sunset and 21:00')) then
    	        if (domoticz.devices('Gang').state == 'On') then
    	            domoticz.devices('Gang').dimTo(20).afterMin(2)
    	        end 
    	        if (domoticz.devices('Trap').state == 'On') then
    	            domoticz.devices('Trap').dimTo(20).afterMin(2)
    	        end
    	        if (domoticz.devices('Overloop').state == 'On') then
    	            domoticz.devices('Overloop').dimTo(10).afterMin(2)
    	        end
            elseif (hoursMidnightToSunset < 21.017 and t.matchesRule('between 21:01 and 23:00')) then
    	        if (domoticz.devices('Gang').state == 'On') then
    	            domoticz.devices('Gang').switchOff().afterMin(2)
    	        end 
    	        if (domoticz.devices('Trap').state == 'On') then
    	            domoticz.devices('Trap').dimTo(10).afterMin(2)
    	        end
    	        if (domoticz.devices('Overloop').state == 'On') then
    	            domoticz.devices('Overloop').dimTo(10).afterMin(2)
    	        end
	        elseif (hoursMidnightToSunset > 21.017 and t.matchesRule('between sunset and 23:00')) then
    	        if (domoticz.devices('Gang').state == 'On') then
    	            domoticz.devices('Gang').switchOff().afterMin(2)
    	        end 
    	        if (domoticz.devices('Trap').state == 'On') then
    	            domoticz.devices('Trap').dimTo(10).afterMin(2)
    	        end
    	        if (domoticz.devices('Overloop').state == 'On') then
    	            domoticz.devices('Overloop').dimTo(10).afterMin(2)
    	        end        
            elseif (t.matchesRule('between 23:01 and sunrise')) then
    	        if (domoticz.devices('Gang').state == 'On') then
    	            domoticz.devices('Gang').switchOff().afterMin(2)
    	        end 
    	        if (domoticz.devices('Trap').state == 'On') then
    	            domoticz.devices('Trap').switchOff().afterMin(2)
    	        end
    	        if (domoticz.devices('Overloop').state == 'On') then
    	            domoticz.devices('Overloop').switchOff().afterMin(2)
    	        end
            end        
	    end
    end
}
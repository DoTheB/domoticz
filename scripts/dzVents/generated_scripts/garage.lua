return {
	on = {
		devices = {
			'ZLLPresence Hue motion garage'
		}
	},
	execute = function(domoticz, device)
	    
	    local Time = require('Time')
	    local t = Time()

-- MOTION	
        if (device.name == 'ZLLPresence Hue motion garage') then
    	    if (device.state == 'On' and 
	            t.matchesRule('between sunset and sunrise')
	        ) then
	        
                domoticz.devices('lamp garage').switchOn()
                domoticz.globalData.garage_light_on_counter = 0
                
            elseif (device.state == 'Off') then
                
                --domoticz.devices('lamp garage').switchOff().afterMin(10)
                
            end
        end
    
    end
}
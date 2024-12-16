return {
	on = {
      timer = {
          'at 16:30',
         '20 minutes before sunset',
         'at 22:01',
         'at 23:09',
         'at 23:31',
         'at 08:30',
         'at sunrise'
      }
	},
	execute = function(domoticz, device)
	    
	    local Time = require('Time')
	    local t = Time()
	    
	    if (t.matchesRule('at 16:30')) then

	    end

	    -- turn lights on
        if (t.matchesRule('20 minutes before sunset')) then
            
            domoticz.devices('Gang').dimTo(30)
            domoticz.devices('Trap').dimTo(30)
            domoticz.devices('Overloop').dimTo(30)
            
            domoticz.devices('Hal').dimTo(40)
            domoticz.devices('Terras deur').dimTo(30)
            domoticz.devices('Terras midden').dimTo(30)
            
            domoticz.devices('Voordeur').dimTo(60)
            domoticz.devices('Oprit').dimTo(60)

        end
    
            -- turn lights off
        if (t.matchesRule('at 22:01')) then
            domoticz.devices('Eetkamer 1').switchOff()
            domoticz.devices('Eetkamer 2').switchOff()
            domoticz.devices('Eetkamer 3').switchOff()
        end
	    
        -- turn lights off
        if (t.matchesRule('at 23:09')) then
            
            domoticz.devices('Gang').switchOff()
            domoticz.devices('Trap').switchOff()
            domoticz.devices('Overloop').switchOff()
            
            domoticz.devices('Hal').switchOff()
            domoticz.devices('Terras deur').switchOff()
            domoticz.devices('Terras midden').switchOff()
            
            domoticz.devices('aanrecht rechts').switchOff()
            domoticz.devices('aanrecht links').switchOff()
            domoticz.devices('Keukentafel Bas').switchOff()
            domoticz.devices('Keukentafel Tim').switchOff()
            domoticz.devices('Keukentafel papa').switchOff()

            domoticz.devices('Eetkamer 1').switchOff()
            domoticz.devices('Eetkamer 2').switchOff()
            domoticz.devices('Eetkamer 3').switchOff()
            
            domoticz.devices('Voordeur').dimTo(30)

        end
        
        -- sunrise
        if (t.matchesRule('at sunrise')) then
            domoticz.devices('Oprit').switchOff()
            domoticz.devices('Voordeur').switchOff()
        end

	end
}
return {
	on = {
		devices = {
			'Hue Sensor Lux woonkamer'
		}
	},
	execute = function(domoticz, device)
	    
	    local luxMax = 55 --40 voor schouw
	    local luxMin = 8 --5 voor schouw
	    local dimMax = 60
	    local dimVal --= 100-((100/14444)*domoticz.devices('Hue Sensor Lux WC').lux)
	    
	    local Time = require('Time')
	    local t = Time()
	    
	    if (    t.matchesRule('between 07:30 and sunset') and
	            (domoticz.devices('Kai Mobiel').state == 'On' or domoticz.devices('Silke Mobiel').state == 'On') and
	            domoticz.globalData.Button_kitchen_pressed_2S == false
	        ) then
	        
            --[[----------------------------------------------------------------------------

            ----------------------------------------------------------------------------]]--         
            if (domoticz.devices('Hue Sensor Lux woonkamer').lux >= luxMax) then
                domoticz.devices('Eetkamer 1').switchOff()
                domoticz.devices('Eetkamer 2').switchOff()
                domoticz.devices('Eetkamer 3').switchOff()
                
                --domoticz.devices('Keukentafel Bas').switchOff()
                --domoticz.devices('Keukentafel Tim').switchOff()
                --domoticz.devices('Keukentafel papa').switchOff()
                
                --domoticz.devices('aanrecht rechts').switchOff()
                --domoticz.devices('aanrecht links').switchOff()  
                
                --domoticz.devices('Voordeur').switchOff()
                domoticz.devices('Tafellamp').switchOff()
                
            end
            
            --[[----------------------------------------------------------------------------

            ----------------------------------------------------------------------------]]--             
            if (domoticz.devices('Hue Sensor Lux woonkamer').lux < luxMax and domoticz.devices('Hue Sensor Lux woonkamer').lux >= luxMin) then
                dimVal = dimMax-((dimMax/(luxMax-luxMin))*(domoticz.devices('Hue Sensor Lux woonkamer').lux)-luxMin)
                domoticz.devices('Eetkamer 1').dimTo(dimVal)
                domoticz.devices('Eetkamer 2').dimTo(dimVal)
                domoticz.devices('Eetkamer 3').dimTo(dimVal)
                
                --domoticzdomoticz.devices('Keukentafel Bas').dimTo(dimVal)
                --domoticz.devices('Keukentafel Tim').dimTo(dimVal)
                --domoticz.devices('Keukentafel papa').dimTo(dimVal)
                
                --domoticz.devices('aanrecht rechts').dimTo(dimVal)
                --domoticz.devices('aanrecht links').dimTo(dimVal)  
                
                --domoticz.devices('Voordeur').dimTo(dimVal)
                
                --domoticz.devices('Staande lamp').dimTo(dimVal)
                domoticz.devices('Tafellamp').dimTo(dimVal)

            end
            
            --[[----------------------------------------------------------------------------

            ----------------------------------------------------------------------------]]--  
            if (domoticz.devices('Hue Sensor Lux woonkamer').lux < luxMin) then
                domoticz.devices('Eetkamer 1').dimTo(dimMax)
                domoticz.devices('Eetkamer 2').dimTo(dimMax)
                domoticz.devices('Eetkamer 3').dimTo(dimMax)
                
                --domoticz.devices('Keukentafel Bas').dimTo(dimMax)
                --domoticz.devices('Keukentafel Tim').dimTo(dimMax)
                --domoticz.devices('Keukentafel papa').dimTo(dimMax)
                
                --domoticz.devices('aanrecht rechts').dimTo(dimMax)
                --domoticz.devices('aanrecht links').dimTo(dimMax) 
                
                domoticz.devices('Voordeur').dimTo(dimMax)
                
                --domoticz.devices('Staande lamp').dimTo(dimMax)
                domoticz.devices('Tafellamp').dimTo(dimMax)
                
            end

        end
    
	    if (    t.matchesRule('between sunrise and sunset') ) then
            --[[----------------------------------------------------------------------------

            ----------------------------------------------------------------------------]]--         
            if (domoticz.devices('Hue Sensor Lux woonkamer').lux >= luxMax) then

                --domoticz.devices('Voordeur').switchOff()
                --domoticz.devices('Oprit').switchOff()

            end
            
            --[[----------------------------------------------------------------------------

            ----------------------------------------------------------------------------]]--             
            if (domoticz.devices('Hue Sensor Lux woonkamer').lux < luxMax and domoticz.devices('Hue Sensor Lux woonkamer').lux >= luxMin) then
                dimVal = dimMax-((dimMax/(luxMax-luxMin))*(domoticz.devices('Hue Sensor Lux WC').lux)-luxMin)

                --domoticz.devices('Voordeur').dimTo(dimVal)
                --domoticz.devices('Oprit').dimTo(dimVal)

            end
            
            --[[----------------------------------------------------------------------------

            ----------------------------------------------------------------------------]]--  
            if (domoticz.devices('Hue Sensor Lux woonkamer').lux < luxMin) then

                --domoticz.devices('Voordeur').dimTo(dimMax)
                --domoticz.devices('Oprit').dimTo(dimMax)

            end
        end

    end
}
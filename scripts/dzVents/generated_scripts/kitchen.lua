return {
	on = {
		devices = {
			'ZLLPresence Sensor keuken',
			'ZLLSwitch Keuken'
		},
        timer = {
            '20 minutes before sunset',
            'at 23:02',
            'at 23:39',
            'at 08:30',
            'at sunrise'
        }
	},
	execute = function(domoticz, device)
	    
	    local Time = require('Time')
	    local t = Time()

-- MOTION	
        if (device.name == 'ZLLPresence Sensor keuken') then
    	    if (domoticz.devices('ZLLPresence Sensor keuken').state == 'On' and 
    	            t.matchesRule('between 06:00 and 08:30') and 
    	            domoticz.devices('Sensor Keuken Lux').lux < 13 and
    	            domoticz.globalData.Button_kitchen_pressed_4S == false
    	        ) then

                domoticz.devices('Keukentafel Bas').dimTo(50)
                domoticz.devices('Keukentafel Tim').dimTo(50)
                domoticz.devices('Keukentafel papa').dimTo(50)
                
            end
        end
        
-- BUTTON
        if (device.name == 'ZLLSwitch Keuken') then
            if (domoticz.devices('ZLLSwitch Keuken').state == 'Button 1 short') then
                domoticz.log('Keuken: Button 1 short', domoticz.LOG_INFO)
                domoticz.devices('Keukentafel Bas').dimTo(100)
                domoticz.devices('Keukentafel Tim').dimTo(100)
                domoticz.devices('Keukentafel papa').dimTo(100)
            end
            
            if (domoticz.devices('ZLLSwitch Keuken').state == 'Button 1 long') then
                domoticz.log('Keuken: Button 1 long', domoticz.LOG_INFO)
                domoticz.devices('Eetkamer 3').switchOff()   
                domoticz.devices('Keukentafel Bas').dimTo(100)
                domoticz.devices('Keukentafel Tim').dimTo(100)
                domoticz.devices('Keukentafel papa').dimTo(100)
                domoticz.devices('aanrecht rechts').dimTo(100)
                domoticz.devices('aanrecht links').dimTo(100)
            end
            
            if (domoticz.devices('ZLLSwitch Keuken').state == 'Button 2 short') then
                domoticz.log('Keuken: Button 2 short', domoticz.LOG_INFO)
                domoticz.devices('Eetkamer 1').switchOff()
                domoticz.devices('Eetkamer 2').switchOff()
                domoticz.devices('Eetkamer 3').switchOff()
                domoticz.devices('Staande lamp').switchOff()
                domoticz.devices('Tafellamp').switchOff()
                
                 domoticz.globalData.Button_kitchen_pressed_2S = true
            end
            
            if (domoticz.devices('ZLLSwitch Keuken').state == 'Button 2 long') then
                domoticz.log('Keuken: Button 2 long', domoticz.LOG_INFO)
                domoticz.devices('Eetkamer 1').dimTo(40)
                domoticz.devices('Eetkamer 2').dimTo(40)
                domoticz.devices('Eetkamer 3').dimTo(40)
                --domoticz.devices('Staande lamp').dimTo(40)
                domoticz.devices('Tafellamp').dimTo(40)
                domoticz.globalData.Button_kitchen_pressed_2S = false
            end
            
            if (domoticz.devices('ZLLSwitch Keuken').state == 'Button 3 short') then
                 domoticz.log('Keuken: Button 3 short', domoticz.LOG_INFO)
            end
            
            if (domoticz.devices('ZLLSwitch Keuken').state == 'Button 3 long') then
                 domoticz.log('Keuken: Button 3 long', domoticz.LOG_INFO)
            end
            
            if (domoticz.devices('ZLLSwitch Keuken').state == 'Button 4 short') then
                domoticz.log('Keuken: Button 4 short', domoticz.LOG_INFO)
                domoticz.devices('Keukentafel Bas').switchOff()
                domoticz.devices('Keukentafel Tim').switchOff()
                domoticz.devices('Keukentafel papa').switchOff()
                domoticz.devices('aanrecht rechts').switchOff()
                domoticz.devices('aanrecht links').switchOff()
                domoticz.globalData.Button_kitchen_pressed_4S = true             
            end
            
            if (domoticz.devices('ZLLSwitch Keuken').state == 'Button 4 long') then
                domoticz.log('Keuken: Button 4 long', domoticz.LOG_INFO)
                domoticz.devices('Gang').switchOff()
                domoticz.devices('Trap').switchOff()
                domoticz.devices('Overloop').switchOff()
                
                domoticz.devices('Kelder gang 1').switchOff()
                domoticz.devices('Kelder gang 2').switchOff()
                domoticz.devices('Speelkamer 1').switchOff()
                domoticz.devices('Speelkamer 2').switchOff()
                
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
                
                domoticz.devices('lamp garage').switchOff()
                
                domoticz.globalData.Button_kitchen_pressed_4L = true  
            end
        end
        
-- TIME 
	    -- turn lights off
	    if (t.matchesRule('at 08:30') or t.matchesRule('at 23:02')) then
            domoticz.devices('aanrecht rechts').switchOff()
            domoticz.devices('aanrecht links').switchOff()
            domoticz.devices('Keukentafel Bas').switchOff()
            domoticz.devices('Keukentafel Tim').switchOff()
            domoticz.devices('Keukentafel papa').switchOff()	        
	    end
	    
	    -- turn lights on
        if (t.matchesRule('20 minutes before sunset')) then
            --domoticz.devices('aanrecht rechts').switchOff()
            --domoticz.devices('aanrecht links').switchOff()
            domoticz.devices('Keukentafel Bas').dimTo(100)
            domoticz.devices('Keukentafel Tim').dimTo(100)
            domoticz.devices('Keukentafel papa').dimTo(100)
  
        end
    
    end
}
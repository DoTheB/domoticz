return {
	on = {
      timer = {
         'every minute'
      }
	},
	execute = function(domoticz, device)
	    
    package.path = package.path .. ';' .. '/home/pi/domoticz/scripts/lua/?.lua'
    local telegram = require('Telegram')	    
	    
    local Time = require('Time')
    local t = Time()
--[[----------------------------------------------------------------------------
garage light not longer on then 3 minutes
----------------------------------------------------------------------------]]--
    if(domoticz.devices('lamp garage').state == 'On') then
        domoticz.globalData.garage_light_on_counter = domoticz.globalData.garage_light_on_counter + 1
        if(domoticz.globalData.garage_light_on_counter >= 15) then
            domoticz.devices('lamp garage').switchOff()
            domoticz.globalData.garage_light_on_counter = 0
        end
    end

--[[----------------------------------------------------------------------------
washing machine
----------------------------------------------------------------------------]]--
    local Icurrent_washingmachine = domoticz.devices('wasmachine (A)').current
    -- hysteresis for washingmachine ready notification
    if(Icurrent_washingmachine > 0.059 and not domoticz.globalData.WashingMachine_isRunning) then
        if (domoticz.globalData.WashingMachine_on_counter >= 5) then
            --domoticz.notify("Domoticz", "Wasmachine aan", domoticz.PRIORITY_NORMAL,domoticz.SOUND_DEFAULT, "" , domoticz.NSS_TELEGRAM)
            result = telegram.sendText('All', 'Wasmachine aan')
            domoticz.globalData.WashingMachine_isRunning = true
        else
            domoticz.globalData.WashingMachine_on_counter = domoticz.globalData.WashingMachine_on_counter + 1
            domoticz.globalData.WashingMachine_off_counter = 0
        end
    elseif(Icurrent_washingmachine < 0.049 and domoticz.globalData.WashingMachine_isRunning) then
        if (domoticz.globalData.WashingMachine_off_counter >= 5) then
            --domoticz.notify("Domoticz", "Wasmachine is klaar", domoticz.PRIORITY_NORMAL,domoticz.SOUND_DEFAULT, "" , domoticz.NSS_TELEGRAM)
            result = telegram.sendText('All', 'Wasmachine is klaar')
            domoticz.globalData.WashingMachine_isRunning = false
        else
            domoticz.globalData.WashingMachine_off_counter = domoticz.globalData.WashingMachine_off_counter + 1
            domoticz.globalData.WashingMachine_on_counter = 0
        end
    end

--[[----------------------------------------------------------------------------
dehumidifier
----------------------------------------------------------------------------]]--
    local Icurrent_dehumidifier = domoticz.devices('luchtontvochtiger (A)').current
    -- hysteresis for dehumidifier ready notification
    if(Icurrent_dehumidifier > 0.03 and not domoticz.globalData.Dehumidifier_isRunning) then
        if (domoticz.globalData.Dehumidifier_on_counter >= 3) then
            --domoticz.notify("Domoticz", "Luchtontvochtiger AAN", domoticz.PRIORITY_NORMAL,domoticz.SOUND_DEFAULT, "" , domoticz.NSS_TELEGRAM)
            result = telegram.sendText('Kai', 'Luchtontvochtiger AAN')
--domoticz.log('Luchtontvochtiger AAN', domoticz.LOG_INFO)            
            domoticz.globalData.Dehumidifier_isRunning = true
        else
            domoticz.globalData.Dehumidifier_on_counter = domoticz.globalData.Dehumidifier_on_counter + 1
            domoticz.globalData.Dehumidifier_off_counter = 0
            domoticz.globalData.Dehumidifier_full_counter = 0
        end
    elseif(Icurrent_dehumidifier < 0.029 and domoticz.globalData.Dehumidifier_isRunning) then
        if (domoticz.globalData.Dehumidifier_off_counter >= 3) then
            --domoticz.notify("Domoticz", "Luchtontvochtiger UIT", domoticz.PRIORITY_NORMAL,domoticz.SOUND_DEFAULT, "" , domoticz.NSS_TELEGRAM)
            result = telegram.sendText('Kai', 'Luchtontvochtiger UIT')        
            domoticz.globalData.Dehumidifier_isRunning = false
        else
            domoticz.globalData.Dehumidifier_off_counter = domoticz.globalData.Dehumidifier_off_counter + 1
            domoticz.globalData.Dehumidifier_on_counter = 0
            domoticz.globalData.Dehumidifier_full_counter = 0
        end
    elseif(Icurrent_dehumidifier > 0.02 and Icurrent_dehumidifier < 0.06 and domoticz.globalData.Dehumidifier_isRunning) then
        if (domoticz.globalData.Dehumidifier_full_counter >= 3) then
            --domoticz.notify("Domoticz", "Luchtontvochtiger VOL, wordt uitgeschakeld", domoticz.PRIORITY_NORMAL,domoticz.SOUND_DEFAULT, "" , domoticz.NSS_TELEGRAM)
            result = telegram.sendText('All', 'Luchtontvochtiger VOL, wordt uitgeschakeld')               
            domoticz.globalData.Dehumidifier_isRunning = false
            domoticz.devices('luchtontvochtiger').switchOff()
            domoticz.globalData.Dehumidifier_full_counter = 0
        else
            domoticz.globalData.Dehumidifier_full_counter = domoticz.globalData.Dehumidifier_full_counter + 1
            domoticz.globalData.Dehumidifier_on_counter = 0
            domoticz.globalData.Dehumidifier_off_counter = 0
        end
    end

--[[----------------------------------------------------------------------------

----------------------------------------------------------------------------]]--
-- turn floor heating on/off
    local tempLiving = domoticz.devices('Home woonkamer TempHum').temperature 
    local tempSet = domoticz.devices('Home woonkamer Setpoint').setPoint 
    local heatOn = domoticz.devices('Home woonkamer Heating Enabled').state
--domoticz.log(tempSet .. ' - ' .. tempLiving  .. ' - ' .. heatOn, domoticz.LOG_INFO)  
    if (tempLiving >= (tempSet+1) and domoticz.devices('vloerverwarming').state == 'On') then
        domoticz.devices('vloerverwarming').switchOff()
    elseif (tempLiving < (tempSet+0.5) and domoticz.devices('vloerverwarming').state == 'Off') then
        domoticz.devices('vloerverwarming').switchOn()
    end

--[[----------------------------------------------------------------------------

----------------------------------------------------------------------------]]--    
-- turn off living room lights when tv shuts down at night
    if (domoticz.globalData.Living_lights_auto_OFF == false and 
	        t.matchesRule('between 23:31 and 06:00') and
	        domoticz.devices('TV Woonkamer').state == 'Off'
    )then
        domoticz.devices('Staande lamp').switchOff()
        domoticz.devices('Tafellamp').switchOff()  
        domoticz.devices('Eetkamer 1').switchOff()
        domoticz.devices('Eetkamer 2').switchOff()
        domoticz.devices('Eetkamer 3').switchOff()
        domoticz.globalData.Living_lights_auto_OFF = true
    end

--[[----------------------------------------------------------------------------

----------------------------------------------------------------------------]]--    
-- turn off basement play room lights when tv shuts down
    if (domoticz.devices('TV Kelder').state == 'Off')then
        --domoticz.devices('Speelkamer 1').switchOff().checkFirst()
        --domoticz.devices('Speelkamer 2').switchOff().checkFirst()
    end

--[[----------------------------------------------------------------------------

----------------------------------------------------------------------------]]--    
-- reset GV flags
    if (t.matchesRule('at 06:00')) then
        domoticz.globalData.Living_lights_auto_OFF = false
    end
    if (t.matchesRule('at 00:00')) then
        domoticz.globalData.Button_kitchen_pressed_2S = false
        domoticz.globalData.Button_kitchen_pressed_2L = false
        domoticz.globalData.Button_kitchen_pressed_4S = false
        domoticz.globalData.Button_kitchen_pressed_4L = false
    end

--[[----------------------------------------------------------------------------

----------------------------------------------------------------------------]]--
-- read outside temperature
    domoticz.globalData.OWM_String = domoticz.devices('OWM Temp').state
    domoticz.globalData.OWM_Data = domoticz.utils.stringSplit(domoticz.globalData.OWM_String,";")
    domoticz.globalData.Outside_Temperature = domoticz.globalData.OWM_Data[1]

--[[----------------------------------------------------------------------------

----------------------------------------------------------------------------]]--    
-- Alarm On
    if(domoticz.globalData.TV_simulator_ON) then
        if(domoticz.globalData.RGB_index > 3) then
            domoticz.globalData.RGB_index = 0
        else
            domoticz.globalData.RGB_index = domoticz.globalData.RGB_index + 1
        end
        domoticz.devices('Tafellamp').setRGB(domoticz.globalData.RGB_Val_R[domoticz.globalData.RGB_index],domoticz.globalData.RGB_Val_G[domoticz.globalData.RGB_index],domoticz.globalData.RGB_Val_B[domoticz.globalData.RGB_index])
        domoticz.devices('Tafellamp').switchOn().forSec(8).repeatAfterSec(0.5, 3)
    end 
    
--[[----------------------------------------------------------------------------

----------------------------------------------------------------------------]]--



--[[  
    -- activated by dummy switch: log power 
    if(domoticz.globalData.WashingMachine_monitor_power) then
        
        local fileName = "log_dump.csv"
        
        -- set all rights for file
        local function osExecute(cmd)
            local fileHandle     = assert(io.popen(cmd, 'r'))
            local commandOutput  = assert(fileHandle:read('*a'))
            local returnTable    = {fileHandle:close()}
            return commandOutput,returnTable[3]            -- rc[3] contains returnCode
        end
        local result, restultCode = osExecute("sudo chown pi:pi " .. "'" .. fileName .. "'" )
        result = osExecute("ls -l "   .. " '" .. fileName .. "'" )
        print (" rc: [" .. restultCode .."] " .. "result = " .. result  )	        
        
        -- measure and log
        Icurrent_dehumidifier = domoticz.utils.round(Icurrent_dehumidifier, 2)
	    local Ivoltage = domoticz.devices('luchtontvochtiger (V)').voltage
	    Ivoltage = domoticz.utils.round(Ivoltage, 2)
	    local Ipower = domoticz.utils.round(Ivoltage * Icurrent_dehumidifier, 2)
	    Ipower = domoticz.utils.round(Ipower, 2)
        local file = io.open(fileName, "a")
        io.output(file)
        io.write(os.date("%H") .. ":" .. os.date("%M") .. ":" .. os.date("%S") .. ","  .. 
            tostring(Icurrent_dehumidifier) .. ",A," .. 
            tostring(Ivoltage) .. ",V," ..  
            "\n")
        io.close(file)
    end
]]--

	end
}
return {
	on = {
		devices = {
			'dummy_switch_2'
		}
	},
	execute = function(domoticz, device)

		    domoticz.log('dimVal wc:  ' .. domoticz.devices('wasmachine (A)').current, domoticz.LOG_INFO)
		    domoticz.globalData.WashingMachine_isRunning = false

	end
}
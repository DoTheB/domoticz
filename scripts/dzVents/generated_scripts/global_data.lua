-- this scripts holds all the globally persistent variables and helper functions
-- see the documentation in the wiki
-- NOTE:
-- THERE CAN BE ONLY ONE global_data SCRIPT in your Domoticz install.

return {
	-- global persistent data
	data = {
		Bathroom_presence = { initial = false },
		Outside_motion_notification = { initial = false },
		WashingMachine_isRunning = { initial = false },
		WashingMachine_monitor_power = { initial = false },
		WashingMachine_off_counter = { initial = 0 },
		WashingMachine_on_counter = { initial = 0 },
		Dehumidifier_isRunning = { initial = false },
		Dehumidifier_isFULL = { initial = false },		
		Dehumidifier_off_counter = { initial = 0 },
		Dehumidifier_on_counter = { initial = 0 },
		Dehumidifier_full_counter = { initial = 0 },
		Button_kitchen_pressed_1S = { initial = false },
		Button_kitchen_pressed_1L = { initial = false },
		Button_kitchen_pressed_2S = { initial = false },
		Button_kitchen_pressed_2L = { initial = false },
		Button_kitchen_pressed_3S = { initial = false },
		Button_kitchen_pressed_3L = { initial = false },
		Button_kitchen_pressed_4S = { initial = false },
		Button_kitchen_pressed_4L = { initial = false },
		Living_lights_auto_OFF = { initial = false },
		Outside_Temperature = { initial = '' },
		OWM_String = { initial = '' },
		OWM_Data = { initial = '' },
		TV_simulator_ON = { initial = false },
		Alarm_ON = { initial = false },
		RGB_Val_R = { initial = {252, 3, 2, 252} },
		RGB_Val_G = { initial = {2, 11, 252, 252} },
		RGB_Val_B = { initial = {3, 252, 11, 3} },
		RGB_Z_Val = { initial = {3, 252, 11, 3} },
		RGB_index = { initial = 0 },
		garage_light_on_counter = { initial = 0 }
	},

	-- global helper functions
	helpers = {
		myHelperFunction = function(domoticz)
			-- code
		end
	}
}

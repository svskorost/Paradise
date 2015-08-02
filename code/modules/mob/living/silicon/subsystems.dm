/mob/living/silicon
	var/register_alarms = 1
	var/datum/nano_module/alarm_monitor/all/alarm_monitor
	var/datum/nano_module/atmos_control/atmos_control
	var/datum/nano_module/crew_monitor/crew_monitor

/mob/living/silicon
	var/list/silicon_subsystems = list(
		/mob/living/silicon/proc/subsystem_alarm_monitor
	)

/mob/living/silicon/ai
	silicon_subsystems = list(
		/mob/living/silicon/proc/subsystem_alarm_monitor,
		/mob/living/silicon/proc/subsystem_atmos_control,
		/mob/living/silicon/proc/subsystem_crew_monitor
	)

/mob/living/silicon/robot/syndicate
	register_alarms = 0

/mob/living/silicon/proc/init_subsystems()
	alarm_monitor 	= new(src)
	atmos_control 	= new(src)
	crew_monitor 	= new(src)

	if(!register_alarms)
		return

	var/list/register_to = list(atmosphere_alarm, camera_alarm, fire_alarm, motion_alarm, power_alarm)
	for(var/datum/alarm_handler/AH in register_to)
		AH.register(src, /mob/living/silicon/proc/receive_alarm)
		queued_alarms[AH] = list()	// Makes sure alarms remain listed in consistent order

/********************
*	Alarm Monitor	*
********************/
/mob/living/silicon/proc/subsystem_alarm_monitor()
	set name = "Alarm Monitor"
	set category = "Subsystems"

	alarm_monitor.ui_interact(usr, state = self_state)
	
/********************
*	Atmos Control	*
********************/
/mob/living/silicon/proc/subsystem_atmos_control()
	set category = "Subsystems"
	set name = "Atmospherics Control"

	atmos_control.ui_interact(usr, state = self_state)

/********************
*	Crew Monitor	*
********************/
/mob/living/silicon/proc/subsystem_crew_monitor()
	set category = "Subsystems"
	set name = "Crew Monitor"

	crew_monitor.ui_interact(usr, state = self_state)

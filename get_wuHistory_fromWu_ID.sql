SELECT id, wu_id, start_time, stop_time, active_user, wu_state, description
	FROM work_units.activity
	WHERE wu_id =85599
	ORDER BY start_time DESC
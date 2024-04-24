SELECT subcountry, w.id, a.active_user, min(start_time) as deploy_date, ST_Length(w.geom::geography) * 0.000621371 miles, table1.wu_state as "currentWuState", array_agg(pc.pc_id) as pc_ids
FROM work_units.work_unit w
JOIN work_units.activity a ON a.wu_id = w.id
INNER JOIN work_units.wu_point_cloud pc ON pc.wu_id=w.id
FULL OUTER JOIN (select w0.id, a0.wu_state 
				from work_units.work_unit w0
				inner join work_units.activity a0 on a0.wu_id = w0.id
				where a0.start_time in (SELECT max(a1.start_time) FROM work_units.activity a1 WHERE a1.wu_id=w0.id)
				) as table1 on table1.id=w.id
WHERE start_time = (
	select min(start_time) 
	FROM work_units.activity 
	where wu_id = w.id 
	and wu_state = 'Ready_Collecting'
)

AND subcountry = 'USA_NorthCarolina'  -- change state or comment this out
AND a.active_user in ('ushr_jgreener')	  --change user or comment this out
AND table1.wu_state not in ('Ready_Collecting')	--exclude certain current WU State, or comment out

GROUP BY subcountry, w.id, a.active_user, w.geom, table1.wu_state
ORDER BY deploy_date DESC 			--ASC = ordered from earliest->latest date, DESC = reverse order
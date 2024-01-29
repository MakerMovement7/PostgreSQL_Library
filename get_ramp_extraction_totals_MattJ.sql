with deliv_wu as (
	-- get work units that are deliverable
	SELECT wu_id, min(start_time) as start_time
	FROM work_units.activity
	WHERE wu_state in ('Ready_Ushr_QC'::work_unit_state, 'Ready_Publish'::work_unit_state)
	GROUP BY wu_id
)
SELECT w.subcountry, rt.road_type_name, count(sb.segment_id) as num_segs, 
round((SUM(road_unit.segment_length(segment_id)) * 0.000621371)::numeric, 2) as miles
FROM road_unit.segment_boundaries sb, road_unit.segments s, road_unit.road_type_names rt, work_units.work_unit w
WHERE sb.segment_id = s.id
AND s.road_type_id = rt.id 
AND sb.wu_id = w.id
AND (
	(
		-- Is original extraction and nothing replaces it
		sb.replaced_by_wuid is NULL 
	 	AND (
			NOT EXISTS (
			-- not a change management work unit
			SELECT 1 FROM road_unit.segment_boundaries sb2 WHERE sb.wu_id = sb2.replaced_by_wuid
		)
			-- Change management work unit ready for delivery
			OR EXISTS (
				SELECT 1 FROM deliv_wu wd2 WHERE wd2.wu_id = sb.wu_id
			)
		)
			
	)
	-- does not have replacement data ready for delivery
	OR NOT EXISTS (
		SELECT 1 FROM deliv_wu dw WHERE dw.wu_id = sb.replaced_by_wuid
	)
)
AND sb.segment_id = road_unit.get_most_recent_segment_id(sb.segment_id)
AND rt.road_type_name in ('INTERCHANGE_LINK', 'ACCESS_RAMP')
--AND w.subcountry = 'USA_Michigan'
GROUP BY w.subcountry, rt.road_type_name

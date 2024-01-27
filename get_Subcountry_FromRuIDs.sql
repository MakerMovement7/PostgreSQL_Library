SELECT w.subcountry, sb.wu_id, sb.segment_id
	FROM road_unit.segment_boundaries sb
	inner join work_units.work_unit w on sb.wu_id = w.id
	WHERE sb.segment_id in (
355688,
1142127,
1170940
)
GROUP BY w.subcountry, sb.wu_id, sb.segment_id
ORDER BY sb.wu_id ASC
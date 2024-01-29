SELECT st_astext(st_union(st_makevalid(p.envelope::geometry))) as geom, w.subcountry, sb.wu_id, sp.segment_id
	FROM road_unit.segment_paths sp
	inner join path.paths p on p.id = sp.id
	--INNER JOIN road_unit.segments segs ON sp.segment_id = segs.id
	--INNER JOIN road_unit.road_type_names ruType ON segs.road_type_id = ruType.id
	inner join road_unit.segment_boundaries sb on sb.segment_id = sp.segment_id
	inner join work_units.work_unit w on sb.wu_id = w.id
--AND (ruType.road_type_name = 'CONTROLLED_ACCESS_DIVIDED')
GROUP BY w.subcountry, sb.wu_id, sp.segment_id
--ORDER BY sp.segment_id ASC
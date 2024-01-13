SELECT bp.id, bp.boundary_id
	FROM boundary.boundary_points bp 
	inner join delineator.delineators d on bp.id = d.end_boundary_point_id --d.start_boundary_point_id
	where d.id=6248348

--using boundary plane start/end ids, then find road unit id
/*SELECT segment_id, start_boundary_id, end_boundary_id, wu_id, replaced_by_wuid
	FROM road_unit.segment_boundaries where start_boundary_id=1096221 and end_boundary_id=1096223*/
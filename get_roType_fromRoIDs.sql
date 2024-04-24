SELECT ro.id as road_object_id, p.id as path_id, ro.type_name
FROM path.paths p
INNER JOIN road_unit.segment_paths sp ON sp.id = p.id
INNER JOIN segment_path_type.segment_path_type_sets_members sptsm ON sp.start_type_set_id = sptsm.segment_path_type_set_id
INNER JOIN segment_path_type.segment_path_types spt ON sptsm.segment_path_type_id = spt.id
INNER JOIN road_unit.segment_boundaries sb ON sp.segment_id = sb.segment_id
INNER JOIN road_object.road_objects_paths rop on rop.path_id = p.id
INNER JOIN road_object.road_objects ro on ro.id = rop.road_object_id
WHERE ro.id in (4299040)
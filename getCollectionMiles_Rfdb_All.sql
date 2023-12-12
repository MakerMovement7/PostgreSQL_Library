SELECT CURRENT_TIMESTAMP as "time_stamp",'RFDB_ALL' as "scope", (SELECT sum(miles)
		FROM (SELECT w.subcountry, sb.segment_id, sb.replaced_by_wuid, (select sum(ST_Length(ST_LineFromMultiPoint(control_points_sequence::geometry)::geography)/1609.344)/ count(distinct d0.id)
		from delineator.delineator_control_points_sequences dcps0
		INNER JOIN delineator.delineators d0 on d0.id=dcps0.delineator_id
		INNER JOIN boundary.boundary_points startb0 on startb0.id =d0.start_boundary_point_id
		INNER JOIN boundary.boundary_points endb0 on endb0.id =d0.end_boundary_point_id
		INNER JOIN road_unit.segment_boundaries sb0 on sb0.start_boundary_id =startb0.boundary_id AND sb0.end_boundary_id =endb0.boundary_id
		WHERE sb0.segment_id =sb.segment_id ) as miles
		FROM road_unit.segment_boundaries sb
		INNER JOIN work_units.work_unit w on sb.wu_id = w.id
		GROUP BY w.subcountry, sb.segment_id) as table1

		WHERE table1.replaced_by_wuid IS NULL) as "Miles_NotReplacedBy"
, (SELECT sum(miles)
		FROM (SELECT w.subcountry, sb.segment_id, sb.replaced_by_wuid, rtn.road_type_name, (select sum(ST_Length(ST_LineFromMultiPoint(control_points_sequence::geometry)::geography)/1609.344)/ count(distinct d0.id)
		from delineator.delineator_control_points_sequences dcps0
		INNER JOIN delineator.delineators d0 on d0.id=dcps0.delineator_id
		INNER JOIN boundary.boundary_points startb0 on startb0.id =d0.start_boundary_point_id
		INNER JOIN boundary.boundary_points endb0 on endb0.id =d0.end_boundary_point_id
		INNER JOIN road_unit.segment_boundaries sb0 on sb0.start_boundary_id =startb0.boundary_id AND sb0.end_boundary_id =endb0.boundary_id
		WHERE sb0.segment_id =sb.segment_id ) as miles
		FROM road_unit.segment_boundaries sb
		INNER JOIN work_units.work_unit w on sb.wu_id = w.id
		FULL OUTER JOIN road_unit.segments s ON s.id = sb.segment_id
		FULL OUTER JOIN road_unit.road_type_names rtn ON rtn.id = s.road_type_id
		GROUP BY w.subcountry, sb.segment_id, sb.replaced_by_wuid, rtn.road_type_name) as table1

		WHERE table1.road_type_name in ('CONTROLLED_ACCESS_DIVIDED', 'INTERCHANGE_LINK','CONTROLLED_ACCESS_DIVIDED_COLLECTOR','CONTROLLED_ACCESS_NON_DIVIDED')
		AND table1.replaced_by_wuid IS NULL) as "CAD / CAND / Link / Collector"
, (SELECT sum(miles)
		FROM (SELECT w.subcountry, sb.segment_id, sb.replaced_by_wuid, rtn.road_type_name, (select sum(ST_Length(ST_LineFromMultiPoint(control_points_sequence::geometry)::geography)/1609.344)/ count(distinct d0.id)
		from delineator.delineator_control_points_sequences dcps0
		INNER JOIN delineator.delineators d0 on d0.id=dcps0.delineator_id
		INNER JOIN boundary.boundary_points startb0 on startb0.id =d0.start_boundary_point_id
		INNER JOIN boundary.boundary_points endb0 on endb0.id =d0.end_boundary_point_id
		INNER JOIN road_unit.segment_boundaries sb0 on sb0.start_boundary_id =startb0.boundary_id AND sb0.end_boundary_id =endb0.boundary_id
		WHERE sb0.segment_id =sb.segment_id ) as miles
		FROM road_unit.segment_boundaries sb
		INNER JOIN work_units.work_unit w on sb.wu_id = w.id
		FULL OUTER JOIN road_unit.segments s ON s.id = sb.segment_id
		FULL OUTER JOIN road_unit.road_type_names rtn ON rtn.id = s.road_type_id
		GROUP BY w.subcountry, sb.segment_id, sb.replaced_by_wuid, rtn.road_type_name) as table1

		WHERE table1.road_type_name in ('LOCAL_DIVIDED', 'LOCAL_NON_DIVIDED','NON_CONTROLLED_ACCESS_DIVIDED','NON_CONTROLLED_ACCESS_NON_DIVIDED')
		AND table1.replaced_by_wuid IS NULL) as "Local / NCAD / NCAND"
, (SELECT sum(miles)
		FROM (SELECT w.subcountry, sb.segment_id, sb.replaced_by_wuid, rtn.road_type_name, (select sum(ST_Length(ST_LineFromMultiPoint(control_points_sequence::geometry)::geography)/1609.344)/ count(distinct d0.id)
		from delineator.delineator_control_points_sequences dcps0
		INNER JOIN delineator.delineators d0 on d0.id=dcps0.delineator_id
		INNER JOIN boundary.boundary_points startb0 on startb0.id =d0.start_boundary_point_id
		INNER JOIN boundary.boundary_points endb0 on endb0.id =d0.end_boundary_point_id
		INNER JOIN road_unit.segment_boundaries sb0 on sb0.start_boundary_id =startb0.boundary_id AND sb0.end_boundary_id =endb0.boundary_id
		WHERE sb0.segment_id =sb.segment_id ) as miles
		FROM road_unit.segment_boundaries sb
		INNER JOIN work_units.work_unit w on sb.wu_id = w.id
		FULL OUTER JOIN road_unit.segments s ON s.id = sb.segment_id
		FULL OUTER JOIN road_unit.road_type_names rtn ON rtn.id = s.road_type_id
		GROUP BY w.subcountry, sb.segment_id, sb.replaced_by_wuid, rtn.road_type_name) as table1

		WHERE table1.road_type_name = 'ACCESS_RAMP'  
		AND table1.replaced_by_wuid IS NULL) as "AccessRamps"
, (SELECT sum(miles)
		FROM (SELECT w.subcountry, sb.segment_id, sb.replaced_by_wuid, (select sum(ST_Length(ST_LineFromMultiPoint(control_points_sequence::geometry)::geography)/1609.344)/ count(distinct d0.id)
		from delineator.delineator_control_points_sequences dcps0
		INNER JOIN delineator.delineators d0 on d0.id=dcps0.delineator_id
		INNER JOIN boundary.boundary_points startb0 on startb0.id =d0.start_boundary_point_id
		INNER JOIN boundary.boundary_points endb0 on endb0.id =d0.end_boundary_point_id
		INNER JOIN road_unit.segment_boundaries sb0 on sb0.start_boundary_id =startb0.boundary_id AND sb0.end_boundary_id =endb0.boundary_id
		WHERE sb0.segment_id =sb.segment_id ) as miles
		FROM road_unit.segment_boundaries sb
		INNER JOIN work_units.work_unit w on sb.wu_id = w.id
		GROUP BY w.subcountry, sb.segment_id) as table1

		WHERE table1.replaced_by_wuid IS NOT NULL) as "Miles_ReplacedBy"





SELECT segment_id, wu_id, replaced_by_wuid
FROM road_unit.segment_boundaries
WHERE segment_id in (207362,
294868
)
ORDER BY segment_id ASC
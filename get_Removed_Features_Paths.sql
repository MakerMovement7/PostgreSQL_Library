SELECT segment_id, deleted_time, deleted_user, deleted_feature
	FROM work_status.removed_features where segment_id in (1518340,
131621,
1164375,
802044,
1185123,
1824056,
1824156,
1318112,
1527582,
1632434,
1639086,
1639344,
1639381,
1810379,
1195308,
1824309,
1811464,
1685449,
1685935,
1562744,
381034,
278586,
563016


)
--and deleted_time>='2021-01-01'					--after certain date
and POSITION('Path ' IN "deleted_feature")>0 	--for removed_paths only
--GROUP BY segment_id
ORDER BY deleted_time DESC

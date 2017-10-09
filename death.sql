SELECT '10953' AS HOSPCODE, cid_hn.HN AS PID,
CASE deaths.IS_HOSP
	WHEN 0 THEN '10953'
	WHEN 1 THEN '00000'
END AS HOSPDEATH,ADM_ID AS AN,

FROM population,cid_hn,deaths,opd_visits
INNER JOIN ipd_reg ON opd_visits.VISIT_ID = ipd_reg.VISIT_ID
WHERE
population.CID = cid_hn.CID AND population.CID = deaths.CID 
LIMIT 1000;
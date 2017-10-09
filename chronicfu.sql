SELECT DISTINCT '10953' AS HOSPCODE,
cid_hn.HN AS PID,  
opd_visits.VISIT_ID AS SEQ,
DATE_FORMAT(opd_visits.REG_DATETIME,'%Y%m%d')DATE_SERV,
FORMAT(opd_visits.WEIGHT,1) AS WEIGHT,
opd_visits.HEIGHT AS HEIGHT,
CASE
	WHEN opd_visits.WAIST = '' THEN 0
ELSE opd_visits.WAIST
END AS WAIST_CM,
opd_visits.BP_SYST AS SBP,
opd_visits.BP_DIAS AS DBP,
CASE
	WHEN ISNULL(dm_foot.cid) then '2'
else '1' end AS FOOT,
CASE
	WHEN ISNULL(dm_eye.cid) then '8'
	WHEN dm_eye.EYE_RX <4 THEN '2'
	WHEN dm_eye.EYE_RX >3 THEN '4'
END AS RETINA,
opd_diagnosis.STAFF_ID AS PROVIDER,
DATE_FORMAT(NOW(), '%Y%m%d%H%i%s') AS D_UPDATE
FROM 
	population 
	INNER JOIN cid_hn ON population.CID = cid_hn.CID 
	INNER JOIN opd_visits ON cid_hn.hn = opd_visits.HN
	LEFT OUTER  JOIN dm_foot ON dm_foot.CID = population.CID and dm_foot.EXAM_DATE between '2014.01.01' and '2014.01.15'
	LEFT OUTER  JOIN dm_eye ON dm_eye.CID = population.CID  and dm_eye.EXAM_DATE between '2014.01.01' and '2014.01.15' 
  INNER JOIN opd_diagnosis  ON opd_visits.visit_id = opd_diagnosis.visit_id and opd_diagnosis.dxt_id = '1'
WHERE  LEFT( population.cid, 5 ) > 00000 
	AND opd_visits.reg_datetime BETWEEN '2014.01.01 00:00' AND '2014.01.15 23:59' 
	AND opd_visits.is_cancel = 0 
	AND opd_visits.visit_id NOT IN( SELECT visit_id FROM ipd_reg )
ORDER BY 
	population.cid;

	

	
SELECT DISTINCT '10953' AS HOSPCODE, 
cid_hn.HN AS PID,  
opd_visits.VISIT_ID AS SEQ, 
DATE_FORMAT(opd_visits.REG_DATETIME,'%Y%m%d')DATE_SERV,
drugs_tho.DRUG_THO AS VACCINETYPE,  
'10953' AS VACCINEPLACE,
prescriptions.STAFF_ID AS PROVIDER,
DATE_FORMAT(NOW(),'%Y%m%d%H%i%s') AS D_UPDATE
FROM 
	population 
	INNER JOIN cid_hn ON population.CID = cid_hn.CID 
	INNER JOIN opd_visits ON cid_hn.hn = opd_visits.HN 
	INNER JOIN prescriptions ON prescriptions.VISIT_ID = opd_visits.VISIT_ID
	INNER JOIN drugs_tho ON drugs_tho.DRUG_ID = prescriptions.DRUG_ID

WHERE 
1 = 1	
	AND LEFT( population.cid, 5 ) > 00000 
  AND opd_visits.reg_datetime BETWEEN '2014.01.01 00:00' AND '2014.01.05 23:59' 
	AND opd_visits.is_cancel = 0 
	AND opd_visits.visit_id NOT IN( SELECT visit_id FROM ipd_reg )
;
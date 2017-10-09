SELECT DISTINCT '10953' AS HOSPCODE,
 cid_hn.hn AS PID,  
opd_visits.VISIT_ID AS SEQ,  
DATE_FORMAT(opd_visits.REG_DATETIME,'%Y%m%d') AS DATE_SERV,
concat('0', opd_visits.UNIT_REG, opd_diagnosis.DXG_ID) AS CLINIC,
replace(replace(icd9cm.code, '.', ''), '-', '') AS PROCEDCODE,
icd9cm.cost AS SERVICEPRICE,
opd_diagnosis.STAFF_ID AS PROVIDER,
DATE_FORMAT(NOW(), '%Y%m%d%H%i%s') AS D_UPDATE
FROM 
	population 
	INNER JOIN cid_hn ON population.CID = cid_hn.CID 
	INNER JOIN opd_visits ON cid_hn.hn = opd_visits.HN
	INNER JOIN opd_operations ON opd_operations.VISIT_ID = opd_visits.VISIT_ID
	INNER JOIN icd9cm ON opd_operations.ICD9_ID = icd9cm.ICD9_ID
	inner join opd_diagnosis on opd_visits.visit_id = opd_diagnosis.VISIT_ID and opd_diagnosis.DXT_ID='1'
#INNER JOIN icd9cm ON opd_visits.
WHERE 
1 = 1	
	AND LEFT( population.cid, 5 ) > 00000 
  AND opd_visits.reg_datetime BETWEEN '2014.01.01 00:00' AND '2014.01.31 23:59' 
	AND opd_visits.is_cancel = 0 
	AND opd_visits.visit_id NOT IN( SELECT visit_id FROM ipd_reg )
ORDER BY population.CID;

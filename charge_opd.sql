SELECT DISTINCT '10953' AS HOSPCODE,
 cid_hn.hn AS PID,  
opd_visits.VISIT_ID AS SEQ,  
DATE_FORMAT(opd_visits.REG_DATETIME,'%Y%m%d') AS DATE_SERV,
concat('1', opd_visits.UNIT_REG, opd_diagnosis.DXG_ID) AS CLINIC,
icd9cm.CGD_ID AS CHARGEITEM,
'' AS CHARGELIST,
'' AS QUANTITY,
'' AS INSTYPE,
'' AS COST,
'' AS PRICE,
'' AS PAYPRICE,
DATE_FORMAT(NOW(), '%Y%m%d%H%i%s') AS D_UPDATE
FROM 
	population 
	INNER JOIN cid_hn ON population.CID = cid_hn.CID 
	INNER JOIN opd_visits ON cid_hn.hn = opd_visits.HN
	INNER JOIN opd_operations ON opd_operations.VISIT_ID = opd_visits.VISIT_ID 
	INNER JOIN opd_diagnosis ON opd_diagnosis.VISIT_ID = opd_visits.VISIT_ID
	INNER JOIN icd9cm ON icd9cm.ICD9_ID = opd_operations.ICD9_ID

WHERE 
1 = 1	
	AND LEFT( population.cid, 5 ) > 00000 
  AND opd_visits.reg_datetime BETWEEN '2014.01.01 00:00' AND '2014.01.31 23:59' 
	AND opd_visits.is_cancel = 0 
	AND opd_visits.visit_id NOT IN( SELECT visit_id FROM ipd_reg )
;

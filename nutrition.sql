SELECT DISTINCT '10953' AS HOSPCODE,
cid_hn.HN AS PID,  
opd_visits.VISIT_ID as SEQ,  
DATE_FORMAT(opd_visits.REG_DATETIME,'%Y%m%d') AS DATE_SERV,
opd_visits.STAFF_ID AS NUTRITIONPLACE,
FORMAT(opd_visits.WEIGHT,1) AS WEIGHT,
opd_visits.HEIGHT AS HEIGHT,
'' AS HEADCIRCUM,
'' AS CHILDDEVELOP,
'' AS FOOD,
'' AS BOTTLE,
'' AS PROVIDER,
DATE_FORMAT(NOW(),'%Y%m%d%H%i%s') AS D_UPDATE
FROM 
	population 
	INNER JOIN cid_hn ON population.CID = cid_hn.CID 
	INNER JOIN opd_visits ON cid_hn.hn = opd_visits.HN
	INNER JOIN opd_operations ON opd_operations.VISIT_ID = opd_visits.VISIT_ID
	INNER JOIN icd9cm ON opd_operations.ICD9_ID = icd9cm.ICD9_ID
	inner join opd_diagnosis on opd_visits.visit_id = opd_diagnosis.VISIT_ID and opd_diagnosis.DXT_ID='1'

WHERE 
1 = 1	
	AND LEFT( population.cid, 5 ) > 00000 
  AND opd_visits.reg_datetime BETWEEN '2014.01.01 00:00' AND '2014.01.31 23:59' 
  AND opd_visits.is_cancel = 0
	AND FLOOR(DATEDIFF(NOW(),population.BIRTHDATE)/365.25) >=0 AND FLOOR(DATEDIFF(NOW(),population.BIRTHDATE)/365.25) <6
	AND opd_visits.visit_id NOT IN( SELECT visit_id FROM ipd_reg )
ORDER BY population.CID;
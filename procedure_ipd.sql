SELECT DISTINCT '10953' AS HOSPCODE,
cid_hn.hn AS PID,  
ipd_reg.ADM_ID AS AN,
DATE_FORMAT(ipd_reg.ADM_DT,'%Y%m%d%H%i%s')DATETIME_ADMIT,
CONCAT('1',opd_visits.UNIT_REG,ipd_reg.WARD_NO) AS WARDSTAY,
replace(replace(icd9cm.code, '.', ''), '-', '') AS PROCEDCODE,
'' AS TIMESTART,
'' AS TIMEFINISH,
'' AS SERVICEPRICE,
ipd_reg.DSC_DR AS PROVIDER,
DATE_FORMAT(NOW(),'%Y%m%d%H%i%s') AS D_UPDATE
FROM 
population
INNER JOIN cid_hn ON population.CID = cid_hn.CID 
INNER JOIN opd_visits ON cid_hn.hn = opd_visits.HN
INNER JOIN ipd_reg ON opd_visits.VISIT_ID = ipd_reg.VISIT_ID
INNER JOIN opd_diagnosis ON opd_diagnosis.VISIT_ID = opd_visits.VISIT_ID
INNER JOIN opd_operations ON opd_operations.VISIT_ID = opd_visits.VISIT_ID
INNER JOIN icd9cm ON opd_operations.ICD9_ID = icd9cm.ICD9_ID
WHERE  LEFT( population.cid, 5 ) > 00000 
	AND opd_visits.reg_datetime BETWEEN '2014.01.01 00:00' AND '2014.01.30 23:59' 
	AND opd_visits.is_cancel = 0 
ORDER BY 
	population.cid;

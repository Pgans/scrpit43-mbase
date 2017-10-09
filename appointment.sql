SELECT DISTINCT '10953' AS HOSPCODE,
appoints.HN AS PID,  
#ipd_reg.ADM_ID AS AN,
appoints.AP_ID AS SEQ, 
DATE_FORMAT(appoints.AP_DATE,'%Y%m%d') AS DATE_SERV,
'' AS CLINIC,
'' AS APDATE,
'' AS APTYPE,
'' AS APDIAG, 
appoints.STAFF_ID AS PROVIDER,
DATE_FORMAT(NOW(),'%Y%m%d%H%i%s') AS D_UPDATE
FROM 
appoints
#INNER JOIN cid_hn ON population.CID = cid_hn.CID 
#INNER JOIN appoints ON appoints.HN = cid_hn.HN
#INNER JOIN ipd_reg ON opd_visits.VISIT_ID = ipd_reg.VISIT_ID
WHERE  appoints.AP_DATE BETWEEN '2014.01.01 00:00' AND '2014.01.30 23:59' 
	AND appoints.is_cancel = 0 
ORDER BY 
	appoints.AP_ID;
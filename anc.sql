SELECT DISTINCT '10953' AS HOSPCODE,
cid_hn.HN AS PID,  
anc.ANC_NO AS SEQ,  
DATE_FORMAT(anc.REG_DATETIME,'%Y%m%d')AS DATE_SERV,
anc.GRAVIDA AS GRAVIDA,
'' AS ANCNO,
anc.GA AS GA,
anc.ANCRES AS ANCRESULT,
'' AS ANCPLACE,
'' AS PROVIDER,
DATE_FORMAT(NOW(),'%Y%m%d%H%i%s') AS D_UPDATE
FROM 
	population 
	INNER JOIN cid_hn ON population.CID = cid_hn.CID 
	INNER JOIN opd_visits ON cid_hn.hn = opd_visits.HN
	INNER JOIN anc ON anc.CID = population.CID
#	INNER JOIN opd_diagnosis ON opd_visits.VISIT_ID = opd_diagnosis.VISIT_ID

WHERE 
1 = 1	
	AND LEFT( anc.cid, 5 ) > 00000 
  AND anc.reg_datetime BETWEEN '2014.01.01 00:00' AND '2014.01.31 23:59' 
	AND anc.is_cancel = 0 
ORDER BY anc.CID;
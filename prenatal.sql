SELECT DISTINCT '10953' AS HOSPCODE,
cid_hn.HN AS PID,  
anc.GRAVIDA AS GRAVIDA,  
DATE_FORMAT(anc.LMP,'%Y%m%d') AS LMP,
'' AS EDC,
anc.VDRL_RS AS VDRL_RESULT,
anc.HB_RS AS HB_RESULT,
anc.HIV_RS AS HIV_RESULT,
'' AS DATE_HCT,
anc.HCT_RS AS HCT_RESULT,
'' AS THALASSEMIA,
DATE_FORMAT(NOW(),'%Y%m%d%H%i%s') AS D_UPDATE
FROM 
	population 
	INNER JOIN cid_hn ON population.CID = cid_hn.CID 
	INNER JOIN opd_visits ON cid_hn.hn = opd_visits.HN
	INNER JOIN anc ON anc.CID = population.CID

WHERE 
1 = 1	
	AND LEFT( anc.cid, 5 ) > 00000 
  AND anc.reg_datetime BETWEEN '2014.01.01 00:00' AND '2014.01.31 23:59' 
	AND anc.is_cancel = 0 
ORDER BY anc.CID;
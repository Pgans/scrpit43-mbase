SELECT DISTINCT '10953' AS HOSPCODE,
cid_hn.HN AS PID,  
anc.GRAVIDA AS GRAVIDA,  
DATE_FORMAT(anc.LMP,'%Y%m%d')LMP,
'' AS EDC,
DATE_FORMAT(anc_outcome.BDATE,'%Y%m%d') AS BDATE,
'' AS BRESULT,
'1' AS BPLACE,
anc_outcome.HOSP_ID AS BHOSP,
'1' AS BTYPE,
CASE 
	WHEN staff.POS_ID = '001' THEN '1'
	WHEN staff.POS_ID = '002' THEN '2'
ELSE '6'
END AS BDOCTOR,
anc.LBORN AS LBORN,
anc_outcome.SBORN AS SBORN,
DATE_FORMAT(NOW(),'%Y%m%d%H%i%s') AS D_UPDATE
FROM 
	population 
	INNER JOIN cid_hn ON population.CID = cid_hn.CID 
	INNER JOIN opd_visits ON cid_hn.hn = opd_visits.HN
	INNER JOIN anc ON anc.CID = population.CID
  INNER JOIN anc_outcome ON anc_outcome.ANC_NO = anc.ANC_NO
	INNER JOIN staff ON staff.STAFF_ID = anc_outcome.STAFF_ID

WHERE 
1 = 1	
	AND LEFT( anc.cid, 5 ) > 00000 
  AND anc.reg_datetime BETWEEN '2014.01.01 00:00' AND '2014.01.31 23:59' 
	AND anc.is_cancel = 0 
ORDER BY anc.CID;
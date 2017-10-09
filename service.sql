SELECT DISTINCT '10953' AS HOSPCODE, 
cid_hn.HN AS PID, cid_hn.HN AS HN,
opd_visits.VISIT_ID AS SEQ,  
DATE_FORMAT(opd_visits.REG_DATETIME,'%Y%m%d')AS DATE_SERV,
DATE_FORMAT(opd_visits.REG_DATETIME,'%H%i%s') AS TIME_SERV,'2' AS LOCATION,'1' AS INTIME,main_inscls.STD_CODE AS INSTYPE,
uc_inscl.UC_CARDID AS INSID,uc_inscl.HOSPMAIN AS MAIN,'1' AS TYPEIN,
(CASE WHEN ISNULL(a.hosp_id) THEN ''
	ELSE a.HOSP_ID
END) AS REFERINHOSP,
'' AS CAUSEIN,
opd_visits.HISTORY AS CHIEFCOMP,
(CASE WHEN ISNULL(c.VISIT_ID) THEN '1'
	ELSE '2'
END) AS SERVPLACE,
opd_visits.BODY_TEMP AS BTEMP,opd_visits.BP_SYST AS SBP,opd_visits.BP_DIAS AS DBP,
opd_visits.PULSE_RATE AS PR,opd_visits.RESP_RATE AS RR,'1' AS TYPEOUT,
(CASE WHEN ISNULL(b.hosp_id) THEN ''
	ELSE b.HOSP_ID
END) AS REFEROUTHOSP,
'' AS CAUSEOUT,
'' AS COST,
'' AS PRICE,
(CASE WHEN ISNULL(d.visit_id) THEN 0
	ELSE d.money
END) AS PAYPRICE,
(CASE WHEN ISNULL(d.visit_id) THEN 0
	ELSE d.paid
END) AS ACTUALPAY,
DATE_FORMAT(NOW(), '%Y%m%d%H%i%s') AS D_UPDATE
FROM population,uc_inscl,cid_hn
INNER JOIN opd_visits ON opd_visits.HN = cid_hn.HN
INNER JOIN main_inscls ON  main_inscls.INSCL = opd_visits.INSCL 
left outer join refers a on opd_visits.visit_id = a.visit_id  and a.rf_type = '1' 
left outer join refers b on opd_visits.visit_id = b.visit_id  and b.rf_type = '2' 
left outer join mobile_visits c on opd_visits.visit_id = c.visit_id  
left outer join receipts d on opd_visits.visit_id = d.visit_id  
WHERE  opd_visits.REG_DATETIME BETWEEN '2014.01.01 00:00' AND '2014.01.03 23:59'
AND cid_hn.CID = population.CID 
AND uc_inscl.CID = population.CID
AND LEFT( population.cid, 5 ) > 00000 
AND opd_visits.IS_CANCEL = 0
AND opd_visits.visit_id NOT IN( SELECT visit_id FROM ipd_reg );

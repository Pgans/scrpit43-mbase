SELECT DISTINCT '10953' AS HOSPCODE, 
cid_hn.HN AS PID,  
opd_visits.VISIT_ID AS SEQ,  
ipd_reg.ADM_ID AS AN,
DATE_FORMAT(ipd_reg.ADM_DT,'%Y%m%d') AS DATETIME_ADMIT,
CONCAT('1',opd_diagnosis.DXG_ID,ipd_reg.WARD_NO) AS WARDADMIT,
main_inscls.STD_CODE AS INSTYPE,
'1' AS TYPEIN,
(CASE WHEN ISNULL(refers.hosp_id) THEN ''
	ELSE refers.HOSP_ID
END) AS REFERINHOSP,
'' AS CAUSEIN,
FORMAT(opd_visits.WEIGHT,1) AS ADMITWEIGHT,
opd_visits.HEIGHT AS ADMITHEIGHT,
DATE_FORMAT(ipd_reg.DSC_DT,'%Y%m%d%H%i%s') AS DATETIME_DISCH,
CONCAT('1',opd_diagnosis.DXG_ID,ipd_reg.WARD_NO) AS WARDDISCH,
ipd_reg.DSC_STATUS AS DISCHSTATUS,
ipd_reg.DSC_TYPE AS DISCHTYPE,
CASE
	WHEN ISNULL(rf_out.hosp_id) THEN ''
	ELSE rf_out.HOSP_ID 
end AS REFEROUTHOSP,
'' AS CAUSEOUT,
'' AS COST,
CASE
	WHEN ISNULL(receipts.PAID) THEN 0.00
ELSE FORMAT(receipts.PAID, 2)
END AS PRICE,
0 AS payprice,
CASE
	WHEN ISNULL(receipts.PAID) THEN 0
ELSE receipts.PAID 
END AS ACTUALPAY,
ipd_reg.DSC_DR AS PROVIDER,
DATE_FORMAT(NOW(), '%Y%m%d%H%i%s') AS D_UPDATE
FROM 
population
INNER JOIN cid_hn ON population.CID = cid_hn.CID 
INNER JOIN opd_visits ON cid_hn.hn = opd_visits.HN
INNER JOIN ipd_reg ON opd_visits.VISIT_ID = ipd_reg.VISIT_ID
INNER JOIN opd_diagnosis ON opd_diagnosis.VISIT_ID = opd_visits.VISIT_ID and opd_diagnosis.dxt_id = '1'
INNER JOIN main_inscls ON  main_inscls.INSCL = opd_visits.INSCL
LEFT OUTER JOIN refers  on opd_visits.visit_id = refers.visit_id  and refers.rf_type = '1' 
LEFT OUTER JOIN refers AS rf_out ON opd_visits.visit_id = rf_out.visit_id  and rf_out.rf_type = '2'
LEFT OUTER JOIN receipts ON opd_visits.visit_id = receipts.visit_id
WHERE  LEFT( population.cid, 5 ) > 00000 
	AND opd_visits.reg_datetime BETWEEN '2014.01.01 00:00' AND '2014.01.30 23:59' 
	AND opd_visits.is_cancel = 0 
ORDER BY 
	population.cid;

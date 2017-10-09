SELECT DISTINCT '10953' AS HOSPCODE, 
cid_hn.HN AS PID,  
ipd_reg.ADM_ID AS AN,
DATE_FORMAT(ipd_reg.ADM_DT,'%Y%m%d%H%i%s')DATETIME_ADMIT,
CONCAT('01',opd_visits.UNIT_REG,ipd_reg.WARD_NO) AS WARDSTAY,
'' AS TYPEDRUG,
drugs.DIDSTD AS DIDSTD,
drugs.DRUG_NAME AS DNAME,
usage_units.UUNIT_ID AS DATESTART,
'' AS DATEFINISH,
prescriptions.RX_AMOUNT AS AMOUNT,
drugs.UUNIT_ID AS UNIT,
usage_units.UUNIT_NAME AS UNIT_PACKING,
'' AS DRUGPRICE,
'' AS DRUGCOST,
opd_diagnosis.STAFF_ID AS PROVIDER,
DATE_FORMAT(NOW(),'%Y%m%d%H%i%s') AS D_UPDATE
FROM 
population
INNER JOIN cid_hn ON population.CID = cid_hn.CID 
INNER JOIN opd_visits ON cid_hn.hn = opd_visits.HN
INNER JOIN ipd_reg ON opd_visits.VISIT_ID = ipd_reg.VISIT_ID
INNER JOIN opd_diagnosis ON opd_diagnosis.VISIT_ID = opd_visits.VISIT_ID 
INNER JOIN main_inscls ON  main_inscls.INSCL = opd_visits.INSCL
INNER JOIN prescriptions  ON opd_visits.visit_id = prescriptions.visit_id 
INNER JOIN drugs ON drugs.DRUG_ID = prescriptions.DRUG_ID
LEFT OUTER JOIN usage_units ON drugs.PACKAGE = usage_units.UUNIT_ID
WHERE  LEFT( population.cid, 5 ) > 00000 
	AND opd_visits.reg_datetime BETWEEN '2014.01.01 00:00' AND '2014.01.30 23:59' 
	AND opd_visits.is_cancel = 0 
ORDER BY 
	population.cid;

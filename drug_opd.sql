SELECT DISTINCT '10953' AS HOSPCODE, 
cid_hn.HN AS PID,  
opd_visits.VISIT_ID AS SEQ,  
DATE_FORMAT(opd_visits.REG_DATETIME,'%Y%m%d') AS DATE_SERV,
CONCAT('01', opd_visits.UNIT_REG, a.DXG_ID) AS CLINIC,
c.didstd AS DIDSTD, 
c.DRUG_NAME AS DNAME,
b.RX_AMOUNT AS AMOUNT,
c.UUNIT_ID AS UNIT,d.UUNIT_NAME AS UNIT_PACKING,
'' AS DRUGPRICE,
c.PRICE AS DRUGCOST,
a.STAFF_ID AS PROVIDER,
DATE_FORMAT(NOW(), '%Y%m%d%H%i%s') AS D_UPDATE
FROM population,cid_hn
INNER JOIN opd_visits ON opd_visits.HN = cid_hn.HN 
INNER JOIN opd_diagnosis a ON opd_visits.visit_id = a.visit_id and a.dxt_id = '1'
INNER JOIN prescriptions b ON opd_visits.visit_id = b.visit_id 
inner join drugs c ON b.drug_id = c.drug_id
LEFT OUTER JOIN usage_units d ON c.PACKAGE = d.UUNIT_ID
WHERE opd_visits.REG_DATETIME BETWEEN '2014.01.01 00:00' AND '2014.01.03 23:59'
AND population.CID = cid_hn.CID
AND LEFT( population.cid, 5 ) > 00000 
AND opd_visits.IS_CANCEL = 0
AND opd_visits.visit_id NOT IN( SELECT visit_id FROM ipd_reg );
SELECT DISTINCT '10953' AS HOSPCODE,
cid_hn.HN AS PID,  
opd_visits.VISIT_ID AS SEQ, 
DATE_FORMAT(opd_visits.REG_DATETIME,'%Y%m%d') AS DATE_SERV,
opd_diagnosis.DXT_ID AS DIAGTYPE,
icd10new.ICD10_TM AS DIAGCODE,  
CONCAT('01', opd_visits.unit_reg, opd_diagnosis.dxg_id) AS CLINIC,
opd_diagnosis.STAFF_ID AS PROVIDER,
DATE_FORMAT(NOW(), '%Y%m%d%H%i%s') AS D_UPDATE
FROM population,cid_hn
INNER JOIN opd_visits ON opd_visits.HN = cid_hn.HN
INNER JOIN opd_diagnosis ON opd_diagnosis.VISIT_ID = opd_visits.VISIT_ID 
INNER JOIN icd10new ON opd_diagnosis.icd10 = icd10new.icd10
WHERE opd_visits.REG_DATETIME BETWEEN '2014.01.01 00:00' AND '2014.01.30 23:59'
AND cid_hn.CID = population.CID 
AND population.CID = cid_hn.CID
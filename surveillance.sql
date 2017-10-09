SELECT DISTINCT '10953' AS HOSPCODE,
cid_hn.hn AS PID,  
opd_visits.VISIT_ID AS SEQ,  
DATE_FORMAT(opd_visits.REG_DATETIME,'%Y%m%d')DATE_SERV,
CASE
	WHEN ISNULL(ipd_reg.ADM_ID) THEN ''
	ELSE ipd_reg.ADM_ID
END AS AN,
DATE_FORMAT(ipd_reg.ADM_DT,'%Y%m%d') AS DATETIME_ADMIT,
'' AS SYNDROME,
icd10new.ICD10_TM AS DIAGCODE,
rpt_506.E0_NUMBER AS CODE506,
'' AS DIAGCODELAST, 
'' AS CODE506LAST,
rpt_506.ill_date AS ILLDATE,
rpt_506.HOME_ADR AS ILLHOUSE,
right(rpt_506.TOWN_ID, 2) AS ILLVILLAGE,
substr(rpt_506.TOWN_ID, 5, 2) AS ILLTAMBON,
SUBSTR(rpt_506.town_id, 3, 2) AS ILLAMPUR,
left(rpt_506.TOWN_ID, 2) AS ILLCHANGWAT,
'' AS LATITUDE,
'' AS LONGITUDE,
rpt_506.PTSTAT AS PTSTATUS,
rpt_506.DATE_DEATH AS DATE_DEATH,
rpt_506.COMPLICA AS COMPLICATION,
rpt_506.ORGANISM AS ORGANISM,
opd_diagnosis.STAFF_ID AS PROVIDER,
DATE_FORMAT(NOW(), '%Y%m%d%H%i%s') AS D_UPDATE
FROM 
	population
	INNER JOIN cid_hn ON population.CID = cid_hn.CID 
	INNER JOIN opd_visits ON cid_hn.hn = opd_visits.HN
  LEFT OUTER JOIN ipd_reg ON opd_visits.VISIT_ID = ipd_reg.VISIT_ID
	INNER JOIN rpt_506 on opd_visits.VISIT_ID = rpt_506.VISIT_ID
	INNER JOIN opd_diagnosis on opd_diagnosis.visit_id = rpt_506.VISIT_ID and opd_diagnosis.ICD10 = rpt_506.ICD10
	INNER JOIN icd10new on rpt_506.icd10 = icd10new.icd10 
WHERE  LEFT( population.cid, 5 ) > 00000 
	AND opd_visits.reg_datetime BETWEEN '2014.01.01 00:00' AND '2014.01.30 23:59'  
;

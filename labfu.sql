SELECT DISTINCT '10953' AS HOSPCODE,
cid_hn.HN AS PID,  
opd_visits.VISIT_ID AS SEQ,
DATE_FORMAT(opd_visits.REG_DATETIME,'%Y%m%d')DATE_SERV,
CASE
	WHEN lab_requests.lab_id between '013' and '015' then '02'
	when lab_requests.LAB_ID = '123' then '05'
	when lab_requests.LAB_ID = '021' then '06'
	when lab_requests.LAB_ID = '018' then '07'
	when lab_requests.LAB_ID = '019' then '08'
	when lab_requests.LAB_ID = '020' then '09'
	when lab_requests.LAB_ID = '009' then '10'
	when lab_requests.LAB_ID = '011' then '11'
	when lab_requests.LAB_ID IN ('016', '299', '168') then '12'
	when lab_requests.LAB_ID = '147' then '13'
end AS LABTEST,
CASE 
	WHEN CAST(lab_requests.LAB_RESULT AS DECIMAL(10,2)) > 0 THEN CAST(lab_requests.LAB_RESULT AS DECIMAL(10,2)) 
	WHEN LOCATE('=', lab_requests.LAB_RESULT) > 0 THEN CAST(SUBSTR(lab_requests.LAB_RESULT, LOCATE('=', lab_requests.LAB_RESULT)+1, 12) AS DECIMAL(10, 2))
END AS LABRESULT,
DATE_FORMAT(NOW(), '%Y%m%d%H%i%s') AS D_UPDATE
FROM 
	population 
	INNER JOIN cid_hn ON population.CID = cid_hn.CID 
	INNER JOIN opd_visits ON cid_hn.hn = opd_visits.HN 
	inner join chronic_reg on chronic_reg.cid = population.cid
	right outer join lab_requests on lab_requests.VISIT_ID = opd_visits.visit_id and lab_requests.lab_id IN ('013', '014', '015', '021', '018', '019', '020', '009', '011', '123', '016', '299', '168', '147') 
and trim(lab_requests.LAB_RESULT) > ''
  INNER JOIN opd_diagnosis  ON opd_visits.visit_id = opd_diagnosis.visit_id and opd_diagnosis.dxt_id = '1'
WHERE  LEFT( population.cid, 5 ) > 00000 
	AND opd_visits.reg_datetime BETWEEN '2014.01.01 00:00' AND '2014.01.15 23:59' 
	AND opd_visits.is_cancel = 0 
	AND opd_visits.visit_id NOT IN( SELECT visit_id FROM ipd_reg )
ORDER BY 
	population.cid;

SELECT population.CID,cid_hn.HN,population.FNAME,population.LNAME,
CASE population.SEX 
	WHEN 1  THEN 'ชาย'
	WHEN 2  THEN 'หญิง'
ELSE 'Uknown'
END AS sex,FLOOR(DATEDIFF(now(),population.BIRTHDATE)/365)AS Age,date_format(population.BIRTHDATE,'%d-%m-%Y')AS BIRTHDATE,
population.HOME_ADR,a.TOWN_NAME AS mooban,b.TOWN_NAME AS tumbon,opd_visits.REG_DATETIME,chronic_reg.ICD10,main_inscls.INSCL_NAME
FROM population,chronic_reg,towns a,towns b,main_inscls,cid_hn
INNER JOIN opd_visits ON opd_visits.HN=cid_hn.HN AND opd_visits.REG_DATETIME BETWEEN '20140101' AND '20140110'
WHERE population.CID=chronic_reg.CID 
#AND chronic_reg.ICD10 BETWEEN 'i20' AND 'i25'
AND cid_hn.CID=population.CID 
AND CONCAT(left(population.TOWN_ID,6),'00' b.TOWN_ID 
AND population.TOWN_ID= a.TOWN_ID  AND main_inscls.INSCL=population.INSCL  
GROUP BY population.CID ORDER BY b.TOWN_NAME ,chronic_reg.ICD10;
SELECT CID,
CASE 
	WHEN DATEDIFF(now(),BIRTHDATE)/365.25>= '20' and sex='1' and MARRIAGE = '4 'then 'พระภิกษุ' 
	WHEN DATEDIFF(now(),BIRTHDATE)/365.25< '20' and sex='1' and MARRIAGE = '4 'then 'สามเณร' 
	WHEN DATEDIFF(now(),BIRTHDATE)/365.25>= '15' and sex='1' then 'นาย' 
	WHEN DATEDIFF(now(),BIRTHDATE)/365.25< '15' and sex='1' then 'เด็กชาย' 
	WHEN DATEDIFF(now(),BIRTHDATE)/365.25< '15' and sex='2' then 'เด็กหญิง' 
	WHEN DATEDIFF(now(),BIRTHDATE)/365.25>= '15' and sex='2' and MARRIAGE ='1'then 'นางสาว' 
		ELSE 'นาง'
END as pname,
FNAME, LNAME, SEX,
CASE
when 
 MARRIAGE,DATEDIFF(now(),BIRTHDATE)/365.25 as 'age'
FROM mbase_data.population
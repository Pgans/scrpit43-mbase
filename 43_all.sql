
SELECT DISTINCT
	'10953' AS HOSPCODE, 
	population.CID, 
	cid_hn.HN AS PID, 
	'' AS HID, 
	( 
		CASE 
			WHEN DATEDIFF( NOW(), BIRTHDATE ) / 365.25 >= '20' AND sex='1' AND MARRIAGE = '4' THEN '831' 
			WHEN DATEDIFF( NOW(), BIRTHDATE ) / 365.25< '20' AND sex='1' AND MARRIAGE = '4' THEN '832' 
			WHEN DATEDIFF( NOW(), BIRTHDATE ) / 365.25 >= '15' AND sex='1' THEN '003' 
			WHEN DATEDIFF( NOW(), BIRTHDATE ) / 365.25 < '15' AND sex='1' THEN '001' 
			WHEN DATEDIFF( NOW(), BIRTHDATE ) / 365.25 < '15' AND sex='2' THEN '002' 
			WHEN DATEDIFF( NOW(), BIRTHDATE ) / 365.25 >= '15' AND sex='2' AND MARRIAGE ='1' THEN '004' 
			ELSE '005'
		END 
	 ) AS PRENAME, 
	FNAME, 	LNAME, cid_hn.HN, population.SEX, 
	DATE_FORMAT( BIRTHDATE, '%Y%m%d' ) AS BIRTH, 
	( 
		CASE 
			WHEN population.marriage = '4' THEN '6' 
			ELSE population.marriage
		END 
	 ) AS MSTSATUS, 
	( 
		CASE
			WHEN population.oc_id > '901' OR population.oc_id IN( '818', '507', '821', '718', '705', '404', '708', '216', '801', '504' ) THEN '000'
			WHEN population.oc_id IN( '501', '502', '503' ) THEN '001'
			WHEN population.oc_id IN( '403', '209', '207', '702', '709', '707', '816', '819', '803' ) THEN '002'
			WHEN population.oc_id IN( '401', '602', '606', '601' ) THEN '003'
			WHEN population.oc_id IN( '201', '106', '208', '110', '111', '112', '108', '805', '113', '203', '114', '102' ) THEN '004'
			WHEN population.oc_id IN( '302', '303' ) THEN '005'
			WHEN population.oc_id IN( '206', '210', '213', '214' ) THEN '006'
			WHEN population.oc_id IN( '202', '204', '205' ) THEN '007'
			WHEN population.oc_id IN( '402', '405' ) THEN '010'
			WHEN population.oc_id = '901' THEN '013'
			WHEN population.oc_id = '713' THEN '014'
			WHEN population.oc_id = '900' THEN '015'
		END 
	 ) AS occupation_old, '6111' AS occupation_new, 
	( 
		CASE 
			WHEN population.natn_id > '' THEN CONCAT( '0', population.natn_id )
			ELSE '099'
		END 
	 ) AS race, 
	( 
		CASE 
			WHEN population.natn_id > '' THEN CONCAT( '0', population.natn_id )
			ELSE '099'
		END 
	 ) AS nation, 
	( 
		CASE 
			WHEN population.religion > '00' THEN population.religion
			ELSE '01'
		END 
	 ) AS religion, 
	( 
		CASE 
			WHEN RIGHT( population.educate, 2 ) BETWEEN '01' AND '06' THEN RIGHT( population.educate, 2 )
			WHEN RIGHT( population.educate, 2 ) BETWEEN '07' AND '08' THEN '06'
			ELSE '00'
		END
	 ) AS education, 
	'' AS fstatus, 
	population.father, population.mother, 
	'' AS couple, 
	'' AS vstatus, 
	'' AS movein, 
	'9' AS discharge, 
	'' AS ddischarge, 
	population.FATHER, population.MOTHER, 
	'' AS COUPLE, '' AS VSTATUS, 
	'' AS MOVEIN, 
	'9' AS DISCHARGE, 
	'' AS DDISCHARGE, 
	( 
		CASE 
			WHEN population.BG_ID IN( '01', '05', '09' ) THEN '1'
			WHEN population.BG_ID IN( 02, 06, 10 ) THEN '2'
			WHEN population.BG_ID IN( 03, 07, 11 ) THEN '3'
			WHEN population.BG_ID IN( 04, 08, 12 ) THEN '4'
			ELSE '0'
		END 
	 ) AS ABOGROUP, 
	( 
		CASE 
			WHEN population.BG_ID IN( 09, 10, 11, 12 ) THEN '1'
			WHEN population.BG_ID IN( 05, 06, 07, 08 ) THEN '2'
			ELSE '0'
		END 
	 ) AS RHGROUP, 
	'' AS LABOR, 
	'' AS PASSPORT, 
	'4' AS TYPEAREA, 
	DATE_FORMAT( NOW(), '%Y%m%d%H%i%s' ) AS D_UPDATE
FROM 
	population 
	INNER JOIN cid_hn ON population.CID = cid_hn.CID 
	INNER JOIN opd_visits ON cid_hn.hn = opd_visits.HN
 
WHERE
	1 = 1	
	AND LEFT( population.cid, 5 ) > 00000 
	AND opd_visits.reg_datetime BETWEEN '2014.01.01 00:00' AND '2014.01.31 23:59' 
	AND opd_visits.is_cancel = 0 
	AND opd_visits.visit_id NOT IN( SELECT visit_id FROM ipd_reg )
ORDER BY 
	population.cid;

##14.SERVICE##############
SELECT DISTINCT '10953' AS HOSPCODE, 
cid_hn.HN AS PID, cid_hn.HN AS HN,
opd_visits.VISIT_ID AS SEQ,  
DATE_FORMAT(opd_visits.REG_DATETIME,'%Y%m%d')AS DATE_SERV,
DATE_FORMAT(opd_visits.REG_DATETIME,'%H%i%s') AS TIME_SERV,'2' AS LOCATION,'1' AS INTIME,main_inscls.STD_CODE AS INSTYPE,
uc_inscl.UC_CARDID AS INSID,uc_inscl.HOSPMAIN AS MAIN,'1' AS TYPEIN,
'' AS REFERINHOSP,
'' AS CAUSEIN,
opd_visits.HISTORY AS CHIEFCOMP,'1' AS SERVPLACE,
opd_visits.BODY_TEMP AS BTEMP,opd_visits.BP_SYST AS SBP,opd_visits.BP_DIAS AS DBP,
opd_visits.PULSE_RATE AS PR,opd_visits.RESP_RATE AS RR,'1' AS TYPEOUT,
'' AS REFEROUTHOSP,
'' AS CAUSEOUT,
'' AS COST,
'' AS PRICE,
'' AS PAYPRICE,
'' AS ACTUALPAY,
DATE_FORMAT(NOW(), '%Y%m%d%H%i%s') AS D_UPDATE
FROM population,uc_inscl,cid_hn
INNER JOIN opd_visits ON opd_visits.HN = cid_hn.HN
INNER JOIN main_inscls ON  main_inscls.INSCL = opd_visits.INSCL 
WHERE  opd_visits.REG_DATETIME BETWEEN '2014.01.01 00:00' AND '2014.01.03 23:59'
AND cid_hn.CID = population.CID 
AND uc_inscl.CID = population.CID
#AND LEFT( population.cid, 5 ) > 00000 
#AND opd_visits.IS_CANCEL = 0
#AND opd_visits.visit_id NOT IN( SELECT visit_id FROM ipd_reg );

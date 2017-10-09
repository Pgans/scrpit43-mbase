/* person mbase
# Create by: Pgan Boon
# Edit by: ict.phoubon@gmail.com
# Date edit: 2014-10-27
*/

SET @maintable := 'f43_person';
SET @pid := '4';
SET @datestart := ( SELECT `datestart` FROM ubonsystem.mas_mapp_main AS m WHERE m.PROGRAM_ID = @pid AND m.MAIN_TABLE = @maintable LIMIT 1 );
SET @dateend := ( SELECT  `dateend` FROM ubonsystem.mas_mapp_main AS m WHERE m.PROGRAM_ID = @pid AND m.MAIN_TABLE = @maintable LIMIT 1 );

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
-- ( 
-- 	SELECT 
-- 		visit_id, hn 
-- 	FROM 
-- 		opd_visits 
-- 	WHERE 
-- 		/*datetime config*/ 
-- 		reg_datetime BETWEEN '2014.01.01 00:00' AND '2014.02.31 23:59' 
-- 		AND is_cancel = 0 
-- 		AND visit_id NOT IN( SELECT visit_id FROM ipd_reg )
--  ) AS opd ON cid_hn.hn = opd.hn 
WHERE
	1 = 1	
	AND LEFT( population.cid, 5 ) > 00000 
	AND opd_visits.reg_datetime BETWEEN '2014.01.01 00:00' AND '2014.02.31 23:59' 
	#AND DATE_FORMAT( opd_visits.reg_datetime, '%Y%m%d ) BETWEEN DATE_FORMAT( @datestart, '%Y%m%d' ) AND DATE_FORMAT( @dateend, '%Y%m%d' )
	AND opd_visits.is_cancel = 0 
	AND opd_visits.visit_id NOT IN( SELECT visit_id FROM ipd_reg )
ORDER BY 
	population.cid;
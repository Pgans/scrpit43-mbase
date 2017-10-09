SELECT DISTINCT '10953' AS HOSPCODE,
cid_hn.HN AS PID,  
ncd_screen.SCREEN_ID AS SEQ,
DATE_FORMAT(ncd_screen.DATE_EXAM,'%Y%m%d') AS DATE_SERV,
'2' AS SERVPLACE,
ncd_screen.SMOKE AS SMOKE,
ncd_screen.ALCOHOL AS ALCOHOL,
ncd_screen.DMFAMILY AS DMFAMILY,
ncd_screen.HTFAMILY AS HTFAMILY,
ncd_screen.WEIGHT AS WEIGHT,
ncd_screen.HEIGHT AS HEIGHT,
ncd_screen.WAIST_CM AS WAIST_CM,
ncd_screen.BPH_1 AS SBP_1,
ncd_screen.BPL_1 AS DBP_1,
ncd_screen.BPH_2 AS SBP_2,
ncd_screen.BPL_2 AS DBP_2,
ncd_screen.BSLEVEL AS BSLEVEL,
ncd_screen.BSTEST AS BSTEST,
ncd_screen.SCRPLACE AS SCREENPLACE,
'' AS PROVIDER,
DATE_FORMAT(NOW(),'%Y%m%d%H%i%s') AS D_UPDATE
FROM
ncd_screen
 INNER JOIN cid_hn ON cid_hn.CID = ncd_screen.CID
 INNER JOIN population ON cid_hn.CID = population.CID
WHERE
	ncd_screen.DATE_EXAM BETWEEN '2011.01.01' AND '2011.01.31'
AND  FLOOR(DATEDIFF(NOW(),population.BIRTHDATE)/365.25) >=15 
ORDER BY ncd_screen.CID;

	
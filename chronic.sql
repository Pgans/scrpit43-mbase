SELECT  DISTINCT '10953' AS HOSPCODE, cid_hn.HN AS PID,DATE_FORMAT(chronic_reg.REG_DATE,'%Y%m%d') AS DATE_DIAG,chronic_reg.ICD10 AS CHRONIC,
 '' AS HOSP_DX, 
(
CASE WHEN TRIM(chronic_reg.HOSP_ID) > '' THEN chronic_reg.HOSP_ID
	ELSE '10953'
END
) AS HOSP_RX, DATE_FORMAT(chronic_reg.DSC_DATE,'%Y%m%d') AS DATE_DISCH,
(
CASE WHEN DAY(chronic_reg.DSC_DATE) = 0 THEN '03'
	ELSE '04'
END) AS TYPEDISCH, DATE_FORMAT(NOW(),'%Y%m%d%H%i%s') AS D_UPDATE
FROM cid_hn,chronic_reg
WHERE chronic_reg.CID = cid_hn.CID AND chronic_reg.REG_DATE BETWEEN '2O14.01.01 00:00' AND '2014.02.01 23:59'
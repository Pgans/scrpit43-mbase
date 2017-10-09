SELECT DISTINCT '10953' AS HOSPCODE, cid_hn.HN AS PID, fam_plan.FPTYPE AS FPTYPE, '' AS NOFPCAUSE, '' AS TOTALSON,
'' AS NUMBERSON, '' AS ABORTION, '' AS STILLBIRTH, DATE_FORMAT(NOW(), '%Y%m%d%H%i%s') AS D_UPDATE
FROM
 cid_hn,population,opd_visits
INNER JOIN fam_plan ON opd_visits.VISIT_ID = fam_plan.VISIT_ID
WHERE
population.CID = cid_hn.CID AND cid_hn.HN = opd_visits.HN
AND FLOOR(DATEDIFF(NOW(),population.BIRTHDATE)/365.25) >=15 AND FLOOR(DATEDIFF(NOW(),population.BIRTHDATE)/365.25) <50
AND population.SEX = '2'
AND population.MARRIAGE = '2'



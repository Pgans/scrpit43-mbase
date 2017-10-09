SELECT DISTINCT '10953' AS HOSPCODE,cid_hn.HN AS PID, main_inscls.INSCL AS INSTYPE_OLD,main_inscls.STD_CODE AS INSTYPE_NEW,
uc_inscl.UC_CARDID AS INSID, DATE_FORMAT(uc_inscl.UC_REGISTER,'%Y%m%d') AS STARTDATE, 
DATE_FORMAT(uc_inscl.UC_EXPIRE,'%Y%m%d')AS EXPIREDATE, uc_inscl.HOSPMAIN AS MAIN,uc_inscl.HOSPSUB AS SUB,
DATE_FORMAT(NOW(), '%Y%m%d%H%i%s') AS D_UPDATE
FROM cid_hn,population,uc_inscl,opd_visits
INNER JOIN main_inscls ON  main_inscls.INSCL = opd_visits.INSCL 
WHERE  opd_visits.REG_DATETIME BETWEEN '2014.01.01 00:00' AND '2014.02.30 23:59'
AND cid_hn.CID = population.CID AND opd_visits.HN = cid_hn.HN
AND uc_inscl.CID = population.CID
AND LEFT( population.cid, 5 ) > 00000 
AND opd_visits.IS_CANCEL = 0
AND opd_visits.visit_id NOT IN( SELECT visit_id FROM ipd_reg )
;
select a.hosp_id, b.icd10_tm, b.icd_name, count(icd10_tm) AS amount from refers a, icd10new b, opd_diagnosis c 
where a.visit_id = c.VISIT_ID and b.icd10 = c.icd10 and a.rf_type = "2" and a.visit_id NOT IN (SELECT visit_id from ipd_reg)
and a.rf_dt between '2012.10.01 00:00' and '2013.09.30 23:59' group by a.hosp_id, b.icd10_tm order by a.hosp_id, b.icd10_tm

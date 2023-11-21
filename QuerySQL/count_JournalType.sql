
	SELECT 
	ljt.journaltype,
	ljty.label,
	count (LJT.JournalType)

FROM GENERALJOURNALENTRY GJE
JOIN GENERALJOURNALACCOUNTENTRY GJAE ON GJE.RECID = GJAE.GeneralJournalEntry
JOIN POSTINGTYPE PT ON PT.Value = GJAE.POSTINGTYPE
JOIN JOURNALCATEGORY JC ON GJE.JOURNALCATEGORY = JC.Value
JOIN DIMENSIONATTRIBUTEVALUECOMBINATION DAVC ON GJAE.LEDGERDIMENSION = DAVC.RECID
--JOIN DIMATTRIBUTEGROUPCHARTOFACCOUNTS DAGCA ON DAGCA.VALUE = DAVC.GROUPCHARTOFACCOUNTSVALUE
JOIN LEDGERJOURNALTRANSACTION LJT ON LJT.GENERALJOURNALENTRY = GJE.RECID
JOIN LEDGERJOURNALTYPE LJTY ON LJTY.Value = LJT.JOURNALTYPE

WHERE (pt.Value=20) and jc.Label='Bank' 

group by ljt.JOURNALTYPE,LJTY.Label

order by ljt.JOURNALTYPE
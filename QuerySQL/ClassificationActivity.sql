	SELECT --distinct top(10000)
	COUNT(*),
	--GJAE.RECID as GjaeRecId,
	--GJAE.LedgerDimension,
	--DAGCA.VALUE as GroupChartOfAccountsValue,
	--DAGCA.name AS GroupChartOfAccountsName,
 --   GJE.Ledger,
 --   GJE.PostingLayer,
	--GJE.SubledgerVoucher,
	GJE.SubledgerVoucherDataAreaId
 --   GJE.CreatedBy,
 --   JC.Label AS JournalCategory,
 --   PT.Label AS PostingTypeLabel,
	--GJAE.PostingType AS PostingTypeValue,
 --   GJAE.MainAccount,
 --   GJAE.Text,
	--LJT.JournalType,
	--LJTY.Label AS JournalTypeLabel,
	--LJT.NumOfLines,
	--LJT.Count as CountLedgerJournal,
 --   GJAE.TransactionCurrencyAmount,
 --   GJAE.TransactionCurrencyCode,
	--CPA.Description as ClosingActivityDescription,
	--CPA.Id as ClosingActivityId

FROM GENERALJOURNALENTRY GJE
JOIN GENERALJOURNALACCOUNTENTRY GJAE ON GJE.RECID = GJAE.GeneralJournalEntry
JOIN POSTINGTYPE PT ON PT.Value = GJAE.POSTINGTYPE
JOIN JOURNALCATEGORY JC ON GJE.JOURNALCATEGORY = JC.Value
JOIN DIMENSIONATTRIBUTEVALUECOMBINATION DAVC ON GJAE.LEDGERDIMENSION = DAVC.RECID
JOIN DIMATTRIBUTEGROUPCHARTOFACCOUNTS DAGCA ON DAGCA.VALUE = DAVC.GROUPCHARTOFACCOUNTSVALUE
LEFT JOIN LEDGERJOURNALTRANSACTION LJT ON LJT.GENERALJOURNALENTRY = GJE.RECID
LEFT JOIN LEDGERJOURNALTYPE LJTY ON LJTY.Value = LJT.JOURNALTYPE
--join MAPPINGCLOSINGPERIODACTIVITY MCPA ON MCPA.postingtypelabel = pt.label and mcpa.journalcategorylabel = jc.label
--join CLOSINGPERIODACTIVITY CPA ON CPA.Id = MCPA.ActivityId

WHERE GJAE.PostingType = 14 AND JC.Label = 'None'

--CPA.Id = 'ACT29' 
--GJE.SUBLEDGERVOUCHERDATAAREAID = 'GB02' and CPA.Id = 'ACT29' and GJAE.Text != ''

--ORDER BY GJE.SUBLEDGERVOUCHERDATAAREAID

group by GJE.SubledgerVoucherDataAreaId

ORDER BY COUNT(*)

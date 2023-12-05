	SELECT distinct
	GJAE.RECID as GjaeRecId,
	GJE.AccountingDate,
	GJE.CreatedDateTime,
	GJAE.LedgerDimension,
	DAGCA.VALUE as GroupChartOfAccountsValue,
	DAGCA.name AS GroupChartOfAccountsName,
    GJE.Ledger,
    GJE.PostingLayer,
    GJE.SubledgerVoucher,
    GJE.SubledgerVoucherDataAreaId,
    GJE.CreatedBy,
    JC.Label AS JournalCategory,
    PT.Label AS PostingTypeLabel,
	GJAE.PostingType AS PostingTypeValue,
    GJAE.MainAccount,
    GJAE.Text,
	LJT.JournalType,
	LJTY.Label AS JournalTypeLabel,
	LJT.NumOfLines,
	LJT.Count as CountLedgerJournal,
    GJAE.TransactionCurrencyAmount,
    GJAE.TransactionCurrencyCode,
	CPA.Description as ClosingActivityDescription,
	CPA.Id as ClosingActivityId

FROM GENERALJOURNALENTRY GJE
JOIN GENERALJOURNALACCOUNTENTRY GJAE ON GJE.RECID = GJAE.GeneralJournalEntry
JOIN POSTINGTYPE PT ON PT.Value = GJAE.POSTINGTYPE
JOIN JOURNALCATEGORY JC ON GJE.JOURNALCATEGORY = JC.Value
JOIN DIMENSIONATTRIBUTEVALUECOMBINATION DAVC ON GJAE.LEDGERDIMENSION = DAVC.RECID
JOIN DIMATTRIBUTEGROUPCHARTOFACCOUNTS DAGCA ON DAGCA.VALUE = DAVC.GROUPCHARTOFACCOUNTSVALUE
left JOIN LEDGERJOURNALTRANSACTION LJT ON LJT.GENERALJOURNALENTRY = GJE.RECID
left JOIN LEDGERJOURNALTYPE LJTY ON LJTY.Value = LJT.JOURNALTYPE
join MAPPINGCLOSINGPERIODACTIVITY MCPA ON MCPA.postingtypelabel = pt.label and mcpa.journalcategorylabel = jc.label
join CLOSINGPERIODACTIVITY CPA ON CPA.Id = MCPA.ActivityId

WHERE GJE.SUBLEDGERVOUCHERDATAAREAID = 'it01'

ORDER BY GJE.CREATEDDATETIME
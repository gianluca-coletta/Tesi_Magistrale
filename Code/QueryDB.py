import pyodbc
import pandas as pd

# Connessione al database utilizzando l'autenticazione Windows
conn = pyodbc.connect('DRIVER={SQL Server};SERVER=LAPTOP-SQAG6MLI;DATABASE=TP_EMEA;Trusted_Connection=yes;')

cursor = conn.cursor()

# Esecuzione della query
query = """
SELECT distinct
    GJAE.RECID as GjaeRecId,
    GJE.CreatedDateTime,
    GJE.SubledgerVoucherDataAreaId,
    JC.Label AS JournalCategory,
    PT.Label AS PostingTypeLabel,
    GJAE.PostingType AS PostingTypeValue,
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
WHERE 
    (GJE.SUBLEDGERVOUCHERDATAAREAID IN ('it01', 'GB02', 'fr13', 'PL01', 'ro01'))
    AND (GJE.CreatedDateTime >= '2020-01-01')
ORDER BY 
    GJE.CREATEDDATETIME;
"""

# Esecuzione della query e salvataggio dei risultati in un DataFrame di pandas
df = pd.read_sql(query, conn)

# Salvataggio del DataFrame in un file CSV
df.to_csv('test.csv', index=False)

# Chiusura della connessione
cursor.close()
conn.close()
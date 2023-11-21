SELECT 
    CAST(GJE.createddatetime AS DATE) AS Data,
    COUNT(*) AS Count,
    GJAE.postingtype AS NumeroPostingType,
    PT.label AS NomePostingType,
	GJE.SUBLEDGERVOUCHERDATAAREAID AS CompanyId
FROM
    generaljournalentry AS GJE
JOIN
    generaljournalaccountentry AS GJAE
ON
    GJE.recid = GJAE.generaljournalentry
LEFT JOIN
    postingtype AS PT
ON
    GJAE.postingtype = PT.value
WHERE
    GJE.SUBLEDGERVOUCHERDATAAREAID = 'it01'
GROUP BY
    CAST(GJE.createddatetime AS DATE), GJAE.postingtype, GJE.SUBLEDGERVOUCHERDATAAREAID, PT.label
ORDER BY
    data, NumeroPostingType;

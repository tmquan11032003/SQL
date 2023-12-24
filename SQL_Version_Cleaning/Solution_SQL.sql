WITH firstTable AS 
( SELECT
	  deviceid,
    firstTime,
    Version1,
    Version2,
    COUNT(VERSION1) OVER (PARTITION BY deviceid ORDER BY firstTime) AS Version1Grouper,
    COUNT(VERSION2) OVER (PARTITION BY deviceid ORDER BY firstTime) AS Version2Grouper
  FROM
    (SELECT * FROM (
              SELECT deviceid,
                MIN(datetime) firstTime,
                metricname,
                metricvalue
              FROM data
              WHERE metricname in ('Version1','Version2')
              GROUP BY deviceid, datetime, metricname, metricvalue) tableToBePivoted 
              PIVOT(MIN(metricvalue) FOR metricname in ([Version1],[Version2])) AS pivotedData
              -- ORDER BY deviceid, firstTime
              ) innerTable)
              
SELECT 
  deviceid,
  firstTime,
  Version1Grouper,
  Version2Grouper,
  MAX(Version1) OVER (PARTITION BY deviceid, Version1Grouper ORDER BY firstTime) AS newVersion1,
  MAX(Version2) OVER (PARTITION BY deviceid, Version2Grouper ORDER BY firstTime) AS newVersion2
FROM firstTable
  
  
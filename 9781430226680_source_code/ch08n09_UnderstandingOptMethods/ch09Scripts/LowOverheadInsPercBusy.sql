SELECT
  ROUND(S.VALUE/O.VALUE/100,2) ORACLE_CPU_PERCENT
FROM
  (SELECT
    SUM(TE.VALUE-NVL(TS.VALUE,0)) VALUE
  FROM
    DATALOG.TE_SYS_TIME_MODEL TE,
    DATALOG.TS_SYS_TIME_MODEL TS
  WHERE
    TE.STAT_NAME IN ('DB CPU', 'background cpu time')
    AND TE.STAT_NAME=TS.STAT_NAME(+) ) S,
  (SELECT
    TE.VALUE-NVL(TS.VALUE,0) VALUE
  FROM
    DATALOG.TE_OSSTAT TE,
    DATALOG.TS_OSSTAT TS
  WHERE
    TE.STAT_NAME='BUSY_TIME'
    AND TE.STAT_NAME=TS.STAT_NAME(+) ) O; 
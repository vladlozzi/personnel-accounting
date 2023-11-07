PARAMETER nLock
SET SKIP OF PAD _база OF _msysmenu nLock
SET SKIP OF PAD _накази OF _msysmenu nLock
SET SKIP OF PAD _вибрк OF _msysmenu nLock
SET SKIP OF PAD _статист OF _msysmenu nLock
SET SKIP OF PAD _довідники OF _msysmenu nLock
IF lI_Am_Guest
 SET SKIP OF PAD _накази OF _msysmenu .T.
 SET SKIP OF PAD _вибрк OF _msysmenu .T.
 SET SKIP OF PAD _статист OF _msysmenu  .T.
 SET SKIP OF PAD _util OF _msysmenu  .T.
ENDIF
RETURN

PARAMETER nLock
SET SKIP OF PAD _���� OF _msysmenu nLock
SET SKIP OF PAD _������ OF _msysmenu nLock
SET SKIP OF PAD _����� OF _msysmenu nLock
SET SKIP OF PAD _������� OF _msysmenu nLock
SET SKIP OF PAD _�������� OF _msysmenu nLock
IF lI_Am_Guest
 SET SKIP OF PAD _������ OF _msysmenu .T.
 SET SKIP OF PAD _����� OF _msysmenu .T.
 SET SKIP OF PAD _������� OF _msysmenu  .T.
 SET SKIP OF PAD _util OF _msysmenu  .T.
ENDIF
RETURN

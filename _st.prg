ON ERROR DO Dummy
ERASE Vk.tmp
ON ERROR DO IntErr WITH ERROR()
ON ERROR 

SET SYSMENU TO DEFAULT
SET TALK OFF
CLEAR ALL
m.logos=[��ز �����]
_Screen.Caption=m.logos+[ - ������������-�������� ]+;
				[������� ����� �����]
_Screen.BackColor=RGB(56,64,56)
_Screen.ForeColor=RGB(128,192,128)

_Screen.FontSize=16

* SET

iVkTmp = FCREATE("Vk.tmp")
IF iVkTmp<0
	=MESSAGEBOX("�� �������� ��� ��������!",0,"������� �������")
	QUIT
ENDIF


*CLOSE ALL
CLEAR
PUBLIC kprac,_m145841,_f145841,MB_OKi,MB_OKe, ;
	cCurN1,cCurN2,cCurN3,True,False, shlyx,TmpDir, ;
	wdOrientLandscape, wdPrinterDefaultBin, ;
    wdSectionNewPage, wdAlignVerticalTop
    
cCurN1=[]
cCurN2=[]
cCurN3=[]
True=.t.
False=.f.
wdOrientLandscape=1
wdPrinterDefaultBin=0
wdSectionNewPage=2
wdAlignVerticalTop=0

MB_OKi=64
MB_OKe=48
_Screen.WindowState=2
SET COLLATE TO "RUSSIAN"
SET DATE TO GERMAN
SET CENTURY ON
SET SAFETY OFF
SET CONSOLE OFF
SET ESCAPE OFF
SET STATUS OFF
SET CLOCK OFF
SET FULLPATH ON
SET NEAR OFF
SET DELETED ON
SET EXCLUSIVE OFF
SET RESOURCE OFF


*ON ERROR

TmpDir=SYS(2023)

PUBLIC Misroku,MisrokuRodv,MisrokuMiscv,aAccess,cMode,cReadOnly
m.cReadOnly='NOUP'
DIMENSION aAccess(1,1)
DIMENSION Misroku(12),MisrokuRodv(12),MisrokuMiscv(12)

Misroku(1)=[�����]
Misroku(2)=[�����]
Misroku(3)=[��������]
Misroku(4)=[������]
Misroku(5)=[�������]
Misroku(6)=[�������]
Misroku(7)=[������]
Misroku(8)=[�������]
Misroku(9)=[��������]
Misroku(10)=[�������]
Misroku(11)=[��������]
Misroku(12)=[�������]

MisrokuRodv(1)=[����]
Misroku(2)=[������]
Misroku(3)=[�������]
Misroku(4)=[�����]
Misroku(5)=[������]
Misroku(6)=[������]
Misroku(7)=[�����]
Misroku(8)=[������]
Misroku(9)=[�������]
Misroku(10)=[������]
Misroku(11)=[���������]
Misroku(12)=[������]

MisrokuMiscv(1)=[���]
MisrokuMiscv(2)=[������]
MisrokuMiscv(3)=[������]
MisrokuMiscv(4)=[����]
MisrokuMiscv(5)=[�����]
MisrokuMiscv(6)=[�����]
MisrokuMiscv(7)=[����]
MisrokuMiscv(8)=[�����]
MisrokuMiscv(9)=[������]
MisrokuMiscv(10)=[�����]
MisrokuMiscv(11)=[��������]
MisrokuMiscv(12)=[�����]

*WAIT WINDOW TmpDir

PUBLIC Upd,Uni,oMForm,FormTitle
PUBLIC aNac,aGromad,aVstup,aInvalid
DIME aNac(1),aGromad(1),aVstup(1),aInvalid(1)

FormTitle=[������� ����� - VKADR]
USE shlax NOUPDATE
m.shlyx=ALLTRIM(shlax)
USE
lI_Am_Rector=.f.
lI_Am_Guest=.f.
lI_Am_Boss = .f.
* ��� ��������� �� �� ftp-������
m.ftpip=""
m.ftpn="personnel_ftp"
m.ftpp=""

DO PRESENT

SET SYSMENU TO DEFAULT
CLEAR
=FCLOSE(iVktmp)
ERASE vk.tmp
ON ERROR
RETURN

PROCEDURE IntErr
PARAMETERS kod_err
=FCLOSE(iVktmp)
ERASE vk.tmp
=MessageBox([�������� �������: ��� ]+ALLT(STR(kod_err))+CHR(13)+CHR(13)+ ;
	[�������� ���� �������]+CHR(13)+CHR(13)+ ;
        [����� ������� ��������� �� ����������]+ ;
	CHR(13)+[� ���� ���� ��� �������, ����]+ ;
	CHR(13)+[�� ��������� ����, �� ��� ���� ��]+ ;
	CHR(13)+[� � ����� ���� ���� ��������]+ ;
	CHR(13)+[�� �������� �� �����������,]+ ;
	CHR(13)+[�� ������ vladloz@nung.edu.ua], ;
	MB_OKe,m.logos+[ - �������])
*CLEAR ALL
QUIT
ENDPROC

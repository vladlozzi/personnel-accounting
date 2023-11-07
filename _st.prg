ON ERROR DO Dummy
ERASE Vk.tmp
ON ERROR DO IntErr WITH ERROR()
ON ERROR 

SET SYSMENU TO DEFAULT
SET TALK OFF
CLEAR ALL
m.logos=[НАШІ КАДРИ]
_Screen.Caption=m.logos+[ - Інформаційно-пошукова ]+;
				[система відділу кадрів]
_Screen.BackColor=RGB(56,64,56)
_Screen.ForeColor=RGB(128,192,128)

_Screen.FontSize=16

* SET

iVkTmp = FCREATE("Vk.tmp")
IF iVkTmp<0
	=MESSAGEBOX("Ця програма вже запущена!",0,"Помилка запуску")
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

Misroku(1)=[січень]
Misroku(2)=[лютий]
Misroku(3)=[березень]
Misroku(4)=[квітень]
Misroku(5)=[травень]
Misroku(6)=[червень]
Misroku(7)=[липень]
Misroku(8)=[серпень]
Misroku(9)=[вересень]
Misroku(10)=[жовтень]
Misroku(11)=[листопад]
Misroku(12)=[грудень]

MisrokuRodv(1)=[січня]
Misroku(2)=[лютого]
Misroku(3)=[березня]
Misroku(4)=[квітня]
Misroku(5)=[травня]
Misroku(6)=[червня]
Misroku(7)=[липня]
Misroku(8)=[серпня]
Misroku(9)=[вересня]
Misroku(10)=[жовтня]
Misroku(11)=[листопада]
Misroku(12)=[грудня]

MisrokuMiscv(1)=[січні]
MisrokuMiscv(2)=[лютому]
MisrokuMiscv(3)=[березні]
MisrokuMiscv(4)=[квітні]
MisrokuMiscv(5)=[травні]
MisrokuMiscv(6)=[червні]
MisrokuMiscv(7)=[липні]
MisrokuMiscv(8)=[серпні]
MisrokuMiscv(9)=[вересні]
MisrokuMiscv(10)=[жовтні]
MisrokuMiscv(11)=[листопаді]
MisrokuMiscv(12)=[грудні]

*WAIT WINDOW TmpDir

PUBLIC Upd,Uni,oMForm,FormTitle
PUBLIC aNac,aGromad,aVstup,aInvalid
DIME aNac(1),aGromad(1),aVstup(1),aInvalid(1)

FormTitle=[Основна форма - VKADR]
USE shlax NOUPDATE
m.shlyx=ALLTRIM(shlax)
USE
lI_Am_Rector=.f.
lI_Am_Guest=.f.
lI_Am_Boss = .f.
* для зберігання БД на ftp-сервері
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
=MessageBox([Внутрішня помилка: код ]+ALLT(STR(kod_err))+CHR(13)+CHR(13)+ ;
	[Програма буде закрита]+CHR(13)+CHR(13)+ ;
        [Автор просить вибачення за незручності]+ ;
	CHR(13)+[і буде дуже Вам вдячний, якщо]+ ;
	CHR(13)+[Ви повідомите йому, під час яких дій]+ ;
	CHR(13)+[і в якому саме місці програми]+ ;
	CHR(13)+[Ви отримали це повідомлення,]+ ;
	CHR(13)+[на адресу vladloz@nung.edu.ua], ;
	MB_OKe,m.logos+[ - Помилка])
*CLEAR ALL
QUIT
ENDPROC

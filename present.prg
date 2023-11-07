m.cWord=[]
m.RegSelected=1

frmReg = CREATEOBJECT('Form')  && Create a Form
WITH frmReg
.ShowTips=.t.
.Closable = .f.  && Disable the Control menu box 
.MinButton=.f.
.MaxButton=.f.
.Caption = [Ласкаво просимо в ]+m.logos+[!]
.Move(100,100)  && Move the form

.AddObject('cmbCommand2','cmdMyCmdBtn2')  && Add "Вхід" Command button
.AddObject('cmbCommand1','cmdMyCmdBtn1')  && Add "Вихід" Command button
.AddObject('RegLbl','MyRegLbl')  && Add Label
.AddObject('CopyRLbl','MyCopyRLbl')  && Add Label
.AddObject('VidOptGrp','MyVidOptGrp')  && Add OptGroup control
.AddObject('Znak','Image')  && Add Picture

.Znak.Picture=[vkadr.bmp]
.Znak.Top=10
.Znak.Left=5
.Znak.Height=110
.Znak.Width=210
.Znak.BorderStyle=0
.Znak.Stretch=1
.Znak.Visible=.T.

.VidOptGrp.Buttons(1).Caption=[режим перегляду та пошуку]
.VidOptGrp.Buttons(1).StatusBarText= ;
		[Режим перегляду та пошуку (зміна бази даних недоступна)]
.VidOptGrp.Buttons(1).ToolTipText= ;
		[В цьому режимі зміна бази даних недоступна]
.VidOptGrp.Buttons(1).Left=5
.VidOptGrp.Buttons(1).Top=4
.VidOptGrp.Buttons(2).Caption=[режим зміни бази даних]
.VidOptGrp.Buttons(2).StatusBarText= ;
		[В цьому режимі, крім розрахунків, доступна і зміна бази даних]
.VidOptGrp.Buttons(2).ToolTipText= ;
		[В цьому режимі, крім розрахунків, доступна і зміна бази даних]
.VidOptGrp.Buttons(2).Left=5
.VidOptGrp.Buttons(2).Top=30
.VidOptGrp.Buttons(2).enabled=NOT (lI_Am_Rector OR lI_Am_Guest)
.VidOptGrp.SetAll([Style],0)
.VidOptGrp.SetAll([Width],260)
.VidOptGrp.SetAll([Height],24)
.VidOptGrp.SetAll([FontSize],14)
.VidOptGrp.SetAll([ForeColor],190)
.cmbCommand1.Visible =.T.
.cmbCommand2.Visible =.T.
.RegLbl.Visible =.T.  
.CopyRLbl.Visible =.T.  
.VidOptGrp.Visible =.T.
.Width=500
.Height=150
.SHOW  && Display the form
ENDWITH
READ EVENTS  && Start event processing

DO CASE
CaSE m.RegSelected=2
	frmAccess=CreateObject('Form')
	WITH frmAccess
		.Closable = .f.  && Disable the Control menu box 
		.MinButton=.f.
		.MaxButton=.f.
		.Visible=.T.
		.Top=250
		.Height=80
		.Left=280
		.Width=300
		.Caption=[Перевірка прав доступу]
		.Closable=.F.
		.AddObject('AcsLab1','AcsLab')
		.AddObject('AcsTxt1','AcsTxt')
		.AddObject('AcsCB1','AcsCB')
		.Show
	ENDWITH
	READ EVENTS
*	WAIT m.cWord WINDOW
		m.nest1f=m.shlyx+'\DOV\nest1'
    SELECT nest1,IIF(ALLTRIM(nestOper)==ALLTRIM(m.cWord),SPACE(8),'NOUPDATE') AS ARight FROM (m.nest1f) INTO ARRAY aAccess ORDER BY nest1
    USE IN nest1
	iL_Access=ALEN(aAccess)/2
	
*	DISPLAY MEMORY LIKE * TO FILE mem.txt
*	MODIFY COMMAND mem.txt NOEDIT
	nA=0
	FOR iA=1 TO iL_Access
		nA=nA+IIF(EMPTY(aAccess(iA)),1,0)
	ENDFOR
	IF nA>0
		Upd=''
	ELSE
		Upd='NOUPDATE'
*	    WAIT m.cWord+m.cPaswL WINDOW
		frmNA=CreateObject('Form')
		WITH frmNA
			.Closable = .f.  && Disable the Control menu box 
			.MinButton=.f.
			.MaxButton=.f.
			.Visible=.T.
			.Top=250
			.Height=80
			.Left=280
			.Width=350
			.Caption=[Спроба несанкціонованого доступу]
			.Closable=.F.
			.AddObject('NALab1','NALab')
			.AddObject('NALab2','NALab')
			.NALab1.Caption=[Пароль введено неправильно!]
			.NALab1.Top=5
			.NALab2.Caption=[Режим зміни для Вас недоступний]
			.NALab2.Top=25
			.AddObject('NACB1','NACB')
			.Show
		ENDWITH
		READ EVENTS
	ENDIF
CASE m.RegSelected=1
    Upd='NOUPDATE'
ENDCASE
CLEAR WINDOWS
*WAIT Upd WINDOW

*DO mainmenu.mpr
DO mainform

RETURN

DEFINE CLASS AcsLab AS Label
Left=30
Top=15
Width=130
Height=25
Visible=.T.
FontSize=12
Caption=[Введіть пароль]
ENDDEFINE

DEFINE CLASS AcsTxt AS TextBox
ToolTipText=[Пароль буде відображатися прихованими символами]
StatusBarText=[Пароль буде відображатися прихованими символами]
Left=160
Top=15
Width=100
Height=25
Visible=.T.
FontSize=12
PasswordChar='*'
ControlSource='m.cWord'
ENDDEFINE

DEFINE CLASS AcsCB AS CommandButton
LEFT=120
Top=50
Width=80
Height=25
Visible=.T.
FontSize=12
Caption=[Вхід]
ToolTipText=[Підтвердження паролю та вхід в ]+m.logos
StatusBarText=[Підтвердження паролю та вхід в ]+m.logos
Alignment=2
PROCEDURE Click
	CLEAR EVENTS
ENDPROC
ENDDEFINE

DEFINE CLASS cmdMyCmdBtn1 AS CommandButton  && Create Command button
FontSize=16
Caption = [Вихід]  && Caption on the Command button
StatusBarText=[Закінчення роботи з ]+m.logos
ToolTipText=[Закінчення роботи з ]+m.logos
Cancel = .T.  && Default Cancel Command button (Esc)
Left = 385  && Command button column
Top = 110  && Command button row
Height = 25  && Command button height
PROCEDURE Click
	=FCLOSE(iVktmp)
	ERASE vk.tmp
    RETURN TO MASTER
*	CLEAR EVENTS  && Stop event processing, close Form
ENDDEFINE

DEFINE CLASS cmdMyCmdBtn2 AS CommandButton  && Create Command button
FontSize=16
Caption = [Вхід] && Caption on the Command button
ToolTipText=[Початок роботи з ]+m.logos
StatusBarText=[Для початку роботи в ]+m.logos+[ виберіть режим і натисніть кнопку "Вхід"]
Cancel = .F.
Left = 230  && Command button column
Top = 110  && Command button row
Height = 25  && Command button height
PROCEDURE Click
	CLEAR EVENTS  && Stop event processing, close Form
ENDDEFINE

DEFINE CLASS MyRegLbl AS Label  && Create Label
FontSize=14
Caption = [Виберіть режим роботи:] && Caption 
ForeColor=128
Alignment=2 && Center
Left=190  && column
Top=5  && row
Height=25  && height
Width=345
ENDDEFINE

DEFINE CLASS MyCopyRLbl AS Label  && Create Label
FontSize=8
Caption=[© В. Лозинський, 2000-23] && Caption
*ForeColor=128
Alignment=2 && Center
Left=5  && column
Top=125  && row
Height=25  && height
Width=210
ENDDEFINE

DEFINE CLASS MyVidOptGrp AS OptionGroup  && Create Option Group
Left=220  && column
Top=30
Height=60  && height
Width=270
ButtonCount=2
PROCEDURE Click
    m.RegSelected=ThisForm.VidOptGrp.Value
ENDDEFINE

DEFINE CLASS NACB AS CommandButton
Left=150
Top=50
Width=80
Height=25
Visible=.T.
FontSize=12
Caption=[Далі]
Alignment=2
PROCEDURE Click
	CLEAR EVENTS
ENDPROC
ENDDEFINE

DEFINE CLASS NALab AS Label
Left=0
Alignment=2
Width=350
Height=25
Visible=.T.
FontSize=12
ENDDEFINE

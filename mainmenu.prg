SET SYSMENU TO
SET SYSMENU AUTOMATIC

DEFINE PAD _���� OF _MSYSMENU PROMPT [\<�����] COLOR SCHEME 5 ;
	KEY ALT+S ;
	MESSAGE [���������� ���� �����]
DEFINE PAD _������ OF _MSYSMENU PROMPT [\<������] COLOR SCHEME 5 ;
	KEY ALT+Y ;
	MESSAGE [���������� �� ��������� ������]
DEFINE PAD _����� OF _MSYSMENU PROMPT [\<������] COLOR SCHEME 5 ;
	KEY ALT+D ;
	MESSAGE [���������� ������ � ���� �����]
DEFINE PAD _������� OF _MSYSMENU PROMPT [\<����������] COLOR SCHEME 5 ;
	KEY ALT+C ;
	MESSAGE [���������� �������� ������������ ����]
DEFINE PAD _�������� OF _MSYSMENU PROMPT "\<��������" COLOR SCHEME 5 ;
	KEY ALT+L ;
	MESSAGE [������ � ���������� ��������, ����� �� ��.]
DEFINE PAD _medit OF _MSYSMENU PROMPT "\<�����������" COLOR SCHEME 5 ;
	KEY ALT+H ;
	MESSAGE [��������, ���������, �������, �����, ����� ������]
DEFINE PAD _util OF _MSYSMENU PROMPT "\<������" COLOR SCHEME 5 ;
	KEY ALT+E ;
	MESSAGE [������� ������ ��� ����������]
	
ON PAD _medit OF _MSYSMENU ACTIVATE POPUP _medit
ON SELECTION PAD _���� OF _MSYSMENU DO baza
ON SELECTION PAD _������ OF _MSYSMENU && DO bnakaz
ON PAD _����� OF _MSYSMENU ACTIVATE POPUP _selections
ON PAD _������� OF _MSYSMENU ACTIVATE POPUP _stat
ON PAD _�������� OF _MSYSMENU ACTIVATE POPUP ��������
ON PAD _util OF _MSYSMENU ACTIVATE POPUP util

DEFINE POPUP _selections MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR  1 OF _selections PROMPT [�� ���������� ����������] FONT "Arial Cyr",12
DEFINE BAR  2 OF _selections PROMPT [������� ��������...] FONT "Arial Cyr",12
DEFINE BAR  3 OF _selections PROMPT [������ �� �������� ����������...] FONT "Arial Cyr",12
DEFINE BAR  4 OF _selections PROMPT [������ ���������� � ������, ����� ������ ���� �����������...] FONT "Arial Cyr",12
DEFINE BAR  5 OF _selections PROMPT [������ �������� �����������...] FONT "Arial Cyr",12
DEFINE BAR  6 OF _selections PROMPT [������ ���������� ��������� ���...] FONT "Arial Cyr",12
DEFINE BAR  7 OF _selections PROMPT [������ ����� ���������...] FONT "Arial Cyr",12
DEFINE BAR  8 OF _selections PROMPT [������ ���������� �� ������ �������...] FONT "Arial Cyr",12
DEFINE BAR  9 OF _selections PROMPT [������ ��� ���] FONT "Arial Cyr",12
DEFINE BAR 10 OF _selections PROMPT [������ ��� ���] FONT "Arial Cyr",12
DEFINE BAR 11 OF _selections PROMPT [����� ���������...] FONT "Arial Cyr",12
DEFINE BAR 12 OF _selections PROMPT [������ ���������� ������...] FONT "Arial Cyr",12
DEFINE BAR 13 OF _selections PROMPT [������ ���� �����������...] FONT "Arial Cyr",12
DEFINE BAR 14 OF _selections PROMPT [������ ��� �� ����...] FONT "Arial Cyr",12
DEFINE BAR 32 OF _selections PROMPT [������ ��� �� ������ ����������...] FONT "Arial Cyr",12
DEFINE BAR 15 OF _selections PROMPT [������ ��� � ������ �����.� ����.-�����.������...] FONT "Arial Cyr",12
DEFINE BAR 16 OF _selections PROMPT [������ ��� - ��������� ����...] FONT "Arial Cyr",12
DEFINE BAR 17 OF _selections PROMPT [������ ��� ������������ ��������...] FONT "Arial Cyr",12
DEFINE BAR 18 OF _selections PROMPT [������ �������,�� �������� �� ������ � �����] FONT "Arial Cyr",12
DEFINE BAR 19 OF _selections PROMPT [��������� ������ �������] FONT "Arial Cyr",12
DEFINE BAR 20 OF _selections PROMPT [������ ����.����,�� �������� �� ������ � �����] FONT "Arial Cyr",12
DEFINE BAR 21 OF _selections PROMPT [��������� ������ ��������� ����] FONT "Arial Cyr",12
DEFINE BAR 22 OF _selections PROMPT [������ ��������� ����, �������] FONT "Arial Cyr",12
DEFINE BAR 23 OF _selections PROMPT [������ ����.���� ���� �� 40 ����, �� �������� �� ����� ������] FONT "Arial Cyr",12
DEFINE BAR 24 OF _selections PROMPT [������ ��������� ���� ���� �� 40 ����] FONT "Arial Cyr",12
DEFINE BAR 25 OF _selections PROMPT [³������ ��� ������ �� �����������] FONT "Arial Cyr",12
DEFINE BAR 26 OF _selections PROMPT [³������ ��� ����������� ���� ����������] FONT "Arial Cyr",12
DEFINE BAR 27 OF _selections PROMPT [������ ����������,���� ������� ����������/������ �������� ] FONT "Arial Cyr",12
DEFINE BAR 28 OF _selections PROMPT [������ ����������, �� �������� ���������...] FONT "Arial Cyr",12
DEFINE BAR 29 OF _selections PROMPT [������ ����������, �� ����������� � "���������" ���������] FONT "Arial Cyr",12
DEFINE BAR 30 OF _selections PROMPT [������ ����������, ����� ������ ���� �����������] FONT "Arial Cyr",12
DEFINE BAR 31 OF _selections PROMPT [������ ���������� - �������� �������] FONT "Arial Cyr",12

ON           BAR  1 OF _selections ACTIVATE POPUP _dninar
ON           BAR  2 OF _selections ACTIVATE POPUP _stform
ON SELECTION BAR  3 OF _selections DO adrtel
ON SELECTION BAR  4 OF _selections DO FORM zkontr
ON SELECTION BAR  5 OF _selections DO FORM vetun
ON SELECTION BAR  6 OF _selections DO pracpens
ON SELECTION BAR  7 OF _selections DO newpens
ON           BAR  8 OF _selections ACTIVATE POPUP _cpucku
ON           BAR  9 OF _selections ACTIVATE POPUP _for_VOP
ON           BAR 10 OF _selections ACTIVATE POPUP _for_Meri
ON           BAR 11 OF _selections ACTIVATE POPUP _for_PFV
ON SELECTION BAR 12 OF _selections DO vklpos
ON SELECTION BAR 13 OF _selections DO womens
ON SELECTION BAR 14 OF _selections DO selvik
ON SELECTION BAR 32 OF _selections DO selbyear
ON SELECTION BAR 15 OF _selections DO form stapnp
ON SELECTION BAR 16 OF _selections DO form candid
ON SELECTION BAR 17 OF _selections DO form nvidpusk
ON SELECTION BAR 18 OF _selections DO dozb1
ON SELECTION BAR 19 OF _selections DO dozzag 
ON SELECTION BAR 20 OF _selections DO kandb1
ON SELECTION BAR 21 OF _selections DO kandzag
ON SELECTION BAR 22 OF _selections DO kanddoz
ON SELECTION BAR 23 OF _selections DO kandozvik
ON SELECTION BAR 24 OF _selections DO vik
ON SELECTION BAR 25 OF _selections DO FORM sumis
ON SELECTION BAR 26 OF _selections DO pedstag
ON SELECTION BAR 27 OF _selections DO pedstnad
ON SELECTION BAR 28 OF _selections DO FORM vikzviln
ON SELECTION BAR 29 OF _selections DO FORM decrvaca
ON SELECTION BAR 30 OF _selections DO FORM endofjob
ON SELECTION BAR 31 OF _selections DO FORM electors

DEFINE POPUP �������� MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR  1 OF �������� PROMPT [ϳ�������...] FONT "Arial Cyr",12
DEFINE BAR  2 OF �������� PROMPT [������ ����� � ����������...] FONT "Arial Cyr",12
DEFINE BAR  3 OF �������� PROMPT [������ ����� �� ������ �����������...] FONT "Arial Cyr",12
DEFINE BAR  4 OF �������� PROMPT [\-] 
DEFINE BAR  5 OF �������� PROMPT [������ ������...] FONT "Arial Cyr",12
DEFINE BAR  6 OF �������� PROMPT [������������...] FONT "Arial Cyr",12
DEFINE BAR  7 OF �������� PROMPT [�������������...] FONT "Arial Cyr",12
DEFINE BAR  8 OF �������� PROMPT [������� � ��������...] FONT "Arial Cyr",12
DEFINE BAR  9 OF �������� PROMPT [��������� ��� ����.������ �� ��.������...] FONT "Arial Cyr",12
DEFINE BAR 10 OF �������� PROMPT [...] FONT "Arial Cyr",12
DEFINE BAR 11 OF �������� PROMPT [...] FONT "Arial Cyr",12
DEFINE BAR 12 OF �������� PROMPT [...] FONT "Arial Cyr",12
DEFINE BAR 13 OF �������� PROMPT [...] FONT "Arial Cyr",12
DEFINE BAR 14 OF �������� PROMPT [...] FONT "Arial Cyr",12
DEFINE BAR 15 OF �������� PROMPT [...] FONT "Arial Cyr",12

ON BAR  1 OF �������� ACTIVATE POPUP pidr123
ON SELECTION BAR 2 OF �������� DO posad
ON SELECTION BAR 3 OF �������� DO postru
ON SELECTION BAR 5 OF �������� DO nstup
ON SELECTION BAR 6 OF �������� DO gromad
ON SELECTION BAR 7 OF �������� DO nac
ON SELECTION BAR 8 OF �������� DO dovnad
ON SELECTION BAR 9 OF �������� DO dovduplat

DEFINE POPUP _medit MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR _med_undo OF _medit PROMPT "\<�����" FONT "Arial Cyr",12;
	KEY CTRL+Z, "Ctrl+Z" ;
	MESSAGE "³���� �������� 䳿" 
DEFINE BAR _med_redo OF _medit PROMPT "\<���������" FONT "Arial Cyr",12;
	KEY CTRL+R, "Ctrl+R" ;
	MESSAGE "���������� �������� 䳿"
DEFINE BAR _med_sp100 OF _medit PROMPT "\-"
DEFINE BAR _med_cut OF _medit PROMPT "��\<�����" FONT "Arial Cyr",12;
	KEY CTRL+X, "Ctrl+X" ;
	MESSAGE "��������� ��������� � ���������� � ����� �����"
DEFINE BAR _med_copy OF _medit PROMPT "\<��������" FONT "Arial Cyr",12;
	KEY CTRL+C, "Ctrl+C" ;
	MESSAGE "��������� ��������� � ����� �����"
DEFINE BAR _med_paste OF _medit PROMPT "\<��������" FONT "Arial Cyr",12;
	KEY CTRL+V, "Ctrl+V" ;
	MESSAGE "������� ����� ������ �����"
DEFINE BAR _med_clear OF _medit PROMPT "�\<�������" FONT "Arial Cyr",12;
	MESSAGE "��������� ��������� ��� ���������� � ����� �����"
DEFINE BAR _med_sp200 OF _medit PROMPT "\-"
DEFINE BAR _med_slcta OF _medit PROMPT "������� ���" FONT "Arial Cyr",12;
	KEY CTRL+A, "Ctrl+A" ;
	MESSAGE "������� ���� ����� ��� �� �������� � ��������� ���"
DEFINE BAR _med_sp300 OF _medit PROMPT "\-"
DEFINE BAR _med_find OF _medit PROMPT "\<������..." FONT "Arial Cyr",12;
	KEY CTRL+F, "Ctrl+F" ;
	MESSAGE "����� ��������� ������"
DEFINE BAR _med_finda OF _medit PROMPT "������ \<��" FONT "Arial Cyr",12 ;
	KEY CTRL+G, "Ctrl+G" ;
	MESSAGE "��������� ����� ��������� ������"
DEFINE BAR _med_repl OF _medit PROMPT "\<�������..." FONT "Arial Cyr",12;
	KEY CTRL+L, "Ctrl+L" ;
	MESSAGE "������� �������� ����� �� �����"

DEFINE POPUP util MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF util PROMPT [����������� ��������] FONT "Arial Cyr",12
*DEFINE BAR 2 OF util PROMPT [��������� ���� ��� ��������] FONT "Arial Cyr",12
DEFINE BAR 3 OF util PROMPT [\-]
DEFINE BAR 4 OF util PROMPT [�������...] FONT "Arial Cyr",12;
	KEY Ctrl+B, "Ctrl+B" ;
	MESSAGE "³������ ������� ���� �����"
DEFINE BAR 5 OF util PROMPT [����� �������� (��� ����������)...] FONT "Arial Cyr",12;
	KEY Ctrl+P, "Ctrl+P" ;
	MESSAGE "³������ ����� �������� (��� ����������)"
DEFINE BAR 6 OF util PROMPT [����� (��� ����������)...] FONT "Arial Cyr",12;
	KEY Ctrl+M, "Ctrl+M" ;
	MESSAGE "³������ ����� (��� ����������)"
DEFINE BAR 7 OF util PROMPT "��������� (��� ����������)" FONT "Arial Cyr",12;
	MESSAGE "��������� ������ ��������  � ����� � OS"
DEFINE BAR 8 OF util PROMPT "SET (��� ����������)" FONT "Arial Cyr",12;
	MESSAGE "�������� ������ ������ ������"

ON SELECTION BAR 1 OF util DO form naraxvidp
*ON SELECTION BAR 2 OF util DO kopker
ON SELECTION BAR 4 OF util DO mybrowse
ON SELECTION BAR 5 OF util DO modpro
ON SELECTION BAR 6 OF util DO modfrm
ON SELECTION BAR 7 OF util CANCEL
ON SELECTION BAR 8 OF util SET

DEFINE POPUP pidr123 MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF pidr123 PROMPT "1-�� ���� - ���� ��������� ..." FONT "Arial Cyr",12
DEFINE BAR 2 OF pidr123 PROMPT "2-�� ���� - ����������, ����� ..." FONT "Arial Cyr",12
DEFINE BAR 3 OF pidr123 PROMPT "3-�� ���� - �������, ��������� ..." FONT "Arial Cyr",12

ON SELECTION BAR 1 OF pidr123 DO dovpid1r
ON SELECTION BAR 2 OF pidr123 DO dovpid2r
ON SELECTION BAR 3 OF pidr123 DO dovpid3r

DEFINE POPUP _stform MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF _stform PROMPT "����..." FONT "Arial Cyr",12
DEFINE BAR 2 OF _stform PROMPT "�.1.��� �������� �����..." FONT "Arial Cyr",12
DEFINE BAR 3 OF _stform PROMPT "�.1�.��� ������..." FONT "Arial Cyr",12
DEFINE BAR 4 OF _stform PROMPT "�.1.��� �������� ����� �������� ..." FONT "Arial Cyr",12

ON SELECTION BAR 1 OF _stform DO zmstform
ON SELECTION BAR 2 OF _stform DO stform
ON SELECTION BAR 3 OF _stform DO dek
ON SELECTION BAR 4 OF _stform DO stform04
*ON SELECTION BAR 2 OF _for_VOP DO vop1

DEFINE POPUP _stat MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF _stat PROMPT "������� �������� ..." FONT "Arial Cyr",12
DEFINE BAR 2 OF _stat PROMPT "������ ��� ��� �������������� ..." FONT "Arial Cyr",12
DEFINE BAR 3 OF _stat PROMPT "����� ��������� ������ ..." FONT "Arial Cyr",12

ON BAR 1 OF _stat ACTIVATE POPUP _statstf
ON SELECTION BAR 2 OF _stat DO statd
ON SELECTION BAR 3 OF _stat DO FORM qualkaf

DEFINE POPUP _statstf MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF _statstf PROMPT "�.2.��� �������� �� ������ ����� ���������� ..." FONT "Arial Cyr",12
DEFINE BAR 2 OF _statstf PROMPT "�.3.��� �������� �� ������ ����� ������ � ���.���. ..." FONT "Arial Cyr",12
DEFINE BAR 3 OF _statstf PROMPT "�.4.������ ��� ��� �� �����..." FONT "Arial Cyr",12
*DEFINE BAR 4 OF _statstf PROMPT "���� ��������� ..." FONT "Arial Cyr",12
*DEFINE BAR 5 OF _statstf PROMPT "������ ��� ��� �������,��������� �� ���������, ������� �� �������� ..." FONT "Arial Cyr",12

ON SELECTION BAR 1 OF _statstf DO forma2
ON SELECTION BAR 2 OF _statstf DO forma3
ON SELECTION BAR 3 OF _statstf DO forma4
*ON SELECTION BAR 4 OF _statstf DO forma2k
*ON SELECTION BAR 5 OF _statstf DO forma5

DEFINE POPUP _cpucku MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF _cpucku PROMPT [������ ���������, ������� ����] FONT "Arial Cyr",12
DEFINE BAR 2 OF _cpucku PROMPT [������ ���������, ��������� ����] FONT "Arial Cyr",12
DEFINE BAR 3 OF _cpucku PROMPT [������ �������, ������� ����] FONT "Arial Cyr",12
DEFINE BAR 4 OF _cpucku PROMPT [������ ��. ����. �����������, ������� ����] FONT "Arial Cyr",12
DEFINE BAR 5 OF _cpucku PROMPT [������ �������, ��������� ����] FONT "Arial Cyr",12
DEFINE BAR 6 OF _cpucku PROMPT [������ ������� ��� ��������� �������] FONT "Arial Cyr",12
DEFINE BAR 7 OF _cpucku PROMPT [������ ��. ����. �����������, ��������� ����] FONT "Arial Cyr",12
DEFINE BAR 8 OF _cpucku PROMPT [������ ��. ����. ����������� ��� ����. �������] FONT "Arial Cyr",12
DEFINE BAR 9 OF _cpucku PROMPT [������ ��������� ���� ��� ������� ������] FONT "Arial Cyr",12
DEFINE BAR 10 OF _cpucku PROMPT [������ ������� ��� ��. ������, ��� ����. �������] FONT "Arial Cyr",12
DEFINE BAR 11 OF _cpucku PROMPT [������ ��. ����������, ��������� ����] FONT "Arial Cyr",12
DEFINE BAR 12 OF _cpucku PROMPT [������ ��. ���������� ��� ����. �������] FONT "Arial Cyr",12
DEFINE BAR 13 OF _cpucku PROMPT [������ ��������� ��� ����. �������, ��� ��.������] FONT "Arial Cyr",12

ON SELECTION BAR 1 OF _cpucku DO doktorprof
ON SELECTION BAR 2 OF _cpucku DO kandudprof
ON SELECTION BAR 3 OF _cpucku DO doktordoz
ON SELECTION BAR 4 OF _cpucku DO ctncdok
ON SELECTION BAR 5 OF _cpucku DO docentkand
ON SELECTION BAR 6 OF _cpucku DO docentbez
ON SELECTION BAR 7 OF _cpucku DO ctnckand
ON SELECTION BAR 8 OF _cpucku DO ctncbez
ON SELECTION BAR 9 OF _cpucku DO kandbezzv
ON SELECTION BAR 10 OF _cpucku DO dozbezctzv
ON SELECTION BAR 11 OF _cpucku DO ctvukkand
ON SELECTION BAR 12 OF _cpucku DO ctvukbezct
ON SELECTION BAR 13 OF _cpucku DO acuctentbez

DEFINE POPUP _for_VOP MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF _for_VOP PROMPT [������ ��� ������, �� ������., ������ ...] FONT "Arial Cyr",12
DEFINE BAR 2 OF _for_VOP PROMPT [������ ��� ������, �� ������., ������ (�� ���������) ...] FONT "Arial Cyr",12
DEFINE BAR 3 OF _for_VOP PROMPT [������ ��� ���� �� ������� ����� ...] FONT "Arial Cyr",12
ON SELECTION BAR 1 OF _for_VOP DO posrndad
ON SELECTION BAR 2 OF _for_VOP DO posrndap
ON SELECTION BAR 3 OF _for_VOP DO vop1

DEFINE POPUP _for_Meri MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF _for_Meri PROMPT [������ ������� ����������  ...] FONT "Arial Cyr",12
ON SELECTION BAR 1 OF _for_Meri DO mvk1

DEFINE POPUP _for_PFV MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF _for_PFV PROMPT [������ ����������� 1...] FONT "Arial Cyr",12
DEFINE BAR 2 OF _for_PFV PROMPT [������ ����������� 2...] FONT "Arial Cyr",12
ON SELECTION BAR 1 OF _for_PFV DO strozst
ON SELECTION BAR 2 OF _for_PFV DO strozst2

DEFINE POPUP _dninar MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF _dninar PROMPT [�� �������...] FONT "Arial Cyr",12
DEFINE BAR 2 OF _dninar PROMPT [�� ����������...] FONT "Arial Cyr",12
ON SELECTION BAR 1 OF _dninar DO FORM dninar
ON SELECTION BAR 2 OF _dninar DO FORM dninar2

IF lI_Am_Guest OR lI_Am_Rector OR lI_Am_Boss
 SET SKIP OF PAD _������ OF _msysmenu .T.
 SET SKIP OF PAD _����� OF _msysmenu .T.
 SET SKIP OF PAD _������� OF _msysmenu  .T.
 SET SKIP OF PAD _util OF _msysmenu  .T.
ENDIF

IF lI_Am_Rector OR lI_Am_Boss
 SET SKIP OF PAD _����� OF _msysmenu .F.
 SET SKIP OF PAD _������� OF _msysmenu  .F.
ENDIF

*
* ���������� ��������� �����
*
LOCAL sprava,stZag,stUn,stNP,stP

* ��������� �������� ���� (� ����)
m.zagstag=0

* ����������� ������������� ���� (� ����)
m.corpstag=0

* �������-����������� ���� (� ����)
m.npstag=0

* ����������� ���� (� ����)
m.pedstag=0

* �������� ���� (� ����)
m.nstag=0

m.sprava=sprava 

*MESSAGEBOX(m.sprava)

IF NOT EMPTY(m.sprava)
	DO forstag WITH m.sprava
ENDIF

* ����������� ��� � ���� � �����

m.stzagr=INT(m.zagstag/365.25) && ��� ���� ���������� ����� 
m.stzagm=INT((m.zagstag-m.stzagr*365.25)/ROUND(365.25/12,4)) && �������� ����� ���������� ����� 
m.stzagr=m.stzagr+IIF(m.stzagm=12,1,0) && ������� ����
m.stzagm=IIF(m.stzagm=12,0,m.stzagm) && ������� �����

m.stunir=INT(m.corpstag/365.25) && ��� ���� �������������� ����� 
m.stunim=INT((m.corpstag-m.stunir*365.25)/ROUND(365.25/12,4)) && �������� �����
m.stunir=m.stunir+IIF(m.stunim=12,1,0) && ������� ����
m.stunim=IIF(m.stunim=12,0,m.stunim) && ������� �����

m.stnpr=INT(m.npstag/365.25) && ��� ���� �������-�����. ����� 
m.stnpm=INT((m.npstag-m.stnpr*365.25)/ROUND(365.25/12,4)) && �������� �����
m.stnpr=m.stnpr+IIF(m.stnpm=12,1,0) && ������� ����
m.stnpm=IIF(m.stnpm=12,0,m.stnpm) && ������� �����

m.stpr=INT(m.pedstag/365.25) && ��� ���� ������������ �����
m.stpm=INT((m.pedstag-m.stpr*365.25)/ROUND(365.25/12,4))  && �������� �����
m.stpr=m.stpr+IIF(m.stpm=12,1,0) && ������� ����
m.stpm=IIF(m.stpm=12,0,m.stpm) && ������� �����

m.stpr=m.stpr+main.peddovr && ���� � ���.������ �� ��������
m.stpm=m.stpm+main.peddovm && ����� � ���.������ �� ��������
m.stpr=m.stpr+IIF(m.stpm>=12,1,0) && ������� ����
m.stpm=m.stpm-IIF(m.stpm<12,0,12) && ������� �����

m.stnr=INT(m.nstag/365.25) && ��� ���� ��������� �����
m.stnm=INT((m.nstag-m.stnr*365.25)/ROUND(365.25/12,4))  && �������� �����
m.stnr=m.stnr+IIF(m.stnm=12,1,0) && ������� ����
m.stnm=IIF(m.stnm=12,0,m.stnm) && ������� �����

*=MESSAGEBOX('���������:'+ALLTRIM(STR(stzagr))+'�. '+ALLTRIM(STR(stzagm))+'�.')
*=MESSAGEBOX('�������-�����������:'+ALLTRIM(STR(stnpr))+'�. '+ALLTRIM(STR(stnpm))+'�.')
*=MESSAGEBOX('�����������: '+ALLTRIM(STR(stpr))+'�. '+ALLTRIM(STR(stpm))+'�.')
*MESSAGEBOX('5')
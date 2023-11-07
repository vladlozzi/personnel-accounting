SET SYSMENU TO
SET SYSMENU AUTOMATIC

DEFINE PAD _база OF _MSYSMENU PROMPT [\<Кадри] COLOR SCHEME 5 ;
	KEY ALT+S ;
	MESSAGE [Формування бази даних]
DEFINE PAD _накази OF _MSYSMENU PROMPT [\<Накази] COLOR SCHEME 5 ;
	KEY ALT+Y ;
	MESSAGE [Формування та реєстрація наказів]
DEFINE PAD _вибрк OF _MSYSMENU PROMPT [\<Вибірки] COLOR SCHEME 5 ;
	KEY ALT+D ;
	MESSAGE [Формування вибірок з бази даних]
DEFINE PAD _статист OF _MSYSMENU PROMPT [\<Статистика] COLOR SCHEME 5 ;
	KEY ALT+C ;
	MESSAGE [Формування зведених статистичних форм]
DEFINE PAD _довідники OF _MSYSMENU PROMPT "\<Довідники" COLOR SCHEME 5 ;
	KEY ALT+L ;
	MESSAGE [Робота з довідниками підрозділів, посад та ін.]
DEFINE PAD _medit OF _MSYSMENU PROMPT "\<Редагування" COLOR SCHEME 5 ;
	KEY ALT+H ;
	MESSAGE [Вирізання, копіювання, вставка, пошук, заміна тексту]
DEFINE PAD _util OF _MSYSMENU PROMPT "\<Утиліти" COLOR SCHEME 5 ;
	KEY ALT+E ;
	MESSAGE [Допоміжні утиліти для програміста]
	
ON PAD _medit OF _MSYSMENU ACTIVATE POPUP _medit
ON SELECTION PAD _база OF _MSYSMENU DO baza
ON SELECTION PAD _накази OF _MSYSMENU && DO bnakaz
ON PAD _вибрк OF _MSYSMENU ACTIVATE POPUP _selections
ON PAD _статист OF _MSYSMENU ACTIVATE POPUP _stat
ON PAD _довідники OF _MSYSMENU ACTIVATE POPUP довідники
ON PAD _util OF _MSYSMENU ACTIVATE POPUP util

DEFINE POPUP _selections MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR  1 OF _selections PROMPT [Дні народження працівників] FONT "Arial Cyr",12
DEFINE BAR  2 OF _selections PROMPT [Штатний формуляр...] FONT "Arial Cyr",12
DEFINE BAR  3 OF _selections PROMPT [Адреси та телефони працівників...] FONT "Arial Cyr",12
DEFINE BAR  4 OF _selections PROMPT [Перелік викладачів і деканів, термін роботи яких завершується...] FONT "Arial Cyr",12
DEFINE BAR  5 OF _selections PROMPT [Перелік ветеранів університету...] FONT "Arial Cyr",12
DEFINE BAR  6 OF _selections PROMPT [Перелік працівників пенсійного віку...] FONT "Arial Cyr",12
DEFINE BAR  7 OF _selections PROMPT [Перелік нових пенсіонерів...] FONT "Arial Cyr",12
DEFINE BAR  8 OF _selections PROMPT [Списки викладачів за якісним складом...] FONT "Arial Cyr",12
DEFINE BAR  9 OF _selections PROMPT [Довідки для ВОП] FONT "Arial Cyr",12
DEFINE BAR 10 OF _selections PROMPT [Довідки для мерії] FONT "Arial Cyr",12
DEFINE BAR 11 OF _selections PROMPT [Штати персоналу...] FONT "Arial Cyr",12
DEFINE BAR 12 OF _selections PROMPT [Перелік викладачів кафедр...] FONT "Arial Cyr",12
DEFINE BAR 13 OF _selections PROMPT [Перелік жінок університету...] FONT "Arial Cyr",12
DEFINE BAR 14 OF _selections PROMPT [Перелік осіб за віком...] FONT "Arial Cyr",12
DEFINE BAR 32 OF _selections PROMPT [Перелік осіб за роками народження...] FONT "Arial Cyr",12
DEFINE BAR 15 OF _selections PROMPT [Перелік осіб зі стажем педаг.і наук.-педаг.роботи...] FONT "Arial Cyr",12
DEFINE BAR 16 OF _selections PROMPT [Перелік осіб - кандидатів наук...] FONT "Arial Cyr",12
DEFINE BAR 17 OF _selections PROMPT [Довідка про невикористані відпустки...] FONT "Arial Cyr",12
DEFINE BAR 18 OF _selections PROMPT [Перелік доцентів,що працюють на ставку і більше] FONT "Arial Cyr",12
DEFINE BAR 19 OF _selections PROMPT [Загальний список доцентів] FONT "Arial Cyr",12
DEFINE BAR 20 OF _selections PROMPT [Перелік канд.наук,що працюють на ставку і більше] FONT "Arial Cyr",12
DEFINE BAR 21 OF _selections PROMPT [Загальний список кандидатів наук] FONT "Arial Cyr",12
DEFINE BAR 22 OF _selections PROMPT [Список кандидатів наук, доцентів] FONT "Arial Cyr",12
DEFINE BAR 23 OF _selections PROMPT [Список канд.наук віком до 40 років, що працюють на повну ставку] FONT "Arial Cyr",12
DEFINE BAR 24 OF _selections PROMPT [Список кандидатів наук віком до 40 років] FONT "Arial Cyr",12
DEFINE BAR 25 OF _selections PROMPT [Відомості про роботу за сумісництвом] FONT "Arial Cyr",12
DEFINE BAR 26 OF _selections PROMPT [Відомості про педагогічний стаж працівників] FONT "Arial Cyr",12
DEFINE BAR 27 OF _selections PROMPT [Перелік працівників,яким потрібно встановити/змінити надбавку ] FONT "Arial Cyr",12
DEFINE BAR 28 OF _selections PROMPT [Перелік викладачів, які пілягають звільненню...] FONT "Arial Cyr",12
DEFINE BAR 29 OF _selections PROMPT [Перелік працівників, які перебувають у "декретних" відпустках] FONT "Arial Cyr",12
DEFINE BAR 30 OF _selections PROMPT [Перелік працівників, термін роботи яких завершується] FONT "Arial Cyr",12
DEFINE BAR 31 OF _selections PROMPT [Перелік працівників - виборців ректора] FONT "Arial Cyr",12

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

DEFINE POPUP довідники MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR  1 OF довідники PROMPT [Підрозділи...] FONT "Arial Cyr",12
DEFINE BAR  2 OF довідники PROMPT [Перелік посад в університеті...] FONT "Arial Cyr",12
DEFINE BAR  3 OF довідники PROMPT [Перелік посад за межами університету...] FONT "Arial Cyr",12
DEFINE BAR  4 OF довідники PROMPT [\-] 
DEFINE BAR  5 OF довідники PROMPT [Наукові ступені...] FONT "Arial Cyr",12
DEFINE BAR  6 OF довідники PROMPT [Громадянства...] FONT "Arial Cyr",12
DEFINE BAR  7 OF довідники PROMPT [Національності...] FONT "Arial Cyr",12
DEFINE BAR  8 OF довідники PROMPT [Доплати і надбавки...] FONT "Arial Cyr",12
DEFINE BAR  9 OF довідники PROMPT [Документи про наук.ступені та вч.звання...] FONT "Arial Cyr",12
DEFINE BAR 10 OF довідники PROMPT [...] FONT "Arial Cyr",12
DEFINE BAR 11 OF довідники PROMPT [...] FONT "Arial Cyr",12
DEFINE BAR 12 OF довідники PROMPT [...] FONT "Arial Cyr",12
DEFINE BAR 13 OF довідники PROMPT [...] FONT "Arial Cyr",12
DEFINE BAR 14 OF довідники PROMPT [...] FONT "Arial Cyr",12
DEFINE BAR 15 OF довідники PROMPT [...] FONT "Arial Cyr",12

ON BAR  1 OF довідники ACTIVATE POPUP pidr123
ON SELECTION BAR 2 OF довідники DO posad
ON SELECTION BAR 3 OF довідники DO postru
ON SELECTION BAR 5 OF довідники DO nstup
ON SELECTION BAR 6 OF довідники DO gromad
ON SELECTION BAR 7 OF довідники DO nac
ON SELECTION BAR 8 OF довідники DO dovnad
ON SELECTION BAR 9 OF довідники DO dovduplat

DEFINE POPUP _medit MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR _med_undo OF _medit PROMPT "\<Назад" FONT "Arial Cyr",12;
	KEY CTRL+Z, "Ctrl+Z" ;
	MESSAGE "Відміна останньої дії" 
DEFINE BAR _med_redo OF _medit PROMPT "\<Повторити" FONT "Arial Cyr",12;
	KEY CTRL+R, "Ctrl+R" ;
	MESSAGE "Повторення останньої дії"
DEFINE BAR _med_sp100 OF _medit PROMPT "\-"
DEFINE BAR _med_cut OF _medit PROMPT "Ви\<різати" FONT "Arial Cyr",12;
	KEY CTRL+X, "Ctrl+X" ;
	MESSAGE "Вилучення вибраного і переміщення в буфер обміну"
DEFINE BAR _med_copy OF _medit PROMPT "\<Копіювати" FONT "Arial Cyr",12;
	KEY CTRL+C, "Ctrl+C" ;
	MESSAGE "Копіювання вибраного в буфер обміну"
DEFINE BAR _med_paste OF _medit PROMPT "\<Вставити" FONT "Arial Cyr",12;
	KEY CTRL+V, "Ctrl+V" ;
	MESSAGE "Вставка вмісту буфера обміну"
DEFINE BAR _med_clear OF _medit PROMPT "О\<чистити" FONT "Arial Cyr",12;
	MESSAGE "Вилучення вибраного без переміщення в буфер обміну"
DEFINE BAR _med_sp200 OF _medit PROMPT "\-"
DEFINE BAR _med_slcta OF _medit PROMPT "Виділити все" FONT "Arial Cyr",12;
	KEY CTRL+A, "Ctrl+A" ;
	MESSAGE "Виділити весь текст або всі елементи в поточному вікні"
DEFINE BAR _med_sp300 OF _medit PROMPT "\-"
DEFINE BAR _med_find OF _medit PROMPT "\<Шукати..." FONT "Arial Cyr",12;
	KEY CTRL+F, "Ctrl+F" ;
	MESSAGE "Пошук вказаного тексту"
DEFINE BAR _med_finda OF _medit PROMPT "Шукати \<ще" FONT "Arial Cyr",12 ;
	KEY CTRL+G, "Ctrl+G" ;
	MESSAGE "Подальший пошук вказаного тексту"
DEFINE BAR _med_repl OF _medit PROMPT "\<Замінити..." FONT "Arial Cyr",12;
	KEY CTRL+L, "Ctrl+L" ;
	MESSAGE "Замінити вказаний текст на інший"

DEFINE POPUP util MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF util PROMPT [Нарахування відпусток] FONT "Arial Cyr",12
*DEFINE BAR 2 OF util PROMPT [Копіювання бази для керівника] FONT "Arial Cyr",12
DEFINE BAR 3 OF util PROMPT [\-]
DEFINE BAR 4 OF util PROMPT [Таблиця...] FONT "Arial Cyr",12;
	KEY Ctrl+B, "Ctrl+B" ;
	MESSAGE "Відкрити таблицю бази даних"
DEFINE BAR 5 OF util PROMPT [Текст програми (для програміста)...] FONT "Arial Cyr",12;
	KEY Ctrl+P, "Ctrl+P" ;
	MESSAGE "Відкрити текст програми (для програміста)"
DEFINE BAR 6 OF util PROMPT [Форма (для програміста)...] FONT "Arial Cyr",12;
	KEY Ctrl+M, "Ctrl+M" ;
	MESSAGE "Відкрити форму (для програміста)"
DEFINE BAR 7 OF util PROMPT "Припинити (для програміста)" FONT "Arial Cyr",12;
	MESSAGE "Припинити роботу програми  і вийти в OS"
DEFINE BAR 8 OF util PROMPT "SET (для програміста)" FONT "Arial Cyr",12;
	MESSAGE "Показати відкриті робочі області"

ON SELECTION BAR 1 OF util DO form naraxvidp
*ON SELECTION BAR 2 OF util DO kopker
ON SELECTION BAR 4 OF util DO mybrowse
ON SELECTION BAR 5 OF util DO modpro
ON SELECTION BAR 6 OF util DO modfrm
ON SELECTION BAR 7 OF util CANCEL
ON SELECTION BAR 8 OF util SET

DEFINE POPUP pidr123 MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF pidr123 PROMPT "1-го рівня - види персоналу ..." FONT "Arial Cyr",12
DEFINE BAR 2 OF pidr123 PROMPT "2-го рівня - факультети, відділи ..." FONT "Arial Cyr",12
DEFINE BAR 3 OF pidr123 PROMPT "3-го рівня - кафедри, лабораторії ..." FONT "Arial Cyr",12

ON SELECTION BAR 1 OF pidr123 DO dovpid1r
ON SELECTION BAR 2 OF pidr123 DO dovpid2r
ON SELECTION BAR 3 OF pidr123 DO dovpid3r

DEFINE POPUP _stform MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF _stform PROMPT "Зміст..." FONT "Arial Cyr",12
DEFINE BAR 2 OF _stform PROMPT "Т.1.Про особовий склад..." FONT "Arial Cyr",12
DEFINE BAR 3 OF _stform PROMPT "Т.1а.Про деканів..." FONT "Arial Cyr",12
DEFINE BAR 4 OF _stform PROMPT "Т.1.Про особовий склад сумісників ..." FONT "Arial Cyr",12

ON SELECTION BAR 1 OF _stform DO zmstform
ON SELECTION BAR 2 OF _stform DO stform
ON SELECTION BAR 3 OF _stform DO dek
ON SELECTION BAR 4 OF _stform DO stform04
*ON SELECTION BAR 2 OF _for_VOP DO vop1

DEFINE POPUP _stat MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF _stat PROMPT "Штатний формуляр ..." FONT "Arial Cyr",12
DEFINE BAR 2 OF _stat PROMPT "Зведені дані для Держстатистики ..." FONT "Arial Cyr",12
DEFINE BAR 3 OF _stat PROMPT "Якість кадрового складу ..." FONT "Arial Cyr",12

ON BAR 1 OF _stat ACTIVATE POPUP _statstf
ON SELECTION BAR 2 OF _stat DO statd
ON SELECTION BAR 3 OF _stat DO FORM qualkaf

DEFINE POPUP _statstf MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF _statstf PROMPT "Т.2.Про кількісний та якісний склад викладачів ..." FONT "Arial Cyr",12
DEFINE BAR 2 OF _statstf PROMPT "Т.3.Про кількісний та якісний склад деканів і зав.каф. ..." FONT "Arial Cyr",12
DEFINE BAR 3 OF _statstf PROMPT "Т.4.Зведені дані про ПВ склад..." FONT "Arial Cyr",12
*DEFINE BAR 4 OF _statstf PROMPT "Факт пенсіонерів ..." FONT "Arial Cyr",12
*DEFINE BAR 5 OF _statstf PROMPT "Зведені дані про докторів,професорів та кандидатів, доцентів по кафедрах ..." FONT "Arial Cyr",12

ON SELECTION BAR 1 OF _statstf DO forma2
ON SELECTION BAR 2 OF _statstf DO forma3
ON SELECTION BAR 3 OF _statstf DO forma4
*ON SELECTION BAR 4 OF _statstf DO forma2k
*ON SELECTION BAR 5 OF _statstf DO forma5

DEFINE POPUP _cpucku MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF _cpucku PROMPT [Список професорів, докторів наук] FONT "Arial Cyr",12
DEFINE BAR 2 OF _cpucku PROMPT [Список професорів, кандидатів наук] FONT "Arial Cyr",12
DEFINE BAR 3 OF _cpucku PROMPT [Список доцентів, докторів наук] FONT "Arial Cyr",12
DEFINE BAR 4 OF _cpucku PROMPT [Список ст. наук. співробітників, докторів наук] FONT "Arial Cyr",12
DEFINE BAR 5 OF _cpucku PROMPT [Список доцентів, кандидатів наук] FONT "Arial Cyr",12
DEFINE BAR 6 OF _cpucku PROMPT [Список доцентів без наукового ступеня] FONT "Arial Cyr",12
DEFINE BAR 7 OF _cpucku PROMPT [Список ст. наук. співробітників, кандидатів наук] FONT "Arial Cyr",12
DEFINE BAR 8 OF _cpucku PROMPT [Список ст. наук. співробітників без наук. ступеня] FONT "Arial Cyr",12
DEFINE BAR 9 OF _cpucku PROMPT [Список кандидатів наук без вченого звання] FONT "Arial Cyr",12
DEFINE BAR 10 OF _cpucku PROMPT [Список доцентів без вч. звання, без наук. ступеня] FONT "Arial Cyr",12
DEFINE BAR 11 OF _cpucku PROMPT [Список ст. викладачів, кандидатів наук] FONT "Arial Cyr",12
DEFINE BAR 12 OF _cpucku PROMPT [Список ст. викладачів без наук. ступеня] FONT "Arial Cyr",12
DEFINE BAR 13 OF _cpucku PROMPT [Список асистентів без наук. ступеня, без вч.звання] FONT "Arial Cyr",12

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
DEFINE BAR 1 OF _for_VOP PROMPT [Довідка про посади, рік народж., адреси ...] FONT "Arial Cyr",12
DEFINE BAR 2 OF _for_VOP PROMPT [Довідка про посади, рік народж., адреси (по підрозділах) ...] FONT "Arial Cyr",12
DEFINE BAR 3 OF _for_VOP PROMPT [Довідка про стаж на останній посаді ...] FONT "Arial Cyr",12
ON SELECTION BAR 1 OF _for_VOP DO posrndad
ON SELECTION BAR 2 OF _for_VOP DO posrndap
ON SELECTION BAR 3 OF _for_VOP DO vop1

DEFINE POPUP _for_Meri MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF _for_Meri PROMPT [Список місцевих працівників  ...] FONT "Arial Cyr",12
ON SELECTION BAR 1 OF _for_Meri DO mvk1

DEFINE POPUP _for_PFV MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF _for_PFV PROMPT [Штатна розстановка 1...] FONT "Arial Cyr",12
DEFINE BAR 2 OF _for_PFV PROMPT [Штатна розстановка 2...] FONT "Arial Cyr",12
ON SELECTION BAR 1 OF _for_PFV DO strozst
ON SELECTION BAR 2 OF _for_PFV DO strozst2

DEFINE POPUP _dninar MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF _dninar PROMPT [за місяцями...] FONT "Arial Cyr",12
DEFINE BAR 2 OF _dninar PROMPT [за підрозділами...] FONT "Arial Cyr",12
ON SELECTION BAR 1 OF _dninar DO FORM dninar
ON SELECTION BAR 2 OF _dninar DO FORM dninar2

IF lI_Am_Guest OR lI_Am_Rector OR lI_Am_Boss
 SET SKIP OF PAD _накази OF _msysmenu .T.
 SET SKIP OF PAD _вибрк OF _msysmenu .T.
 SET SKIP OF PAD _статист OF _msysmenu  .T.
 SET SKIP OF PAD _util OF _msysmenu  .T.
ENDIF

IF lI_Am_Rector OR lI_Am_Boss
 SET SKIP OF PAD _вибрк OF _msysmenu .F.
 SET SKIP OF PAD _статист OF _msysmenu  .F.
ENDIF

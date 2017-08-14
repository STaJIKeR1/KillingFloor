class NewsTab extends MidGamePanel;

var bool bClean;

var automated GUISectionBackground i_BGSec;
var automated GUIScrollTextBox lb_Text;

var() config array<string> NewsLine;

var(ServerNews) localized string DefaultText;

var bool bReceivedRules;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    local int i;

    Super.InitComponent(MyController, MyOwner);

       bClean = true;
       lb_Text.SetContent(DefaultText);
    lb_Text.OnDraw = OnLabelDraw;
       for(i=NewsLine.Length-1; i>=0; i--)
       {
         lb_Text.AddText(NewsLine[i]);
       }
       lb_Text.AddText(" ");
       lb_Text.MyScrollBar.GripPos = 0;
       lb_Text.MyScrollBar.CurPos = 0;
       lb_Text.MyScrollBar.MyList.SetTopItem(0);
       lb_Text.MyScrollBar.AlignThumb();
       OnShow = Shown;
}

function bool OnLabelDraw(Canvas c)
{
    C.Style = 1;
    C.Font = class'ROHUD'.Static.GetSmallMenuFont(C);

    return false;
}

function Shown()
{
    lb_Text.MyScrollBar.GripPos = 0;
    lb_Text.MyScrollBar.CurPos = 0;

       lb_Text.MyScrollBar.MyList.SetTopItem(0);
       lb_Text.MyScrollBar.AlignThumb();
}

defaultproperties
{
     Begin Object Class=GUISectionBackground Name=BGSec
         Caption="ServerNews"
         WinTop=0.018000
         WinLeft=0.019240
         WinWidth=0.961520
         WinHeight=0.798982
         bFillClient=True
         OnPreDraw=BGSec.InternalPreDraw
     End Object
     i_BGSec=GUISectionBackground'ServerPerks.NewsTab.BGSec'

     Begin Object Class=GUIScrollTextBox Name=InfoText
         bNoTeletype=True
         CharDelay=0.002500
         EOLDelay=0.000000
         OnCreateComponent=InfoText.InternalOnCreateComponent
         WinTop=0.082000
         WinLeft=0.030000
         WinWidth=0.945000
         WinHeight=0.720000
         bBoundToParent=True
         bScaleToParent=True
         bNeverFocus=True
     End Object
     lb_Text=GUIScrollTextBox'ServerPerks.NewsTab.InfoText'

     NewsLine(0)="Переработан Коммандо и Поддержка (режим теста)"
     NewsLine(1)="Добавлены мобы из WTF"
     NewsLine(2)="Изменена таблица убийств (Просчитываються как обычные зомби, так и новогодние)."
     NewsLine(3)="Изменен стандартный спавн"
     DefaultText="Новости обновления:"
}
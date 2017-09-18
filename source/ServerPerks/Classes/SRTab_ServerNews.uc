class SRTab_ServerNews extends SRTab_Base;

var automated GUIButton				b_Prev,b_Next,b_Reload;
var automated GUISectionBackground	i_BGSec;
var automated GUIScrollTextBox		lb_Text;
var automated GUIHTMLTextBox		HTMLText;
var byte Stage;
var SRBufferedTCPLink Link;
var array<string> BrowseHistory;
var int CurrentIndex;
var string NextHistory;
var bool bAddHistory,bSkipHistoryChange;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local PlayerController PC;

	Super.InitComponent(MyController, MyOwner);
	CheckButtons();
	PC = PlayerOwner();
	if( PC.Level.GRI!=None )
		SetNewsText(Repl(PC.Level.GRI.MessageOfTheDay,"|","<BR>"));
	SetTimer(0.25,true);
	Timer();
}

function Timer()
{
	switch( Stage )
	{
	case 0:
		FirstPass();
		break;
	case 1:
		SecondPass();
		break;
	}
}
final function FirstPass()
{
	local ClientPerkRepLink L;

	L = Class'ClientPerkRepLink'.Static.FindStats(PlayerOwner());
	if( L==None || !L.bReceivedURL )
		return;
	if( L.ServerWebSite=="" )
	{
		BrowseHistory.Length = 0;
		KillTimer();
	}
	else
	{
		Link = PlayerOwner().Spawn(class'SRBufferedTCPLink');
		Link.StartBuffering(L.ServerWebSite);
		BrowseHistory.Length = 1;
		BrowseHistory[0] = L.ServerWebSite;
		CurrentIndex = 0;
		++Stage;
		CheckButtons();
	}
}
final function SecondPass()
{
	if( Link.bHasError )
		SetNewsText("Error when connecting to news page:| -"$Link.ErrorName);
	else if( Link.bHasData )
		SetNewsText(Link.InputBuffer);
	else return; // Waiting.

	Link.DestroyLink();
	Link = none;
	KillTimer();
}

final function SetNewsText( string S )
{
	if( bAddHistory )
	{
		++CurrentIndex;
		BrowseHistory.Length = CurrentIndex+1;
		BrowseHistory[CurrentIndex] = NextHistory;
	}
	HTMLText.SetContents(S);
	if( HTMLText.TitleString!="" )
		i_BGSec.Caption = HTMLText.TitleString;
	CheckButtons();
}

function SwitchPage( string NewURL )
{
	if( Link!=None )
		Link.DestroyLink();
	Link = PlayerOwner().Spawn(class'SRBufferedTCPLink');
	Link.StartBuffering(NewURL);
	if( bSkipHistoryChange )
		bAddHistory = false;
	else
	{
		NextHistory = NewURL;
		bAddHistory = true;
	}
	SetTimer(0.25,true);
}

final function GoToHistory( int Move )
{
	CurrentIndex = Clamp(CurrentIndex+Move,0,BrowseHistory.Length-1);
	bSkipHistoryChange = true;
	SwitchPage(BrowseHistory[CurrentIndex]);
	bSkipHistoryChange = false;
	CheckButtons();
}
final function CheckButtons()
{
	if( BrowseHistory.Length==0 )
	{
		DisableComponent(b_Prev);
		DisableComponent(b_Next);
		DisableComponent(b_Reload);
		return;
	}
	EnableComponent(b_Reload);
	if( CurrentIndex<=0 )
		DisableComponent(b_Prev);
	else EnableComponent(b_Prev);
	if( CurrentIndex>=(BrowseHistory.Length-1) )
		DisableComponent(b_Next);
	else EnableComponent(b_Next);
}

function bool ButtonClicked(GUIComponent Sender)
{
	switch( Sender )
	{
	case b_Prev:
		GoToHistory(-1);
		break;
	case b_Next:
		GoToHistory(1);
		break;
	case b_Reload:
		GoToHistory(0);
		break;
	}
	return true;
}

defaultproperties
{
     Begin Object Class=GUIButton Name=PreviousButton
         Caption="Prev"
         bAutoSize=True
         Hint="Go to previous page in history"
         WinTop=0.820000
         WinLeft=0.050000
         WinWidth=0.100000
         WinHeight=0.030000
         TabOrder=0
         OnClick=SRTab_ServerNews.ButtonClicked
         OnKeyEvent=PreviousButton.InternalOnKeyEvent
     End Object
     b_Prev=GUIButton'ServerPerks.SRTab_ServerNews.PreviousButton'

     Begin Object Class=GUIButton Name=NextButton
         Caption="Next"
         bAutoSize=True
         Hint="Go to next page in history"
         WinTop=0.820000
         WinLeft=0.170000
         WinWidth=0.100000
         WinHeight=0.030000
         TabOrder=0
         OnClick=SRTab_ServerNews.ButtonClicked
         OnKeyEvent=NextButton.InternalOnKeyEvent
     End Object
     b_Next=GUIButton'ServerPerks.SRTab_ServerNews.NextButton'

     Begin Object Class=GUIButton Name=ReloadButton
         Caption="Refresh"
         bAutoSize=True
         Hint="Reload current page"
         WinTop=0.820000
         WinLeft=0.095000
         WinWidth=0.100000
         WinHeight=0.030000
         TabOrder=0
         OnClick=SRTab_ServerNews.ButtonClicked
         OnKeyEvent=ReloadButton.InternalOnKeyEvent
     End Object
     b_Reload=GUIButton'ServerPerks.SRTab_ServerNews.ReloadButton'

     Begin Object Class=GUISectionBackground Name=BGSec
         bFillClient=True
         Caption="Server News"
         WinTop=0.018000
         WinLeft=0.019240
         WinWidth=0.961520
         WinHeight=0.798982
         OnPreDraw=BGSec.InternalPreDraw
     End Object
     i_BGSec=GUISectionBackground'ServerPerks.SRTab_ServerNews.BGSec'

     Begin Object Class=GUIHTMLTextBox Name=HTMLInfoText
         LaunchKFURL=SRTab_ServerNews.SwitchPage
         WinTop=0.052000
         WinLeft=0.030000
         WinWidth=0.945000
         WinHeight=0.760000
         bBoundToParent=True
         bScaleToParent=True
         bNeverFocus=True
         OnDraw=HTMLInfoText.RenderHTMLText
         OnClick=HTMLInfoText.LaunchURL
     End Object
     HTMLText=GUIHTMLTextBox'ServerPerks.SRTab_ServerNews.HTMLInfoText'

}

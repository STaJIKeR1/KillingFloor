class SRTab_MidGamePerks extends SRTab_Base;

// begin KFTab_MidGamePerks
var automated GUISectionBackground	i_BGPerks;
var	automated SRPerkSelectListBox	lb_PerkSelect;

var automated GUISectionBackground	i_BGPerkEffects;
var automated GUIScrollTextBox		lb_PerkEffects;

var automated GUISectionBackground	i_BGPerkNextLevel;
var	automated SRPerkProgressListBox	lb_PerkProgress;

var	automated GUIButton	b_Save;
// end KFTab_MidGamePerks

var localized string NextInfoStr,PleaseWaitStr;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	// Init localized
	i_BGPerks.Caption = Class'KFTab_MidGamePerks'.Default.i_BGPerks.Caption;
	i_BGPerkEffects.Caption = Class'KFTab_MidGamePerks'.Default.i_BGPerkEffects.Caption;
	i_BGPerkNextLevel.Caption = Class'KFTab_MidGamePerks'.Default.i_BGPerkNextLevel.Caption;
	b_Save.Caption = Class'KFTab_MidGamePerks'.Default.b_Save.Caption;
	b_Save.Hint = Class'KFTab_MidGamePerks'.Default.b_Save.Hint;
	
	Super.InitComponent(MyController, MyOwner);

	lb_PerkSelect.List.OnChange = OnPerkSelected;
}

function ShowPanel(bool bShow)
{
	Super.ShowPanel(bShow);

	if ( bShow )
	{
		if ( Class'ClientPerkRepLink'.Static.FindStats(PlayerOwner())!=none )
		{
			// Initialize the List
			lb_PerkSelect.List.InitList(None);
			lb_PerkProgress.List.InitList();
		}
	}
}

function OnPerkSelected(GUIComponent Sender)
{
	local ClientPerkRepLink ST;
	local byte Idx;

	ST = Class'ClientPerkRepLink'.Static.FindStats(PlayerOwner());
	if ( ST==None || ST.CachePerks.Length==0 )
	{
		if( ST!=None )
			ST.ServerRequestPerks();
		lb_PerkEffects.SetContent(PleaseWaitStr);
	}
	else
	{
		Idx = lb_PerkSelect.GetIndex();
		if( ST.CachePerks[Idx].CurrentLevel==0 )
			lb_PerkEffects.SetContent(ST.CachePerks[Idx].PerkClass.Static.GetVetInfoText(0,1));
		else if( ST.CachePerks[Idx].CurrentLevel==ST.MaximumLevel )
			lb_PerkEffects.SetContent(ST.CachePerks[Idx].PerkClass.Static.GetVetInfoText(ST.CachePerks[Idx].CurrentLevel-1,1));
		else lb_PerkEffects.SetContent(ST.CachePerks[Idx].PerkClass.Static.GetVetInfoText(ST.CachePerks[Idx].CurrentLevel-1,1)$NextInfoStr$ST.CachePerks[Idx].PerkClass.Static.GetVetInfoText(ST.CachePerks[Idx].CurrentLevel,1));
		lb_PerkProgress.List.PerkChanged(None, Idx);
	}
}

function bool OnSaveButtonClicked(GUIComponent Sender)
{
	local ClientPerkRepLink ST;

	ST = Class'ClientPerkRepLink'.Static.FindStats(PlayerOwner());
	if ( ST!=None && lb_PerkSelect.GetIndex()>=0 )
		ST.ServerSelectPerk(ST.CachePerks[lb_PerkSelect.GetIndex()].PerkClass);
	return true;
}

defaultproperties
{
     Begin Object Class=GUISectionBackground Name=BGPerks
         bFillClient=True
         WinTop=0.012063
         WinLeft=0.019240
         WinWidth=0.457166
         WinHeight=0.796032
         OnPreDraw=BGPerks.InternalPreDraw
     End Object
     i_BGPerks=GUISectionBackground'ServerPerks.SRTab_MidGamePerks.BGPerks'

     Begin Object Class=SRPerkSelectListBox Name=PerkSelectList
         OnCreateComponent=PerkSelectList.InternalOnCreateComponent
         WinTop=0.057760
         WinLeft=0.029240
         WinWidth=0.437166
         WinHeight=0.742836
     End Object
     lb_PerkSelect=SRPerkSelectListBox'ServerPerks.SRTab_MidGamePerks.PerkSelectList'

     Begin Object Class=GUISectionBackground Name=BGPerkEffects
         bFillClient=True
         WinTop=0.012063
         WinLeft=0.486700
         WinWidth=0.491566
         WinHeight=0.366816
         OnPreDraw=BGPerkEffects.InternalPreDraw
     End Object
     i_BGPerkEffects=GUISectionBackground'ServerPerks.SRTab_MidGamePerks.BGPerkEffects'

     Begin Object Class=GUIScrollTextBox Name=PerkEffectsScroll
         CharDelay=0.002500
         EOLDelay=0.100000
         OnCreateComponent=PerkEffectsScroll.InternalOnCreateComponent
         WinTop=0.057760
         WinLeft=0.500554
         WinWidth=0.465143
         WinHeight=0.313477
         TabOrder=9
     End Object
     lb_PerkEffects=GUIScrollTextBox'ServerPerks.SRTab_MidGamePerks.PerkEffectsScroll'

     Begin Object Class=GUISectionBackground Name=BGPerksNextLevel
         bFillClient=True
         WinTop=0.392889
         WinLeft=0.486700
         WinWidth=0.490282
         WinHeight=0.415466
         OnPreDraw=BGPerksNextLevel.InternalPreDraw
     End Object
     i_BGPerkNextLevel=GUISectionBackground'ServerPerks.SRTab_MidGamePerks.BGPerksNextLevel'

     Begin Object Class=SRPerkProgressListBox Name=PerkProgressList
         OnCreateComponent=PerkProgressList.InternalOnCreateComponent
         WinTop=0.476850
         WinLeft=0.499269
         WinWidth=0.463858
         WinHeight=0.341256
     End Object
     lb_PerkProgress=SRPerkProgressListBox'ServerPerks.SRTab_MidGamePerks.PerkProgressList'

     Begin Object Class=GUIButton Name=SaveButton
         WinTop=0.822807
         WinLeft=0.302670
         WinWidth=0.363829
         WinHeight=0.042757
         TabOrder=2
         bBoundToParent=True
         OnClick=SRTab_MidGamePerks.OnSaveButtonClicked
         OnKeyEvent=SaveButton.InternalOnKeyEvent
     End Object
     b_Save=GUIButton'ServerPerks.SRTab_MidGamePerks.SaveButton'

     NextInfoStr="||Next level effects:|"
     PleaseWaitStr="Please wait while your client is loading the perks..."
}

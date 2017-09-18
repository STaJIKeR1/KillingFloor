class SRTab_MidGameStats extends SRTab_Base;

var automated GUISectionBackground	i_BGPerks;
var	automated SRStatListBox	lb_PerkSelect;

function ShowPanel(bool bShow)
{
	local ClientPerkRepLink L;

	super.ShowPanel(bShow);

	if ( bShow )
	{
		L = Class'ClientPerkRepLink'.Static.FindStats(PlayerOwner());
		if ( L!=None )
			lb_PerkSelect.List.InitList(L);
	}
}

defaultproperties
{
     Begin Object Class=GUISectionBackground Name=BGPerks
         bFillClient=True
         Caption="Stats"
         WinTop=0.012063
         WinLeft=0.019240
         WinWidth=0.961520
         WinHeight=0.796032
         OnPreDraw=BGPerks.InternalPreDraw
     End Object
     i_BGPerks=GUISectionBackground'ServerPerks.SRTab_MidGameStats.BGPerks'

     Begin Object Class=SRStatListBox Name=StatSelectList
         OnCreateComponent=StatSelectList.InternalOnCreateComponent
         WinTop=0.057760
         WinLeft=0.029240
         WinWidth=0.941520
         WinHeight=0.742836
     End Object
     lb_PerkSelect=SRStatListBox'ServerPerks.SRTab_MidGameStats.StatSelectList'

}

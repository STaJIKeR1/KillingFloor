//=============================================================================
// The Trader menu with a tab for the store and the perks
//=============================================================================
class SRGUIBuyMenu extends GUIBuyMenu;

function bool NotifyLevelChange()
{
	bPersistent = false;
	return true;
}
function InitTabs()
{
	local SRKFTab_BuyMenu B;

	B = SRKFTab_BuyMenu(c_Tabs.AddTab(PanelCaption[0], string(Class'SRKFTab_BuyMenu'),, PanelHint[0]));
	c_Tabs.AddTab(PanelCaption[1], string(Class'SRKFTab_Perks'),, PanelHint[1]);

	SRBuyMenuFilter(BuyMenuFilter).SaleListBox = SRBuyMenuSaleList(B.SaleSelect.List);
}

defaultproperties
{
     Begin Object Class=SRKFQuickPerkSelect Name=QS
         WinTop=0.011906
         WinLeft=0.008008
         WinWidth=0.316601
         WinHeight=0.082460
         OnDraw=QS.MyOnDraw
     End Object
     QuickPerkSelect=SRKFQuickPerkSelect'ServerPerks.SRGUIBuyMenu.QS'

     Begin Object Class=SRBuyMenuFilter Name=SRFilter
         WinTop=0.051000
         WinLeft=0.670000
         WinWidth=0.305000
         WinHeight=0.082460
         OnDraw=SRFilter.MyOnDraw
     End Object
     BuyMenuFilter=SRBuyMenuFilter'ServerPerks.SRGUIBuyMenu.SRFilter'

     Begin Object Class=SRWeightBar Name=WeightB
         WinTop=0.945302
         WinLeft=0.055266
         WinWidth=0.443888
         WinHeight=0.053896
         OnDraw=WeightB.MyOnDraw
     End Object
     WeightBar=SRWeightBar'ServerPerks.SRGUIBuyMenu.WeightB'

}

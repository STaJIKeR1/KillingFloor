class WTFEquipBanHammerAttachment extends AxeAttachment;

/*
simulated function PostNetBeginPlay()
{
	Super(BaseKFWeaponAttachment).PostNetBeginPlay();
	SetTimer(1.0,true);
}

simulated function Timer()
{
	Super(BaseKFWeaponAttachment).Timer();
	
	if (Instigator != None && WTFEquipBanHammer(Instigator.Weapon) != None && WTFEquipBanHammer(Instigator.Weapon).bIsBlown)
	{
		Skins[0]=Texture'FreePerksServer_T.BanHammer.Banhammer_bloody_3rd';
	}
	else
	{
		Skins[0]=Texture'FreePerksServer_T.BanHammer.Banhammer_3rd';
	}
}
*/

defaultproperties
{
     Skins(0)=Texture'FreePerksServer_T.BanHammer.Banhammer_3rd'
}

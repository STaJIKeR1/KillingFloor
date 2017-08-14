class WTFEquipBanHammer extends Axe;

#exec OBJ LOAD FILE=FreePerksServer_T.utx

var bool bIsBlown;

replication
{
	reliable if(Role == ROLE_Authority)
		bIsBlown;
		
	reliable if(Role < ROLE_Authority)
		ResetBlown;
}

function ResetBlown()
{
	bIsBlown=false;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (ROLE == ROLE_AUTHORITY)
		bIsBlown=False;
	super.BringUp(PrevWeapon);
}

simulated function AltFire(float F)
{
	if (bIsBlown)
	{
		ResetBlown();
		PlayAnim(SelectAnim, SelectAnimRate, 0.0);
		Skins[BloodSkinSwitchArray] = default.Skins[BloodSkinSwitchArray];
		Texture = default.Texture;
	}
}

defaultproperties
{
     BloodyMaterial=Texture'FreePerksServer_T.BanHammer.Banhammer_bloody'
     Weight=2.000000
     TraderInfoTexture=Texture'FreePerksServer_T.BanHammer.BanHammer_Trader'
     SelectSoundRef="FreePerksServer_T.BanHammer.BanHammer_selected"
     HudImageRef="FreePerksServer_T.BanHammer.BanHammer_unselected"
     FireModeClass(0)=Class'ServerPerksP.WTFEquipBanHammerFire'
     FireModeClass(1)=Class'KFMod.NoFire'
     Description="A deadly weapon"
     PickupClass=Class'ServerPerksP.WTFEquipBanHammerPickup'
     AttachmentClass=Class'ServerPerksP.WTFEquipBanHammerAttachment'
     ItemName="Ban Hammer"
     Skins(0)=Texture'FreePerksServer_T.BanHammer.BanHammer'
}

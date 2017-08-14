class SRVetSharpshooter extends SRVeterancyTypes
	abstract;

static function int GetPerkProgressInt( ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum )
{
	switch( CurLevel )
	{
	case 0:
		FinalInt = 10;
		break;
	case 1:
		FinalInt = 30;
		break;
	case 2:
		FinalInt = 100;
		break;
	case 3:
		FinalInt = 250;
		break;
	case 4:
		FinalInt = 500;
		break;
	case 5:
		FinalInt = 1000;
		break;
	case 6:
		FinalInt = 2000;
		break;
	default:
		FinalInt = 2000+GetDoubleScaling(CurLevel,1000);
	}
	return Min(StatOther.RHeadshotKillsStat,FinalInt);
}

static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType)
{
	if ( AmmoType == class'FragAmmo' )
		// Up to 6 extra Grenades
		return 1.0 + (0.025 * float(KFPRI.ClientVeteranSkillLevel));
	if ( AmmoType == class'CrossbowAmmo' || AmmoType == class'WinchesterAmmo' || AmmoType == class'DeagleAmmo'
        || AmmoType == class'DualiesAmmo' || AmmoType == class'M14EBRAmmo' || AmmoType == class'M99Ammo'
        || AmmoType == class'Magnum44Ammo' || AmmoType == class'MK23Ammo' )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return 1.0;
		return 1.0 + (0.025 * float(KFPRI.ClientVeteranSkillLevel));
	}
	return 1.0;
}



static function float GetHeadShotDamMulti(KFPlayerReplicationInfo KFPRI, KFPawn P, class<DamageType> DmgType)
{
	local float ret;

	// Removed extra SS Crossbow headshot damage in Round 1(added back in Round 2) and Removed Single/Dualies Damage for Hell on Earth in Round 6
	// Added Dual Deagles back in for Balance Round 7
	if ( DmgType == class'DamTypeCrossbow' || DmgType == class'DamTypeCrossbowHeadShot' || DmgType == class'DamTypeWinchester' ||
		 DmgType == class'DamTypeDeagle' || DmgType == class'DamTypeDualDeagle' || DmgType == class'DamTypeM14EBR' ||
		  DmgType == class'DamTypeMagnum44Pistol' || DmgType == class'DamTypeDual44Magnum'
          || DmgType == class'DamTypeMK23Pistol' || DmgType == class'DamTypeDualMK23Pistol'
          || DmgType == class'DamTypeM99SniperRifle' || DmgType == class'DamTypeM99HeadShot' ||
          DmgType == class'DamTypeSPSniper' ||
		 (DmgType == class'DamTypeDualies' && KFPRI.Level.Game.GameDifficulty < 7.0) )
	{
		if ( KFPRI.ClientVeteranSkillLevel <= 3 )
		{
			ret = 1.05 + (0.05 * float(KFPRI.ClientVeteranSkillLevel));
		}
		else if ( KFPRI.ClientVeteranSkillLevel == 4 )
		{
			ret = 1.30;
		}
		else if ( KFPRI.ClientVeteranSkillLevel == 5 )
		{
			ret = 1.50;
		}
		else if ( KFPRI.ClientVeteranSkillLevel == 6 )
		{
			ret = 1.60; // 60% increase in Crossbow/Winchester/Handcannon damage
		}
		else
		{
			ret = 1.6 + (0.05 * float(KFPRI.ClientVeteranSkillLevel));
		}
	}
	// Reduced extra headshot damage for Single/Dualies in Hell on Earth difficulty(added in Balance Round 6)
	else if ( DmgType == class'DamTypeDualies' && KFPRI.Level.Game.GameDifficulty >= 7.0 )
	{
		return (1.0 + (0.08 * float(Min(KFPRI.ClientVeteranSkillLevel, 5)))); // 40% increase in Headshot Damage
	}
	else
	{
		ret = 1.0; // Fix for oversight in Balance Round 6(which is the reason for the Round 6 second attempt patch)
	}

	if ( KFPRI.ClientVeteranSkillLevel == 0 )
	{
		return ret * 1.05;
	}

	return ret * (1.0 + (0.10 * float(Min(KFPRI.ClientVeteranSkillLevel, 5)))); // 50% increase in Headshot Damage
}

static function float ModifyRecoilSpread(KFPlayerReplicationInfo KFPRI, WeaponFire Other, out float Recoil)
{
	if ( Crossbow(Other.Weapon) != none || Winchester(Other.Weapon) != none
        || Single(Other.Weapon) != none || Dualies(Other.Weapon) != none
        || Deagle(Other.Weapon) != none || DualDeagle(Other.Weapon) != none 
		|| Magnum44Pistol(Other.Weapon) != none|| Dual44Magnum(Other.Weapon) != none
		|| M14EBRBattleRifle(Other.Weapon) != none || M99SniperRifle(Other.Weapon) != none
        || SPSniperRifle(Other.Weapon) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 1)
			Recoil = 0.75;
		else if ( KFPRI.ClientVeteranSkillLevel == 2 )
			Recoil = 0.50;
		else Recoil = 0.25; // 75% recoil reduction with Crossbow/Winchester/Handcannon
		return Recoil;
	}
	Recoil = 1.0;
	Return Recoil;
}

// Modify fire speed
static function float GetFireSpeedMod(KFPlayerReplicationInfo KFPRI, Weapon Other)
{
	if ( Winchester(Other)!=none || Crossbow(Other)!=none || M99SniperRifle(Other)!=none || SPSniperRifle(Other)!=none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return 1.0;
		return 1.0 + (0.025 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 60% faster fire rate with Winchester
	}
	return 1.0;
}

static function float GetReloadSpeedModifier(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( Crossbow(Other) != none || Winchester(Other) != none
		 || Single(Other) != none || Dualies(Other) != none
         || Deagle(Other) != none || DualDeagle(Other) != none
         || MK23Pistol(Other) != none || DualMK23Pistol(Other) != none
         || M14EBRBattleRifle(Other) != none || Magnum44Pistol(Other) != none
         || Dual44Magnum(Other) != none || SPSniperRifle(Other) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return 1.0;
		return 1.0 + (0.025 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 60% faster reload with Crossbow/Winchester/Handcannon
	}
	return 1.0;
}

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'DeaglePickup' || Item == class'DualDeaglePickup' ||
	    Item == class'MK23Pickup' || Item == class'DualMK23Pickup' ||
        Item == class'Magnum44Pickup' || Item == class'Dual44MagnumPickup'
        || Item == class'M14EBRPickup' || Item == class'M99Pickup'
        || Item == class'SPSniperPickup' || Item == class'GoldenDeaglePickup'
        || Item == class'GoldenDualDeaglePickup' )
		return FMax(0.9 - (0.10 * float(KFPRI.ClientVeteranSkillLevel)),0.1); // Up to 70% discount on Handcannon/Dual Handcannons/EBR
	return 1.0;
}

static function float GetAmmoCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'CrossbowPickup' )
		return FMax(1.0 - (0.15 * float(KFPRI.ClientVeteranSkillLevel)),0.1f); // Up to 42% discount on Crossbow Bolts(Added in Balance Round 4 at 30%, increased to 42% in Balance Round 7)
	return 1.0;
}

	//Add Extra Carry Weight modify
static function int AddCarryMaxWeight(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel >=0 && KFPRI.ClientVeteranSkillLevel <= 5 )
		return 0;
	if ( KFPRI.ClientVeteranSkillLevel >=6 && KFPRI.ClientVeteranSkillLevel <= 10 )
		return 2;
	if ( KFPRI.ClientVeteranSkillLevel >=11 && KFPRI.ClientVeteranSkillLevel <= 15 )
		return 4;
	if ( KFPRI.ClientVeteranSkillLevel >=16 && KFPRI.ClientVeteranSkillLevel <= 20 )
		return 6;
	if ( KFPRI.ClientVeteranSkillLevel >= 21 && KFPRI.ClientVeteranSkillLevel <= 25 )
		return 8;
	if ( KFPRI.ClientVeteranSkillLevel >= 26 && KFPRI.ClientVeteranSkillLevel <= 30 )
		return 10;
	if ( KFPRI.ClientVeteranSkillLevel >= 31 && KFPRI.ClientVeteranSkillLevel <= 35 )
		return 12;
	if ( KFPRI.ClientVeteranSkillLevel >= 36 && KFPRI.ClientVeteranSkillLevel <= 40 )
		return 14;
	if ( KFPRI.ClientVeteranSkillLevel >= 41 )
		return 16;	
	return 16;
}

static function int GetMaxArmor(KFPlayerReplicationInfo KFPRI)
{
    local float Ret;
    local SRPlayerReplicationInfo SRPRI;
    local int Level;

    Level = 1;
    SRPRI = SRPlayerReplicationInfo(KFPRI);
    Ret = 100.0;
    if(KFPRI != none)
    {
        Level = KFPRI.ClientVeteranSkillLevel;
    }
    if(Level > 40)
    {
        Ret += float(150);
    }
    return int(Ret);
    //return;    
}

	// Give Extra Items as Default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	if ( KFPRI.ClientVeteranSkillLevel >= 0 && KFPRI.ClientVeteranSkillLevel <= 5   )
    {
		AddPerkedWeapon(class'Winchester',KFPRI,P);
		P.ShieldStrength = 0;
    }
	
    if  ( KFPRI.ClientVeteranSkillLevel >=6 && KFPRI.ClientVeteranSkillLevel <= 10   )
    {
		AddPerkedWeapon(class'MK23Pistol',KFPRI,P);
		AddPerkedWeapon(class'Winchester',KFPRI,P);
		P.ShieldStrength = 25;
    }    
	
	if ( KFPRI.ClientVeteranSkillLevel >=11 && KFPRI.ClientVeteranSkillLevel <= 20   )
    {
		AddPerkedWeapon(class'MK23Pistol',KFPRI,P );
		AddPerkedWeapon(class'Magnum44Pistol',KFPRI,P);
		AddPerkedWeapon(class'Winchester',KFPRI,P);
		P.ShieldStrength = 50;
    }   
	
	if ( KFPRI.ClientVeteranSkillLevel >=21 && KFPRI.ClientVeteranSkillLevel <= 30  )
    {
		AddPerkedWeapon(class'Magnum44Pistol',KFPRI,P );
		AddPerkedWeapon(class'DualMK23Pistol',KFPRI,P);
		AddPerkedWeapon(class'Crossbow',KFPRI,P);
		AddPerkedWeapon(class'M14EBRBattleRifle',KFPRI,P);
		P.ShieldStrength = 75;
    }  
	
	if ( KFPRI.ClientVeteranSkillLevel >=31 && KFPRI.ClientVeteranSkillLevel <= 40  )
    {
		AddPerkedWeapon(class'DualMK23Pistol',KFPRI,P );
		AddPerkedWeapon(class'M14EBRBattleRifle',KFPRI,P);
		AddPerkedWeapon(class'Crossbow',KFPRI,P);
		AddPerkedWeapon(class'Magnum44Pistol',KFPRI,P);
		P.ShieldStrength = 100;
    }
	
	if ( KFPRI.ClientVeteranSkillLevel >=41 && KFPRI.ClientVeteranSkillLevel <= 41  )
    {
		AddPerkedWeapon(class'DualMK23Pistol',KFPRI,P );
		AddPerkedWeapon(class'M14EBRBattleRifle',KFPRI,P);
		AddPerkedWeapon(class'Crossbow',KFPRI,P);
		AddPerkedWeapon(class'Magnum44Pistol',KFPRI,P);
		P.ShieldStrength = 150;
    }

}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	ReplaceText(S,"%s",GetPercentStr((1.6 + (0.05 * float(Level)))));
	ReplaceText(S,"%p",GetPercentStr(0.1 * float(Level)));
	ReplaceText(S,"%d",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f)));
	return S;
}

defaultproperties
{
	PerkIndex=2

	OnHUDIcon=Texture'KillingFloorHUD.Perks.Perk_SharpShooter'
	OnHUDGoldIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_SharpShooter_Gold'
	VeterancyName="Sharpshooter"
	Requirements[0]="Get %x headshot kills with Pistols, Rifle, Crossbow, M14, M99, or S.P. Musket"

	SRLevelEffects(0)="5% more damage with Pistols, Rifle, Crossbow, M14, and M99|5% extra Headshot damage with all weapons|10% discount on Handcannon/M14/M99"
	SRLevelEffects(1)="10% more damage with Pistols, Rifle, Crossbow, M14, and M99|25% less recoil with Pistols, Rifle, Crossbow, M14, M99, and S.P. Musket|10% faster reload with Pistols, Rifle, Crossbow, M14, M99, and S.P. Musket|10% extra headshot damage|20% discount on Handcannon/44 Magnum/M14/M99/S.P. Musket"
	SRLevelEffects(2)="15% more damage with Pistols, Rifle, Crossbow, M14, and M99|50% less recoil with Pistols, Rifle, Crossbow, M14, M99, and S.P. Musket|20% faster reload with Pistols, Rifle, Crossbow, M14, M99, and S.P. Musket|20% extra headshot damage|30% discount on Handcannon/44 Magnum/M14/M99/S.P. Musket"
	SRLevelEffects(3)="20% more damage with Pistols, Rifle, Crossbow, M14, and M99|75% less recoil with Pistols, Rifle, Crossbow, M14, M99, and S.P. Musket|30% faster reload with Pistols, Rifle, Crossbow, M14, M99, and S.P. Musket|30% extra headshot damage|40% discount on Handcannon/44 Magnum/M14/M99/S.P. Musket"
	SRLevelEffects(4)="30% more damage with Pistols, Rifle, Crossbow, M14, and M99|75% less recoil with Pistols, Rifle, Crossbow, M14, M99, and S.P. Musket|40% faster reload with Pistols, Rifle, Crossbow, M14, M99, and S.P. Musket|40% extra headshot damage|50% discount on Handcannon/44 Magnum/M14/M99/S.P. Musket"
	SRLevelEffects(5)="50% more damage with Pistols, Rifle, Crossbow, M14, and M99|75% less recoil with Pistols, Rifle, Crossbow, M14, M99, and S.P. Musket|50% faster reload with Pistols, Rifle, Crossbow, M14, M99, and S.P. Musket|50% extra headshot damage|60% discount on Handcannon/44 Magnum/M14/M99/S.P. Musket|Spawn with a Lever Action Rifle"
	SRLevelEffects(6)="60% more damage with Pistols, Rifle, Crossbow, M14, and M99|75% less recoil with Pistols, Rifle, Crossbow, M14, M99, and S.P. Musket|60% faster reload with Pistols, Rifle, Crossbow, M14, M99, and S.P. Musket|50% extra headshot damage|70% discount on Handcannon/44 Magnum/M14/M99/S.P. Musket|Spawn with a Crossbow"
	CustomLevelInfo="%s more damage with Pistols, Rifle, Crossbow, M14, and M99|75% less recoil with Pistols, Rifle, Crossbow, M14, M99, and S.P. Musket|%p faster reload with Pistols, Rifle, Crossbow, M14, M99, and S.P. Musket|50% extra headshot damage|%d discount on Handcannon/44 Magnum/M14/M99/S.P. Musket|Spawn with a Crossbow"
}
class SRVetFirebug extends SRVeterancyTypes
	abstract;

static function int GetPerkProgressInt( ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum )
{
	switch( CurLevel )
	{
	case 0:
		FinalInt = 10000;
		break;
	case 1:
		FinalInt = 25000;
		break;
	case 2:
		FinalInt = 100000;
		break;
	case 3:
		FinalInt = 500000;
		break;
	case 4:
		FinalInt = 1500000;
		break;
	case 5:
		FinalInt = 3500000;
		break;
	case 6:
		FinalInt = 5500000;
		break;
	default:
		FinalInt = 5500000+GetDoubleScaling(CurLevel,500000);
	}
	return Min(StatOther.RFlameThrowerDamageStat,FinalInt);
}

static function float GetMagCapacityMod(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( Flamethrower(Other) != none && KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 60% larger fuel canister
	if ( MAC10MP(Other) != none && KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + (0.12 * FMin(float(KFPRI.ClientVeteranSkillLevel), 5.0)); // 60% increase in MAC10 ammo carry
	return 1.0;
}
static function float GetAmmoPickupMod(KFPlayerReplicationInfo KFPRI, KFAmmunition Other)
{
	if ( (FlameAmmo(Other)!=none || MAC10Ammo(Other)!=none || HuskGunAmmo(Other)!=none || TrenchgunAmmo(Other)!=none || FlareRevolverAmmo(Other)!=none) && KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 60% larger fuel canister
	return 1.0;
}
static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType)
{
	if ( (AmmoType==class'FlameAmmo' || AmmoType==class'MAC10Ammo' || AmmoType==class'HuskGunAmmo' || AmmoType==class'TrenchgunAmmo' || AmmoType==class'FlareRevolverAmmo' || AmmoType==class'GoldenFlameAmmo') && KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 60% larger fuel canister
	return 1.0;
}

static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if ( class<DamTypeBurned>(DmgType)!=none || class<DamTypeFlamethrower>(DmgType)!=none || class<DamTypeHuskGunProjectileImpact>(DmgType)!=none || class<DamTypeFlareProjectileImpact>(DmgType)!=none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.05;
		return float(InDamage) * (1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel))); //  Up to 60% extra damage
	}
	return InDamage;
}

// Change effective range on FlameThrower
static function int ExtraRange(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel <= 2 )
		return 0;
	else if ( KFPRI.ClientVeteranSkillLevel <= 4 )
		return 1; // 50% Longer Range
	return 2; // 100% Longer Range
}

static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, Pawn Instigator, int InDamage, class<DamageType> DmgType)
{
	if ( class<DamTypeBurned>(DmgType)!=none || class<DamTypeFlamethrower>(DmgType)!=none || class<DamTypeHuskGunProjectileImpact>(DmgType)!=none || class<DamTypeFlareProjectileImpact>(DmgType)!=none )
	{
		if ( KFPRI.ClientVeteranSkillLevel <= 3 )
			return float(InDamage) * (0.50 - (0.10 * float(KFPRI.ClientVeteranSkillLevel)));
		return 0; // 100% reduction in damage from fire
	}
	return InDamage;
}

static function class<Grenade> GetNadeType(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel >= 3 )
		return class'FlameNade'; // Grenade detonations cause enemies to catch fire
	return super.GetNadeType(KFPRI);
}

static function float GetReloadSpeedModifier(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( Flamethrower(Other)!=none || MAC10MP(Other)!=none || Trenchgun(Other)!=none || FlareRevolver(Other)!=none || DualFlareRevolver(Other)!=none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return 1.0;
		return 1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 60% faster reload with all
	}
	return 1.0;
}

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item==class'FlameThrowerPickup' || Item==class'MAC10Pickup' || Item==class'HuskGunPickup' || Item==class'TrenchgunPickup' || Item==class'FlareRevolverPickup' || Item==class'DualFlareRevolverPickup' || Item==class'GoldenFTPickup' )
		return FMax(0.9 - (0.10 * float(KFPRI.ClientVeteranSkillLevel)),0.1); // Up to 70% discount on Flame Thrower
	return 1.0;
}

// Give Extra Items as default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If Level 5 or 6, give them a Flame Thrower
	if ( KFPRI.ClientVeteranSkillLevel >= 5 )
		KFHumanPawn(P).CreateInventoryVeterancy(string(class'FlameThrower'), default.StartingWeaponSellPriceLevel5);

	// If Level 6, give them Body Armor
	if ( KFPRI.ClientVeteranSkillLevel >= 6 )
		P.ShieldStrength = 100;
}

static function class<DamageType> GetMAC10DamageType(KFPlayerReplicationInfo KFPRI)
{
	return class'DamTypeMAC10MPInc';
}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	S = Repl(S,"%s",GetPercentStr(0.1 * float(Level)));
	S = Repl(S,"%m",GetPercentStr(0.05 * float(Level)));
	S = Repl(S,"%d",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f)));
	return S;
}

defaultproperties
{
     CustomLevelInfo="%s extra flame weapon damage|%m faster Flamethrower reload|%s more flame weapon ammo|100% resistance to fire|100% extra Flamethrower range|Grenades set enemies on fire|%d discount on flame weapons|Spawn with a Flamethrower and Body Armor"
     SRLevelEffects(0)="5% extra flame weapon damage|50% resistance to fire|10% discount on the Flamethrower"
     SRLevelEffects(1)="10% extra flame weapon damage|10% faster Flamethrower reload|10% more flame weapon ammo|60% resistance to fire|20% discount on flame weapons"
     SRLevelEffects(2)="20% extra flame weapon damage|20% faster Flamethrower reload|20% more flame weapon ammo|70% resistance to fire|30% discount on flame weapons"
     SRLevelEffects(3)="30% extra flame weapon damage|30% faster Flamethrower reload|30% more flame weapon ammo|80% resistance to fire|50% extra Flamethrower range|Grenades set enemies on fire|40% discount on flame weapons"
     SRLevelEffects(4)="40% extra flame weapon damage|40% faster Flamethrower reload|40% more flame weapon ammo|90% resistance to fire|50% extra Flamethrower range|Grenades set enemies on fire|50% discount on flame weapons"
     SRLevelEffects(5)="50% extra flame weapon damage|50% faster Flamethrower reload|50% more flame weapon ammo|100% resistance to fire|100% extra Flamethrower range|Grenades set enemies on fire|60% discount on flame weapons|Spawn with a Flamethrower"
     SRLevelEffects(6)="60% extra flame weapon damage|60% faster Flamethrower reload|60% more flame weapon ammo|100% resistance to fire|100% extra Flamethrower range|Grenades set enemies on fire|70% discount on flame weapons|Spawn with a Flamethrower and Body Armor"
     PerkIndex=5
     OnHUDIcon=Texture'KillingFloorHUD.Perks.Perk_Firebug'
     OnHUDGoldIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_Firebug_Gold'
     VeterancyName="Firebug"
     Requirements(0)="Deal %x damage with the Flamethrower"
}

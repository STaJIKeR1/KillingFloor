class SRVetFirebug extends SRVeterancyTypes
	abstract;

static function int GetPerkProgressInt( ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum )
{
	switch( CurLevel )
	{
	
        case 0:
            FinalInt = 5000;
            break;
        case 1:
            FinalInt = 15000;
            break;
        case 2:
            FinalInt = 30000;
            break;
        case 3:
            FinalInt = 60000;
            break;
        case 4:
            FinalInt = 120000;
            break;
        case 5:
            FinalInt = 250000;
            break;
        case 6:
            FinalInt = 500000;
            break;
        case 7:
            FinalInt = 1000000;
            break;
        case 8:
            FinalInt = 2000000;
            break;
        case 9:
            FinalInt = 4000000;
            break;
        case 10:
            FinalInt = 6000000;
            break;
        case 11:
            FinalInt = 8000000;
            break;
        case 12:
            FinalInt = 13000000;
            break;
        case 13:
            FinalInt = 18000000;
            break;
        case 14:
            FinalInt = 23000000;
            break;
        case 15:
            FinalInt = 26000000;
            break;
        case 16:
            FinalInt = 34000000;
            break;
        case 17:
            FinalInt = 42000000;
            break;
        case 18:
            FinalInt = 50000000;
            break;
        case 19:
            FinalInt = 58000000;
            break;
        case 20:
            FinalInt = 66000000;
            break;
        case 21:
            FinalInt = 77250000;
            break;
        case 22:
            FinalInt = 89250000;
            break;
        case 23:
            FinalInt = 102000000;
            break;
        case 24:
            FinalInt = 115500000;
            break;
        case 25:
            FinalInt = 129750000;
            break;
        case 26:
            FinalInt = 144250000;
            break;
        case 27:
            FinalInt = 160500000;
            break;
        case 28:
            FinalInt = 177000000;
            break;
        case 29:
            FinalInt = 194250000;
            break;
        case 30:
            FinalInt = 212250000;
            break;
        case 31:
            FinalInt = 231000000;
            break;
        case 32:
            FinalInt = 253500000;
            break;
        case 33:
            FinalInt = 276000000;
            break;
        case 34:
            FinalInt = 298500000;
            break;
        case 35:
            FinalInt = 321000000;
            break;
        case 36:
            FinalInt = 343500000;
            break;
        case 37:
            FinalInt = 366000000;
            break;
        case 38:
            FinalInt = 388500000;
            break;
        case 39:
            FinalInt = 418500000;
            break;
        case 40:
            FinalInt = 450000000;
            break;
        case 41:
            FinalInt = 1000000000;
            break;
        default:
            FinalInt = 5500000 + GetDoubleScaling(CurLevel, 500000);
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
		return 1.0 + (0.30 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 60% larger fuel canister
		
		
	return 1.0;
}
static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType)
{
	if (( AmmoType == class'FragAmmo' )
		&& KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + 0.10 * KFPRI.ClientVeteranSkillLevel;
	if (( AmmoType == class'FireBombAmmo' )
		&& KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + 0.50 * KFPRI.ClientVeteranSkillLevel;
	if (( AmmoType == class'FM32Ammo' )
		&& KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + 0.50 * KFPRI.ClientVeteranSkillLevel;
	if ((AmmoType==class'FlameAmmo' || AmmoType==class'MAC10Ammo' || AmmoType==class'HuskGunAmmo' || AmmoType==class'TrenchgunAmmo' 
	|| AmmoType==class'FlareRevolverAmmo' || AmmoType==class'GoldenFlameAmmo' )
	&& KFPRI.ClientVeteranSkillLevel > 5 )
		return 1.0 + (0.20 * float(KFPRI.ClientVeteranSkillLevel)); 
	return 1.0;
}

static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if ( class<DamTypeBurned>(DmgType)!=none || class<DamTypeFlamethrower>(DmgType)!=none || class<DamTypeHuskGunProjectileImpact>(DmgType)!=none || class<DamTypeFlareProjectileImpact>(DmgType)!=none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.00;
		return float(InDamage) * (1.0 + (0.020 * float(KFPRI.ClientVeteranSkillLevel))); //  Up to 60% extra damage
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
		if ( KFPRI.ClientVeteranSkillLevel <= 0 )
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
		return 1.0 + (0.025 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 60% faster reload with all
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

	// Give Extra Items as default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If Level 5 or 6, give them a Flame Thrower
	if ( KFPRI.ClientVeteranSkillLevel >= 5 )
		AddPerkedWeapon(class'FlameThrower',KFPRI,P);

	if ( KFPRI.ClientVeteranSkillLevel >=0 && KFPRI.ClientVeteranSkillLevel <= 5 )
		P.ShieldStrength = 0;
	if ( KFPRI.ClientVeteranSkillLevel >=6 && KFPRI.ClientVeteranSkillLevel <= 10 )
		P.ShieldStrength = 25;
	if ( KFPRI.ClientVeteranSkillLevel >=11 && KFPRI.ClientVeteranSkillLevel <= 20 )
		P.ShieldStrength = 50;
	if ( KFPRI.ClientVeteranSkillLevel >=21 && KFPRI.ClientVeteranSkillLevel <= 30)
		P.ShieldStrength = 75;
	if ( KFPRI.ClientVeteranSkillLevel >=31 && KFPRI.ClientVeteranSkillLevel <= 40)
		P.ShieldStrength = 100;
	if ( KFPRI.ClientVeteranSkillLevel >=41 && KFPRI.ClientVeteranSkillLevel <= 41)
		P.ShieldStrength = 150;
}

static function class<DamageType> GetMAC10DamageType(KFPlayerReplicationInfo KFPRI)
{
	return class'DamTypeMAC10MPInc';
}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	ReplaceText(S,"%s",GetPercentStr(0.1 * float(Level)));
	ReplaceText(S,"%m",GetPercentStr(0.05 * float(Level)));
	ReplaceText(S,"%d",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f)));
	return S;
}

defaultproperties
{
	PerkIndex=5

	OnHUDIcon=Texture'KillingFloorHUD.Perks.Perk_Firebug'
	OnHUDGoldIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_Firebug_Gold'
	VeterancyName="Firebug"
	Requirements(0)="Deal %x damage with the Flamethrower"

	SRLevelEffects(0)="5% extra flame weapon damage|50% resistance to fire|10% discount on the Flamethrower"
	SRLevelEffects(1)="10% extra flame weapon damage|10% faster Flamethrower reload|10% more flame weapon ammo|60% resistance to fire|20% discount on flame weapons"
	SRLevelEffects(2)="20% extra flame weapon damage|20% faster Flamethrower reload|20% more flame weapon ammo|70% resistance to fire|30% discount on flame weapons"
	SRLevelEffects(3)="30% extra flame weapon damage|30% faster Flamethrower reload|30% more flame weapon ammo|80% resistance to fire|50% extra Flamethrower range|Grenades set enemies on fire|40% discount on flame weapons"
	SRLevelEffects(4)="40% extra flame weapon damage|40% faster Flamethrower reload|40% more flame weapon ammo|90% resistance to fire|50% extra Flamethrower range|Grenades set enemies on fire|50% discount on flame weapons"
	SRLevelEffects(5)="50% extra flame weapon damage|50% faster Flamethrower reload|50% more flame weapon ammo|100% resistance to fire|100% extra Flamethrower range|Grenades set enemies on fire|60% discount on flame weapons|Spawn with a Flamethrower"
	SRLevelEffects(6)="60% extra flame weapon damage|60% faster Flamethrower reload|60% more flame weapon ammo|100% resistance to fire|100% extra Flamethrower range|Grenades set enemies on fire|70% discount on flame weapons|Spawn with a Flamethrower and Body Armor"
	CustomLevelInfo="%s extra flame weapon damage|%m faster Flamethrower reload|%s more flame weapon ammo|100% resistance to fire|100% extra Flamethrower range|Grenades set enemies on fire|%d discount on flame weapons|Spawn with a Flamethrower and Body Armor"
}
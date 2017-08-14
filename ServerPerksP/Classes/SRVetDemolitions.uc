class SRVetDemolitions extends SRVeterancyTypes
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
	return Min(StatOther.RExplosivesDamageStat,FinalInt);
}

static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType)
{
	if (( AmmoType == class'FragAmmo' )
		&& KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + 0.15 * KFPRI.ClientVeteranSkillLevel;
	if (( AmmoType == class'PipeBombAmmo' )
		&& KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + 0.25 * KFPRI.ClientVeteranSkillLevel;
	if (( AmmoType == class'LAWAmmo' || AmmoType == class'SealSquealAmmo' )
		&& KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + 0.05 * KFPRI.ClientVeteranSkillLevel;
	if (( AmmoType == class'M32Ammo' || AmmoType == class'M203Ammo' || AmmoType == class'CamoM32Ammo'|| AmmoType == class'M4203Ammo'|| AmmoType == class'M79Ammo' || AmmoType == class'M4203Ammo' || AmmoType == class'SeekerSixAmmo'  )
		&& KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + 0.10 * KFPRI.ClientVeteranSkillLevel;
	return 1.0;
}

static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if ( class<DamTypeFrag>(DmgType) != none)
	{	
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.00;
		return float(InDamage) * (1.00 + (0.05 * float(KFPRI.ClientVeteranSkillLevel)));
	}
	if ( class<DamTypePipeBomb>(DmgType) != none)
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.00;
		return float(InDamage) * (1.00 + (0.05 * float(KFPRI.ClientVeteranSkillLevel)));
	}
	if ( class<DamTypeM79Grenade>(DmgType) != none || class<DamTypeM32Grenade>(DmgType) != none
        || class<DamTypeM203Grenade>(DmgType) != none || class<DamTypeSPGrenade>(DmgType) != none 
        || class<DamTypeSeekerSixRocket>(DmgType) != none)
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.00;
		return float(InDamage) * (1.00 + (0.05 * float(KFPRI.ClientVeteranSkillLevel))); //  Up to 60% extra damage
	}
	if ( class<DamTypeRocketImpact>(DmgType) != none || class<DamTypeSealSquealExplosion>(DmgType) != none)
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.50;
		return float(InDamage) * (1.50 + (0.10 * float(KFPRI.ClientVeteranSkillLevel))); //  Up to 60% extra damage
	}
	return InDamage;
}

///Test
static function float GetReloadSpeedModifier(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( CamoM32GrenadeLauncher(Other) != none || M32GrenadeLauncher(Other) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return 1.0;
		return 1.0 + (0.025 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 2,5% faster reload with level
	}
	return 1.0;
}

static function float GetMagCapacityMod(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( CamoM32GrenadeLauncher(Other) != none || M32GrenadeLauncher(Other) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return 1.0;
		return 1.0 + (0.025 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 5% faster reload with level
	}
	return 1.0;
}
///Test


static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, Pawn Instigator, int InDamage, class<DamageType> DmgType)
{
	if ( class<DamTypeFrag>(DmgType) != none || class<DamTypePipeBomb>(DmgType) != none ||
		 class<DamTypeM79Grenade>(DmgType) != none || class<DamTypeM32Grenade>(DmgType) != none
         || class<DamTypeM203Grenade>(DmgType) != none || class<DamTypeRocketImpact>(DmgType) != none
         || class<DamTypeSPGrenade>(DmgType) != none || class<DamTypeSealSquealExplosion>(DmgType) != none
         || class<DamTypeSeekerSixRocket>(DmgType) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel <= 0 )
			return float(InDamage) * (0.50 - (0.10 * float(KFPRI.ClientVeteranSkillLevel)));
		return 0; // 100% reduction in damage from expl
	}
	return InDamage;
}

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'PipeBombPickup' )
		// Todo, this won't need to be so extreme when we set up the system to only allow him to buy it perhaps
		return FMax(0.5 - (0.04 * float(KFPRI.ClientVeteranSkillLevel)),0.01f); // Up to 93% discount on PipeBomb
	if ( Item == class'M79Pickup' || Item == class 'M32Pickup'
        || Item == class 'LawPickup' || Item == class 'M4203Pickup'
        || Item == class'GoldenM79Pickup' || Item == class'SPGrenadePickup'
        || Item == class'CamoM32Pickup' || Item == class'SealSquealPickup'
        || Item == class'SeekerSixPickup' )
		return FMax(1.00 - (0.10 * float(KFPRI.ClientVeteranSkillLevel)),0.1f); // Up to 70% discount on M79/M32
	return 1.0;
}

// Change the cost of particular ammo
static function float GetAmmoCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'PipeBombPickup' )
		// Todo, this won't need to be so extreme when we set up the system to only allow him to buy it perhaps
		return FMax(0.5 - (0.04 * float(KFPRI.ClientVeteranSkillLevel)),0.01f); // Up to 93% discount on PipeBomb
	if ( Item == class'M79Pickup' || Item == class'M32Pickup'
        || Item == class'LAWPickup' || Item == class'M4203Pickup'
        || Item == class'GoldenM79Pickup' || Item == class'SPGrenadePickup'
        || Item == class'CamoM32Pickup' || Item == class'SealSquealPickup'
        || Item == class'SeekerSixPickup' )
		return FMax(1.0 - (0.15 * float(KFPRI.ClientVeteranSkillLevel)),0.1f); // Up to 30% discount on Grenade Launcher and LAW Ammo(Balance Round 5)
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


// Give Extra Items as default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
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
		
	if ( KFPRI.ClientVeteranSkillLevel >=0 && KFPRI.ClientVeteranSkillLevel <= 5 )
    {
		AddPerkedWeapon(class'M4203AssaultRifle',KFPRI,P);
		AddPerkedWeapon(class'PipeBombExplosive',KFPRI,P);
    }
  
	if  ( KFPRI.ClientVeteranSkillLevel >=6 && KFPRI.ClientVeteranSkillLevel <= 10 )
    {
		AddPerkedWeapon(class'M79GrenadeLauncher',KFPRI,P);
		AddPerkedWeapon(class'PipeBombExplosive',KFPRI,P);
		AddPerkedWeapon(class'M4203AssaultRifle',KFPRI,P);
    }
    
	if ( KFPRI.ClientVeteranSkillLevel >=11 && KFPRI.ClientVeteranSkillLevel <= 20 )
    {
		AddPerkedWeapon(class'M79GrenadeLauncher',KFPRI,P);
		AddPerkedWeapon(class'PipeBombExplosive',KFPRI,P);
		AddPerkedWeapon(class'M4203AssaultRifle',KFPRI,P);
		AddPerkedWeapon(class'M32GrenadeLauncher',KFPRI,P);
	}
    
	if ( KFPRI.ClientVeteranSkillLevel >=21 && KFPRI.ClientVeteranSkillLevel <= 30 )
	
    {
		AddPerkedWeapon(class'M79GrenadeLauncher',KFPRI,P);
		AddPerkedWeapon(class'PipeBombExplosive',KFPRI,P);
		AddPerkedWeapon(class'M32GrenadeLauncher',KFPRI,P);
		AddPerkedWeapon(class'LAW',KFPRI,P);
    }
    
	if ( KFPRI.ClientVeteranSkillLevel >=31 && KFPRI.ClientVeteranSkillLevel <= 41 )
    {
		AddPerkedWeapon(class'M79GrenadeLauncher',KFPRI,P);
		AddPerkedWeapon(class'PipeBombExplosive',KFPRI,P);
		AddPerkedWeapon(class'M32GrenadeLauncher',KFPRI,P);
		AddPerkedWeapon(class'LAW',KFPRI,P);
    }
}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	ReplaceText(S,"%s",GetPercentStr(0.05 * float(Level)));
	ReplaceText(S,"%r",GetPercentStr(FMin(0.25f+0.05 * float(Level),0.95f)));
	ReplaceText(S,"%d",GetPercentStr(FMin(0.5+0.04 * float(Level),0.99f)));
	ReplaceText(S,"%x",string(2+Level));
	ReplaceText(S,"%y",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f)));
	return S;
}

defaultproperties
{
	PerkIndex=6

	OnHUDIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_Demolition'
	OnHUDGoldIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_Demolition_Gold'
	VeterancyName="Подрывник"
	Requirements(0)="Нанести %x урона взрывами"

	SRLevelEffects(0)="5% extra Explosives damage|25% resistance to Explosives|10% discount on Explosives|50% off Remote Explosives"
	SRLevelEffects(1)="10% extra Explosives damage|30% resistance to Explosives|20% increase in grenade capacity|Can carry 3 Remote Explosives|20% discount on Explosives|54% off Remote Explosives"
	SRLevelEffects(2)="20% extra Explosives damage|35% resistance to Explosives|40% increase in grenade capacity|Can carry 4 Remote Explosives|30% discount on Explosives|58% off Remote Explosives"
	SRLevelEffects(3)="30% extra Explosives damage|40% resistance to Explosives|60% increase in grenade capacity|Can carry 5 Remote Explosives|40% discount on Explosives|62% off Remote Explosives"
	SRLevelEffects(4)="40% extra Explosives damage|45% resistance to Explosives|80% increase in grenade capacity|Can carry 6 Remote Explosives|50% discount on Explosives|66% off Remote Explosives"
	SRLevelEffects(5)="50% extra Explosives damage|50% resistance to Explosives|100% increase in grenade capacity|Can carry 7 Remote Explosives|60% discount on Explosives|70% off Remote Explosives|Spawn with a Pipe Bomb"
	SRLevelEffects(6)="60% extra Explosives damage|55% resistance to Explosives|120% increase in grenade capacity|Can carry 8 Remote Explosives|70% discount on Explosives|74% off Remote Explosives|Spawn with an M79 and Pipe Bomb"
	CustomLevelInfo="%s extra Explosives damage|%r resistance to Explosives|120% increase in grenade capacity|Can carry %x Remote Explosives|%y discount on Explosives|%d off Remote Explosives|Spawn with an M79 and Pipe Bomb"
}

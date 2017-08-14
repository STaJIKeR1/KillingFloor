class SRVetSupportSpec extends SRVeterancyTypes
	abstract;

static function int GetPerkProgressInt( ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum )
{
	switch( CurLevel )
	{
        
        case 0:
            FinalInt = 5000;
            break;        
        case 1:
            FinalInt = 18750;           
            break;        
        case 2:
            FinalInt = 37500;            
            break;        
        case 3:
            FinalInt = 75000;
            break;
        case 4:
            FinalInt = 150000;
            break;
        case 5:
            FinalInt = 312500;
            break;
        case 6:
            FinalInt = 625000;
            break;
        case 7:
            FinalInt = 1250000;
            break;
        case 8:
            FinalInt = 2500000;
            break;
        case 9:
            FinalInt = 5000000;
            break;
        case 10:
            FinalInt = 7500000;
            break;
        case 11:
            FinalInt = 10000000;
            break;
        case 12:
            FinalInt = 17000000;
            break;
        case 13:
            FinalInt = 24000000;
            break;
        case 14:
            FinalInt = 31000000;
            break;
        case 15:
            FinalInt = 38000000;
            break;
        case 16:
            FinalInt = 48000000;
            break;
        case 17:
            FinalInt = 58000000;
            break;
        case 18:
            FinalInt = 68000000;
            break;
        case 19:
            FinalInt = 78000000;
            break;
        case 20:
            FinalInt = 88000000;
            break;
        case 21:
            FinalInt = 103000000;
            break;
        case 22:
            FinalInt = 119000000;
            break;
        case 23:
            FinalInt = 136000000;
            break;
        case 24:
            FinalInt = 154000000;
            break;
        case 25:
            FinalInt = 173000000;
            break;
        case 26:
            FinalInt = 193000000;
            break;
        case 27:
            FinalInt = 214000000;
            break;
        case 28:
            FinalInt = 236000000;
            break;
        case 29:
            FinalInt = 259000000;
            break;
        case 30:
            FinalInt = 283000000;
            break;
        case 31:
            FinalInt = 308000000;
            break;
        case 32:
            FinalInt = 338000000;
            break;
        case 33:
            FinalInt = 368000000;
            break;
        case 34:
            FinalInt = 398000000;
            break;
        case 35:
            FinalInt = 428000000;
            break;
        case 36:
            FinalInt = 458000000;
            break;
        case 37:
            FinalInt = 488000000;
            break;
        case 38:
            FinalInt = 518000000;
            break;
        case 39:
            FinalInt = 558000000;
            break;
        case 40:
            FinalInt = 600000000;
            break;
        case 41:
            FinalInt = 1350000000;
            break;
        default:
            FinalInt = 5500000 + GetDoubleScaling(CurLevel, 500000);
        
    }
	return Min(StatOther.RShotgunDamageStat,FinalInt);
}

	//Add Extra Carry Weight modify
static function int AddCarryMaxWeight(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel >=0 && KFPRI.ClientVeteranSkillLevel <= 5 )
		return 0;
	if ( KFPRI.ClientVeteranSkillLevel >=6 && KFPRI.ClientVeteranSkillLevel <= 10 )
		return 4;
	if ( KFPRI.ClientVeteranSkillLevel >=11 && KFPRI.ClientVeteranSkillLevel <= 15 )
		return 6;
	if ( KFPRI.ClientVeteranSkillLevel >=16 && KFPRI.ClientVeteranSkillLevel <= 20 )
		return 10;
	if ( KFPRI.ClientVeteranSkillLevel >= 21 && KFPRI.ClientVeteranSkillLevel <= 25 )
		return 14;
	if ( KFPRI.ClientVeteranSkillLevel >= 26 && KFPRI.ClientVeteranSkillLevel <= 30 )
		return 18;
	if ( KFPRI.ClientVeteranSkillLevel >= 31 && KFPRI.ClientVeteranSkillLevel <= 35 )
		return 22;
	if ( KFPRI.ClientVeteranSkillLevel >= 36 && KFPRI.ClientVeteranSkillLevel <= 40 )
		return 26;
	if ( KFPRI.ClientVeteranSkillLevel >= 41 )
		return 26;	
	return 20;
}

	//Weld speed
static function float GetWeldSpeedModifier(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel <=0)
		return 2.00;
	return 2.00 + (0.10 * float(KFPRI.ClientVeteranSkillLevel)); 
}
	//Mag Capacity
static function float GetMagCapacityMod(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
   if ((GoldenAA12AutoShotgun(Other) != none || GoldenBenelliShotgun(Other) != none)
		&& KFPRI.ClientVeteranSkillLevel > 0 )
		{
		if ( KFPRI.ClientVeteranSkillLevel > 0)
		return 2.50 + (0.02 * float(KFPRI.ClientVeteranSkillLevel));
		return 0.00;
		}
		if ((AA12AutoShotgun(Other) != none || BenelliShotgun(Other) != none ||CamoShotgun(Other) != none 
        || Shotgun(Other) != none|| BenelliShotgun(Other) != none || SPAutoShotgun(Other) != none || KSGShotgun (Other) != none
		|| NailGun(Other) != none)
		&& KFPRI.ClientVeteranSkillLevel > 0 )
	 {
		if ( KFPRI.ClientVeteranSkillLevel == 1 )
			return 1.00;
		return 1.0 + (0.01 * float(KFPRI.ClientVeteranSkillLevel)); 
		}
	return 1.0;
}

static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType)
{
	if ( AmmoType == class'FragAmmo' )
		return 1.0 + (0.25 * float(KFPRI.ClientVeteranSkillLevel));
	
	if ( AmmoType == class'ShotgunAmmo' || AmmoType == class'DBShotgunAmmo' || AmmoType == class'AA12Ammo'
        || AmmoType == class'BenelliAmmo' || AmmoType == class'KSGAmmo' || AmmoType == class'NailGunAmmo'
        ||  AmmoType == class'SPShotgunAmmo' ||  AmmoType == class'CamoShotgunAmmo' || AmmoType == class'GoldenBenelliAmmo' || AmmoType == class'GoldenAA12Ammo' )
	{
		if ( KFPRI.ClientVeteranSkillLevel <= 6 )
			return 1.00;
		return  1.00 + (0.10 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 50% more damage with Nades
	}
	return 1.0;
}

//reload speed
static function float GetReloadSpeedModifier(KFPlayerReplicationInfo KFPRI, KFWeapon Other) // Скорость перезарядки
{
	if ( KFPRI.ClientVeteranSkillLevel >=0 && KFPRI.ClientVeteranSkillLevel <= 5 )
		return 1.00;
	if ( KFPRI.ClientVeteranSkillLevel >=6 && KFPRI.ClientVeteranSkillLevel <= 10 )
		return 1.15;
	if ( KFPRI.ClientVeteranSkillLevel >=11 && KFPRI.ClientVeteranSkillLevel <= 15 )
		return 1.30;
	if ( KFPRI.ClientVeteranSkillLevel >=16 && KFPRI.ClientVeteranSkillLevel <= 20 )
		return 1.45;
	if ( KFPRI.ClientVeteranSkillLevel >= 21 && KFPRI.ClientVeteranSkillLevel <= 25 )
		return 1.60;
	if ( KFPRI.ClientVeteranSkillLevel >= 26 && KFPRI.ClientVeteranSkillLevel <= 30 )
		return 1.75;
	if ( KFPRI.ClientVeteranSkillLevel >= 31 && KFPRI.ClientVeteranSkillLevel <= 35 )
		return 1.90;
	if ( KFPRI.ClientVeteranSkillLevel >= 36 && KFPRI.ClientVeteranSkillLevel <= 40 )
		return 2.05;
	if ( KFPRI.ClientVeteranSkillLevel >= 41 )
		return 2.20;	
	return 2.20;
}


static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeShotgun' || DmgType == class'DamTypeDBShotgun' || DmgType == class'DamTypeAA12Shotgun'
        || DmgType == class'DamTypeBenelli' || DmgType == class'DamTypeKSGShotgun' || DmgType == class'DamTypeNailgun'
        || DmgType == class'DamTypeSPShotgun' )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 1.00;
		return InDamage * (1.50 + (0.050 * float(KFPRI.ClientVeteranSkillLevel))); // Up to 60% more damage with Shotguns
	}
	if ( DmgType == class'DamTypeFrag' && KFPRI.ClientVeteranSkillLevel > 0 )
	{
		if ( KFPRI.ClientVeteranSkillLevel <= 6 )
			return float(InDamage) * 1.00;
		return float(InDamage) * (1.00 + (0.050 * float(KFPRI.ClientVeteranSkillLevel))); // Up to 50% more damage with Nades
	}
	return InDamage;
}

// Reduce Penetration damage with Shotgun slower
static function float GetShotgunPenetrationDamageMulti(KFPlayerReplicationInfo KFPRI, float DefaultPenDamageReduction)
{
	local float PenDamageInverse;

	PenDamageInverse = 1.0 - FMax(0,DefaultPenDamageReduction);

	if ( KFPRI.ClientVeteranSkillLevel == 0 )
		return DefaultPenDamageReduction + (PenDamageInverse / 10.0);

	return DefaultPenDamageReduction + ((PenDamageInverse / 5.5555) * float(Min(KFPRI.ClientVeteranSkillLevel, 5)));
}

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'ShotgunPickup' || Item == class'BoomstickPickup' || Item == class'AA12Pickup'
        || Item == class'BenelliPickup' || Item == class'KSGPickup' || Item == class'NailGunPickup'
        || Item == class'GoldenBenelliPickup' || Item == class'SPShotgunPickup' || Item == class'GoldenAA12Pickup'
        || Item == class'CamoShotgunPickup' )
		return FMax(0.9 - (0.10 * float(KFPRI.ClientVeteranSkillLevel)),0.1f); // Up to 70% discount on Shotguns
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


// Give Extra Items as Default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	if ( KFPRI.ClientVeteranSkillLevel >=0 && KFPRI.ClientVeteranSkillLevel <= 5  )
    {
		AddPerkedWeapon(class'Shotgun',KFPRI,P);
		P.ShieldStrength = 0;
    }
  	if  ( KFPRI.ClientVeteranSkillLevel >=6 && KFPRI.ClientVeteranSkillLevel <= 10  )
    {
		AddPerkedWeapon(class'KSGShotgun',KFPRI,P);
		AddPerkedWeapon(class'Shotgun',KFPRI,P);
		P.ShieldStrength = 25;
    }
    	if ( KFPRI.ClientVeteranSkillLevel >=11 && KFPRI.ClientVeteranSkillLevel <= 20  )
    {
		AddPerkedWeapon(class'KSGShotgun',KFPRI,P );
		AddPerkedWeapon(class'BoomStick',KFPRI,P);
		AddPerkedWeapon(class'Shotgun',KFPRI,P);
		P.ShieldStrength = 50;
    }
    	if ( KFPRI.ClientVeteranSkillLevel >=21 && KFPRI.ClientVeteranSkillLevel <= 30  )
    {
		AddPerkedWeapon(class'KSGShotgun',KFPRI,P );
		AddPerkedWeapon(class'BoomStick',KFPRI,P);
		AddPerkedWeapon(class'Shotgun',KFPRI,P);
		AddPerkedWeapon(class'AA12AutoShotgun',KFPRI,P);
		P.ShieldStrength = 75;
    }
    	if ( KFPRI.ClientVeteranSkillLevel >=31 && KFPRI.ClientVeteranSkillLevel <= 40 )
    {
		AddPerkedWeapon(class'GoldenAA12AutoShotgun',KFPRI,P );
		AddPerkedWeapon(class'GoldenBenelliShotgun',KFPRI,P);
		AddPerkedWeapon(class'KSGShotgun',KFPRI,P);
		AddPerkedWeapon(class'BoomStick',KFPRI,P);
		P.ShieldStrength = 100;
    }
	if ( KFPRI.ClientVeteranSkillLevel >=41 && KFPRI.ClientVeteranSkillLevel <= 41 )
    {
		AddPerkedWeapon(class'GoldenAA12AutoShotgun',KFPRI,P );
		AddPerkedWeapon(class'GoldenBenelliShotgun',KFPRI,P);
		AddPerkedWeapon(class'KSGShotgun',KFPRI,P);
		AddPerkedWeapon(class'BoomStick',KFPRI,P);
		P.ShieldStrength = 150;
    }	
}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	ReplaceText(S,"%s",GetPercentStr(0.1 * float(Level)));
	ReplaceText(S,"%g",GetPercentStr(0.1*float(Level)-0.1f));
	ReplaceText(S,"%d",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f)));
	return S;
}

defaultproperties
{
	PerkIndex=1

	OnHUDIcon=Texture'KillingFloorHUD.Perks.Perk_Support'
	OnHUDGoldIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_Support_Gold'
	VeterancyName="Специалист поддержки"
	Requirements[2]="Нанести %x урона дробовиками"
	NumRequirements=1

	SRLevelEffects(0)="10% more damage with Shotguns|10% better Shotgun penetration|10% faster welding/unwelding|10% discount on Shotguns"
	SRLevelEffects(1)="10% more damage with Shotguns|18% better Shotgun penetration|10% extra shotgun ammo|5% more damage with Grenades|20% increase in grenade capacity|15% increased carry weight|25% faster welding/unwelding|20% discount on Shotguns"
	SRLevelEffects(2)="20% more damage with Shotguns|36% better Shotgun penetration|20% extra shotgun ammo|10% more damage with Grenades|40% increase in grenade capacity|20% increased carry weight|50% faster welding/unwelding|30% discount on Shotguns"
	SRLevelEffects(3)="30% more damage with Shotguns|54% better Shotgun penetration|25% extra shotgun ammo|20% more damage with Grenades|60% increase in grenade capacity|25% increased carry weight|75% faster welding/unwelding|40% discount on Shotguns"
	SRLevelEffects(4)="40% more damage with Shotguns|72% better Shotgun penetration|25% extra shotgun ammo|30% more damage with Grenades|80% increase in grenade capacity|30% increased carry weight|100% faster welding/unwelding|50% discount on Shotguns"
	SRLevelEffects(5)="50% more damage with Shotguns|90% better Shotgun penetration|25% extra shotgun ammo|40% more damage with Grenades|100% increase in grenade capacity|50% increased carry weight|150% faster welding/unwelding|60% discount on Shotguns|Spawn with a Shotgun"
	SRLevelEffects(6)="60% more damage with Shotguns|90% better Shotgun penetration|30% extra shotgun ammo|50% more damage with Grenades|120% increase in grenade capacity|60% increased carry weight|150% faster welding/unwelding|70% discount on Shotguns|Spawn with a Hunting Shotgun"
	CustomLevelInfo="%s more damage with Shotguns|90% better Shotgun penetration|30% extra shotgun ammo|%g more damage with Grenades|120% increase in grenade capacity|%s increased carry weight|150% faster welding/unwelding|%d discount on Shotguns|Spawn with a Hunting Shotgun"
}

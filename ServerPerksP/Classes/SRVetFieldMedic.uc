class SRVetFieldMedic extends SRVeterancyTypes
	abstract;

static function int GetPerkProgressInt(ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum)
{
    switch(CurLevel)
    {
        case 0:
            FinalInt = 50;
            break;
        case 1:
            FinalInt = 187;
            break;
        case 2:
            FinalInt = 375;
            break;
        case 3:
            FinalInt = 750;
            break;
        case 4:
            FinalInt = 1500;
            break;
        case 5:
            FinalInt = 3125;
            break;
        case 6:
            FinalInt = 6250;
            break;
        case 7:
            FinalInt = 12500;
            break;
        case 8:
            FinalInt = 25000;
            break;
        case 9:
            FinalInt = 50000;
            break;
        case 10:
            FinalInt = 75000;
            break;
        case 11:
            FinalInt = 100000;
            break;
        case 12:
            FinalInt = 170000;
            break;
        case 13:
            FinalInt = 240000;
            break;
        case 14:
            FinalInt = 310000;
            break;
        case 15:
            FinalInt = 380000;
            break;
        case 16:
            FinalInt = 480000;
            break;
        case 17:
            FinalInt = 580000;
            break;
        case 18:
            FinalInt = 680000;
            break;
        case 19:
            FinalInt = 780000;
            break;
        case 20:
            FinalInt = 880000;
            break;
        case 21:
            FinalInt = 1030000;
            break;
        case 22:
            FinalInt = 1190000;
            break;
        case 23:
            FinalInt = 1360000;
            break;
        case 24:
            FinalInt = 1540000;
            break;
        case 25:
            FinalInt = 1730000;
            break;
        case 26:
            FinalInt = 1930000;
            break;
        case 27:
            FinalInt = 2140000;
            break;
        case 28:
            FinalInt = 2360000;
            break;
        case 29:
            FinalInt = 2590000;
            break;
        case 30:
            FinalInt = 2830000;
            break;
        case 31:
            FinalInt = 3080000;
            break;
        case 32:
            FinalInt = 3380000;
            break;
        case 33:
            FinalInt = 3680000;
            break;
        case 34:
            FinalInt = 3980000;
            break;
        case 35:
            FinalInt = 4280000;
            break;
        case 36:
            FinalInt = 4580000;
            break;
        case 37:
            FinalInt = 4880000;
            break;
        case 38:
            FinalInt = 5180000;
            break;
        case 39:
            FinalInt = 5580000;
            break;
        case 40:
            FinalInt = 6000000;
            break;
        case 41:
            FinalInt = 12500000;
            break;
        default:
            FinalInt = 100000 + GetDoubleScaling(CurLevel, 20000);
    }
	return Min(StatOther.RDamageHealedStat,FinalInt);
}

static function class<Grenade> GetNadeType(KFPlayerReplicationInfo KFPRI)
{
	return class'MedicNade'; // Grenade detonations heal nearby teammates, and cause enemies to be poisoned
}

	//Syringe Charge Rate
static function float GetSyringeChargeRate(KFPlayerReplicationInfo KFPRI)
{
	return 1.50 + (0.10 * float(KFPRI.ClientVeteranSkillLevel)); 
}

	//Heal Potency
static function float GetHealPotency(KFPlayerReplicationInfo KFPRI)
{
	 return 1.50 + (0.05 * float(KFPRI.ClientVeteranSkillLevel));  
}

static function float GetMovementSpeedModifier(KFPlayerReplicationInfo KFPRI, KFGameReplicationInfo KFGRI)
{
	if ( KFPRI.ClientVeteranSkillLevel <= 5 )
	{
		return 1.0;
	}
	return 1.00 + 0.04*float(KFPRI.ClientVeteranSkillLevel); 
}

	//Reduce Damage Vomit and add damage with Husk Weapon
static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, Pawn Instigator, int InDamage, class<DamageType> DmgType)
{	
	local float retval;
	if ( DmgType == class'DamTypeVomit' )
	{
		if ( KFPRI.ClientVeteranSkillLevel <= 4 )
			return float(InDamage) * 0.75;
		else if ( KFPRI.ClientVeteranSkillLevel >= 5 && KFPRI.ClientVeteranSkillLevel <= 10 )
			return float(InDamage) * 0.50;
		else if ( KFPRI.ClientVeteranSkillLevel >= 11 && KFPRI.ClientVeteranSkillLevel <= 19 )
			return float(InDamage) * 0.25;
		else if ( KFPRI.ClientVeteranSkillLevel >= 20 && KFPRI.ClientVeteranSkillLevel <= 21 )
			return float(InDamage) * 0.01; // 100% decrease in damage from Bloat's Bile
		return float(InDamage) * 0.01; // 100% decrease in damage from Bloat's Bile
	}
	return InDamage;		
	if	((DmgType == class'DamTypeHuskGunProjectileImpact' || DmgType == class'DamTypeFlareProjectileImpact')
		&&	Injured.ShieldStrength > 0) // C броней
{ 
	if ( KFPRI.ClientVeteranSkillLevel <= 5 ) 
		retval = float(InDamage) * 1.00; 
	else if ( KFPRI.ClientVeteranSkillLevel >= 6 && KFPRI.ClientVeteranSkillLevel <= 10 ) 
		retval = float(InDamage) * 1.50; 
	else if ( KFPRI.ClientVeteranSkillLevel >= 11 && KFPRI.ClientVeteranSkillLevel <= 15 ) 
		retval = float(InDamage) * 2.00;
	else if ( KFPRI.ClientVeteranSkillLevel >= 16 && KFPRI.ClientVeteranSkillLevel <= 20 ) 
		retval = float(InDamage) * 2.50;
	else if ( KFPRI.ClientVeteranSkillLevel >= 21 && KFPRI.ClientVeteranSkillLevel <= 25 ) 
		retval = float(InDamage) * 3.00;
	else if ( KFPRI.ClientVeteranSkillLevel >= 26 && KFPRI.ClientVeteranSkillLevel <= 30 ) 
		retval = float(InDamage) * 3.50;
	else if ( KFPRI.ClientVeteranSkillLevel >= 31 && KFPRI.ClientVeteranSkillLevel <= 35 ) 
		retval = float(InDamage) * 4.00;
	else if ( KFPRI.ClientVeteranSkillLevel >= 36 && KFPRI.ClientVeteranSkillLevel <= 40 ) 
		retval = float(InDamage) * 4.50;
	else if ( KFPRI.ClientVeteranSkillLevel >= 41 && KFPRI.ClientVeteranSkillLevel <= 41 ) 
		retval = float(InDamage) * 5.00; 
} 
	if (DmgType == class'DamTypeHuskGunProjectileImpact' || DmgType == class'DamTypeFlareProjectileImpact' ||
	class<KFWeaponDamageType>(DmgType) != none && class<KFWeaponDamageType>(DmgType).default.bDealBurningDamage && Injured.ShieldStrength <= 0) //без брони
{ 
	retval /= GetBodyArmorDamageModifier(KFPRI); 
} 
return retval; 
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
    else
    {
        if(Level > 39)
        {
            Ret += float(100);
        }
        else
        {
            if(Level > 35)
            {
                Ret += float(80);
            }
            else
            {
                if(Level > 30)
                {
                    Ret += float(60);
                }
                else
                {
                    if(Level > 25)
                    {
                        Ret += float(40);
                    }
                    else
                    {
                        if(Level > 20)
                        {
                            Ret += float(20);
                        }
                    }
                }
            }
        }
    }
    return int(Ret);   
}



	//Get Mag Capacity Mod
static function float GetMagCapacityMod(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( (MP7MMedicGun(Other) != none || MP5MMedicGun(Other) != none || M7A3MMedicGun(Other) != none
        || KrissMMedicGun(Other) != none || BlowerThrower(Other) != none )
        && KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.00 + 0.025 * float(KFPRI.ClientVeteranSkillLevel); // 100% increase in MP7 Medic weapon ammo carry	
	return 1.0;
}

	//Add Extra Ammo For
static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType)
{
	if (( AmmoType == class'FragAmmo' )
		&& KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + 0.25 * KFPRI.ClientVeteranSkillLevel;
	if (( AmmoType == class'MP7MAmmo' || AmmoType == class'MP5MAmmo' || AmmoType == class'M7A3MAmmo'
        || AmmoType == class'KrissMAmmo' || AmmoType == class'CamoMP5MAmmo'|| AmmoType == class'NeonKrissMAmmo' || AmmoType == class'GrenadePistolLLIAmmo'  )
		&& KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + 0.10 * KFPRI.ClientVeteranSkillLevel; 
	if ((AmmoType == class'BlowerThrowerAmmo')
		&& KFPRI.ClientVeteranSkillLevel > 0)
		return 1.0 + 0.30 * KFPRI.ClientVeteranSkillLevel; 
	return 1.0;
}

	//Ammo Pickup Mod
static function float GetAmmoPickupMod(KFPlayerReplicationInfo KFPRI, KFAmmunition Other)
{
	if ( (MP7MAmmo(Other) != none || MP5MAmmo(Other) != none || M7A3MAmmo(Other) != none 
        || KrissMAmmo(Other) != none || BlowerThrowerAmmo(Other) != none || CamoMP5MAmmo(Other) != none || NeonKrissMAmmo(Other) != none) 
		&& KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + 0.20 * KFPRI.ClientVeteranSkillLevel;  
	return 1.0;
}

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'Vest' )
		return FMax(0.9 - (0.10 * float(KFPRI.ClientVeteranSkillLevel)),0.1f);  // Up to 70% discount on Body Armor
	if ( Item == class'MP7MPickup' || Item == class'MP5MPickup' || Item == class'M7A3MPickup'
        || Item == class'KrissMPickup' || Item == class'BlowerThrowerPickup' || Item == class'CamoMP5MPickup' )
		return FMax(0.25 - (0.02 * float(KFPRI.ClientVeteranSkillLevel)),0.02f);  // Up to 87% discount on Medic Gun
	return 1.0;
}

// Reduce damage when wearing Armor
static function float GetBodyArmorDamageModifier(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel == 0 && KFPRI.ClientVeteranSkillLevel <= 1 )
		return 0.90;
	else if ( KFPRI.ClientVeteranSkillLevel >= 2 && KFPRI.ClientVeteranSkillLevel <= 3 )
		return 0.80;
	else if ( KFPRI.ClientVeteranSkillLevel >= 4 && KFPRI.ClientVeteranSkillLevel <= 5 )
		return 0.70;
	else if ( KFPRI.ClientVeteranSkillLevel >= 6 && KFPRI.ClientVeteranSkillLevel <= 7 )
		return 0.60;
	else if ( KFPRI.ClientVeteranSkillLevel >= 8 && KFPRI.ClientVeteranSkillLevel <= 9 )
		return 0.40;
	else if ( KFPRI.ClientVeteranSkillLevel >= 10 && KFPRI.ClientVeteranSkillLevel <= 11 )
		return 0.35;
	else if ( KFPRI.ClientVeteranSkillLevel >= 12 && KFPRI.ClientVeteranSkillLevel <= 13 )
		return 0.30;
	else if ( KFPRI.ClientVeteranSkillLevel >= 14 && KFPRI.ClientVeteranSkillLevel <= 15 )
		return 0.25;
	else if ( KFPRI.ClientVeteranSkillLevel >= 16 && KFPRI.ClientVeteranSkillLevel <= 17 )
		return 0.20;
	else if ( KFPRI.ClientVeteranSkillLevel >= 18 && KFPRI.ClientVeteranSkillLevel <= 19 )
		return 0.15;
	else if ( KFPRI.ClientVeteranSkillLevel == 20 )
		return 0.10;
	else if ( KFPRI.ClientVeteranSkillLevel >= 21 )
		return 0.05;    
    return 0.05; // Level 13 - 95% Better Body Armor
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


	// Give Extra Items as Default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	//Armor Respawn
	// give armor with lvl client
	if ( KFPRI.ClientVeteranSkillLevel >=0 && KFPRI.ClientVeteranSkillLevel <= 5 )
		P.ShieldStrength = 0;
	if ( KFPRI.ClientVeteranSkillLevel >=6 && KFPRI.ClientVeteranSkillLevel <= 10  )
		P.ShieldStrength = 50;
	if ( KFPRI.ClientVeteranSkillLevel >=11 && KFPRI.ClientVeteranSkillLevel <= 15 )
		P.ShieldStrength = 75;
	if ( KFPRI.ClientVeteranSkillLevel >=16 && KFPRI.ClientVeteranSkillLevel <= 20 )
		P.ShieldStrength = 100;
	if ( KFPRI.ClientVeteranSkillLevel >= 21 && KFPRI.ClientVeteranSkillLevel <= 41 )
		P.ShieldStrength = 200;
	// If Level 0-6, give them a Medic Gun
	if ( KFPRI.ClientVeteranSkillLevel <= 6 )
		AddPerkedWeapon(class'MP7MMedicGun',KFPRI,P);
	if ( KFPRI.ClientVeteranSkillLevel >= 7 )
		AddPerkedWeapon(class'MP5MMedicGun',KFPRI,P);
	if ( KFPRI.ClientVeteranSkillLevel >= 16 )
		AddPerkedWeapon(class'M7A3MMedicGun',KFPRI,P);
}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	ReplaceText(S,"%s",GetPercentStr(2.4 + (0.1 * float(Level))));
	ReplaceText(S,"%d",GetPercentStr(FMin(0.1 + 0.1 * float(Level),0.9f)));
	ReplaceText(S,"%m",GetPercentStr(FMin(0.75+0.02 * float(Level),0.98f)));
	ReplaceText(S,"%r",GetPercentStr(FMin(0.05 * float(Level-2),0.55f)));
	return S;
}

defaultproperties
{
	PerkIndex=0

	OnHUDIcon=Texture'KillingFloorHUD.Perks.Perk_Medic'
	OnHUDGoldIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_Medic_Gold'
	VeterancyName="Полевой медик"
	Requirements[0]="Вылечить %x жизней команды"

	SRLevelEffects(0)="10% faster Syringe recharge|10% more potent healing|10% less damage from Bloat Bile|10% better Body Armor|10% discount on Body Armor|75% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 20% Body Armor and MP7M Medic Gun"
	SRLevelEffects(1)="25% faster Syringe recharge|10% more potent healing|25% less damage from Bloat Bile|20% larger Medic Gun clips|10% better Body Armor|20% discount on Body Armor|77% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn 20% with Body Armor and MP7M Medic Gun"
	SRLevelEffects(2)="50% faster Syringe recharge|20% more potent healing|50% less damage from Bloat Bile|5% faster movement speed|40% larger Medic Gun clips|20% better Body Armor|30% discount on Body Armor|79% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 20% Body Armor and MP7M Medic Gun"
	SRLevelEffects(3)="75% faster Syringe recharge|20% more potent healing|50% less damage from Bloat Bile|10% faster movement speed|60% larger Medic Gun clips|20% better Body Armor|40% discount on Body Armor|81% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 20% Body Armor and MP7M Medic Gun"
	SRLevelEffects(4)="100% faster Syringe recharge|50% more potent healing|50% less damage from Bloat Bile|15% faster movement speed|80% larger Medic Gun clips|30% better Body Armor|50% discount on Body Armor|83% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 20% Body Armor and MP7M Medic Gun"
	SRLevelEffects(5)="150% faster Syringe recharge|50% more potent healing|75% less damage from Bloat Bile|20% faster movement speed|100% larger Medic Gun clips|30% better Body Armor|60% discount on Body Armor|85% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 50% Body Armor and MP7M Medic Gun"
	SRLevelEffects(6)="200% faster Syringe recharge|75% more potent healing|75% less damage from Bloat Bile|25% faster movement speed|100% larger Medic Gun clips|40% better Body Armor|70% discount on Body Armor|87% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 50% Body Armor and MP7M Medic Gun"
	SRLevelEffects(7)="200% faster Syringe recharge|75% more potent healing|75% less damage from Bloat Bile|25% faster movement speed|100% larger Medic Gun clips|40% better Body Armor|70% discount on Body Armor|87% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 50% Body Armor and MP5M Medic Gun"
	SRLevelEffects(8)="200% faster Syringe recharge|90% more potent healing|75% less damage from Bloat Bile|25% faster movement speed|100% larger Medic Gun clips|60% better Body Armor|70% discount on Body Armor|87% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 50% Body Armor and MP5M Medic Gun"
	SRLevelEffects(9)="200% faster Syringe recharge|90% more potent healing|75% less damage from Bloat Bile|25% faster movement speed|100% larger Medic Gun clips|60% better Body Armor|70% discount on Body Armor|87% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 50% Body Armor and MP5M Medic Gun"
	SRLevelEffects(10)="200% faster Syringe recharge|110% more potent healing|75% less damage from Bloat Bile|25% faster movement speed|100% larger Medic Gun clips|65% better Body Armor|70% discount on Body Armor|87% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 50% Body Armor and MP5M Medic Gun"
	SRLevelEffects(11)="200% faster Syringe recharge|110% more potent healing|75% less damage from Bloat Bile|25% faster movement speed|100% larger Medic Gun clips|65% better Body Armor|70% discount on Body Armor|87% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 75% Body Armor and MP5M Medic Gun"
	SRLevelEffects(12)="200% faster Syringe recharge|120% more potent healing|75% less damage from Bloat Bile|25% faster movement speed|100% larger Medic Gun clips|70% better Body Armor|70% discount on Body Armor|87% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 75% Body Armor and MP5M Medic Gun"
	SRLevelEffects(13)="200% faster Syringe recharge|120% more potent healing|75% less damage from Bloat Bile|25% faster movement speed|100% larger Medic Gun clips|70% better Body Armor|70% discount on Body Armor|87% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 75% Body Armor and MP5M Medic Gun"
	SRLevelEffects(14)="200% faster Syringe recharge|130% more potent healing|75% less damage from Bloat Bile|25% faster movement speed|100% larger Medic Gun clips|75% better Body Armor|70% discount on Body Armor|87% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 75% Body Armor and MP5M Medic Gun"
	SRLevelEffects(15)="200% faster Syringe recharge|130% more potent healing|75% less damage from Bloat Bile|25% faster movement speed|100% larger Medic Gun clips|75% better Body Armor|70% discount on Body Armor|87% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 75% Body Armor and MP5M Medic Gun"
	SRLevelEffects(16)="200% faster Syringe recharge|140% more potent healing|75% less damage from Bloat Bile|25% faster movement speed|100% larger Medic Gun clips|80% better Body Armor|70% discount on Body Armor|87% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 100% Body Armor and MP5M Medic Gun"
	SRLevelEffects(17)="200% faster Syringe recharge|140% more potent healing|75% less damage from Bloat Bile|25% faster movement speed|100% larger Medic Gun clips|80% better Body Armor|70% discount on Body Armor|87% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 100% Body Armor and M7A3M, MP5M Medic Gun"
	SRLevelEffects(18)="200% faster Syringe recharge|150% more potent healing|75% less damage from Bloat Bile|25% faster movement speed|100% larger Medic Gun clips|85% better Body Armor|70% discount on Body Armor|87% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 100% Body Armor and M7A3M, MP5M Medic Gun"
	SRLevelEffects(19)="200% faster Syringe recharge|150% more potent healing|75% less damage from Bloat Bile|25% faster movement speed|100% larger Medic Gun clips|85% better Body Armor|70% discount on Body Armor|87% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 100% Body Armor and M7A3M, MP5M Medic Gun"
	SRLevelEffects(20)="200% faster Syringe recharge|170% more potent healing|100% less damage from Bloat Bile|25% faster movement speed|100% larger Medic Gun clips|90% better Body Armor|70% discount on Body Armor|87% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 120% Body Armor and M7A3M, MP5M Medic Gun"
	SRLevelEffects(21)="200% faster Syringe recharge|200% more potent healing|100% less damage from Bloat Bile|25% faster movement speed|100% larger Medic Gun clips|95% better Body Armor|70% discount on Body Armor|87% discount on Medic Guns|Grenades heal teammates and hurt enemies|Fire inflicts increased damage x4.5|Spawn with 150% Body Armor and M7A3M, MP5M Medic Gun"
}
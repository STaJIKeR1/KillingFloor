class SRVetBerserker extends SRVeterancyTypes
	abstract;

static function int GetPerkProgressInt(ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum)
{
    switch(CurLevel)
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
	return Min(StatOther.RMeleeDamageStat,FinalInt);
}

static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	local class<KFWeaponDamageType> MyDmgType;    
	MyDmgType = class<KFWeaponDamageType>(DmgType);    
	if(MyDmgType != None && MyDmgType.default.bIsMeleeDamage)
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 2;
		return float(InDamage) * 2; // 200% damage
	}
	return InDamage;
}

static function float GetHeadShotDamMulti(KFPlayerReplicationInfo KFPRI, KFPawn P, class<DamageType> DmgType)
{
    local class<KFWeaponDamageType> MyDmgType;    
	MyDmgType = class<KFWeaponDamageType>(DmgType);    
	if(MyDmgType != None && MyDmgType.default.bIsMeleeDamage)
    {
        return 1.0 + (float(KFPRI.ClientVeteranSkillLevel - 1) * 0.025);
    }
    return 1.0;
}

static function bool CanMeleeStun()
{
	return true;
}

static function float GetFireSpeedMod(KFPlayerReplicationInfo KFPRI, Weapon Other)
{
	if ( KFMeleeGun(Other) != none || Crossbuzzsaw(Other) != none )
	{
		switch ( KFPRI.ClientVeteranSkillLevel )
		{
			case 1:
				return 1.00;
			default:
				return 1.00 + 0.025*float(KFPRI.ClientVeteranSkillLevel);
		}
	}

	return 1.00;
}

static function float GetMeleeMovementSpeedModifier(KFPlayerReplicationInfo KFPRI)
{
	switch( KFPRI.ClientVeteranSkillLevel )
	{
	case 0:
		return 0.05; // Was 0.10 in Balance Round 1
	case 1:
		return 0.10; // Was 0.15 in Balance Round 1
	case 2:
		return 0.15; // Was 0.20 in Balance Round 1
	case 3:
	case 4:
	case 5:
		return 0.20; // Was 0.25 in Balance Round 1
	default:
		return 0.55; // Was 0.35 in Balance Round 1
	}
}

static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, Pawn Instigator, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeVomit' )
	{
		switch ( KFPRI.ClientVeteranSkillLevel )
		{
			case 0:
				return float(InDamage) * 0.90;
			case 1:
				return float(InDamage) * 0.75;
			case 2:
				return float(InDamage) * 0.65;
			case 3:
				return float(InDamage) * 0.50;
			case 4:
				return float(InDamage) * 0.35;
			case 5:
				return float(InDamage) * 0.25;
			default:
				return float(InDamage) * 0.20; // 80% reduced Bloat Bile damage
		}
	}
	return float(InDamage) * 0.20 ;
}

	//Heal Potency
static function float GetHealPotency(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel >=0 && KFPRI.ClientVeteranSkillLevel <= 5 )
		return 1.00;
	if ( KFPRI.ClientVeteranSkillLevel >=6 && KFPRI.ClientVeteranSkillLevel <= 10 )
		return 1.50;
	if ( KFPRI.ClientVeteranSkillLevel >=11 && KFPRI.ClientVeteranSkillLevel <= 15 )
		return 2.00;
	if ( KFPRI.ClientVeteranSkillLevel >=16 && KFPRI.ClientVeteranSkillLevel <= 20 )
		return 2.50;
	if ( KFPRI.ClientVeteranSkillLevel >= 21 && KFPRI.ClientVeteranSkillLevel <= 25 )
		return 3.00;
	if ( KFPRI.ClientVeteranSkillLevel >= 26 && KFPRI.ClientVeteranSkillLevel <= 30 )
		return 3.50;
	if ( KFPRI.ClientVeteranSkillLevel >= 31 && KFPRI.ClientVeteranSkillLevel <= 35 )
		return 4.00;
	if ( KFPRI.ClientVeteranSkillLevel >= 36 && KFPRI.ClientVeteranSkillLevel <= 40 )
		return 4.50;
	if ( KFPRI.ClientVeteranSkillLevel >= 41 )
		return 5.00;	
	return 1.00;
}

static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType)
{
	if (AmmoType == class' CrossbuzzsawAmmo' )
		return 1.0 + 0.15 * KFPRI.ClientVeteranSkillLevel;
	return 1.0;
}


static function bool CanBeGrabbed(KFPlayerReplicationInfo KFPRI, KFMonster Other)
{
	return !Other.IsA('ZombieClot');
}

// Set number times Zed Time can be extended
static function int ZedTimeExtensions(KFPlayerReplicationInfo KFPRI)
{
	return Min(KFPRI.ClientVeteranSkillLevel, 5);
}

	// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'ChainsawPickup' || Item == class'KatanaPickup' || Item == class'ClaymoreSwordPickup'
        || Item == class'CrossbuzzsawPickup' || Item == class'ScythePickup' || Item == class'GoldenKatanaPickup'
        || Item == class'MachetePickup' || Item == class'AxePickup' || Item == class'DwarfAxePickup'
        || Item == class'GoldenChainsawPickup' )
		return FMax(0.9 - (0.10 * float(KFPRI.ClientVeteranSkillLevel)),0.1); // Up to 70% discount on Melee Weapons
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
        Ret += float(200);
    }
    return int(Ret);
    //return;    
}


	// Give Extra Items as default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{	

	if ( KFPRI.ClientVeteranSkillLevel >= 0 && KFPRI.ClientVeteranSkillLevel <= 5  )
    {
		AddPerkedWeapon(class'Machete',KFPRI,P);
    }
  
  if  ( KFPRI.ClientVeteranSkillLevel >=6 && KFPRI.ClientVeteranSkillLevel <= 10  )
    {
		AddPerkedWeapon(class'Machete',KFPRI,P);
		AddPerkedWeapon(class'Scythe',KFPRI,P);
    }
    
	if ( KFPRI.ClientVeteranSkillLevel >=11 && KFPRI.ClientVeteranSkillLevel <= 15  )
    {
		AddPerkedWeapon(class'Machete',KFPRI,P );
		AddPerkedWeapon(class'Scythe',KFPRI,P);
		AddPerkedWeapon(class'Chainsaw',KFPRI,P);
    }
    
	if ( KFPRI.ClientVeteranSkillLevel >=16 && KFPRI.ClientVeteranSkillLevel <= 20  )
    {
		AddPerkedWeapon(class'Axe',KFPRI,P );
		AddPerkedWeapon(class'GoldenKatana',KFPRI,P);
		AddPerkedWeapon(class'Crossbuzzsaw',KFPRI,P);
		AddPerkedWeapon(class'GoldenChainsaw',KFPRI,P);
    }
    
	if ( KFPRI.ClientVeteranSkillLevel >= 21 && KFPRI.ClientVeteranSkillLevel <= 41  )
    {
		AddPerkedWeapon(class'Axe',KFPRI,P );
		AddPerkedWeapon(class'GoldenKatana',KFPRI,P);
		AddPerkedWeapon(class'Crossbuzzsaw',KFPRI,P);
		AddPerkedWeapon(class'GoldenChainsaw',KFPRI,P);  
  
    }
	 
	if ( KFPRI.ClientVeteranSkillLevel >=0 && KFPRI.ClientVeteranSkillLevel <= 5 )
		P.ShieldStrength = 0;
	if ( KFPRI.ClientVeteranSkillLevel >=6 && KFPRI.ClientVeteranSkillLevel <= 10 )
		P.ShieldStrength = 25;
	if ( KFPRI.ClientVeteranSkillLevel >=11 && KFPRI.ClientVeteranSkillLevel <= 20 )
		P.ShieldStrength = 50;
	if ( KFPRI.ClientVeteranSkillLevel >=21 && KFPRI.ClientVeteranSkillLevel <= 30)
		P.ShieldStrength = 100;
	if ( KFPRI.ClientVeteranSkillLevel >=31 && KFPRI.ClientVeteranSkillLevel <= 40)
		P.ShieldStrength = 150;
	if ( KFPRI.ClientVeteranSkillLevel >=41 && KFPRI.ClientVeteranSkillLevel <= 41)
		P.ShieldStrength = 200;
}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	ReplaceText(S,"%s",GetPercentStr(0.05 * float(Level)-0.05));
	ReplaceText(S,"%d",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f)));
	ReplaceText(S,"%r",GetPercentStr(0.7 + 0.05*float(Level)));
	ReplaceText(S,"%l",GetPercentStr(FMin(0.05*float(Level),0.65f)));
	return S;
}

defaultproperties
{
	PerkIndex=4

	OnHUDIcon=Texture'KillingFloorHUD.Perks.Perk_Berserker'
	OnHUDGoldIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_Berserker_Gold'
	VeterancyName="Берсерк"
	Requirements(0)="Нанести %x урона оружием ближнего боя"

	SRLevelEffects(0)="10% extra melee damage|5% faster melee movement|10% less damage from Bloat Bile|10% discount on melee weapons|Can't be grabbed by Clots"
	SRLevelEffects(1)="20% extra melee damage|5% faster melee attacks|10% faster melee movement|25% less damage from Bloat Bile|5% resistance to all damage|20% discount on melee weapons|Spawn with a Machete|Can't be grabbed by Clots"
	SRLevelEffects(2)="40% extra melee damage|10% faster melee attacks|15% faster melee movement|35% less damage from Bloat Bile|10% resistance to all damage|30% discount on melee weapons|Spawn with a Machete|Can't be grabbed by Clots|Zed-Time can be extended by killing an enemy while in slow motion"
	SRLevelEffects(3)="60% extra melee damage|10% faster melee attacks|20% faster melee movement|50% less damage from Bloat Bile|15% resistance to all damage|40% discount on melee weapons|Spawn with a Machete|Can't be grabbed by Clots|Up to 2 Zed-Time Extensions"
	SRLevelEffects(4)="80% extra melee damage|15% faster melee attacks|20% faster melee movement|65% less damage from Bloat Bile|20% resistance to all damage|50% discount on melee weapons|Spawn with a Machete|Can't be grabbed by Clots|Up to 3 Zed-Time Extensions"
	SRLevelEffects(5)="100% extra melee damage|20% faster melee attacks|20% faster melee movement|75% less damage from Bloat Bile|30% resistance to all damage|60% discount on melee weapons|Spawn with a Machete|Can't be grabbed by Clots|Up to 4 Zed-Time Extensions"
	SRLevelEffects(6)="100% extra melee damage|25% faster melee attacks|30% faster melee movement|80% less damage from Bloat Bile|40% resistance to all damage|70% discount on melee weapons|Spawn with an Axe and Body Armor|Can't be grabbed by Clots|Up to 4 Zed-Time Extensions"
	CustomLevelInfo="%r extra melee damage|%s faster melee attacks|30% faster melee movement|80% less damage from Bloat Bile|%l resistance to all damage|%d discount on melee weapons|Spawn with a Axe and Body Armor|Can't be grabbed by Clots|Up to 4 Zed-Time Extensions"
}
class SRVetCommando extends SRVeterancyTypes
	abstract;

static function int GetPerkProgressInt( ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum )
{
	switch(CurLevel)
    {
        case 0:
            if(ReqNum == 0)
            {
                FinalInt = 3;
            }
            else
            {
                FinalInt = 10000;
            }
            break;
        case 1:
            if(ReqNum == 0)
            {
                FinalInt = 3;
            }
            else
            {
                FinalInt = 15000;
            }
            break;
        case 2:
            if(ReqNum == 0)
            {
                FinalInt = 6;
            }
            else
            {
                FinalInt = 30000;
            }
            break;
        case 3:
            if(ReqNum == 0)
            {
                FinalInt = 12;
            }
            else
            {
                FinalInt = 60000;
            }
            break;
        case 4:
            if(ReqNum == 0)
            {
                FinalInt = 24;
            }
            else
            {
                FinalInt = 120000;
            }
            break;
        case 5:
            if(ReqNum == 0)
            {
                FinalInt = 50;
            }
            else
            {
                FinalInt = 250000;
            }
            break;
        case 6:
            if(ReqNum == 0)
            {
                FinalInt = 100;
            }
            else
            {
                FinalInt = 500000;
            }
            break;
        case 7:
            if(ReqNum == 0)
            {
                FinalInt = 200;
            }
            else
            {
                FinalInt = 1000000;
            }
            break;
        case 8:
            if(ReqNum == 0)
            {
                FinalInt = 400;
            }
            else
            {
                FinalInt = 2000000;
            }
            break;
        case 9:
            if(ReqNum == 0)
            {
                FinalInt = 800;
            }
            else
            {
                FinalInt = 4000000;
            }
            break;
        case 10:
            if(ReqNum == 0)
            {
                FinalInt = 1200;
            }
            else
            {
                FinalInt = 6000000;
            }
            break;
        case 11:
            if(ReqNum == 0)
            {
                FinalInt = 1600;
            }
            else
            {
                FinalInt = 8000000;
            }
            break;
        case 12:
            if(ReqNum == 0)
            {
                FinalInt = 2600;
            }
            else
            {
                FinalInt = 13000000;
            }
            break;
        case 13:
            if(ReqNum == 0)
            {
                FinalInt = 3600;
            }
            else
            {
                FinalInt = 18000000;
            }
            break;
        case 14:
            if(ReqNum == 0)
            {
                FinalInt = 4600;
            }
            else
            {
                FinalInt = 23000000;
            }
            break;
        case 15:
            if(ReqNum == 0)
            {
                FinalInt = 5200;
            }
            else
            {
                FinalInt = 26000000;
            }
            break;
        case 16:
            if(ReqNum == 0)
            {
                FinalInt = 6800;
            }
            else
            {
                FinalInt = 34000000;
            }
            break;
        case 17:
            if(ReqNum == 0)
            {
                FinalInt = 8400;
            }
            else
            {
                FinalInt = 42000000;
            }
            break;
        case 18:
            if(ReqNum == 0)
            {
                FinalInt = 10000;
            }
            else
            {
                FinalInt = 50000000;
            }
            break;
        case 19:
            if(ReqNum == 0)
            {
                FinalInt = 11600;
            }
            else
            {
                FinalInt = 58000000;
            }
            break;
        case 20:
            if(ReqNum == 0)
            {
                FinalInt = 13200;
            }
            else
            {
                FinalInt = 66000000;
            }
            break;
        case 21:
            if(ReqNum == 0)
            {
                FinalInt = 15450;
            }
            else
            {
                FinalInt = 77250000;
            }
            break;
        case 22:
            if(ReqNum == 0)
            {
                FinalInt = 17850;
            }
            else
            {
                FinalInt = 89250000;
            }
            break;
        case 23:
            if(ReqNum == 0)
            {
                FinalInt = 20400;
            }
            else
            {
                FinalInt = 102000000;
            }
            break;
        case 24:
            if(ReqNum == 0)
            {
                FinalInt = 23100;
            }
            else
            {
                FinalInt = 115500000;
            }
            break;
        case 25:
            if(ReqNum == 0)
            {
                FinalInt = 25950;
            }
            else
            {
                FinalInt = 129750000;
            }
            break;
        case 26:
            if(ReqNum == 0)
            {
                FinalInt = 28850;
            }
            else
            {
                FinalInt = 144250000;
            }
            break;
        case 27:
            if(ReqNum == 0)
            {
                FinalInt = 32100;
            }
            else
            {
                FinalInt = 160500000;
            }
            break;
        case 28:
            if(ReqNum == 0)
            {
                FinalInt = 35400;
            }
            else
            {
                FinalInt = 177000000;
            }
            break;
        case 29:
            if(ReqNum == 0)
            {
                FinalInt = 38850;
            }
            else
            {
                FinalInt = 194250000;
            }
            break;
        case 30:
            if(ReqNum == 0)
            {
                FinalInt = 42450;
            }
            else
            {
                FinalInt = 212250000;
            }
            break;
        case 31:
            if(ReqNum == 0)
            {
                FinalInt = 46200;
            }
            else
            {
                FinalInt = 231000000;
            }
            break;
        case 32:
            if(ReqNum == 0)
            {
                FinalInt = 50700;
            }
            else
            {
                FinalInt = 253500000;
            }
            break;
        case 33:
            if(ReqNum == 0)
            {
                FinalInt = 55200;
            }
            else
            {
                FinalInt = 276000000;
            }
            break;
        case 34:
            if(ReqNum == 0)
            {
                FinalInt = 59700;
            }
            else
            {
                FinalInt = 298500000;
            }
            break;
        case 35:
            if(ReqNum == 0)
            {
                FinalInt = 64200;
            }
            else
            {
                FinalInt = 321000000;
            }
            break;
        case 36:
            if(ReqNum == 0)
            {
                FinalInt = 68700;
            }
            else
            {
                FinalInt = 343500000;
            }
            break;
        case 37:
            if(ReqNum == 0)
            {
                FinalInt = 73200;
            }
            else
            {
                FinalInt = 366000000;
            }
            break;
        case 38:
            if(ReqNum == 0)
            {
                FinalInt = 77700;
            }
            else
            {
                FinalInt = 388500000;
            }
            break;
        case 39:
            if(ReqNum == 0)
            {
                FinalInt = 83700;
            }
            else
            {
                FinalInt = 418500000;
            }
            break;
        case 40:
            if(ReqNum == 0)
            {
                FinalInt = 90000;
            }
            else
            {
                FinalInt = 450000000;
            }
            break;
        case 41:
            if(ReqNum == 0)
            {
                FinalInt = 200000;
            }
            else
            {
                FinalInt = 1000000000;
            }
            break;
        default:
            if(ReqNum == 0)
            {
                FinalInt = 3600 + GetDoubleScaling(CurLevel, 350);
            }
            else
            {
                FinalInt = 5500000 + GetDoubleScaling(CurLevel, 500000);
            }
            if(ReqNum == 0)
            {
                return Min(StatOther.RStalkerKillsStat, FinalInt);
            }
            return Min(StatOther.RBullpupDamageStat, FinalInt);
    }
	if( ReqNum==0 )
		return Min(StatOther.RStalkerKillsStat,FinalInt);
	return Min(StatOther.RBullpupDamageStat,FinalInt);
}

// Display enemy health bars
static function SpecialHUDInfo(KFPlayerReplicationInfo KFPRI, Canvas C)
{
	local KFMonster KFEnemy;
	local HUDKillingFloor HKF;
	local float MaxDistanceSquared;

	if ( KFPRI.ClientVeteranSkillLevel > 0 )
	{
		HKF = HUDKillingFloor(C.ViewPort.Actor.myHUD);
		if ( HKF == none || Pawn(C.ViewPort.Actor.ViewTarget)==none || Pawn(C.ViewPort.Actor.ViewTarget).Health<=0 )
			return;

		switch ( KFPRI.ClientVeteranSkillLevel )
		{
			case 1:
				MaxDistanceSquared = 25600; // 20% (160 units)
				break;
			case 2:
				MaxDistanceSquared = 102400; // 40% (320 units)
				break;
			case 3:
				MaxDistanceSquared = 230400; // 60% (480 units)
				break;
			case 4:
				MaxDistanceSquared = 409600; // 80% (640 units)
				break;
			default:
				MaxDistanceSquared = 640000; // 100% (800 units)
				break;
		}

		foreach C.ViewPort.Actor.DynamicActors(class'KFMonster',KFEnemy)
		{
			if ( KFEnemy.Health > 0 && (!KFEnemy.Cloaked() || KFEnemy.bZapped || KFEnemy.bSpotted) && VSizeSquared(KFEnemy.Location - C.ViewPort.Actor.Pawn.Location) < MaxDistanceSquared )
			{
				HKF.DrawHealthBar(C, KFEnemy, KFEnemy.Health, KFEnemy.HealthMax , 100.0);
			}
		}
	}
}

static function bool ShowStalkers(KFPlayerReplicationInfo KFPRI)
{
	return true;
}

static function float GetStalkerViewDistanceMulti(KFPlayerReplicationInfo KFPRI)
{
	return 0.75 + (0.20 * float(KFPRI.ClientVeteranSkillLevel));
}

static function float GetMagCapacityMod(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( (Bullpup(Other) != none || AK47AssaultRifle(Other) != none ||
        SCARMK17AssaultRifle(Other) != none || M4AssaultRifle(Other) != none
        || FNFAL_ACOG_AssaultRifle(Other) != none || MKb42AssaultRifle(Other) != none
        || ThompsonSMG(Other) != none || ThompsonDrumSMG(Other) != none
        || SPThompsonSMG(Other) != none)
		&& KFPRI.ClientVeteranSkillLevel > 5 )
	return 1.5 + (0.05 * float(KFPRI.ClientVeteranSkillLevel)); 	
	return 1.0;
}

	//Reduce Damage Siren Scream
static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, Pawn Instigator, int InDamage, class<DamageType> DmgType)
{
	if ( class<SirenScreamDamage>(DmgType)!=none )
	{
		if ( KFPRI.ClientVeteranSkillLevel <= 0 )
			return float(InDamage) * (0.80 - (0.015 * float(KFPRI.ClientVeteranSkillLevel)));
		return 1.00; // 
	}
	return InDamage;
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
        Ret += float(125);
    }
    return int(Ret);
    //return;    
}

static function float GetFireSpeedMod(KFPlayerReplicationInfo KFPRI, Weapon Other)
{
	if ( (Bullpup(Other) != none || AK47AssaultRifle(Other) != none ||
        SCARMK17AssaultRifle(Other) != none || M4AssaultRifle(Other) != none
        || FNFAL_ACOG_AssaultRifle(Other) != none || MKb42AssaultRifle(Other) != none
        || ThompsonSMG(Other) != none || ThompsonDrumSMG(Other) != none
        || SPThompsonSMG(Other) != none)
		&& KFPRI.ClientVeteranSkillLevel > 0 )
	return 1.0 + (0.01 * float(KFPRI.ClientVeteranSkillLevel)); 	
	return 1.0;
}


static function float GetAmmoPickupMod(KFPlayerReplicationInfo KFPRI, KFAmmunition Other)
{
	if ( (BullpupAmmo(Other) != none || AK47Ammo(Other) != none ||
        SCARMK17Ammo(Other) != none || M4Ammo(Other) != none
        || FNFALAmmo(Other) != none || MKb42Ammo(Other) != none
        || ThompsonAmmo(Other) != none || GoldenAK47Ammo(Other) != none
        || ThompsonDrumAmmo(Other) != none || SPThompsonAmmo(Other) != none
        || CamoM4Ammo(Other) != none) && KFPRI.ClientVeteranSkillLevel > 0 )
	return 1.0 + (0.05 * float(KFPRI.ClientVeteranSkillLevel)); 	
	return 1.0;
}
static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType)
{
	if ( (AmmoType == class'BullpupAmmo' || AmmoType == class'AK47Ammo' ||
        AmmoType == class'SCARMK17Ammo' || AmmoType == class'M4Ammo'
        || AmmoType == class'FNFALAmmo' || AmmoType == class'MKb42Ammo'
        || AmmoType == class'ThompsonAmmo' || AmmoType == class'GoldenAK47Ammo'
        || AmmoType == class'ThompsonDrumAmmo' || AmmoType == class'SPThompsonAmmo'
        || AmmoType == class'CamoM4Ammo' )
        && KFPRI.ClientVeteranSkillLevel > 0 )
	return 1.0 + (0.05 * float(KFPRI.ClientVeteranSkillLevel)); 	
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


static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeBullpup' || DmgType == class'DamTypeAK47AssaultRifle' ||
        DmgType == class'DamTypeSCARMK17AssaultRifle' || DmgType == class'DamTypeM4AssaultRifle'
        || DmgType == class'DamTypeFNFALAssaultRifle' || DmgType == class'DamTypeMKb42AssaultRifle'
        || DmgType == class'DamTypeThompson' || DmgType == class'DamTypeThompsonDrum'
        || DmgType == class'DamTypeSPThompson' )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 2.50;
		return float(InDamage) * (2.50 + (0.031250 * float(KFPRI.ClientVeteranSkillLevel))); // Up to 50% increase in Damage with Bullpup
	}
	return InDamage;
}

static function float ModifyRecoilSpread(KFPlayerReplicationInfo KFPRI, WeaponFire Other, out float Recoil)
{
	if ( Bullpup(Other.Weapon) != none || AK47AssaultRifle(Other.Weapon) != none ||
        SCARMK17AssaultRifle(Other.Weapon) != none || M4AssaultRifle(Other.Weapon) != none
        || FNFAL_ACOG_AssaultRifle(Other.Weapon) != none || MKb42AssaultRifle(Other.Weapon) != none
        || ThompsonSMG(Other.Weapon) != none || ThompsonDrumSMG(Other.Weapon) != none
        || SPThompsonSMG(Other.Weapon) != none )
	{
		if ( KFPRI.ClientVeteranSkillLevel < 1 )
			Recoil = 1.00;
		else if ( KFPRI.ClientVeteranSkillLevel <= 5 )
			Recoil = 0.95;
		else if ( KFPRI.ClientVeteranSkillLevel == 6 )
			Recoil = 0.94;
		else Recoil = FMax(0.94 - (0.01 * float(KFPRI.ClientVeteranSkillLevel)),0.f);
		return Recoil;
	}
	Recoil = 1.0;
	return Recoil;
}

static function float GetReloadSpeedModifier(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	return 1.00 + (0.010 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 35% faster reload speed
}

// Set number times Zed Time can be extended
static function int ZedTimeExtensions(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel >= 3 )
		return KFPRI.ClientVeteranSkillLevel - 2; // Up to 4 Zed Time Extensions
	return 0;
}

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'BullpupPickup' || Item == class'AK47Pickup' ||
        Item == class'SCARMK17Pickup' || Item == class'M4Pickup'
        || Item == class'FNFAL_ACOG_Pickup' || Item == class'MKb42Pickup'
        || Item == class'ThompsonPickup' || Item == class'GoldenAK47Pickup'
        || Item == class'ThompsonDrumPickup' || Item == class'SPThompsonPickup'
        || Item == class'CamoM4Pickup' )
		return FMax(1.0 - (0.01 * float(KFPRI.ClientVeteranSkillLevel)),0.1f); // Up to 70% discount on Assault Rifles
	return 1.0;
}

// give armor and weapon with lvl client
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	if ( KFPRI.ClientVeteranSkillLevel >= 0 && KFPRI.ClientVeteranSkillLevel <= 5  )
    {
		AddPerkedWeapon(class'Bullpup',KFPRI,P);
		P.ShieldStrength = 0;
    }  
	if  (  KFPRI.ClientVeteranSkillLevel >= 6 && KFPRI.ClientVeteranSkillLevel <= 10  )
    {
		AddPerkedWeapon(class'AK47AssaultRifle',KFPRI,P);
		AddPerkedWeapon(class'Bullpup',KFPRI,P);
		P.ShieldStrength = 25;
    }   
	if ( KFPRI.ClientVeteranSkillLevel >= 11 && KFPRI.ClientVeteranSkillLevel <= 20  )
    {
		AddPerkedWeapon(class'MKb42AssaultRifle',KFPRI,P );
		AddPerkedWeapon(class'AK47AssaultRifle',KFPRI,P);
		AddPerkedWeapon(class'Bullpup',KFPRI,P);
		P.ShieldStrength = 50;
    }
	if ( KFPRI.ClientVeteranSkillLevel >= 21 && KFPRI.ClientVeteranSkillLevel <= 30  )
    {
		AddPerkedWeapon(class'MKb42AssaultRifle',KFPRI,P );
		AddPerkedWeapon(class'AK47AssaultRifle',KFPRI,P);
		AddPerkedWeapon(class'Bullpup',KFPRI,P);
		AddPerkedWeapon(class'M4AssaultRifle',KFPRI,P);
		P.ShieldStrength = 75;
    }    
	if ( KFPRI.ClientVeteranSkillLevel >= 31 && KFPRI.ClientVeteranSkillLevel <= 40 )
    {
		AddPerkedWeapon(class'MKb42AssaultRifle',KFPRI,P );
		AddPerkedWeapon(class'SCARMK17AssaultRifle',KFPRI,P);
		AddPerkedWeapon(class'ThompsonDrumSMG',KFPRI,P);
		AddPerkedWeapon(class'FNFAL_ACOG_AssaultRifle',KFPRI,P);
		P.ShieldStrength = 100;
    }
	if ( KFPRI.ClientVeteranSkillLevel >= 41 && KFPRI.ClientVeteranSkillLevel <= 41 )
    {
		AddPerkedWeapon(class'MKb42AssaultRifle',KFPRI,P );
		AddPerkedWeapon(class'SCARMK17AssaultRifle',KFPRI,P);
		AddPerkedWeapon(class'ThompsonDrumSMG',KFPRI,P);
		AddPerkedWeapon(class'FNFAL_ACOG_AssaultRifle',KFPRI,P);
		P.ShieldStrength = 125;
    }
}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	ReplaceText(S,"%s",GetPercentStr(0.05 * float(Level)+0.05));
	ReplaceText(S,"%d",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f)));
	ReplaceText(S,"%z",string(Level-2));
	ReplaceText(S,"%r",GetPercentStr(FMin(0.05 * float(Level)+0.1,1.f)));
	ReplaceText(S,"%l",GetPercentStr(FMin(0.05 * float(Level)+0.1,1.f)));
	return S;
}

defaultproperties
{
	PerkIndex=3

	OnHUDIcon=Texture'KillingFloorHUD.Perks.Perk_Commando'
	OnHUDGoldIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_Commando_Gold'
	VeterancyName="Коммандо"
	Requirements[0]="Убить %x сталкеров с помощью штурмовых винтовок"
	Requirements[1]="Нанести %x урона с помощью штурмовых винтовок"
	NumRequirements=2

	SRLevelEffects(0)="На 5% больше урона с помощью штурмовых винтовок|На 5% меньше отдачи со штурмовых винтовок|На 5% быстрее перезарядка всех оружий|10% Скидка на все штуромвые винтовки|Видит сталкеров на растоянии 4 метров"
	SRLevelEffects(1)="На 10% больше урона с помощью штурмовых винтовок|На 10% меньше отдачи со штурмовых винтовок|На 10% больше обойма всех штурмовых винтовок|На 10% быстрее перезарядка всех оружий|20% Скидка на все штуромвые винтовки|Воскрешение с Bullpup|Видит сталкеров на растоянии 8 метров|Видит жизни зедов на растоянии 4 метров"
	SRLevelEffects(2)="На 15% больше урона с помощью штурмовых винтовок|На 15% меньше отдачи со штурмовых винтовок|На 20% больше обойма всех штурмовых винтовок|На 15% быстрее перезарядка всех оружий|30% Скидка на все штуромвые винтовки|Воскрешение с Bullpup|Видит сталкеров на растоянии 10 метров|Видит жизни зедов на растоянии 7 метров"
	SRLevelEffects(3)="На 20% больше урона с помощью штурмовых винтовок|На 20% меньше отдачи со штурмовых винтовок|На 25% больше обойма всех штурмовых винтовок|На 20% быстрее перезарядка всех оружий|40% Скидка на все штуромвые винтовки|Воскрешение с Bullpup|Видит сталкеров на растоянии 12 метров|Видит жизни зедов на растоянии 10 метров|Zed-Time can be extended by killing an enemy while in slow motion"
	SRLevelEffects(4)="На 25% больше урона с помощью штурмовых винтовок|На 25% меньше отдачи со штурмовых винтовок|На 25% больше обойма всех штурмовых винтовок|На 25% быстрее перезарядка всех оружий|50% Скидка на все штуромвые винтовки|Воскрешение с Bullpup|Видит сталкеров на растоянии 14 метров|Видит жизни зедов на растоянии 13 метров|Up to 2 Zed-Time Extensions"
	SRLevelEffects(5)="На 30% больше урона с помощью штурмовых винтовок|На 30% меньше отдачи со штурмовых винтовок|На 25% больше обойма всех штурмовых винтовок|На 30% быстрее перезарядка всех оружий|60% Скидка на все штуромвые винтовки|Воскрешение с Bullpup|Видит сталкеров на растоянии 16 метров|Видит жизни зедов на растоянии 16 метров|Up to 3 Zed-Time Extensions"
	SRLevelEffects(6)="На 35% больше урона с помощью штурмовых винтовок|На 40% меньше отдачи со штурмовых винтовок|На 25% больше обойма всех штурмовых винтовок|На 35% быстрее перезарядка всех оружий|70% Скидка на все штуромвые винтовки|Воскрешение с AK47 и Bullpup|Видит сталкеров на растоянии 16 метров|Видит жизни зедов на растоянии 16 метров|Up to 4 Zed-Time Extensions"
	SRLevelEffects(7)="На 40% больше урона с помощью штурмовых винтовок|На 40% меньше отдачи со штурмовых винтовок|На 25% больше обойма всех штурмовых винтовок|На 35% быстрее перезарядка всех оружий|70% Скидка на все штуромвые винтовки|Воскрешение с AK47 и Bullpup|Видит сталкеров на растоянии 16 метров|Видит жизни зедов на растоянии 16 метров|Up to 4 Zed-Time Extensions"
	SRLevelEffects(8)="На 45% больше урона с помощью штурмовых винтовок|На 40% меньше отдачи со штурмовых винтовок|На 25% больше обойма всех штурмовых винтовок|На 35% быстрее перезарядка всех оружий|70% Скидка на все штуромвые винтовки|Воскрешение с AK47 и Bullpup|Видит сталкеров на растоянии 16 метров|Видит жизни зедов на растоянии 16 метров|Up to 4 Zed-Time Extensions"
	SRLevelEffects(9)="На 50% больше урона с помощью штурмовых винтовок|На 40% меньше отдачи со штурмовых винтовок|На 25% больше обойма всех штурмовых винтовок|На 35% быстрее перезарядка всех оружий|70% Скидка на все штуромвые винтовки|Воскрешение с AK47 и Bullpup|Видит сталкеров на растоянии 16 метров|Видит жизни зедов на растоянии 16 метров|Up to 4 Zed-Time Extensions"
	SRLevelEffects(10)="На 55% больше урона с помощью штурмовых винтовок|На 40% меньше отдачи со штурмовых винтовок|На 25% больше обойма всех штурмовых винтовок|На 35% быстрее перезарядка всех оружий|70% Скидка на все штуромвые винтовки|Воскрешение с AK47 и Bullpup|Видит сталкеров на растоянии 16 метров|Видит жизни зедов на растоянии 16 метров|Up to 4 Zed-Time Extensions"
	SRLevelEffects(11)="На 60% больше урона с помощью штурмовых винтовок|На 40% меньше отдачи со штурмовых винтовок|На 25% больше обойма всех штурмовых винтовок|На 35% быстрее перезарядка всех оружий|70% Скидка на все штуромвые винтовки|Воскрешение с AK47 и Bullpup|Видит сталкеров на растоянии 16 метров|Видит жизни зедов на растоянии 16 метров|Up to 4 Zed-Time Extensions"
	SRLevelEffects(12)="На 65% больше урона с помощью штурмовых винтовок|На 40% меньше отдачи со штурмовых винтовок|На 25% больше обойма всех штурмовых винтовок|На 35% быстрее перезарядка всех оружий|70% Скидка на все штуромвые винтовки|Воскрешение с AK47 и Bullpup|Видит сталкеров на растоянии 16 метров|Видит жизни зедов на растоянии 16 метров|Up to 4 Zed-Time Extensions"
	SRLevelEffects(13)="На 75% больше урона с помощью штурмовых винтовок|На 40% меньше отдачи со штурмовых винтовок|На 25% больше обойма всех штурмовых винтовок|На 35% быстрее перезарядка всех оружий|70% Скидка на все штуромвые винтовки|Воскрешение с AK47 и Bullpup|Видит сталкеров на растоянии 16 метров|Видит жизни зедов на растоянии 16 метров|Up to 4 Zed-Time Extensions"
	CustomLevelInfo="На 75% больше урона с помощью штурмовых винтовок|На 40% меньше отдачи со штурмовых винтовок|На 25% больше обойма всех штурмовых винтовок|На %s быстрее перезарядка всех оружий|%d Скидка на все штуромвые винтовки|Воскрешение с AK47 и Bullpup|Видит сталкеров на растоянии 16 метров|Видит жизни зедов на растоянии 16 метров|Up to %z Zed-Time Extensions"
}
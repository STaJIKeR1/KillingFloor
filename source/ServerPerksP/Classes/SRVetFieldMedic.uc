class SRVetFieldMedic extends SRVeterancyTypes
	abstract;

static function int GetPerkProgressInt( ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum )
{
	switch( CurLevel )
	{
	case 0:
		FinalInt = 100;
		break;
	case 1:
		FinalInt = 200;
		break;
	case 2:
		FinalInt = 400;
		break;
	case 3:
		FinalInt = 800;
		break;
	case 4:
		FinalInt = 1600;
		break;
	case 5:
		FinalInt = 3200;
		break;
	case 6:
		FinalInt = 6400;
		break;
	default:
		FinalInt = 6400+GetDoubleScaling(CurLevel,6400);
	}
	return Min(StatOther.RDamageHealedStat,FinalInt);
}

static function class<Grenade> GetNadeType(KFPlayerReplicationInfo KFPRI)
{
	return class'MedicNade'; // Grenade detonations heal nearby teammates, and cause enemies to be poisoned
}

static function float GetSyringeChargeRate(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel == 0 )
		return 1.10;
	else if ( KFPRI.ClientVeteranSkillLevel <= 4 )
		return 1.25 + (0.25 * float(KFPRI.ClientVeteranSkillLevel));
	else if ( KFPRI.ClientVeteranSkillLevel == 5 )
		return 2.50; // Recharges 150% faster
	return 2.4 + (0.1 * float(KFPRI.ClientVeteranSkillLevel)); // Level 6 - Recharges 200% faster
}

static function float GetHealPotency(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel == 0 )
		return 1.10;
	else if ( KFPRI.ClientVeteranSkillLevel <= 2 )
		return 1.25;
	else if ( KFPRI.ClientVeteranSkillLevel <= 5 )
		return 1.5;
	return 1.75;  // Heals for 75% more
}

static function float GetMovementSpeedModifier(KFPlayerReplicationInfo KFPRI, KFGameReplicationInfo KFGRI)
{
	// Medic movement speed reduced in Balance Round 2(limited to Suicidal and HoE in Round 7)
	if ( KFGRI.GameDiff >= 5.0 )
	{
		if ( KFPRI.ClientVeteranSkillLevel <= 2 )
		{
			return 1.0;
		}

		return 1.05 + FMin(0.05 * float(KFPRI.ClientVeteranSkillLevel - 3),0.55); // Moves up to 20% faster
	}

	if ( KFPRI.ClientVeteranSkillLevel <= 1 )
		return 1.0;
	return 1.05 + FMin(0.05 * float(KFPRI.ClientVeteranSkillLevel - 2),0.55); // Moves up to 25% faster
}

static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, Pawn Instigator, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeVomit' )
	{
		if ( KFPRI.ClientVeteranSkillLevel == 0 )
			return float(InDamage) * 0.90;
		else if ( KFPRI.ClientVeteranSkillLevel == 1 )
			return float(InDamage) * 0.75;
		else if ( KFPRI.ClientVeteranSkillLevel <= 4 )
			return float(InDamage) * 0.50;
		return float(InDamage) * 0.25; // 75% decrease in damage from Bloat's Bile
	}
	return InDamage;
}

static function float GetMagCapacityMod(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( (MP7MMedicGun(Other) != none || MP5MMedicGun(Other) != none || M7A3MMedicGun(Other) != none
        || KrissMMedicGun(Other) != none || BlowerThrower(Other) != none )
        && KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + (0.20 * FMin(KFPRI.ClientVeteranSkillLevel, 5.0)); // 100% increase in MP7 Medic weapon ammo carry
	return 1.0;
}

static function float GetAmmoPickupMod(KFPlayerReplicationInfo KFPRI, KFAmmunition Other)
{
	if ( (MP7MAmmo(Other) != none || MP5MAmmo(Other) != none || M7A3MAmmo(Other) != none
        || KrissMAmmo(Other) != none || BlowerThrowerAmmo(Other) != none || CamoMP5MAmmo(Other) != none || NeonKrissMAmmo(Other) != none ) 
		&& KFPRI.ClientVeteranSkillLevel > 0 )
		return 1.0 + (0.20 * FMin(KFPRI.ClientVeteranSkillLevel, 5.0)); // 100% increase in MP7 Medic weapon ammo carry
	return 1.0;
}

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
	if ( Item == class'Vest' )
		return FMax(0.9 - (0.10 * float(KFPRI.ClientVeteranSkillLevel)),0.1f);  // Up to 70% discount on Body Armor
	if ( Item == class'MP7MPickup' || Item == class'MP5MPickup' || Item == class'M7A3MPickup'
        || Item == class'KrissMPickup' || Item == class'BlowerThrowerPickup' || Item == class'CamoMP5MPickup'
        || Item == class'NeonKrissMPickup' )
		return FMax(0.25 - (0.02 * float(KFPRI.ClientVeteranSkillLevel)),0.02f);  // Up to 87% discount on Medic Gun
	return 1.0;
}

// Reduce damage when wearing Armor
static function float GetBodyArmorDamageModifier(KFPlayerReplicationInfo KFPRI)
{
	if ( KFPRI.ClientVeteranSkillLevel <= 5 )
		return 1.0 - (0.05 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 50% improvement of Body Armor
	return 0.25; // Level 6 - 75% Better Body Armor
}

// Give Extra Items as Default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If Level 5 or Higher, give them Body Armor
	if ( KFPRI.ClientVeteranSkillLevel >= 5 )
		P.ShieldStrength = 100;
	// If Level 6, give them a Medic Gun
	if ( KFPRI.ClientVeteranSkillLevel >= 6 )
		KFHumanPawn(P).CreateInventoryVeterancy(string(class'MP7MMedicGun'), default.StartingWeaponSellPriceLevel6);
}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	S = Repl(S,"%s",GetPercentStr(2.4 + (0.1 * float(Level))));
	S = Repl(S,"%d",GetPercentStr(FMin(0.1 + 0.1 * float(Level),0.9f)));
	S = Repl(S,"%m",GetPercentStr(FMin(0.75+0.02 * float(Level),0.98f)));
	S = Repl(S,"%r",GetPercentStr(FMin(0.05 * float(Level-2),0.55f)));
	return S;
}

defaultproperties
{
     CustomLevelInfo="%s faster Syringe recharge|75% more potent healing|75% less damage from Bloat Bile|%r faster movement speed|100% larger Medic Gun clips|75% better Body Armor|%d discount on Body Armor|%m discount on Medic Guns|Spawn with Body Armor and Medic Gun"
     SRLevelEffects(0)="10% faster Syringe recharge|10% more potent healing|10% less damage from Bloat Bile|10% discount on Body Armor|75% discount on Medic Guns|Grenades heal teammates and hurt enemies"
     SRLevelEffects(1)="25% faster Syringe recharge|25% more potent healing|25% less damage from Bloat Bile|20% larger Medic Gun clips|10% better Body Armor|20% discount on Body Armor|77% discount on Medic Guns|Grenades heal teammates and hurt enemies"
     SRLevelEffects(2)="50% faster Syringe recharge|25% more potent healing|50% less damage from Bloat Bile|5% faster movement speed|40% larger Medic Gun clips|20% better Body Armor|30% discount on Body Armor|79% discount on Medic Guns|Grenades heal teammates and hurt enemies"
     SRLevelEffects(3)="75% faster Syringe recharge|50% more potent healing|50% less damage from Bloat Bile|10% faster movement speed|60% larger Medic Gun clips|30% better Body Armor|40% discount on Body Armor|81% discount on Medic Guns|Grenades heal teammates and hurt enemies"
     SRLevelEffects(4)="100% faster Syringe recharge|50% more potent healing|50% less damage from Bloat Bile|15% faster movement speed|80% larger Medic Gun clips|40% better Body Armor|50% discount on Body Armor|83% discount on Medic Guns|Grenades heal teammates and hurt enemies"
     SRLevelEffects(5)="150% faster Syringe recharge|50% more potent healing|75% less damage from Bloat Bile|20% faster movement speed|100% larger Medic Gun clips|50% better Body Armor|60% discount on Body Armor|85% discount on Medic Guns|Grenades heal teammates and hurt enemies"
     SRLevelEffects(6)="200% faster Syringe recharge|75% more potent healing|75% less damage from Bloat Bile|25% faster movement speed|100% larger Medic Gun clips|75% better Body Armor|70% discount on Body Armor|87% discount on Medic Guns|Grenades heal teammates and hurt enemies"
     PerkIndex=0
     OnHUDIcon=Texture'KillingFloorHUD.Perks.Perk_Medic'
     OnHUDGoldIcon=Texture'KillingFloor2HUD.Perk_Icons.Perk_Medic_Gold'
     VeterancyName="Полевой Медик"
     Requirements(0)="Вылечить %x жизней вашей команде"
}

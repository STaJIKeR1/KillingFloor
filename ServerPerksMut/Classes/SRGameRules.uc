//=============================================================================
// SRGameRules
//=============================================================================
class SRGameRules extends GameRules;

function PostBeginPlay()
{
	if( Level.Game.GameRulesModifiers==None )
		Level.Game.GameRulesModifiers = Self;
	else Level.Game.GameRulesModifiers.AddGameRules(Self);
}

function AddGameRules(GameRules GR)
{
	if ( GR!=Self )
		Super.AddGameRules(GR);
}

function bool PreventDeath(Pawn Killed, Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	local ClientPerkRepLink R;
	local SRCustomProgress S;

	if ( (NextGameRules != None) && NextGameRules.PreventDeath(Killed,Killer, damageType,HitLocation) )
		return true;

	if( xPlayer(Killer)!=None && Killed.Controller!=None && Killed.Controller!=Killer )
	{
		R = FindStatsFor(Killer);
		if( R!=None )
			for( S=R.CustomLink; S!=None; S=S.NextLink )
				S.NotifyPlayerKill(Killed,damageType);
	}
	if( xPlayer(Killed.Controller)!=None && Killer!=None && Killer.Pawn!=None )
	{
		R = FindStatsFor(Killed.Controller);
		if( R!=None )
			for( S=R.CustomLink; S!=None; S=S.NextLink )
				S.NotifyPlayerKilled(Killer.Pawn,damageType);
	}
	return false;
}
static final function ClientPerkRepLink FindStatsFor( Controller C )
{
	local LinkedReplicationInfo L;

	if( C.PlayerReplicationInfo==None )
		return None;
	for( L=C.PlayerReplicationInfo.CustomReplicationInfo; L!=None; L=L.NextReplicationInfo )
		if( ClientPerkRepLink(L)!=None )
			return ClientPerkRepLink(L);
	return None;
}

function ScoreKill(Controller Killer, Controller Killed)
{
	local SRPlayerReplicationInfo SRPRI;

	if(Killer!=None && Killer.Pawn!=None && Killer.IsA('PlayerController') && Killer.Pawn.IsA('KFHumanPawn'))
	{
		SRPRI = SRPlayerReplicationInfo(KFPlayerController(Killer).PlayerReplicationInfo);

		if(SRPRI!=None && Killed.Pawn!=None)
		{
			if(Killed.Pawn.IsA('ZombieClot_STANDARD') || Killed.Pawn.IsA ('ZombieClot_XMas'))
				SRPRI.KilledClots++;
			else if(Killed.Pawn.IsA('ZombieGoreFast_STANDARD')|| Killed.Pawn.IsA ('ZombieGoreFast_XMas'))
				SRPRI.KilledGorefasts++;
			else if(Killed.Pawn.IsA('ZombieCrawler_STANDARD')|| Killed.Pawn.IsA ('ZombieCrawler_XMas'))
				SRPRI.KilledCrawlers++;
			else if(Killed.Pawn.IsA('ZombieStalker_STANDARD')|| Killed.Pawn.IsA ('ZombieStalker_Xmas'))
				SRPRI.KilledStalkers++;
			else if(Killed.Pawn.IsA('ZombieBloat_STANDARD')|| Killed.Pawn.IsA ('ZombieBloat_XMas'))
				SRPRI.KilledBloats++;
			else if(Killed.Pawn.IsA('ZombieSiren_Standard')|| Killed.Pawn.IsA ('ZombieSiren_XMas'))
				SRPRI.KilledSirens++;
			else if(Killed.Pawn.IsA('ZombieHusk_STANDARD')|| Killed.Pawn.IsA ('ZombieHusk_XMas'))
				SRPRI.KilledHusks++;
			else if(Killed.Pawn.IsA('ZombieScrake_STANDARD')|| Killed.Pawn.IsA ('ZombieScrake_XMas'))
				SRPRI.KilledScrakes++;
			else if(Killed.Pawn.IsA('ZombieFleshpound_STANDARD')|| Killed.Pawn.IsA ('ZombieFleshPound_XMas'))
				SRPRI.KilledFPs++;
			else if(Killed.Pawn.IsA('ZombieBoss_STANDARD')|| Killed.Pawn.IsA ('ZombieBoss_XMas'))
	      		SRPRI.KilledPats++;
		}
	}

	if(NextGameRules!=None)
	{
		NextGameRules.ScoreKill(Killer, Killed);
	}
}
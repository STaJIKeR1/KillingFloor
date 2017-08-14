class SRPlayerReplicationInfo extends KFPlayerReplicationInfo;

struct PlayerData
{
	var string Hash;
	var string ClanName;
	var int ColorR,ColorG,ColorB,ColorA;
};

struct ClanData
{
	var string ClanName;
	var string ClanTexture;
	var int ClanTextureW;
	var int ClanTextureH;
	var int clanX,clanY;
	var int logoX,logoY;
	var Color RGBA;
};

var ClanData myClanData;
var string ClanName;
var int ColorR,ColorG,ColorB,ColorA;
var int KilledClots, KilledGorefasts, KilledCrawlers, KilledStalkers, KilledBloats, KilledSirens, KilledHusks, KilledScrakes, KilledFPs, KilledPats;
var string PlayerLocalTime;


simulated event PostBeginPlay()
{
	SetTimer(1.0,true);
	Super.PostBeginPlay();
}

simulated function Timer()
{
	if(Role<ROLE_Authority)
		PlayerLocalTime=GetLocalTimeString();
	Super.Timer();
}

simulated function string GetLocalTimeString()
{
	local string Hour,Minute,Second,result;
	Hour=string(Level.Hour);
	if(Level.Hour<10) Hour=0$Hour;
	Minute=string(Level.Minute);
	if(Level.Minute<10) Minute=0$Minute;
	Second=string(Level.Second);
	if(Level.Second<10) Second=0$Second;
	result=Hour$":"$Minute$":"$Second;
	return result;
}

replication
{
	reliable if (bNetDirty && Role == Role_Authority)
		KilledClots, KilledGorefasts, KilledCrawlers, KilledStalkers, KilledBloats,
		KilledSirens, KilledHusks, KilledScrakes, KilledFPs, KilledPats;
	reliable if (bNetDirty && Role == Role_Authority)
		myClanData, ClanName, ColorR, ColorG, ColorB, ColorA;
}

defaultproperties
{
}
class ClanLogoMut extends Mutator Config(ServerPerks);

#exec obj load file="MONOLIT_ICO.utx"
var Material Staj;
var Material Vyzhivator;
var() config array<SRPlayerReplicationInfo.PlayerData> PlayerDataList;
var() config array<SRPlayerReplicationInfo.ClanData> ClanDataList;
var array<PlayerController> PendingPlayers;

//+++
//
//***

function PostBeginPlay()
{
	local int i;
	local string s1,s2;
	for (i=0; i<ClanDataList.Length; i++)
	{
		if( ClanDataList[i].ClanTexture != "" )
		{
			Divide(ClanDataList[i].ClanTexture,".",s1,s2);
			AddToPackageMap(s1);
		}
	}
	SaveConfig();
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	if( PlayerController(Other)!=None )
	{
		PendingPlayers[PendingPlayers.Length] = PlayerController(Other);
		SetTimer(0.1,false);
	}
	return true;
}

function Timer()
{
	local int i;
	local SRPlayerReplicationInfo SRPRI;
	local byte bInClan;
	for(i=PendingPlayers.Length-1;i>=0;--i)
	{
		SRPRI = SRPlayerReplicationInfo(PendingPlayers[i].PlayerReplicationInfo);
		if(SRPRI==none || SRPRI.PlayerID==0) continue;
		bInClan=0;
		SRPRI.myClanData=SetClanData(PendingPlayers[i],bInClan);
		if(bInClan==0) continue;
		SRPRI.ClanName=SRPRI.myClanData.ClanName;
	}
	PendingPlayers.Length = 0;
}

function SRPlayerReplicationInfo.ClanData SetClanData(Controller C, out byte bInClan)
{
	local int i;
	local SRPlayerReplicationInfo.ClanData cData;
	local PlayerController PC;
	local string ClanName;
	PC = PlayerController(C);
	if (PC!=none)
	{
		ClanName=GetClanName(PC.GetPlayerIDHash());
		FillClanColor(PC,PC.GetPlayerIDHash());
	}
	for (i=0; i<ClanDataList.Length; i++)
	{
		if (ClanName~=ClanDataList[i].ClanName)
		{
			cData = ClanDataList[i];
			bInClan=1;
		}
	}
	return cData;
}

function FillClanColor(PlayerController PC, string Hash)
{
	local int i;
	local SRPlayerReplicationInfo SRPRI;
	SRPRI = SRPlayerReplicationInfo(PC.PlayerReplicationInfo);
	for(i=0;i<PlayerDataList.Length;i++)
	{
		if(PlayerDataList[i].Hash~=Hash)
		{
			SRPRI.ColorR=PlayerDataList[i].ColorR;
			SRPRI.ColorG=PlayerDataList[i].ColorG;
			SRPRI.ColorB=PlayerDataList[i].ColorB;
			SRPRI.ColorA=PlayerDataList[i].ColorA;
		}
	}
}


function string GetClanName(string Hash)
{
	local int i;
	for(i=0;i<PlayerDataList.Length;i++)
		if(PlayerDataList[i].Hash~=Hash) return PlayerDataList[i].ClanName;
	return "";
}

defaultproperties
{
	ClanDataList(0)=(ClanName="MONOLIT",ClanTexture="MONOLIT_ICO.Vyzhivator.Frame1",ClanTextureW=40,ClanTextureH=40)
	PlayerDataList(0)=(ClanName="MONOLIT",Hash="76561198060417861",ColorR=255,ColorG=0,ColorB=0)
	PlayerDataList(1)=(ClanName="MONOLIT",Hash="76561198037693391",ColorR=255,ColorG=0,ColorB=0)
	bAddToServerPackages=true
	GroupName="KF-ClanLogo"
	FriendlyName="ClanLogoMut"
	Description="ClanLogoMut"
}
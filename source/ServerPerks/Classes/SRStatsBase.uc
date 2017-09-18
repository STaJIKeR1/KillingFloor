// Template class.
Class SRStatsBase extends KFSteamStatsAndAchievements
	Abstract;

var ClientPerkRepLink Rep;
var KFPlayerController PlayerOwner;
var bool bStatsReadyNow;

function int GetID();
function SetID( int ID );
function ChangeCharacter( string CN );
function ApplyCharacter( string CN );
function AddHeadshotKills(int Amount);
function AddStalkerKills(int Amount);

function ServerSelectPerkName( name N );
function ServerSelectPerk( Class<SRVeterancyTypes> VetType );

function NotifyStatChanged();

defaultproperties
{
     bInitialized=True
     bUsedCheats=True
     RemoteRole=ROLE_None
     bNetNotify=False
}

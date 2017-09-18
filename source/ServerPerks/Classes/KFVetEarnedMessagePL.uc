class KFVetEarnedMessagePL extends CriticalEventPlus
	abstract;
	
var(Message) localized string EarnedString;

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1, 
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
	local string S;

	if( Class<KFVeterancyTypes>(OptionalObject)==None )
		return "";
	S = Default.EarnedString;
	ReplaceText(S,"%s",Eval(RelatedPRI_1!=None,RelatedPRI_1.PlayerName,"Someone"));
	ReplaceText(S,"%v",Class<KFVeterancyTypes>(OptionalObject).Default.VeterancyName);
	ReplaceText(S,"%l",string(Switch));
	Return S;
}

defaultproperties
{
     EarnedString="%s has earned %v level %l!"
     Lifetime=6
     DrawColor=(G=50,R=255)
     PosY=0.100000
}

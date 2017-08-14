class Utilities extends Actor
	abstract;

static function bool HasItem(Pawn P, Name ItemName)
{
	local Inventory Inv;
	for(Inv=P.Inventory;Inv!=None;Inv=Inv.Inventory)
	{
		if(Inv.Name==ItemName)
			return true;
	}
	return false;
}

local gt = this.getroottable();

gt.MSU.modSkills <- function ()
{
	::mods_hookExactClass("skills/perks/perk_quick_hands", function(o) {
		o.m.IsSpent <- false;
		o.m.ItemActionOrder <- this.Const.ItemActionOrder.Any;

		o.onUpdate = function(_properties)
		{
		}

		o.onCombatStarted = function()
		{
		}

		o.onCombatFinished = function()
		{
			this.skill.onCombatFinished();
		}


		o.isHidden <- function()
		{
			return this.m.IsSpent;
		}

		o.getItemActionCost <- function(_items)
		{
			return this.m.IsSpent ? null : 0;
		}

		o.onPayForItemAction <- function(_skill, _items)
		{
			if (_skill == this)
			{
				this.m.IsSpent = true;
			}
		}

		o.onTurnStart <- function()
		{
			this.m.IsSpent = false;
		}
	});
}
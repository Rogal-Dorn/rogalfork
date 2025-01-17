::mods_hookExactClass("skills/actives/rally_the_troops", function(o)
{
	o.getTooltip = function ()
	{
		local bravery = this.getBonus();
		local tooltip = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Triggers a morale check to rally fleeing allies within 4 tiles distance, with a bonus to Resolve of [color=" + this.Const.UI.Color.PositiveValue + "]+" + bravery + "[/color] based on this character\'s Resolve"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Triggers a morale check to raise the morale of anyone wavering or worse within 4 tiles distance, with a bonus to Resolve of [color=" + this.Const.UI.Color.PositiveValue + "]+" + bravery + "[/color] based on this character\'s Resolve, but lowered by [color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] per tile distance"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]" + bravery + "%[/color] chance to remove [color=#731f39]Charmed[/color], [color=#731f39]Sleeping[/color] or [color=#731f39]Infatuated[/color] from affected targets on cast."
			}
		];

		if (this.getContainer().hasSkill("effects.rallied"))
		{
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not rally others the same turn as being rallied themself[/color]"
			});
		}

		return tooltip;
	}

	o.getBonus <- function()
	{
		return this.Math.floor(this.getContainer().getActor().getCurrentProperties().getBravery() * 0.4);
	}

	o.onUse = function ( _user, _targetTile )
	{
		local myTile = _user.getTile();
		local bravery = this.getBonus();
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());

		foreach( a in actors )
		{
			if (a.getID() == _user.getID())
			{
				continue;
			}

			if (myTile.getDistanceTo(a.getTile()) > 4)
			{
				continue;
			}

			if (a.getFaction() != _user.getFaction())
			{
				continue;
			}
				this.logInfo("attempting to rally");
				if (a.getSkills().hasSkill("effects.charmed") || a.getSkills().hasSkill("effects.legend_intensely_charmed") || a.getSkills().hasSkill("effects.sleeping"))
				{
					local rand = this.Math.rand(1, 100);
					if( bravery > rand )
						{
						this.logInfo("Removing charms");
						a.getSkills().removeByID("effects.charmed");
						a.getSkills().removeByID("effects.sleeping");
						a.getSkills().removeByID("effects.legend_intensely_charmed");
						}
				}
				if ( a.getMoraleState() >= this.Const.MoraleState.Steady )
				{
					continue;
				}
				  this.logInfo("finding rally difficulty");
				local difficulty = bravery;
					this.logInfo("getting distance");
				local distance = a.getTile().getDistanceTo(myTile) * 10;
					this.logInfo("getting morale state");
				local morale = a.getMoraleState();

				if (a.getMoraleState() == this.Const.MoraleState.Fleeing)
				{
					this.logInfo("Turning back the fleeing");
					a.checkMorale(this.Const.MoraleState.Wavering - this.Const.MoraleState.Fleeing, difficulty, this.Const.MoraleCheckType.Default, "status_effect_56");
				}
				else
				{
					this.logInfo("moral check for the rest");
					a.checkMorale(1, difficulty - distance, this.Const.MoraleCheckType.Default, "status_effect_56");
				}

			if (a.getSkills().hasSkill("effects.rallied"))
			{
				continue;
			}


			if (a.getSkills().hasSkill("effects.charmed") || a.getSkills().hasSkill("effects.legend_intensely_charmed") || a.getSkills().hasSkill("effects.sleeping"))
			{
				local rand = this.Math.rand(1, 100);
				if( bravery > rand )
				{						
					a.getSkills().removeByID("effects.charmed");
					a.getSkills().removeByID("effects.sleeping");
					a.getSkills().removeByID("effects.legend_intensely_charmed");
				}
			}

			if ( a.getMoraleState() >= this.Const.MoraleState.Steady )
			{
				continue;
			}

			local difficulty = bravery;
			local distance = a.getTile().getDistanceTo(myTile) * 10;
			local morale = a.getMoraleState();

			if (a.getMoraleState() == this.Const.MoraleState.Fleeing)
			{
				a.checkMorale(this.Const.MoraleState.Wavering - this.Const.MoraleState.Fleeing, difficulty, this.Const.MoraleCheckType.Default, "status_effect_56");
			}
			else
			{
				a.checkMorale(1, difficulty - distance, this.Const.MoraleCheckType.Default, "status_effect_56");
			}

			if (morale != a.getMoraleState())
			{
				a.getSkills().add(this.new("scripts/skills/effects/rallied_effect"));
			}
		}

		this.getContainer().add(this.new("scripts/skills/effects/rallied_effect"));
		return true;
	}
});

this.legend_transformed_bear_effect <- this.inherit("scripts/skills/skill", {
	m = {
	TurnsLeft = 5,
	Body = "",
	Head = "",
	Injury = ""
	},
	function create()
	{
		this.m.ID = "effect.legend_transformed_bear";
		this.m.Name = "Bear Form";
		this.m.Description = "This character is currently a bear";
		this.m.Icon = "ui/perks/bear_circle.png";
		this.m.IconMini = "status_effect_08_mini";
		this.m.Type = this.Const.SkillType.Terrain | this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		{
			ret.extend([
				{
					id = 11,
					type = "text",
					icon = "ui/icons/health.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+50%[/color] hitpoints"
				}
			]);
		}
		return ret;
	}


	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (("State" in this.Tactical) && this.Tactical.State != null) {
			if (actor.getTile().IsVisibleForPlayer)
			{
				if (this.Const.Tactical.HideParticles.len() != 0)
				{
					for( local i = 0; i < this.Const.Tactical.HideParticles.len(); i = ++i )
					{
						this.Tactical.spawnParticleEffect(false, this.Const.Tactical.HideParticles[i].Brushes, actor.getTile(), this.Const.Tactical.HideParticles[i].Delay, this.Const.Tactical.HideParticles[i].Quantity, this.Const.Tactical.HideParticles[i].LifeTimeQuantity, this.Const.Tactical.HideParticles[i].SpawnRate, this.Const.Tactical.HideParticles[i].Stages);
					}
				}
			}
		}
		
		//change the AI 
		this.m.OriginalAgent = actor.getAIAgent();
		this.m.OriginalFaction = actor.getFaction();
		
		if (actor.isPlayerControlled())
		{
			if (this.m.Container.hasSkill("perk.legend_surpress_urges") && !this.m.Container.hasSkill("perk.legend_control_instincts"))
			{
			actor.setAIAgent(this.new("scripts/ai/tactical/agents/bear_agent"));
			actor.getAIAgent().setActor(actor);
			}
			else if (this.m.Container.hasSkill("perk.legend_surppress_urges") && this.m.Container.hasSkill("perk.legend_control_instincts"))
			{

			}
			else	
			{
			actor.setFaction(this.Const.Faction.Beasts);		
			actor.setAIAgent(this.new("scripts/ai/tactical/agents/bear_agent"));
			actor.getAIAgent().setActor(actor);
			}

		}
		else
		{
		actor.setAIAgent(this.new("scripts/ai/tactical/agents/direwolf_agent"));
		actor.getAIAgent().setActor(actor);
		}
	
		this.m.OriginalSocket = actor.getSprite("socket").getBrush().Name;
		actor.getSprite("socket").setBrush("bust_base_beasts");
		actor.setDirty(true);		
		
		// remove items 
		this.logDebug(this.getName() + " removing items");
		local items = actor.getItems();
		if (items.getItemAtSlot(this.Const.ItemSlot.Mainhand))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
			item.drop();
		}
		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
			item.drop();
		}
		if (items.getItemAtSlot(this.Const.ItemSlot.Body))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Body);
			item.drop();
		}
		if (items.getItemAtSlot(this.Const.ItemSlot.Head))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Head);
			item.drop();
		}

		this.m.Body = actor.getSprite("body").getBrush().Name;
		this.m.Head = actor.getSprite("head").getBrush().Name;

		actor.getSprite("body").setBrush("were_bear_body");
		actor.getSprite("head").setBrush("were_bear_head");
		actor.getSprite("injury").setBrush("were_injured");
		actor.getSprite("body").setHorizontalFlipping(1);
		actor.getSprite("head").setHorizontalFlipping(1);
		actor.getSprite("injury").setHorizontalFlipping(1);

		actor.getSprite("armor").Alpha = 10;
		actor.getSprite("helmet").Alpha = 10;
		actor.getSprite("shield_icon").Alpha = 10;
		actor.getSprite("armor_layer_chain").Alpha = 10;
		actor.getSprite("armor_layer_plate").Alpha = 10;
		actor.getSprite("armor_layer_tabbard").Alpha = 10;
		actor.getSprite("armor_layer_tabbard").Alpha = 10;
		actor.getSprite("hair").Alpha = 10;
		actor.getSprite("beard").Alpha = 10;
		actor.getSprite("tattoo_head").Alpha = 10;
		actor.getSprite("tattoo_body").Alpha = 10;
		actor.getSprite("quiver").Alpha = 10;
		actor.getSprite("arms_icon").Alpha = 10;
		actor.getSprite("dirt").Alpha = 10;
		actor.getSprite("accessory").Alpha = 10;
		actor.getSprite("surcoat").Alpha = 10;
		actor.getSprite("armor_upgrade_back").Alpha = 10;
		actor.getSprite("armor_upgrade_front").Alpha = 10;
		actor.getSprite("socket").Alpha = 10;
		this.m.TurnsLeft = 3;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_true_form"))
		{
			this.m.TurnsLeft = 6;
		}

		this.m.Container.add(this.new("scripts/skills/actives/legend_bear_claws"));
		this.m.Container.add(this.new("scripts/skills/actives/legend_bear_bite"));
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		
		//reset AI
		if (this.m.OriginalAgent != null)
		{
			actor.setAIAgent(this.m.OriginalAgent);
		}
		actor.setFaction(this.m.OriginalFaction);
		actor.getSprite("socket").setBrush(this.m.OriginalSocket);
		actor.setDirty(true);
		
		//change appearance 		
		actor.getSprite("body").setBrush(this.m.Body);
		actor.getSprite("head").setBrush(this.m.Head);
		actor.getSprite("armor").Alpha = 255;
		actor.getSprite("helmet").Alpha = 255;
		actor.getSprite("shield_icon").Alpha = 255;
		actor.getSprite("armor_layer_chain").Alpha = 255;
		actor.getSprite("armor_layer_plate").Alpha = 255;
		actor.getSprite("armor_layer_tabbard").Alpha = 255;
		actor.getSprite("armor_layer_cloak").Alpha = 255;
		actor.getSprite("hair").Alpha = 255;
		actor.getSprite("beard").Alpha = 255;
		actor.getSprite("tattoo_head").Alpha = 255;
		actor.getSprite("tattoo_body").Alpha = 255;
		actor.getSprite("quiver").Alpha = 255;
		actor.getSprite("arms_icon").Alpha = 255;
		actor.getSprite("dirt").Alpha = 255;
		actor.getSprite("accessory").Alpha = 255;
		actor.getSprite("surcoat").Alpha = 255;
		actor.getSprite("armor_upgrade_back").Alpha = 255;
		actor.getSprite("armor_upgrade_front").Alpha = 255;
		actor.getSprite("socket").Alpha = 255;
		actor.getSprite("body").setHorizontalFlipping(0);
		actor.getSprite("head").setHorizontalFlipping(0);
		actor.getSprite("injury").setHorizontalFlipping(0);

		if (("State" in this.Tactical) && this.Tactical.State != null)
		{
			if (actor.getTile().IsVisibleForPlayer)
			{
				if (this.Const.Tactical.HideParticles.len() != 0)
				{
					for( local i = 0; i < this.Const.Tactical.HideParticles.len(); i = ++i )
					{
						this.Tactical.spawnParticleEffect(false, this.Const.Tactical.HideParticles[i].Brushes, actor.getTile(), this.Const.Tactical.HideParticles[i].Delay, this.Const.Tactical.HideParticles[i].Quantity, this.Const.Tactical.HideParticles[i].LifeTimeQuantity, this.Const.Tactical.HideParticles[i].SpawnRate, this.Const.Tactical.HideParticles[i].Stages);
					}
				}
			}
		}

		actor.getSkills().removeByID("actives.legend_bear_claws");
		actor.getSkills().removeByID("actives.legend_bear_bite");
		local items = actor.getItems();
		items.getData()[this.Const.ItemSlot.Offhand][0] = null;
		items.getData()[this.Const.ItemSlot.Mainhand][0] = null;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		actor.getSprite("body").setBrush("were_bear_body");
		actor.getSprite("head").setBrush("were_bear_head");
		
		actor.getSprite("armor").Alpha = 10;
		actor.getSprite("helmet").Alpha = 10;
		actor.getSprite("shield_icon").Alpha = 10;
		actor.getSprite("armor_layer_chain").Alpha = 10;
		actor.getSprite("armor_layer_plate").Alpha = 10;
		actor.getSprite("armor_layer_tabbard").Alpha = 10;
		actor.getSprite("armor_layer_tabbard").Alpha = 10;
		actor.getSprite("hair").Alpha = 10;
		actor.getSprite("beard").Alpha = 10;
		actor.getSprite("tattoo_head").Alpha = 10;
		actor.getSprite("tattoo_body").Alpha = 10;
		actor.getSprite("quiver").Alpha = 10;
		actor.getSprite("arms_icon").Alpha = 10;
		actor.getSprite("dirt").Alpha = 10;
		actor.getSprite("accessory").Alpha = 10;
		actor.getSprite("surcoat").Alpha = 10;
		actor.getSprite("armor_upgrade_back").Alpha = 10;
		actor.getSprite("armor_upgrade_front").Alpha = 10;
		actor.getSprite("socket").Alpha = 10;

		_properties.HitpointsMult *= 1.5;

	}

	function onCombatFinished()
	{
		local actor = this.getContainer().getActor();
		
		//reset AI
		if (this.m.OriginalAgent != null)
		{
			actor.setAIAgent(this.m.OriginalAgent);
		}
		actor.setFaction(this.m.OriginalFaction);
		actor.getSprite("socket").setBrush(this.m.OriginalSocket);
		actor.setDirty(true);
		
		//change appearance 		
		actor.getSprite("body").setBrush(this.m.Body);
		actor.getSprite("head").setBrush(this.m.Head);
		actor.getSprite("armor").Alpha = 255;
		actor.getSprite("helmet").Alpha = 255;
		actor.getSprite("shield_icon").Alpha = 255;
		actor.getSprite("armor_layer_chain").Alpha = 255;
		actor.getSprite("armor_layer_plate").Alpha = 255;
		actor.getSprite("armor_layer_tabbard").Alpha = 255;
		actor.getSprite("armor_layer_cloak").Alpha = 255;
		actor.getSprite("hair").Alpha = 255;
		actor.getSprite("beard").Alpha = 255;
		actor.getSprite("tattoo_head").Alpha = 255;
		actor.getSprite("tattoo_body").Alpha = 255;
		actor.getSprite("quiver").Alpha = 255;
		actor.getSprite("arms_icon").Alpha = 255;
		actor.getSprite("dirt").Alpha = 255;
		actor.getSprite("accessory").Alpha = 255;
		actor.getSprite("surcoat").Alpha = 255;
		actor.getSprite("armor_upgrade_back").Alpha = 255;
		actor.getSprite("armor_upgrade_front").Alpha = 255;
		actor.getSprite("socket").Alpha = 255;
		actor.getSprite("body").setHorizontalFlipping(0);
		actor.getSprite("head").setHorizontalFlipping(0);
		actor.getSprite("injury").setHorizontalFlipping(0);

		if (("State" in this.Tactical) && this.Tactical.State != null)
		{
			if (actor.getTile().IsVisibleForPlayer)
			{
				if (this.Const.Tactical.HideParticles.len() != 0)
				{
					for( local i = 0; i < this.Const.Tactical.HideParticles.len(); i = ++i )
					{
						this.Tactical.spawnParticleEffect(false, this.Const.Tactical.HideParticles[i].Brushes, actor.getTile(), this.Const.Tactical.HideParticles[i].Delay, this.Const.Tactical.HideParticles[i].Quantity, this.Const.Tactical.HideParticles[i].LifeTimeQuantity, this.Const.Tactical.HideParticles[i].SpawnRate, this.Const.Tactical.HideParticles[i].Stages);
					}
				}
			}
		}

		actor.getSkills().removeByID("actives.legend_bear_claws");
		actor.getSkills().removeByID("actives.legend_bear_bite");
		local items = actor.getItems();
		items.getData()[this.Const.ItemSlot.Offhand][0] = null;
		items.getData()[this.Const.ItemSlot.Mainhand][0] = null;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}
});


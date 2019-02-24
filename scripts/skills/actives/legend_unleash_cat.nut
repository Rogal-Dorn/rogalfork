this.legend_unleash_cat <- this.inherit("scripts/skills/skill", {
	m = {
		Item = null,
		Sounds0 = [
			"sounds/enemies/cat_hurt_01.wav",
			"sounds/enemies/cat_hurt_02.wav",
			"sounds/enemies/cat_hurt_03.wav",
			"sounds/enemies/cat_hurt_04.wav",
			"sounds/enemies/cat_hurt_05.wav",
			"sounds/enemies/cat_hurt_06.wav",
			"sounds/enemies/cat_hurt_07.wav"
		],
		Sounds1 = [
			"sounds/enemies/cat_death_01.wav",
			"sounds/enemies/cat_death_02.wav",
			"sounds/enemies/cat_death_03.wav",
			"sounds/enemies/cat_death_04.wav",
			"sounds/enemies/cat_death_05.wav"
		],
		Sounds2 = [
			"sounds/enemies/cat_flee_01.wav",
			"sounds/enemies/cat_flee_02.wav",
			"sounds/enemies/cat_flee_03.wav"
		],
		Sounds3 = [
			"sounds/enemies/cat_idle_01.wav",
			"sounds/enemies/cat_idle_02.wav",
			"sounds/enemies/cat_idle_03.wav"
		],
		Sounds4 = [
			"sounds/enemies/cat_attack_01.wav",
			"sounds/enemies/cat_attack_02.wav",
			"sounds/enemies/cat_attack_03.wav",
			"sounds/enemies/cat_attack_04.wav"
		],
		Sounds5 = [
			"sounds/enemies/cat_attack_01.wav",
			"sounds/enemies/cat_attack_02.wav",
			"sounds/enemies/cat_attack_03.wav",
			"sounds/enemies/cat_attack_04.wav",
			"sounds/enemies/cat_attack_05.wav",
		]
	},
	function setItem( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	function create()
	{
		this.m.ID = "actives.legend_unleash_cat";
		this.m.Name = "Summon Cat";
		this.m.Description = "Summon your cat, hopefully it doesn\'t just run away. Needs a free tile adjacent.";
		this.m.Icon = "skills/active_83.png";
		this.m.IconDisabled = "skills/active_83_sw.png";
		this.m.Overlay = "active_83";
		this.m.SoundOnUse = [
			"sounds/combat/cat_purr_01.wav",
			"sounds/combat/cat_purr_02.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 5;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsTargetingActor = false;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function addResources()
	{
		this.skill.addResources();

		foreach( r in this.m.Sounds0 )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.Sounds1 )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.Sounds2 )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.Sounds3 )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.Sounds4 )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.Sounds5 )
		{
			this.Tactical.addResource(r);
		}
	}

	function getTooltip()
	{
		local ret = [
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
			}
		];
		return ret;
	}

	function isUsable()
	{
		if (this.m.Item.isUnleashed() || !this.skill.isUsable())
		{
			return false;
		}

		return true;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		local actor = this.getContainer().getActor();
		return this.skill.onVerifyTarget(_originTile, _targetTile) && _targetTile.IsEmpty;
	}

	function onUpdate( _properties )
	{
		this.m.IsHidden = this.m.Item.isUnleashed();
	}

	function onUse( _user, _targetTile )
	{
		local entity = this.Tactical.spawnEntity(this.m.Item.getScript(), _targetTile.Coords.X, _targetTile.Coords.Y);
		entity.setFaction(this.Const.Faction.PlayerAnimals);
		entity.setItem(this.m.Item);
		entity.setName(this.m.Item.getName());
		entity.setVariant(this.m.Item.getVariant());
		this.m.Item.setEntity(entity);

		if (this.m.Item.getArmorScript() != null)
		{
			local item = this.new(this.m.Item.getArmorScript());
			entity.getItems().equip(item);
		}

		if (this.getContainer().hasSkill("background.houndmaster"))
		{
			entity.setMoraleState(this.Const.MoraleState.Confident);
		}

		if (!this.World.getTime().IsDaytime)
		{
			entity.getSkills().add(this.new("scripts/skills/special/night_effect"));
		}

		this.m.IsHidden = true;
		return true;
	}

});

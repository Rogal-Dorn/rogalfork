this.legend_vala_inscribe_armor <- this.inherit("scripts/skills/skill", {
	m = {
		InscriptionSuccessTime = 0,
		InscriptionSuccessCooldown = 0,
		InscriptionTryTime = 0,
		InscriptionTryCooldown = 0,
		FirstTime = true
	},
	function create()
	{
		this.m.ID = "perk.legend_vala_inscribe_armor";
		this.m.Name = "Rune Sigils: Armors";
		this.m.Description = "";
		this.m.Icon = "ui/perks/legend_vala_inscribe_armor.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast + 3;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
		this.m.IsSerialized = true;
	}


	function onSerialize( _out )
	{
		_out.writeF32(this.m.InscriptionSuccessTime);
		_out.writeU8(this.m.InscriptionSuccessCooldown);
		_out.writeF32(this.m.InscriptionTryTime);
		_out.writeU8(this.m.InscriptionTryCooldown);
		_out.writeBool(this.m.FirstTime);
	}


	function onDeserialize( _in )
	{
		this.m.InscriptionSuccessTime = _in.readF32();
		this.m.InscriptionSuccessCooldown = _in.readU8();
		this.m.InscriptionTryTime = _in.readF32();
		this.m.InscriptionTryCooldown = _in.readU8();
		this.m.FirstTime = _in.readBool();
	}


	function isHidden()
	{
		return true;
	}


	function getTooltip()
	{
		local tooltip =
		[
			{
				id = 1,
				type = "title",
				text = this.getName()
			}
		];

		local countdown = this.Math.ceil((this.m.InscriptionSuccessCooldown - this.getDaysSinceInscriptionSuccess()));
		local valaname = this.getContainer().getActor().m.Name;

		if (countdown > 0)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + countdown + "[/color] days until " + valaname + " can begin inscribing rocks with armor specific rune sigils again."
			});
		}

		return tooltip;
	}


	function getTimeSinceInscriptionTry()
	{
		return ((this.Time.getVirtualTimeF() - this.m.InscriptionTryTime) / this.World.getTime().SecondsPerDay);
	}


	function getDaysSinceInscriptionSuccess()
	{
		return ((this.Time.getVirtualTimeF() - this.m.InscriptionSuccessTime) / this.World.getTime().SecondsPerDay);
	}


	function getCurrentTime()
	{
		return this.Time.getVirtualTimeF();
	}


	function onUpdate (_properties)
	{
		if (this.World.State.getCombatStartTime() != 0)
		{
			return;
		}

		if ((this.getTimeSinceInscriptionTry() >= this.m.InscriptionTryCooldown && this.getDaysSinceInscriptionSuccess() >= this.m.InscriptionSuccessCooldown && this.World.Assets.getStash().hasEmptySlot()) || (this.m.FirstTime == true && this.World.Assets.getStash().hasEmptySlot()))
		{
			local expertise = 15.0 + ((this.getContainer().getActor().getLevel() * 15.00) / this.Const.LevelXP.len());

			if ((this.Math.rand(1, 400) <= expertise) || this.m.FirstTime == true)
			{
				local stash = this.World.Assets.getStash();
				local token = this.new("scripts/items/rune_sigils/legend_vala_inscription_token");
				token.setRuneVariant(this.Math.rand(21, 23));
				token.updateRuneSigilToken();
				stash.add(token);

				this.m.InscriptionSuccessTime = this.getCurrentTime();
				if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_vala_inscription_mastery"))
				{
					this.m.InscriptionSuccessCooldown = 15;
				}
				else
				{
					this.m.InscriptionSuccessCooldown = 20;
				}
				this.m.FirstTime = false;
				this.Sound.play("sounds/legend_vala_inscribe.wav");
			}

			this.m.InscriptionTryTime = this.getCurrentTime();
			if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_vala_inscription_mastery"))
			{
				this.m.InscriptionTryCooldown = 0.18;
			}
			else
			{
				this.m.InscriptionTryCooldown = 0.25;
			}
		}
	}


	function onAdded()
	{
		if (!this.getContainer().getActor().getSkills().hasSkill("special.legend_vala_inscription_information"))
		{
			this.getContainer().getActor().getSkills().add(this.new("scripts/skills/perks/legend_vala_inscription_information"));
		}
	}


	function getCountdownTime()
	{
		return this.Math.ceil((this.m.InscriptionSuccessCooldown - this.getDaysSinceInscriptionSuccess()));
	}
});

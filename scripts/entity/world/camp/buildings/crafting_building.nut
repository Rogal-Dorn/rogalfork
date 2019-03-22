this.crafting_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {
        BaseCraft = 50.0,
        ItemsCrafted = [],
        Queue = []
	},
    function create()
    {
        this.camp_building.create();
        this.m.ID = this.Const.World.CampBuildings.Crafting;
        this.m.Slot = "crafting";
        this.m.Name = "Craft";
        this.m.Description = "Craft items"
		this.m.UIImage = "ui/settlements/taxidermist_day_empty";
		this.m.UIImageNight = "ui/settlements/taxidermist_night_empty";
		this.m.UIImageFull = "ui/settlements/taxidermist_day_full";
		this.m.UIImageNightFull = "ui/settlements/taxidermist_night_full";
    }

    function init()
    {
		this.m.ItemsCrafted = [];
    }

    function onInit()
    {
		local q = [];
		for (local i = 0; i < this.m.Queue.len(); i = ++i)
		{
			if (this.m.Queue[i] == null)
			{
				continue
			}
			if (this.m.Queue[i].Blueprint == null)
			{
				continue
			}			
			q.push(this.m.Queue[i])
		}
		this.m.Queue = q
	}

    function getModifiers()
    {
        local ret = 
        {
            Craft = 0.0,
            Assigned = 0,
            Modifiers = []

        }
		local roster = this.World.getPlayerRoster().getAll();
        foreach( bro in roster )
        {
            if (bro.getCampAssignment() != this.m.ID)
            {
                continue
            }

            local rm = (this.m.BaseCraft + this.m.BaseCraft * this.Const.LegendMod.getCraftingModifier(bro.getBackground().getID()))
            ret.Craft += rm
            ++ret.Assigned
			ret.Modifiers.push([rm, bro.getName(), bro.getBackground().getNameOnly()]);	
        }
        return ret;
    }

	function getResults()
    {
		local res = []
		local id = 20;
		foreach (b in this.m.ItemsCrafted)
		{
			res.push({
		 		id = id,
		 		icon = b.getIcon(),
		 		text = "You craft a " + b.getName()
			})
			++id;
		}
        return res;
    }

    function update ()
    {
        local modifiers = this.getModifiers();
        foreach (i, r in this.m.Queue)
        {
            if (r == null)
            {
                continue;
            }

			if (r.Blueprint == null)
			{
				continue;
			}

			if (!r.Blueprint.isCraftable())
			{
				continue;
			}

            local needed = r.Blueprint.getCost() - r.Points;

            if (modifiers.Craft < needed)
            {
                needed = modifiers.Craft;
            }
			r.Points += needed;
            modifiers.Craft -= needed;

			if (r.Points >= r.Blueprint.getCost())
			{
				r.Blueprint.craft();
				this.m.ItemsCrafted.push(r.Blueprint)
				this.m.Queue[i] = null;
			}

            if (modifiers.Craft <= 0) 
            {
                break
            }

        }
    }

	function getQueue()
	{
		local ret = [];
		foreach( b in this.m.Queue )
		{
			if (b == null)
			{
				continue
			}
			local r = b.Blueprint.getUIData();
			r.Percentage <- (r.Points / (b.Blueprint.getCost() * 1.0)) * 100
			ret.push(r);
		}
		return ret;
	}

    function getRequiredTime()
    {
        local points = 0;
        foreach (r in this.m.Queue)
        {
            if (r == null)
            {
                continue;
            }
            
            points += r.Blueprint.getCost();
        }
        local modifiers = this.getModifiers();
        return this.Math.ceil(points / modifiers.Craft);
    }

    function getAssignedBros()
    {
        local mod = this.getModifiers();
        return mod.Assigned;
    }

	function onAdd ( _blueprintID )
	{
		local blueprint = this.World.Crafting.getBlueprint(_blueprintID);
		if (!blueprint.isCraftable())
		{
			return;
		}
		this.m.Queue.push({
			Points = 0.0,
			Blueprint = blueprint
		});
		if (blueprint.getSounds().len() != 0)
		{
			this.Sound.play(blueprint.getSounds()[this.Math.rand(0, blueprint.getSounds().len() - 1)], 1.0);
		}		
	}

	function onRemove ( _idx )
	{
		local q = [];
		for (local i = 0; i < this.m.Queue.len(); i = ++i)
		{
			if (i == _idx)
			{
				continue
			}
			q.push(this.m.Queue[i])
		}
		this.m.Queue = q
	}

	function onSwap ( _source, _target)
	{
		local item = this.m.Queue[_source];
		this.m.Queue[_source] = this.m.Queue[_target];
		this.m.Queue[_target] = item;
		if (item.Blueprint.getSounds().len() != 0)
		{
			this.Sound.play(item.Blueprint.getSounds()[this.Math.rand(0, blueprint.getSounds().len() - 1)], 1.0);
		}
	}

	function onClicked( _campScreen )
	{
        _campScreen.showCraftingDialog();
        this.camp_building.onClicked(_campScreen);
	}
        
	function onSerialize( _out )
	{
		this.onInit(); //clear out null queue items
		_out.writeU16(this.m.Queue.len());
		foreach( b in this.m.Queue )
		{
			_out.writeString(b.Blueprint.getID());
			_out.writeF32(b.Points)
		}
	}

	function onDeserialize( _in )
	{
		this.m.Queue = [];
		local num = _in.readU16();
		for( local i = 0; i < num; i = ++i )
		{
			this.m.Queue.push({
				Blueprint = this.getBlueprint(_in.readString()),
				Points = _in.readF32(),
			})
		}
	}
    
});
this.formations_container <- {
	m = {
		Actor = null,
        CurrentIndex = 0
		Items = [],
        Bags = [],
        Positions = []
	},
	function setActor( _a )
	{
		this.m.Actor = this.WeakTableRef(_a);
	}

	function getActor()
	{
		return this.m.Actor;
	}

	function create()
	{
        for( local i = 0; i < this.Const.Formations.Count; i = ++i )
        {
            this.m.Positions.push(255);
            this.m.Items.push([]);
            this.m.Bags.push([]);
            this.m.CurrentIndex = 0;
        }
	}

    function setFormation(_index) 
    {
        this.m.CurrentIndex = _index;
    }

    function getCurrentIndex() 
    {
        return this.m.CurrentIndex;
    }

    function getPosition()
    {
        return this.m.Positions[this.m.CurrentIndex];
    }

    function getItems() 
    {
        return this.m.Items[this.m.CurrentIndex];
    }

    function getBags() 
    {
        return this.m.Bags[this.m.CurrentIndex];
    }

    function savePosition( _pos )
    {
        this.m.Positions[this.m.CurrentIndex] = _pos;
    }

    function saveItems( _itemContainer )
    {
        this.m.Items[this.m.CurrentIndex].clear();
        this.m.Bags[this.m.CurrentIndex].clear();
        local items = _itemContainer.getAllItems();
        foreach( item in items ) {
            if (item.isEquipped())
            {
                this.m.Items[this.m.CurrentIndex].push(item.getInstanceID());
            } 
            else
            {
               this.m.Bags[this.m.CurrentIndex].push(item.getInstanceID());
            }
        }
    }

	function onSerialize( _out )
	{
		_out.writeU8(this.m.CurrentIndex);

		for( local i = 0; i < this.Const.Formations.Count; i = ++i )
        {
		    _out.writeU8(this.m.Positions[i]);
            local items = this.m.Items[i];
            _out.writeU8(items.len());
            foreach( item in items) 
            {
                _out.writeString(item);
            }
            local bags = this.m.Bags[i];
            _out.writeU8(bags.len());
            foreach( item in bags) 
            {
                _out.writeString(item);
            }            
        }
	}

	function onDeserialize( _in )
	{
		this.m.CurrentIndex = _in.readU8();
		for( local i = 0; i < this.Const.Formations.Count; i = ++i )
        {
		    this.m.Positions[i] = _in.readU8();
            local numItems = _in.readU8();
            for (local j = 0; j < numItems; j = ++j)
            {
                this.m.Items[i].push(_in.readString());
            }
            local numBags = _in.readU8();
            for (local j = 0; j < numBags; j = ++j)
            {
                this.m.Bags[i].push(_in.readString());
            }
        }
	}

};

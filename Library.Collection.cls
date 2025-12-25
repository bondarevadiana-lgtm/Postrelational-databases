Class Library.Collection Extends %Persistent
{
Property Name As %String [ Required ];

Relationship Items As Library.Item [ Cardinality = many, Inverse = Collection ];

Property Members As list Of Library.Member;

Method %OnNew() As %Status
{
    Set ..Members = ##class(%ListOfObjects).%New()
    Quit $$$OK
}

ClassMethod PrintCollectionItems(collectionId As %Integer)
{

    &sql(DECLARE C1 CURSOR FOR
        SELECT Title, PublishedYear
        FROM Library.Item
        WHERE Collection = :collectionId)
    
    &sql(OPEN C1)
    Write "Items in collection ID ", collectionId, ":", !
    For {
        &sql(FETCH C1 INTO :title, :year)
        Quit:SQLCODE
        Write "- ", title, " (", year, ")", !
    }
    &sql(CLOSE C1)
}

Method AddItem(item As Library.Item) As %Status
{
    Do ..Items.Insert(item)
    Quit $this.%Save()
}

Method AddMember(member As Library.Member) As %Status
{
    Do ..Members.Insert(member)
    Quit $this.%Save()
}
}
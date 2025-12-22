Class Library.Collection Extends %Persistent
{

Property Name As %String [ Required ];

Property Items As list Of Library.Item;

Property Members As list Of Library.Member;

Method %OnNew() As %Status
{
    Set ..Items = ##class(%ListOfObjects).%New()
    Set ..Members = ##class(%ListOfObjects).%New()
    Quit $$$OK
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

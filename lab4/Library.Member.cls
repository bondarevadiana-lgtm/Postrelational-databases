Class Library.Member Extends %Persistent
{

Property Name As %String [ Required ];

Property MemberID As %Integer;

Property RegisteredDate As %TimeStamp;

Property BorrowLimit As %Integer [ InitialExpression = 3 ];

Property BorrowedItems As list Of Library.Item;

Method %OnNew() As %Status
{
    Set ..BorrowedItems = ##class(%ListOfObjects).%New()
    Quit $$$OK
}

Index IDIndex On MemberID [ Unique ];

Method CanBorrow() As %Boolean
{
    Quit (..BorrowedItems.Count() < ..BorrowLimit)
}

Method BorrowItem(item As Library.Item) As %Status
{
    If ..CanBorrow() {
        Do ..BorrowedItems.Insert(item)
        Quit $this.%Save()
    }
    Else {
        Quit $$$ERROR($$$GeneralError, "Cannot borrow more items. Limit reached.")
    }
}

}

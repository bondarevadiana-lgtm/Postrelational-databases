Class Library.Member Extends %Persistent
{
Property Name As %String [ Required ];
Property MemberID As %Integer;
Property RegisteredDate As %TimeStamp;
Property BorrowLimit As %Integer [ InitialExpression = 3 ];
Property BorrowedItems As list Of Library.Item;

Index IDIndex On MemberID [ Unique ];

Method BorrowItem(item As Library.Item) As %Status
{
    If (..BorrowedItems.Count() < ..BorrowLimit) {
        Do ..BorrowedItems.Insert(item)
        Quit ..%Save()
    }
    Quit $$$ERROR($$$GeneralError, "Limit reached")
}

Query ActiveBorrowers() As %Query(ROWSPEC = "Name:%String,BorrowedCount:%Integer") [ SqlProc ]
{
}

ClassMethod ActiveBorrowersExecute(ByRef qHandle As %Binary) As %Status
{
    Set qHandle = ""
    Quit $$$OK
}

ClassMethod ActiveBorrowersFetch(ByRef qHandle As %Binary, ByRef Row As %List, ByRef AtEnd As %Integer = 0) As %Status
{
    Set qHandle = $Order(^Library.MemberD(qHandle))
    If qHandle = "" { Set AtEnd = 1, Row = "" Quit $$$OK }
    Set obj = ##class(Library.Member).%OpenId(qHandle)
    If obj.BorrowedItems.Count() > 0 {
        Set Row = $ListBuild(obj.Name, obj.BorrowedItems.Count())
    } Else { Quit ..ActiveBorrowersFetch(.qHandle, .Row, .AtEnd) }
    Quit $$$OK
}

ClassMethod ActiveBorrowersClose(ByRef qHandle As %Binary) As %Status
{
    Quit $$$OK
}
}
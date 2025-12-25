Class Library.Item Extends %Persistent
{
Property Title As %String [ Required ];
Property ItemID As %Integer [ Required ];
Property PublishedYear As %Integer;
Property DescriptionStream As %Stream.GlobalCharacter;

Index IDKeyIndex On ItemID [ IdKey, Unique ];

Query FindByYear(year As %Integer) As %SQLQuery
{
    SELECT %ID, Title, ItemID, PublishedYear FROM Library.Item
    WHERE PublishedYear = :year
}

Relationship Collection As Library.Collection [ Cardinality = one, Inverse = Items ];
}
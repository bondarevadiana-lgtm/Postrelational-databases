Class Library.Item Extends %Persistent
{

Property Title As %String [ Required ];

Property ItemID As %Integer;

Property PublishedYear As %Integer;

Property DescriptionStream As %Stream.GlobalCharacter;

Index IDIndex On ItemID [ Unique ];

}

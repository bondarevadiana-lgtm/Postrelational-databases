Class Library.Item Extends %Persistent
{

Property Title As %String [ Required ];

Property ItemID As %Integer;

Property PublishedYear As %Integer;

Property DescriptionStream As %Stream.GlobalCharacter;

Property IsNewRelease As %Boolean [ Calculated, SqlComputeCode = { set {*} = ($select({PublishedYear}="":0, 1:({PublishedYear} >= ($extract($zd($h,8),1,4) - 2)))) }, SqlComputed ];

Method IsNewReleaseGet() As %Boolean
{
    Set currentYear = $Extract($ZDate($Horolog, 8), 1, 4)
    If (..PublishedYear = "") Quit 0
    Quit (..PublishedYear >= (currentYear - 2))
}

Index IDIndex On ItemID [ Unique ];

}

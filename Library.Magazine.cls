Class Library.Magazine Extends Library.Item
{

Property IssueNumber As %Integer;

Method DisplayInfo() As %String
{
    Quit "Magazine: '" _ ..Title _ "', Issue #" _ ..IssueNumber _ " (" _ ..PublishedYear _ ")."
}

}
Class Library.Magazine Extends Library.Item
{

Property IssueNumber As %Integer;

Query FindByIssue(issue As %Integer) As %SQLQuery
{
    SELECT %ID, Title, IssueNumber, PublishedYear FROM Library.Magazine
    WHERE IssueNumber = :issue
}

Method DisplayInfo() As %String
{
    Quit "Magazine: '" _ ..Title _ "', Issue #" _ ..IssueNumber _ " (" _ ..PublishedYear _ ")."
}

}
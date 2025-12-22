Class Library.Book Extends Library.Item
{

Property Author As %String;

Property Pages As %Integer;

Method DisplayInfo() As %String
{
    Quit "Book: '" _ ..Title _ "' by " _ ..Author _ " (" _ ..PublishedYear _ "), " _ ..Pages _ " pages."
}

}
Class Library.Book Extends Library.Item
{
Property Author As %String;
Property Pages As %Integer;

Trigger LogNewBook [ Event = INSERT, Time = AFTER ]
{
    Set title = {Title}
    Write !,"[TRIGGER] Book '", title, "' was successfully saved to DB.", !
}
}
Class Library.SOAP Extends %SOAP.WebService
{

Parameter SERVICENAME = "LibraryService";

Parameter NAMESPACE = "http://tempuri.org";

Method SaveBook(title As %String, author As %String, itemId As %Integer, year As %Integer) As %String [ WebMethod ]
{

    If ##class(Library.Book).%ExistsId(itemId) {
        Set book = ##class(Library.Book).%OpenId(itemId)
    } Else {
        Set book = ##class(Library.Book).%New()
        Set book.ItemID = itemId
    }
    
    Set book.Title = title
    Set book.Author = author
    Set book.PublishedYear = year
    
    Set sc = book.%Save()
    If $$$ISOK(sc) {
        Return "Книга '"_title_"' успішно збережена. ID: "_book.%Id()
    } Else {
        Return "Помилка збереження: "_$system.Status.GetErrorText(sc)
    }
}

Method DeleteBook(id As %Integer) As %Boolean [ WebMethod ]
{

    Set sc = ##class(Library.Book).%DeleteId(id)
    Quit $$$ISOK(sc)
}

}
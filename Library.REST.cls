Class Library.REST Extends %CSP.REST
{

/// Налаштування маршрутів (URL)
XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/book/:id" Method="GET" Call="GetBook"/>
<Route Url="/book" Method="POST" Call="CreateBook"/>
<Route Url="/book/:id" Method="DELETE" Call="DeleteBook"/>
</Routes>
}


ClassMethod GetBook(id As %Integer) As %Status
{
    Set %response.ContentType = "application/json"

    Set book = ##class(Library.Book).%OpenId(id)
    If '$IsObject(book) {
        Set %response.Status = "404 Not Found"
        Quit $$$OK
    }
    
    Set proxy = {
        "Title": (book.Title),
        "Author": (book.Author),
        "Year": (book.PublishedYear)
    }
    Write proxy.%ToJSON()
    Quit $$$OK
}


ClassMethod CreateBook() As %Status
{
    Set %response.ContentType = "application/json"

    Set data = {}.%FromJSON(%request.Content)
    
    Set book = ##class(Library.Book).%New()
    Set book.Title = data.Title
    Set book.Author = data.Author
    Set book.ItemID = data.ItemID
    Set book.PublishedYear = data.Year
    
    Set sc = book.%Save()
    If $$$ISERR(sc) {
        Set %response.Status = "500 Internal Server Error"
        Quit sc
    }
    
    Write {"status": "success", "id": (book.%Id())}.%ToJSON()
    Quit $$$OK
}


ClassMethod DeleteBook(id As %Integer) As %Status
{
    Set %response.ContentType = "application/json"

    Set sc = ##class(Library.Book).%DeleteId(id)
    If $$$ISERR(sc) {
        Set %response.Status = "404 Not Found"
        Quit $$$OK
    }
    
    Write {"status": "deleted"}.%ToJSON()
    Quit $$$OK
}

}
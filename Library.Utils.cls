Class Library.Utils
{
ClassMethod GenerateData(count As %Integer = 5) As %Status
{
    TSTART
    Try {
        Set collection = ##class(Library.Collection).%New()
        Set collection.Name = "Central City Library"
        
        For i=1:1:count {

            Set book = ##class(Library.Book).%New()
            Set book.Title = "Book Title " _ i
            Set book.ItemID = i
            Set book.PublishedYear = 2020 + (i # 6) 
            Set book.Author = "Author " _ i
            Set book.Pages = 100 * i
            Do collection.AddItem(book)
            
            Set mag = ##class(Library.Magazine).%New()
            Set mag.Title = "Magazine Vol " _ i
            Set mag.ItemID = i + 1000
            Set mag.PublishedYear = 2024
            Set mag.IssueNumber = i
            Do collection.AddItem(mag)
            
            Set member = ##class(Library.Member).%New()
            Set member.Name = "User " _ i
            Set member.MemberID = i
            Set member.RegisteredDate = $zdt($h, 3)
            Do collection.AddMember(member)
        }
        
        Set sc = collection.%Save()
        If $$$ISERR(sc) Throw ##class(%Exception.StatusException).CreateFromStatus(sc)
        
        TCOMMIT
        Write "Data generated successfully!",!
    } Catch ex {
        TROLLBACK
        Write "Error: ", ex.DisplayString(), !
        Return ex.AsStatus()
    }
    Quit $$$OK
}
}
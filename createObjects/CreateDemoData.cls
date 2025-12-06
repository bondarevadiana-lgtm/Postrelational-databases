Class CreateObjects.CreateDemoData
{

ClassMethod Run()
{
    Set sc = $$$OK

    Try {
        Write "--- Початок створення об'єктів ---", !

        /* --- Книга 1 --- */
        Set b1 = ##class(Library.Book).%New()
        Set b1.Title = "1984 George Orwell"
        Set b1.PublishedYear = 1949
        Set b1.Author = "George Orwell"
        Set b1.Pages = 328
        Set b1.DescriptionStream = "A classic dystopian novel"
        Set sc = b1.%Save()
        If $$$ISERR(sc) Throw sc
        Write "Створено Книгу 1: ", b1.DisplayInfo(), ", ID: "_b1.%Id(), !

        /* --- Книга 2 --- */
        Set b2 = ##class(Library.Book).%New()
        Set b2.Title = "The Hobbit"
        Set b2.PublishedYear = 1937
        Set b2.Author = "J.R.R. Tolkien"
        Set b2.Pages = 310
        Set sc = b2.%Save()
        If $$$ISERR(sc) Throw sc
        Write "Створено Книгу 2: ", b2.DisplayInfo(), ", ID: "_b2.%Id(), !

        /* --- Журнал 1 --- */
        Set m1 = ##class(Library.Magazine).%New()
        Set m1.Title = "National Geographic"
        Set m1.PublishedYear = 2024
        Set m1.IssueNumber = 112
        Set sc = m1.%Save()
        If $$$ISERR(sc) Throw sc
        Write "Створено Журнал 1: ", m1.Title, " №", m1.IssueNumber, ", ID: "_m1.%Id(), !

        /* --- Журнал 2 --- */
        Set m2 = ##class(Library.Magazine).%New()
        Set m2.Title = "Burda"
        Set m2.PublishedYear = 2020
        Set m2.IssueNumber = 120
        Set sc = m2.%Save()
        If $$$ISERR(sc) Throw sc
        Write "Створено Журнал 2: ", m2.Title, " №", m2.IssueNumber, ", ID: "_m2.%Id(), !

        /* --- Читач 1 --- */
        Set member1 = ##class(Library.Member).%New()
        Set member1.MemberID = 1001
        Set member1.Name = "Alice Johnson"
        Set member1.RegisteredDate = $ZDT($H, 3)
        Do member1.BorrowedItems.Insert(b1)
        Do member1.BorrowedItems.Insert(m1)
        Set sc = member1.%Save()
        If $$$ISERR(sc) Throw sc
        Write "Створено Читача 1: "_member1.Name_", запозичені предмети: "
        If member1.BorrowedItems.Count()=0 {
           Write "немає"
        } Else {
          Set id=""
          For {
            Set id = member1.BorrowedItems.Next(id)
            Quit:id=""
            Set obj = ##class(Library.Item).%OpenId(id)
            Write obj.Title_", "
          }
        }
        Write ", ID: "_member1.%Id(), !


        /* --- Читач 2 --- */
        Set member2 = ##class(Library.Member).%New()
        Set member2.MemberID = 1002
        Set member2.Name = "Bob Smith"
        Set member2.RegisteredDate = $ZDT($H, 3)
        Do member2.BorrowedItems.Insert(b2)
        Do member2.BorrowedItems.Insert(m2)
        Set sc = member2.%Save()
        If $$$ISERR(sc) Throw sc
        Write "Створено Читача 2: "_member2.Name_", запозичені предмети: "
        If member2.BorrowedItems.Count()=0 {
           Write "немає"
        } Else {
          Set id=""
          For {
            Set id = member2.BorrowedItems.Next(id)
            Quit:id=""
            Set obj = ##class(Library.Item).%OpenId(id)
            Write obj.Title_", "
          }
        }
        Write ", ID: "_member2.%Id(), !

        /* --- Бібліотека --- */
        Set library1 = ##class(Library.Collection).%New()
        Set library1.Name = "Library "
        Do library1.Items.Insert(b1)
        Do library1.Items.Insert(m1)
        Do library1.Items.Insert(b2)
        Do library1.Members.Insert(member1)
        Do library1.Members.Insert(member2)
        Set sc = library1.%Save()
        If $$$ISERR(sc) Throw sc
        Write "Створено Бібліотеку: "_library1.Name_", кількість предметів: "_library1.Items.Count()_", кількість читачів: "_library1.Members.Count()_", ID: "_library1.%Id(), !

        Set library2 = ##class(Library.Collection).%New()
        Set library2.Name = "National University Library"
        Do library2.Items.Insert(m2)
        Do library2.Members.Insert(member2)
        Set sc = library2.%Save()
        If $$$ISERR(sc) Throw sc
        Write "Створено Бібліотеку: "_library2.Name_", кількість предметів: "_library2.Items.Count()_", кількість читачів: "_library2.Members.Count()_", ID: "_library2.%Id(), !

        Write "--- Створення об'єктів завершено ---", !

    } Catch err {
        Do $System.Status.DisplayError(err)
    }

    Quit
}


}

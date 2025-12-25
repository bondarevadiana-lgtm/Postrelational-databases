Class Library.Test Extends %UnitTest.TestCase
{

Method TestLibraryLogic()
{
    Set member = ##class(Library.Member).%New()
    Set sc = member.%Save()
    Do $$$AssertStatusNotOK(sc, "Не можна зберегти Member без імені (Required)")
    
    Set member.Name = "Ivan Mazepa"
    Set member.MemberID = 101
    Do $$$AssertStatusOK(member.%Save(), "Member збережений успішно")

    Set item1 = ##class(Library.Book).%New()
    Set item1.Title = "Unique Book 1"
    Set item1.ItemID = 500
    Do item1.%Save()
    
    Set item2 = ##class(Library.Book).%New()
    Set item2.Title = "Unique Book 2"
    Set item2.ItemID = 500
    Set scUnique = item2.%Save()

    Set member.BorrowLimit = 1
    Set book1 = ##class(Library.Book).%New()
    Set book1.Title = "Book 1"
    Set book1.ItemID = 601
    
    Set book2 = ##class(Library.Book).%New()
    Set book2.Title = "Book 2"
    Set book2.ItemID = 602
    
    Do member.BorrowItem(book1)
    Set scLimit = member.BorrowItem(book2)
    Do $$$AssertStatusNotOK(scLimit, "Borrow Limit працює: не можна перевищити ліміт")

    Set coll = ##class(Library.Collection).%New()
    Set coll.Name = "Test Collection"
    Do coll.AddMember(member)
    Set collId = coll.%Id()
    Set memberId = member.%Id()
    
    Do $$$AssertStatusOK(##class(Library.Member).%DeleteId(memberId), "Member видалено успішно")
    
    Set collReload = ##class(Library.Collection).%OpenId(collId)
    Do $$$AssertTrue($IsObject(collReload), "Колекція існує після видалення учасника")
    
    Do ##class(Library.Collection).%DeleteId(collId)
}

}
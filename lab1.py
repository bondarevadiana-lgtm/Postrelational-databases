from abc import ABC, abstractmethod
from typing import List


# Abstract Class
class LibraryItem(ABC):
    def __init__(self, title: str, year: int):
        self.title = title          # public property
        self._year = year           # protected
        self.__id = None            # private property

    @property
    def year(self):
        return self._year

    @property
    def id(self):
        return self.__id

    @id.setter
    def id(self, new_id: int):
        if new_id > 0:
            self.__id = new_id
        else:
            raise ValueError("ID must be positive")

    @abstractmethod
    def display_info(self):

        pass

# Derived Classes
class Book(LibraryItem):
    def __init__(self, title: str, year: int, author: str, pages: int):
        super().__init__(title, year)
        self.author = author
        self.pages = pages


    # Overloaded method
    def display_info(self, show_author=True):
        if show_author:
            print(f"Book: '{self.title}' by {self.author} ({self.year}), {self.pages} pages")
        else:
            print(f"Book: '{self.title}' ({self.year})")


class Magazine(LibraryItem):
    def __init__(self, title: str, year: int, issue_number: int):
        super().__init__(title, year)
        self.issue_number = issue_number

    def display_info(self):
        print(f"Magazine: '{self.title}', Issue #{self.issue_number} ({self.year})")



class LibraryMember:
    def __init__(self, name: str, member_id: int):
        self.name = name
        self.member_id = member_id
        self.borrowed_items: List[LibraryItem] = []   # list of objects

    def borrow_item(self, item: LibraryItem):
        if self.__can_borrow():
            self.borrowed_items.append(item)
            print(f"{self.name} borrowed '{item.title}'")
        else:
            print(f"{self.name} cannot borrow more items.")

    def __can_borrow(self):  
        return len(self.borrowed_items) < 3

    def show_borrowed_items(self):
        print(f"{self.name}'s borrowed items:")
        for item in self.borrowed_items:
            item.display_info()



class Library:
    def __init__(self, name: str):
        self.name = name
        self.items: List[LibraryItem] = []  # list of LibraryItem objects
        self.members: List[LibraryMember] = []

    def add_item(self, item: LibraryItem):
        self.items.append(item)

    def add_member(self, member: LibraryMember):
        self.members.append(member)

    def show_all_items(self):
        print(f"--- {self.name} Items ---")
        for item in self.items:
            item.display_info()



if __name__ == "__main__":
    
    library = Library("City Central Library")

    
    b1 = Book("1984", 1949, "George Orwell", 328)
    b2 = Book("The Hobbit", 1937, "J.R.R. Tolkien", 310)
    m1 = Magazine("National Geographic", 2025, 112)

  
    b1.id = 1
    b2.id = 2
    m1.id = 3

    # Add items to library
    library.add_item(b1)
    library.add_item(b2)
    library.add_item(m1)


    alice = LibraryMember("Alice", 1001)
    bob = LibraryMember("Bob", 1002)

    library.add_member(alice)
    library.add_member(bob)


    alice.borrow_item(b1)
    alice.borrow_item(m1)
    bob.borrow_item(b2)


    library.show_all_items()
    alice.show_borrowed_items()
    bob.show_borrowed_items()


    b1.display_info(show_author=False)

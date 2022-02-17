//
//  ContentView.swift
//  Bookworm
//
//  Created by Peter Hartnett on 2/14/22.
//

//********** Challenge day challenges **************
//Right now it’s possible to select no title, author, or genre for books, which causes a problem for the detail view. Please fix this, either by forcing defaults, validating the form, or showing a default picture for unknown genres – you can choose.
//*Went with forcing defaults and genre picture, it just makes the most sense. I am not sure if there is a real instance of a book not having an author or title that would conflict with this idea. And the poetry image works well for a default.

//Modify ContentView so that books rated as 1 star are highlighted somehow, such as having their name shown in red.
//*Simple enough to add a conditional to the formatting of that. I actually like ternary operators... cause im nuts

//Add a new “date” attribute to the Book entity, assigning Date.now to it so it gets the current date and time, then format that nicely somewhere in DetailView.
//*Had to look up the formatting syntax for dates again, oddly complicated things. Placing it at the end of the review similar to a signature seems to be the most reasonable thing to do.

//TODO Add a sorting option to the list of reviews, seems like an easy program to extend.
//TODO Make some system for pulling the information out of the program to something like a word document for use elsewhere easily. Share to .doc or pdf or something

import SwiftUI



struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title)]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(books){book in
                    NavigationLink{
                        DetailView(book: book)
                      
                    } label: {
                        HStack{
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading){
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? .red : .primary)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                } //end foreach
                .onDelete(perform: deleteBooks)
            }
                .navigationTitle("BookWorm")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button{
                            showingAddScreen.toggle()
                        } label: {
                            Label("Add Book", systemImage: "plus")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading){
                        EditButton()
                    }
                } //end toolbar
                .sheet(isPresented: $showingAddScreen){
                    AddBookView()
                }
        }//end navigation view
    }//end body
    
    func deleteBooks(at offsets: IndexSet){
        for offset in offsets{
            //find this book in our fetch request
            let book = books[offset]
            
            //delete it from the context
            moc.delete(book)
        }
        //save teh changes to the data
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}

//
//  AddBookView.swift
//  Bookworm
//
//  Created by Peter Hartnett on 2/15/22.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thirller"]
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id: \.self){ word in
                            Text(word)
                        }
                    }
                }//end section
                
                Section{
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }//end section
                    header: {
                        Text("Write a review")
                    }
                Section{
                    Button("Save"){
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.date = Date.now
                        newBook.title = title
                        if title.isEmpty { newBook.title = "Unknown Title"}
                        newBook.author = author
                        if author.isEmpty { newBook.author = "Unknown Author"}
                        newBook.genre = genre
                        if genre.isEmpty { newBook.genre = "Poetry"}
                        newBook.rating = Int16(rating)
                        newBook.review = review
                        
                        try? moc.save()
                        dismiss()
                        
                    }
                }
            }//End Form
            .navigationTitle("Add Book")
        }//End Nav view
        
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}

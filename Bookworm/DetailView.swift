//
//  DetailView.swift
//  Bookworm
//
//  Created by Peter Hartnett on 2/16/22.
//

import SwiftUI
import CoreData

struct DetailView: View {
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    func deleteBook(){
        moc.delete(book)
        try? moc.save()
        dismiss()
    }
    
    var body: some View {
        ScrollView{
            ZStack(alignment: .bottomTrailing){
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No review")
                .padding([.top, .leading, .trailing])
            HStack{
                Spacer()
                Text(book.date ?? Date.now, format: .dateTime.day().month().year() )
                    .font(.caption)
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing)
                
            }
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }//End scroll view
        .navigationTitle(book.title ?? "Unknown book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Book", isPresented: $showingDeleteAlert){
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel){}
        } message: {
            Text("Are you sure?")
        }
        .toolbar{
            Button{
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//    
//    static var previews: some View {
//        let book = Book(context: moc)
//        book.title = "Test book"
//        book.author = "Test Author"
//        book.genre = "Fantasy"
//        book.rating = 4
//        book.review = "Test review words would go in this space here."
//        
//        return NavigationView{
//            DetailView(book: book)
//        }
//    }
//}

//
//  DeleteMemo.swift
//  MemoCoreData WatchKit Extension
//
//  Created by Ginger on 27/02/2021.
//

import SwiftUI

struct DeleteMemo: View {
    // We're getting Memos at Descending order by using Added or Modified date
    @FetchRequest(entity: Memo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Memo.dateAdded, ascending: false)], animation: .easeIn) var results: FetchedResults<Memo>
    
    @State var deleteMemoItem: Memo?
    @State var deleteMemo = false
    
    //context
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        List(results) { item in
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 6, content: {
                    Text(item.title ?? "")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                    
                    Text(item.dateAdded ?? Date(), style: .date)
                        .font(.system(size: 8))
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                })
                
                Spacer(minLength: 4)
                
                // Edit Button
                
                Button(action: {
                    // storing Current Memo
                    deleteMemoItem = item
                    deleteMemo.toggle()
                }) {
                    Image(systemName: "trash")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color("red"))
                        .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .listStyle(CarouselListStyle())
        .padding(.top)
        .overlay(
            Text(results.isEmpty ? "No Memo to delete" : "")
        )
        .navigationTitle("Delete Memo")
        .alert(isPresented: $deleteMemo, content: {
            Alert(title: Text("Confirm"), message: Text("To delete this Memo"), primaryButton: .default(Text("Ok"), action: {
                // deleting Memo when ok Clicked
                deleteMemo(memo: deleteMemoItem!)
            }), secondaryButton: .destructive(Text("Cancel")))
        })
    }
    
    // Delete Memo
    func deleteMemo(memo: Memo) {
        context.delete(memo)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct DeleteMemo_Previews: PreviewProvider {
    static var previews: some View {
        DeleteMemo()
    }
}

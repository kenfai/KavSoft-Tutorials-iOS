//
//  ContentView.swift
//  StackedCarousel
//
//  Created by Ginger on 22/12/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    // 40 = padding horizontal
    // 60 = 2 card to right side
    var width = UIScreen.main.bounds.width - (40 + 60)
    var height = UIScreen.main.bounds.height / 2
    
    @State var books = [
        // Make sure id is in ascending order
        Book(id: 0, image: "p1", title: "The Murder of Roger Ackroyd", author: "Agatha Christie", rating: 3, offset: 0),
        Book(id: 1, image: "p0", title: "The Hound of the Baskervilles", author: "Arthur Conan", rating: 4, offset: 0),
        Book(id: 2, image: "p3", title: "The Girl with the Dragon Tattoo", author: "Stieg Larsson", rating: 4, offset: 0),
        Book(id: 3, image: "p2", title: "The Godfather", author: "Mario Puzo", rating: 5, offset: 0),
        Book(id: 4, image: "p5", title: "The Lovely Bones", author: "Alice Sebold", rating: 4, offset: 0),
        Book(id: 5, image: "p4", title: "Rebecca", author: "Daphne Du Maurier", rating: 4, offset: 0),
    ]
    
    @State var swiped = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Custom Carousel")
                    .font(.title)
                    .fontWeight(.heavy)
                
                Spacer(minLength: 0)
                
                Button(action: {}) {
                    Image(systemName: "circle.grid.2x2.fill")
                        .font(.system(size: 22))
                }
            }
            .foregroundColor(.white)
            .padding()
            
            Spacer(minLength: 0)
            
            ZStack {
                // since its ZStack it overlay on on-top of another in reversed
                ForEach(books.reversed()) { book in
                    HStack {
                        ZStack {
                            Image(book.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                //.frame(width: width, height: getHeight(index: book.id))
                                .frame(width: width, height: height)
                                .cornerRadius(25)
                                .scaleEffect(getScale(index: book.id))
                            // Little Shadow
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5)
                            
                            // Read More Button
                            CardView(card: book)
                                .frame(width: width, height: getHeight(index: book.id))
                            
                        }
                        .offset(x: book.id - swiped < 3 ? CGFloat(book.id - swiped) * 40 : 60)
                        
                        Spacer(minLength: 0)
                    }
                    // Content shape for DragGesture
                    .contentShape(Rectangle())
                    .padding(.horizontal, 20)
                    // gesture
                    .offset(x: book.offset)
                    .gesture(DragGesture().onChanged({ value in
                        withAnimation {
                            onScroll(value: value.translation.width, index: book.id)
                        }
                    }).onEnded({ (value) in
                        withAnimation {
                            onEnd(value: value.translation.width, index: book.id)
                        }
                    }))
                }
            }
            .frame(height: height)
            
            PageViewController(total: books.count, current: $swiped)
                .padding(.top, 25)
            
            Spacer(minLength: 0)
        }
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))
    }
    
    // Dynamic height change
    func getHeight(index: Int) -> CGFloat {
        // two card = 80
        // all other are 80 in the background
        
        // automatic height and offset adjusting
        return height - (index - swiped < 3 ? CGFloat(index - swiped) * 40 : 80)
    }
    
    func getScale(index: Int) -> CGFloat {
        switch index - swiped {
        case 0:
            return 1.0
        case 1:
            return 0.9
        case 2:
            return 0.8
        default:
            return 0.6
        }
    }
    
    func onScroll(value: CGFloat, index: Int) {
        if value < 0 {
            // Left Swipe
            if index != books.last!.id {
                books[index].offset = value
            }
        } else {
            // Right Swipe
            // Safe Check
            if index > 0 {
                books[index - 1].offset = -(width + 60) + value
            }
        }
    }
    
    func onEnd(value: CGFloat, index: Int) {
        if value < 0 {
            if -value > width / 2 && index != books.last!.id {
                books[index].offset = -(width + 60)
                swiped += 1
            } else {
                books[index].offset = 0
            }
        } else {
            if index > 0 {
                if value > width / 2 {
                    books[index - 1].offset = 0
                    swiped -= 1
                } else {
                    books[index - 1].offset = -(width + 60)
                }
            }
        }
    }
}

struct CardView: View {
    var card: Book
    
    var body: some View {
        VStack {
            // You can display all details
            // I'm displaying only read button
            Spacer(minLength: 0)
            
            HStack {
                Button(action: {}) {
                    Text("Read Now")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color("purple"))
                        .clipShape(Capsule())
                }
                
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.bottom, 10)
        }
    }
}

// Book data

struct Book: Identifiable {
    var id: Int
    var image: String
    var title: String
    var author: String
    var rating: Int
    var offset: CGFloat
}

// Paging COntrol
struct PageViewController: UIViewRepresentable {
    var total: Int
    @Binding var current: Int
    
    func makeUIView(context: Context) -> UIPageControl {
         let view = UIPageControl()
        view.numberOfPages = total
        view.currentPage = current
        view.currentPageIndicatorTintColor = .white
        view.preferredIndicatorImage = UIImage(systemName: "book.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))
        view.backgroundStyle = .prominent
        
        return view
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = current
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

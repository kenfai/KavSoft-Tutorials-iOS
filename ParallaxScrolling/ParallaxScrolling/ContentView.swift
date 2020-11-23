//
//  ContentView.swift
//  ParallaxScrolling
//
//  Created by Ginger on 23/11/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            GeometryReader { reader in
                if reader.frame(in: .global).minY > -480 {
                    Image("main")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .offset(y: -reader.frame(in: .global).minY)
                    // parallax Effect
                        .frame(width: UIScreen.main.bounds.width, height: reader.frame(in: .global).minY + 480)
                        //.frame(width: UIScreen.main.bounds.width, height: reader.frame(in: .global).minY > 0 ? reader.frame(in: .global).minY + 480 : 480)
                }
            }
            // default frame
            .frame(height: 480)
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Blade Runner")
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(.white)
                
                HStack(spacing: 15) {
                    ForEach(1...5, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.white)
                    }
                }
                
                Text("Some Scene May Scare Very Young Children")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.top, 5)
                
                Text(plot)
                    .padding(.top, 10)
                    .foregroundColor(.white)
                
                HStack(spacing: 15) {
                    Button(action: {}) {
                        Text("Bookmark")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {}) {
                        Text("Buy Tickets")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                .padding(.top, 25)
            }
            .padding(.top, 25)
            .padding(.horizontal)
            .background(Color.black)
            .cornerRadius(20)
            .offset(y: -30)
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

var plot = """
In 2019 Los Angeles, former policeman Rick Deckard is detained by Officer Gaff, and brought to his former supervisor, Bryant. Deckard, whose job as a "blade runner" was to track down bioengineered humanoids known as replicants and terminally "retire" them, is informed that four replicants are on Earth illegally. Deckard begins to leave, but Bryant ambiguously threatens him and Deckard stays. The two watch a video of a blade runner named Holden administering the Voight-Kampff test, which is designed to distinguish replicants from humans based on their emotional response to questions. The test subject, Leon, shoots Holden on the second question. Bryant wants Deckard to retire Leon and three other Nexus-6 replicants: Roy Batty, Zhora, and Pris.

Bryant has Deckard meet with the CEO of the company that creates the replicants, Eldon Tyrell, so he can administer the test on a Nexus-6 to see if it works. Tyrell expresses his interest in seeing the test fail first and asks him to administer it on his assistant Rachael. After a much longer than standard test, Deckard concludes that Rachael is a replicant who believes she is human. Tyrell explains that she is an experiment who has been given false memories to provide an "emotional cushion".
"""

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

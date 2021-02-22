//
//  FeatureContent.swift
//  MediumAppStickyFooter
//
//  Created by Ginger on 22/02/2021.
//

import SwiftUI

struct FeatureContent: View {
    var body: some View {
        VStack(spacing: 15) {
            HStack(spacing: 15) {
                Image("featured1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .cornerRadius(10)
                
                Text("People who are good with money look for quality over quantity, and don’t make purchases that will derail their money goals later.")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 15) {
                Image("featured2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .cornerRadius(10)
                
                Text("How to overcome psychological reactance, the rarely-discussed psychological reflex that’s holding you back")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
                       
           HStack(spacing: 15) {
               Image("featured3")
                   .resizable()
                   .aspectRatio(contentMode: .fill)
                   .frame(width: 70, height: 70)
                   .cornerRadius(10)
               
               Text("Inside the brave new world of data-driven, search-optimized virtual restaurants that exist only on DoorDash and GrubHub")
           }
           .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

struct FeatureContent_Previews: PreviewProvider {
    static var previews: some View {
        FeatureContent()
    }
}

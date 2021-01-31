//
//  QuestionView.swift
//  QuizFirebaseFirestore
//
//  Created by Ginger on 31/01/2021.
//

import SwiftUI

struct QuestionView: View {
    @Binding var question: Question
    @Binding var correct: Int
    @Binding var wrong: Int
    @Binding var answered: Int
    
    @State var selected = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            Text(question.question!)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .padding(.top, 25)
            
            Spacer(minLength: 0)
            
            // Options
            Button(action: {
                selected = question.optionA!
            }) {
                Text(question.optionA!)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(color(option: question.optionA!), lineWidth: 2)
                    )
            }
            
            Button(action: {
                selected = question.optionB!
            }) {
                Text(question.optionB!)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(color(option: question.optionB!), lineWidth: 2)
                    )
            }
            
            Button(action: {
                selected = question.optionC!
            }) {
                Text(question.optionC!)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(color(option: question.optionC!), lineWidth: 2)
                    )
            }
            
            Spacer(minLength: 0)
            
            // Buttons
            HStack(spacing: 15) {
                Button(action: checkAns) {
                    Text("Submit")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                }
                // disabling
                .disabled(question.isSubmitted)
                .opacity(question.isSubmitted ? 0.7 : 1)
                
                Button(action: {
                    withAnimation {
                        question.completed.toggle()
                        answered += 1
                    }
                }) {
                    Text("Next")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                }
                .disabled(!question.isSubmitted)
                .opacity(!question.isSubmitted ? 0.7 : 1)
            }
            .padding(.bottom)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
    }
    
    // highlighting Answer
    func color(option: String) -> Color {
        if option == selected {
            // displaying if correct means green, else red
            if question.isSubmitted {
                if selected == question.answer! {
                    return Color.green
                } else {
                    return Color.red
                }
            } else {
                return Color.blue
            }
        } else {
            // displaying right if wrong selected
            if question.isSubmitted && option != selected {
                if question.answer! == option {
                    return Color.green
                }
            }
            
            return Color.gray
        }
    }
    
    // check Answer
    func checkAns() {
        if selected == question.answer! {
            correct += 1
        } else {
            wrong += 1
        }
        
        question.isSubmitted.toggle()
    }
}

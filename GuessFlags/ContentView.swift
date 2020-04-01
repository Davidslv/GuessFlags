//
//  ContentView.swift
//  GuessFlags
//
//  Created by David Silva on 01/04/2020.
//  Copyright © 2020 David Silva. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var shuffledCountries = countries.shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var counter = 0
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name:"Futura", size: 26)!]
        // UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text(String(counter))
                    .font(.largeTitle).foregroundColor(Color.blue).fontWeight(.heavy)
                                
                VStack {
                    ForEach(0...2, id: \.self) { number in                            
                        Image(
                            findFlagByCountryName(name: self.shuffledCountries[number])
                        )
                        .resizable()
                        .frame(width: 220, height: 150, alignment: .center)
                            .border(Color.black).onTapGesture {
                                self.flagTapped(number)
                        }

                    }
                }
                .navigationBarTitle(Text(shuffledCountries[correctAnswer].uppercased()), displayMode: .automatic)
            }
        }
    }
    
    func flagTapped(_ tag: Int) {
        if tag == correctAnswer {
            counter += 1
        }
        else {
            counter -= 1
        }
        
        AskNewQuestion()
    }
    
    func AskNewQuestion() {
        self.shuffledCountries.shuffle()
        self.correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

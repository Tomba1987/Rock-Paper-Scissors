//
//  ContentView.swift
//  Challenge Day 2
//
//  Created by Tomislav Tomic on 05/11/2020.
//

import SwiftUI

struct ButtonStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 30))
            .background(Color.black)
            .foregroundColor(.red)
            .clipShape(Capsule())
            .padding()
    }

}

extension View {
    
    func stil() -> some View {
        self.modifier(ButtonStyle())
    }
}




struct ContentView: View {
    
    var moves = ["Rock", "Paper", "Scissors"]
    
    @State private var choice = "Paper"
    @State private var playerScore = 0
    @State private var runda = 10
    @State private var winLose = false
    
    @State private var rundaGotova = false
    
    func nextRound() {
        
        choice = moves[Int.random(in: 0 ... 2)]
        
        winLose = Bool.random()
        
        runda -= 1
        
        if runda > 0 {
            rundaGotova = false
        }
        else {
            rundaGotova = true
        }
    }
    
    func newGame() {
        
        playerScore = 0
        runda = 10
    }
    
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [.yellow, .green]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                Spacer()
                Text("Score \(playerScore)")
                    .font(.title2)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding()
                Spacer()
                Text("Round \(runda)")
                    .font(.title2)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding()
                    
                Spacer()
                    
                }
                
                Spacer()
                
                Text("My move is \(choice.uppercased())")
                    .padding(30)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .padding()
                    
                    
                
                Text("You must \(winLose ? "WIN" : "LOSE") !")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
                    .padding()
                Spacer()
                
                Text("Choose")
                    .font(.title2)
                
                HStack {
                    
                    Spacer()
                    
                    Button ( action: {
                        
                        if self.choice == self.moves[2] && self.winLose || self.choice == self.moves[1] && !self.winLose {
                            self.playerScore += 1
                        }
                        else {
                            self.playerScore -= 1
                        }
                        
                        self.nextRound()
                        
                    }) { Image("rock") }.padding(.leading)
                    
                    Spacer()
                    
                    Button( action: {
                        
                        if self.choice == self.moves[0] && self.winLose || self.choice == self.moves[2] && !self.winLose {
                            self.playerScore += 1
                        }
                        else {
                            self.playerScore -= 1
                        }
                        
                        self.nextRound()
                        
                        
                        
                    }) { Image("pap") }.padding(.leading)
                    
                    Spacer()
                    
                    Button( action: {
                        
                        if self.choice == self.moves[1] && self.winLose || self.choice == self.moves[0] && !self.winLose {
                            self.playerScore += 1
                        }
                        else {
                            self.playerScore -= 1
                        }
                        
                        self.nextRound()
                        
                        
                        
                    }) { Image("sci") }
                    
                    Spacer()
                    
                }
                .padding()
                .alert(isPresented: $rundaGotova, content: {
                    Alert(title: Text("Game Over!"), message: Text("You've won \(playerScore) points!"), dismissButton: .default(Text("OK")){ newGame() })
                })
                Spacer()
                
            }
            .navigationBarTitle(Text("Rock Paper Scissors"))
            .navigationBarItems(trailing: Button("New Game") { newGame() })
            
        }
        
        }
            
    }
    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

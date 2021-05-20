//
//  ContentView.swift
//  TimerWithCombine
//
//  Created by ramil on 20.05.2021.
//

import SwiftUI
import Combine

private var subscription: AnyCancellable?
struct ContentView: View {
    @State private var countLabel = 0
        
    var body: some View {
        VStack {
            Text("\(countLabel)")
                .font(.largeTitle)
                .bold()
                .padding()
            HStack {
                Button(action: {
                    startTimer()
                }, label: {
                    Text("Start")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                })
                Button(action: {
                    stopTimer()
                }, label: {
                    Text("Stop")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                })
            }
        }
    }
    
    private func startTimer() {
        subscription = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .scan(0, { count, _ in
                return count + 1
            })
            .sink(receiveCompletion: { _ in
                print("Finished")
            }, receiveValue: { count in
                countLabel = count
            })
    }
    
    private func stopTimer() {
        countLabel = 0
        subscription?.cancel()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

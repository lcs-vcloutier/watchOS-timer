//
//  ContentView.swift
//  watchOS timer WatchKit Extension
//
//  Created by Cloutier, Vincent on 2020-11-19.
//

import SwiftUI

struct ContentView: View {
    //to keep track of UI shown
    @State var secondScreenShown = false
    //to keep track of actual timer
    @State var timerVal = 1
    var body: some View {
        VStack{
            //To explain whas happening
            Text("Start timer for \(timerVal) seconds")
                .font(.system(size: 14))
            //pick duration of timer
            Picker(selection: $timerVal, label: Text("")) {
                Text("1").tag(1)
                Text("5").tag(5)
                Text("10").tag(10)
                Text("15").tag(15)
            }
            //navigation link to next screen where timer is activated
            NavigationLink(destination: SecondView(secondScreenShown: $secondScreenShown, timerVal: timerVal), isActive: $secondScreenShown, label: {Text("Go")})
        }
    }
}
struct SecondView: View{
    //pass secondscreenshown passed both ways cuz binding
    @Binding var secondScreenShown:Bool
    //Not binding so its only passed forward
    @State var timerVal:Int
    var body: some View {
        VStack{
            //if timer is on
            if timerVal > 0 {
                Text("Time remaining")
                    .font(.system(size: 14))
                //show time left
                Text("\(timerVal)")
                    .font(.system(size: 40))
                    //on appear keep reducing it each second
                    .onAppear(){
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                            if self.timerVal > 0 {
                                self.timerVal -= 1
                            }
                        }
                    }
                Text("seconds")
                    .font(.system(size: 14))
                //cancel button that sends us back to first view
                Button(action: {
                    self.secondScreenShown = false
                }) {
                    Text("Cancel")
                        .foregroundColor(.red)
                }
            } else {
                //done button that sends us back to first view
                Button(action: {
                    self.secondScreenShown = false
                }) {
                    Text("Done")
                        .foregroundColor(.green)
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

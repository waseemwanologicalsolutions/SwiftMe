//
//  PickersSample.swift
//  SwiftyMe
//
//  Created by MacBook on 12/01/2023.
//

import SwiftUI

struct PickersSample: View {
    
    @State var theme:Theme = Theme.bubblegum
    @State var showTimePicker = false
    @State var selectedDate = Date()
    @State var dateComponents:DatePickerComponents
    @State var score:CGFloat = 0
    
    var body: some View {
        ZStack{
            
            VStack{
                ThemePicker(selection: $theme)
                Button(action:{
                    dateComponents = .hourAndMinute
                    showTimePicker = true
                }){
                    Text("Time Picker")
                }
                Button(action:{
                    dateComponents = .date
                    showTimePicker = true
                }){
                    Text("Date Picker")
                }
                
                Button(action:{
                    score = score + 0.1
                }){
                    Text("Progress fill")
                }
                
                ProgressCircle(
                    progress: score,
                    strockWidth: 10,
                    background: Color.black,
                    forground: .red
                ).frame(width: 100, height: 100)
                    .animation(.easeInOut.delay(0.15), value: 5)
            }.padding(20)
            overlays
        }
    }
    
    var overlays: some View{
        Group{
            ZStack(alignment: .bottom){
                if showTimePicker{
                    Color.black
                        .opacity(0.75)
                        .transition(.opacity)
                        .ignoresSafeArea()
                    TimePikerView(
                        date: $selectedDate,
                        title: "Select Time",
                        min: Date(),
                        max: Date(),
                        dateComponents: dateComponents,
                        onSave: {
                            print(selectedDate)
                            showTimePicker = false
                        },
                        onClose: {
                            showTimePicker = false
                        }
                    )
                    .transition(.move(edge: .bottom))
                    .environment(\.locale, Locale(identifier: "en_GB"))
                }
            }
            .animation(.easeInOut, value: 300)
        }
    }
}

struct PickersSample_Previews: PreviewProvider {
    static var previews: some View {
        PickersSample(dateComponents: .hourAndMinute)
    }
}



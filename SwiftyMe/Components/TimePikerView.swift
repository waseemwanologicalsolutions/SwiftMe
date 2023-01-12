//
//  TimePikerView.swift
//  SwiftyMe
//
//  Created by MacBook on 12/01/2023.
//

import SwiftUI

struct TimePikerView: View {
    @Binding var date: Date
    let title: String
    let min: Date?
    let max: Date?
    let dateComponents:DatePickerComponents
    let onSave: () -> Void
    let onClose: () -> Void
    
    var body: some View {
        ZStack(alignment: .bottom){
            // MARK:  Background click
            Color.clear
                .opacity(1)
                .contentShape(Rectangle())
                .onTapGesture(perform: onClose)
                .ignoresSafeArea()
        
            
            VStack(spacing: 10) {
                // MARK:  Picker
                VStack(spacing: 24) {
                    Text(title)
                        .font(.sfProRounded(.body, weight: .bold))
                        .foregroundColor(Color.white)
                    DatePicker(
                        "",
                        selection: $date,
                        displayedComponents: dateComponents
                        
                    )
                    .datePickerStyle(.wheel)
                    .foregroundColor(Color.white)
                    .labelsHidden()
                    .colorScheme(.dark)
                }
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(Color.tableBackground)
                .cornerRadius(40)

                CapsuleButton(title: "SAVE", foreground: Color.white, background: Color.indigo, action: onSave)
                CapsuleButton(
                    title: "CANCEL",
                    foreground: .white,
                    background: .gray.opacity(0.5),
                    action: onClose
                )

            }
            .padding(.horizontal, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct TimePikerView_Previews: PreviewProvider {
    static var previews: some View {
        TimePikerView(
            date: .constant(Date()),
            title: "Time to Sleep",
            min: Date().addingTimeInterval(6*3600),
            max: Date().addingTimeInterval(24*30*3600),
            dateComponents: .hourAndMinute,
            onSave: {},
            onClose: {}
        )
    }
}

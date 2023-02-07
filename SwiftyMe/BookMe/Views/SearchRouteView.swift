//
//  SearchRouteView.swift
//  SwiftyMe
//
//  Created by MacBook on 24/01/2023.
//

import SwiftUI

struct SearchRouteView: View {
    
    @EnvironmentObject var vm:SearchRouteViewModel
    @State var selectedDate:Date = Date()
    
    
    var body: some View {
        
        VStack{
            
            HeaderView
            
            Text("Recent Searches")
                .font(.sfProRounded(.headline))
                .foregroundColor(Color.bm_black_text)
                .multilineTextAlignment(.leading)
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding()
            
            List{
                RecentLocationRowView()
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                RecentLocationRowView()
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                RecentLocationRowView()
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
            .background(Color.bm_white_text)
            .scrollContentBackground(.hidden)
            
            
            
            Spacer()
        }
        
        
        .edgesIgnoringSafeArea(.bottom)
        .toolbarColorScheme(.light, for: .navigationBar)
        .sheet(isPresented: $vm.showDatePicker){
            DatePikerView(
                date: $selectedDate,
                title: "Select Date",
                min: Date(),
                max: Date(),
                dateComponents:vm.dateComponents,
                onSave: {
                    print(selectedDate)
                    self.vm.showDatePicker = false
                },
                onClose: {
                    print(selectedDate)
                    self.vm.showDatePicker = false
                }
            )
            .presentationDetents([.height(580)])
            .transition(.move(edge: .bottom))
            .environment(\.locale, Locale(identifier: "en_GB"))
        }
        .navigationDestination(isPresented: $vm.showServiceScreen) {
            ServicesListView(showServiceScreen: $vm.showServiceScreen)
        }
        .navigationDestination(isPresented: $vm.showSourceDestinationScreen) {
            SourceDestinationLocationView(showScreen: $vm.showSourceDestinationScreen)
        }
        
    }
    
    var HeaderView: some View {
        
        VStack(spacing: 15){
            
            Text("Search Bus")
                .font(.sfProRounded(.title, weight: .bold))
                .foregroundColor(Color.white)
                .padding([.top, .bottom], 5)
            
            HStack(alignment: .center, spacing: 10){
                FromLocationView(text: vm.selectedLocationFrom?.name ?? "From", icon: "bm_bus"){
                    print("from")
                    vm.isSourceLocationSelectting = true
                    vm.showSourceDestinationScreen = true
                }
                FromLocationView(text: vm.selectedLocationTo?.name ?? "To", icon: "bm_bus"){
                    print("to")
                    vm.isSourceLocationSelectting = false
                    vm.showSourceDestinationScreen = true
                }
            }
            .padding([.leading, .trailing], 10)
            
            HStack(alignment: .center, spacing: 10){
                
                FromLocationView(text: selectedDate.getCustomFormatDateString(format: "dd MMM, yy"), icon: "bm_calendar"){
                    print("date")
                    vm.showDatePicker = true
                }
                
            }
            .padding([.leading, .trailing], 10)
            
            HStack(alignment: .center, spacing: 10){
                FromLocationView(text: vm.selectedService?.name ?? "All services"){
                    print("services")
                    vm.showServiceScreen = true
                }
                RectButton(title: "Search", foreground: Color.white, background: Color.bm_yellow, height: 40, weight: .bold){
                    print("search")
                    vm.showServiceScreen = true
                }
                .frame(width: 120)
                
            }
            .padding([.leading, .trailing], 10)
            .padding([.bottom],20)
            
            
        }
        .background(Color.bm_blue_bg)
    }
}

struct SearchRouteView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRouteView().environmentObject(SearchRouteViewModel())
    }
}


struct FromLocationView:View{
    var text:String = "From"
    var icon:String?
    let action: () -> Void
    var body: some View{
        
        Button(action: action) {
            ZStack{
                Rectangle()
                    .fill(Color.bm_field_bg)
                    .cornerRadius(5)
                HStack{
                    if let icon = icon{
                        Image(icon)
                            .resizable()
                            .frame(width: 18, height: 18)
                    }
                    Text(text)
                        .foregroundColor(Color.bm_black_text)
                    Spacer()
                }
                .padding(10)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
        }
        .buttonStyle(.plain)
        
        //.overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth:1))
        //.overlay(RoundedRectangle(cornerRadius: 5).fill(Color.white))
    }
}

struct RecentLocationRowView:View{
    
    var body: some View{
        
        ZStack{
            Rectangle()
                .fill(Color.bm_field_bg)
                .cornerRadius(5)
                .shadow(color:Color.bm_black_text.opacity(0.3),radius: 4)
                .padding([.top, .bottom],10)
                .padding([.leading, .trailing],10)
            
            HStack{
                Text("LHR - ISB")
                    .foregroundColor(Color.bm_black_text)
                    .font(.sfProRounded(.headline))
                Divider()
                Text("All services")
                    .foregroundColor(Color.bm_black_text)
                Spacer()
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 70)
        
        //.overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth:1))
        //.overlay(RoundedRectangle(cornerRadius: 5).fill(Color.white))
    }
}

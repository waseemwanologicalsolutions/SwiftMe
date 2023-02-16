//
//  ServicesSearchResultsView.swift
//  SwiftyMe
//
//  Created by MacBook on 13/02/2023.
//

import SwiftUI
import Combine

struct ServicesSearchResultsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var searchRouteViewModel:SearchRouteViewModel
    @StateObject var vm = ServicesSearchResultsViewModel()
    
    var body: some View {
        VStack{
            
            HeaderView
            
            List(vm.results) { item in
                ResultsListRowView(item: item)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        vm.selectedResult = item
                        vm.showBusDetails = true
                    }
                
            }.listStyle(.plain)
            
            
            
        }
        .navigationBarHidden()
        .onAppear{
            vm.results = ServicesSearchResultsViewModelData.initServicesList()
        }
        .navigationDestination(isPresented:$vm.showBusDetails){
            BusDetailsView(result:vm.selectedResult)
        }
    }
    
    var HeaderView: some View {
        
        VStack(spacing: 10){
            HStack(alignment: .center){
                Button(action:{
                    self.mode.wrappedValue.dismiss()
                }){
                    HStack{
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.white)
                            .frame(width: 26, height: 26)
                        Spacer()
                    }
                }
                .frame(width: 40, height: 40)
                
                HStack(){
                   
                    VStack(alignment:.leading, spacing:5){
                        HStack{
                            Text(locationsTitle)
                                .foregroundColor(Color.bm_black_text)
                                .font(.sfProRounded(18))
                                .padding([.leading], 10)
                                .padding([.trailing], 10)
                                
                            Spacer()
                        }
                        
                        HStack{
                            Text(searchRouteViewModel.selectedDate.getCustomFormatDateString(format: "dd MMM") + " | " + (searchRouteViewModel.selectedService?.name ?? "All services"))
                                .foregroundColor(Color.bm_black_text)
                                .font(.sfProRounded(11))
                                .multilineTextAlignment(.leading)
                                .padding([.leading], 10)
                                .padding([.trailing], 10)
                            
                            Spacer()
                        }
                    }
                    .padding([.top, .bottom], 10)
                    
                    
                }
                .frame(maxWidth: .infinity)
                .background( Rectangle()
                    .fill(Color.bm_field_bg)
                    .cornerRadius(5))
            }
            .padding([.leading, .trailing], 10)
            .padding([.bottom], 20)
            
        }
        .background(Color.bm_blue_bg)
    }
    
    var locationsTitle:String{
        (searchRouteViewModel.selectedLocationFrom?.name ?? "") + " - " + (searchRouteViewModel.selectedLocationTo?.name ?? "")
    }
}

struct ServicesSearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ServicesSearchResultsView().environmentObject(SearchRouteViewModel())
    }
}


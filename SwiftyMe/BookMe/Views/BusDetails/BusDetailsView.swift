//
//  BusDetailsView.swift
//  SwiftyMe
//
//  Created by MacBook on 14/02/2023.
//

import SwiftUI
import Combine

struct BusDetailsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var searchRouteViewModel:SearchRouteViewModel
    @StateObject var vm = BusDetailsViewModel()
    @State var result:ServicesSearchResultsModel = ServicesSearchResultsViewModelData.initServicesList()[0]
    
    var body: some View {
        ZStack(alignment:.bottom){
            VStack(){
                
                HeaderView
                
                ScrollView{
                    VStack(spacing:15){
                        BusDetailsResultView(item: result)
                        
                        BusFacilitiesView(item: result)
                        
                        AboutTransporterView()
                    }
                    .padding([.bottom], 100)
                }
               
            }
            
            ConfirmButton.onTapGesture {
                print("confirm tapped")
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden()
        .onAppear{
            
        }
    }
    
    var ConfirmButton:some View{
        HStack{
            Text("Confirm")
                .foregroundColor(Color.white)
                .font(.sfProRounded(.headline))
                .padding([.leading], 15)
            Spacer()
            Text(String(format:"Rs %0.1f",result.price ?? 0))
                .foregroundColor(Color.white)
                .font(.sfProRounded(.headline))
                .padding([.trailing], 15)
        }
        .frame(maxWidth: .infinity)
        .frame(height:60)
        .background(Color.bm_blue_bg)
        .cornerRadius(15)
        .padding()
    }
    
    var HeaderView: some View {
        
        VStack(spacing: 10){
            HStack(alignment: .center){
                Button(action:{
                    self.mode.wrappedValue.dismiss()
                }){
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.white)
                        .frame(width: 26, height: 26)
                }
                .frame(width: 40, height: 40)
                
                HStack(){
                   
                    VStack(alignment:.leading, spacing:5){
                        HStack{
                            Text("Bus Details")
                                .foregroundColor(Color.white)
                                .font(.sfProRounded(.headline))
                                .padding([.leading], 0)
                                .padding([.trailing], 0)
                                
                            Spacer()
                        }
                        
                        HStack{
                            Text(searchRouteViewModel.selectedDate.getCustomFormatDateString(format: "dd MMM") + " | " + (searchRouteViewModel.selectedService?.name ?? " All services"))
                                .foregroundColor(Color.white)
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .padding([.leading], 0)
                                .padding([.trailing], 0)
                            
                            Spacer()
                        }
                    }
                    .padding([.top, .bottom], 10)
                    
                    
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding([.leading, .trailing], 10)
            .padding([.bottom], 10)
            
        }
        .background(Color.bm_blue_bg)
    }
}

struct BusDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BusDetailsView().environmentObject(SearchRouteViewModel())
    }
}

//
//  ContentView.swift
//  WeSplit
//
//  Created by Andre Almeida on 06/05/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 3
    @State private var tipPercentage = [0,5,10,15,20,25,30]
    @State private var tipSelection: Double = 10
    @State private var isEditing = false
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
  
    var body: some View {
        
        NavigationView{
            
            Form{
                
                Section(header: Text("Insira do valor aqui:")){
                    TextField("Valor final", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Quantas pessoas vão dividir a conta?")){
                    Picker("Escolha o número de pessoas", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) Pessoas")
                        }
                    }
                }
                
                Section(header: Text("Valor da gorjeta:")){
                    Slider(
                        value: $tipSelection,
                        in: 0...30,
                        step: 5,
                        onEditingChanged: { editing in
                            isEditing = editing
                        },
                        minimumValueLabel: Text("0%"),
                        maximumValueLabel: Text("30%")
                    ) {
                        Text("Gorjeta")
                    }
                    Text("\(Int(tipSelection))%")
                        .foregroundColor(isEditing ? .red : .blue)
                }
                
                Section(header: Text("Total por pessoa:")){
                    Text("R$ \(totalPerPerson, specifier: "%.2f")")
                        .font(.largeTitle)
                }
                
            }
            .navigationTitle("WeSplit")
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

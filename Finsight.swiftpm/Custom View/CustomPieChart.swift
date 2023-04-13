//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 13/04/23.
//

import SwiftUI
import Charts

struct CustomPieChartView: UIViewRepresentable {
//    @Binding var entries: [PieChartDataEntry]
    @Binding var dataset: PieChartDataSet?
    @Binding var selectedSliceValue: String?
    @Binding var selectedSlicePercent: Double?
    let pieChart = PieChartView()
    
    
    func makeUIView(context: Context) -> Charts.PieChartView {
        pieChart.delegate = context.coordinator
        return pieChart
    }
    
    func updateUIView(_ uiView: Charts.PieChartView, context: Context) {
        
//        let dataset = PieChartDataSet(entries: entries)
        
        guard let dataset = dataset else { return }
        
        dataset.colors = [
           UIColor(Color.income),
           UIColor(Color.expense)
        ]
        
        
        
        uiView.data = PieChartData(dataSet: dataset)
        uiView.legend.enabled = false
        uiView.data?.setValueTextColor(.black)
        uiView.holeRadiusPercent = 0.8
        
        // entry label styling
        uiView.entryLabelColor = .black
        uiView.drawEntryLabelsEnabled = false
        dataset.drawValuesEnabled = false
        uiView.entryLabelFont = .systemFont(ofSize: 12, weight: .light)
        uiView.holeColor = UIColor(Color.white)
        
    }
    
    class Coordinator: NSObject, ChartViewDelegate {
        let parent: CustomPieChartView
        init(parent: CustomPieChartView){
            self.parent = parent
        }
        
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {

            guard let dataset = parent.dataset else { return }
            
            if entry.y == dataset[0].y {
                parent.selectedSliceValue = CashFlow.income.rawValue
            } else {
                parent.selectedSliceValue = CashFlow.expense.rawValue
            }
            
            parent.selectedSlicePercent = entry.y
            
            
        }
        
        func chartValueNothingSelected(_ chartView: ChartViewBase) {
            parent.selectedSliceValue = nil
            parent.selectedSlicePercent = nil
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    typealias UIViewType = PieChartView
    
}
//
//struct CustomPieChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomPieChartView(entries: .constant([PieChartDataEntry(value: 60)]))
//    }
//}

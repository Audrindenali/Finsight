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
    let pieChart = PieChartView()
    
    
    func makeUIView(context: Context) -> Charts.PieChartView {
        pieChart.delegate = context.coordinator
        return pieChart
    }
    
    func updateUIView(_ uiView: Charts.PieChartView, context: Context) {
        
//        let dataset = PieChartDataSet(entries: entries)
        
        guard let dataset = dataset else { return }
        
        dataset.colors = [
           UIColor(Color.blue),
           UIColor(Color.black)
        ]
        
        
        
        uiView.data = PieChartData(dataSet: dataset)
        uiView.legend.enabled = false
        uiView.data?.setValueTextColor(.black)
        uiView.holeRadiusPercent = 0.6
        
        // entry label styling
        uiView.entryLabelColor = .black
        uiView.drawEntryLabelsEnabled = false
        dataset.drawValuesEnabled = false
        uiView.entryLabelFont = .systemFont(ofSize: 12, weight: .light)
        uiView.holeColor = UIColor(Color.mainColor)
        
    }
    
    class Coordinator: NSObject, ChartViewDelegate {
        let parent: CustomPieChartView
        init(parent: CustomPieChartView){
            self.parent = parent
        }
        
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            print("X : \(entry.x)")
            print("Y : \(entry.y)")
            print("Label: \(entry)")
            
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

//
//  TempGradient.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 9/19/22.
//

import SwiftUI

struct TempGradient: View {
    let low: Measurement<UnitTemperature>
    let high: Measurement<UnitTemperature>
    
    var body: some View {
        Capsule()
            .fill(
                LinearGradient(colors: colors(forLow: low, high: high),
                               startPoint: .leading,
                               endPoint: .trailing)
            )
    }
    
    private func colors(forLow low: Measurement<UnitTemperature>,
                        high: Measurement<UnitTemperature>) -> Array<Color> {
        var colors: [Color] = []
        let lowTemp = Int(round(low.converted(to: .fahrenheit).value))
        let highTemp = Int(round(high.converted(to: .fahrenheit).value))
        
        let (q1, _) = lowTemp.quotientAndRemainder(dividingBy: 10)
        let (q2, _) = highTemp.quotientAndRemainder(dividingBy: 10)
        let min = q1 * 10
        let max = q2 * 10 + 10
        
        for i in stride(from: min, to: max, by: 10) {
            switch i {
            case _ where i < -20:
                colors.append(Color("White"))
            case -19 ... -10:
                colors.append(Color("HimalayanBalsam"))
            case -9 ... -1:
                colors.append(Color("Magenta"))
            case 0...9:
                colors.append(Color("AcaiJuice"))
            case 10...19:
                colors.append(Color("OceanAbyss"))
            case 20...29:
                colors.append(Color("Blue"))
            case 30...39:
                colors.append(Color("VividSkyBlue"))
            case 40...49:
                colors.append(Color("ArcticWater"))
            case 50...59:
                colors.append(Color("Radium"))
            case 60...69:
                colors.append(Color("Yellow"))
            case 70...79:
                colors.append(Color("VibrantYellow"))
            case 80...89:
                colors.append(Color("ClementineEarring"))
            case 90...99:
                colors.append(Color("Red"))
            default:
                colors.append(Color("CrimsonRed"))
            }
        }
        
        return colors
    }
}

struct TempGradient_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TempGradient(low: Measurement(value: 2, unit: .celsius),
                         high: Measurement(value: 41, unit: .celsius))
                .preferredColorScheme(.light)
                .previewDisplayName("Light")
            TempGradient(low: Measurement(value: 2, unit: .celsius),
                         high: Measurement(value: 42, unit: .celsius))
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark")
        }
        .previewLayout(.sizeThatFits)
    }
}

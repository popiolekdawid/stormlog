//
//  RatingView.swift
//  weather-journal
//
//  Created by Dawid Popiołek on 15/06/2023.
//

import SwiftUI

struct RatingView: View {
    @Binding var weather: Int
    
    var label = ""
    
    var maxWeather = 5
    
    var onImages = [
        Image("snowfall"),
        Image("downpour"),
        Image("windy"),
        Image("cloudy-day"),
        Image("sunny")
    ]
    
    var offImages = [
        Image("snowfallBW"),
        Image("downpourBW"),
        Image("windyBW"),
        Image("cloudy-dayBW"),
        Image("sunnyBW")
    ]
    
    func image(for number: Int) -> Image {
        if number == weather {
            return onImages[number - 1]
        } else {
            return offImages[number - 1]
        }
    }
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1..<maxWeather + 1, id: \.self) { number in
                image(for: number)
                    .resizable()
                    .scaledToFit()
                    .onTapGesture {
                        weather = number
                    }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(weather: .constant(3))
    }
}

//
//  SingleRatingView.swift
//  weather-journal
//
//  Created by Dawid Popiołek on 15/06/2023.
//

import SwiftUI

struct SingleRatingView: View {
    let weather: Int16

    var body: some View {
        switch weather {
        case 1:
            Image("snowfall")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 50)
        case 2:
            Image("downpour")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 50)
        case 3:
            Image("windy")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 50)
        case 4:
            Image("cloudy-day")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 50)
        default:
            Image("sunny")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 50)
        }
    }
}

struct SingleRatingView_Previews: PreviewProvider {
    static var previews: some View {
        SingleRatingView(weather: 3)
    }
}

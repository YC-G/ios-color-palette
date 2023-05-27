//
//  ColorService.swift
//  ColorPalette
//
//  Created by Yuchen Guo on 4/7/23.
//

import Foundation
import UIKit

enum ColorCallingError: Error {
    case problemGeneratingURL
    case problemGettingDataFromAPI
    case problemDecodingData
}

class ColorService {
    // correct dataset
    private let urlString = "https://run.mocky.io/v3/e4a9e2f5-5391-442c-b472-e094c3274752"
    // empty JSON
    //private let urlString = "https://run.mocky.io/v3/bfdcd2a5-6c88-408b-b1a9-09513a5600c8"
    // empty url
    //private let urlString = ""
    // incorrect url
    //private let urlString = "http://KFC-V50"
    
    var hasProblemGeneratingURL = false
    var hasProblemGettingDataFromAPI = false
    var hasProblemDecodingData = false
    
    func getColors(completion: @escaping ([Color]?, Error?) -> ()) {
        guard let url = URL(string: self.urlString) else {
            DispatchQueue.main.async {
                completion (nil,
                            ColorCallingError.problemGeneratingURL)}
            self.hasProblemGeneratingURL = true
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {data,
            response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion (nil,
                                                       ColorCallingError.problemGettingDataFromAPI)}
                self.hasProblemGettingDataFromAPI = true
                return
            }
            do {
                let colorResult = try JSONDecoder().decode(colorResult.self, from: data)
                DispatchQueue.main.async { completion(colorResult.colors, nil)}
            } catch (let error) {
                print(error)
                DispatchQueue.main.async { completion(nil,
                                                      ColorCallingError.problemDecodingData)}
                self.hasProblemDecodingData = true
            }
            

        }
        
        task.resume()
        
    }
    
    /*
    func getColors() -> [Color] {
        return [
            Color("柿红", "persimmon red", "#F24818", "https://color-term.com/assets/img/colors-big/shihong-f2481b.png"),
            Color("鹤顶红", "arsenic red", "#D42517", "https://color-term.com/assets/img/colors-big/hedinghong-d42517.png"),
            Color("淡绯", "light crimson", "#F2CAC9", "https://color-term.com/assets/img/colors-big/danfei-f2cac9.png"),
            Color("杏黄", "apricot yellow", "#F28E16", "https://color-term.com/assets/img/colors-big/xinghuang-f28e16.png"),
            Color("淡松烟", "light pine soot", "#4D4030", "https://color-term.com/assets/img/colors-big/dansongyan-4d4030.png"),
            Color("群青", "ultramarine", "#1772B4", "https://color-term.com/assets/img/colors-big/qunqing-1772b4.png"),
            Color("暮云灰", "evening cloud grey", "#4F383E", "https://color-term.com/assets/img/colors/muyunhui-4f383e.png"),
            Color("柿红", "persimmon red", "#F24818", "https://color-term.com/assets/img/colors-big/shihong-f2481b.png"),
            Color("鹤顶红", "arsenic red", "#D42517", "https://color-term.com/assets/img/colors-big/hedinghong-d42517.png"),
            Color("淡绯", "light crimson", "#F2CAC9", "https://color-term.com/assets/img/colors-big/danfei-f2cac9.png"),
            Color("杏黄", "apricot yellow", "#F28E16", "https://color-term.com/assets/img/colors-big/xinghuang-f28e16.png"),
            Color("淡松烟", "light pine soot", "#4D4030", "https://color-term.com/assets/img/colors-big/dansongyan-4d4030.png"),
            Color("群青", "ultramarine", "#1772B4", "https://color-term.com/assets/img/colors-big/qunqing-1772b4.png"),
            Color("暮云灰", "evening cloud grey", "#4F383E", "https://color-term.com/assets/img/colors/muyunhui-4f383e.png"),
            Color("柿红", "persimmon red", "#F24818", "https://color-term.com/assets/img/colors-big/shihong-f2481b.png"),
            Color("鹤顶红", "arsenic red", "#D42517", "https://color-term.com/assets/img/colors-big/hedinghong-d42517.png"),
            Color("淡绯", "light crimson", "#F2CAC9", "https://color-term.com/assets/img/colors-big/danfei-f2cac9.png"),
            Color("杏黄", "apricot yellow", "#F28E16", "https://color-term.com/assets/img/colors-big/xinghuang-f28e16.png"),
            Color("淡松烟", "light pine soot", "#4D4030", "https://color-term.com/assets/img/colors-big/dansongyan-4d4030.png"),
            Color("群青", "ultramarine", "#1772B4", "https://color-term.com/assets/img/colors-big/qunqing-1772b4.png"),
            Color("暮云灰", "evening cloud grey", "#4F383E", "https://color-term.com/assets/img/colors/muyunhui-4f383e.png")
        ]
    }
    */
}

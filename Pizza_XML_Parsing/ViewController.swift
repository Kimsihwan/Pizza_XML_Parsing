//
//  ViewController.swift
//  Pizza_XML_Parsing
//
//  Created by D7702_10 on 2018. 9. 19..
//  Copyright © 2018년 ksh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    
    // 딕셔너리의 배열 저장 : item
    var elements:[[String:String]] = []
    // 딕셔너리 : item [key:value]
    var item:[String:String] = [:]
    
    var currentElement = ""
    
    let strURL = "https://api.androidhive.info/pizza/?format=xml"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if URL(string: strURL) != nil {
            
            if let myParser = XMLParser(contentsOf: URL(string: strURL)!){
                myParser.delegate = self
                
                if myParser.parse(){
                    print("파싱 성공")
                    print("elements = \(elements)")
                } else {
                    print("파싱 실패")
                }
                
            }
            
        } else {
            print("URL 오류 발생!")
        }
        
    }
    // XMLParser Delegete 메소드
    
    // 1. tag(element)를 만나면 실행
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        //print(elementName)
    }
    
    // 2. tag 다음에 문자열을 만나면 실행
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        // 공백제거
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        // 공백체크 후 데이터 뽑기
        if !data.isEmpty {
            item[currentElement] = data
            //print(item[currentElement])
        }
        
    }
    
    // 3. tag가 끝날때 실행(/tag)
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            elements.append(item)
        }
    }
    
}


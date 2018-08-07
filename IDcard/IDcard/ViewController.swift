//
//  ViewController.swift
//  IDcard
//
//  Created by kimdaeman14 on 2018. 8. 8..
//  Copyright © 2018년 GoldenShoe. All rights reserved.
//


/*
 <Row>
    <설치장소>양평2동주민센터</설치장소>
    <설치위치>민원실입구</설치위치>
    <운영시간>08:30-18:00</운영시간>
    <소재지도로명주소>서울특별시 영등포구 양평로20길 8-1(양평동4가)</소재지도로명주소>
    <소재지지번주소>서울특별시 영등포구 양평동4가 172-1</소재지지번주소>
    <관리기관명>서울특별시 영등포구청</관리기관명>
    <전화번호>02-2670-3106</전화번호>
    <위도>37.537755</위도>
    <경도>126.895949</경도>
    <데이터기준일자>2018-02-20</데이터기준일자>
 </Row>
 */

import UIKit

class ViewController: UIViewController {
    
    var strXMLData:String = ""
    var currentElement:String = ""
    var passData:Bool=false
    var passName:Bool=false
    var parser = XMLParser()
    
    var location = ""
    var place = ""
    var operatingTime = ""
    var latitude = ""
    
    
    @IBOutlet weak var locationData:UILabel!
    @IBOutlet weak var placeData:UILabel!
    @IBOutlet weak var operatingTimeData:UILabel!
    @IBOutlet weak var latitudeData:UILabel!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        

            if let path = Bundle.main.url(forResource: "idcard", withExtension: "xml"){
                if let parser = XMLParser(contentsOf: path) {
                    parser.delegate = self
                    let success:Bool = parser.parse()
                    if success {
                        print("parse success!")
                        locationData.text = location
                        placeData.text = place
                        operatingTimeData.text = operatingTime
                        latitudeData.text = latitude

                    } else {
                        print("parse failure!")
                    }
                    
                }
        }
      
    }
    
   
    
}

extension ViewController: XMLParserDelegate {
    // parser가 시작 태그를 만나면 호출됩니다. Ex) <name>
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElement=elementName;
        
            if(elementName=="설치장소" || elementName=="설치위치" || elementName=="운영시간" || elementName=="위도")
            {
                if(elementName=="name"){
                    passName=true;
                }
                passData=true;
            }
    }
    // parser가 닫는 태그를 만나면 호출됩니다. Ex) </name>
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        currentElement="";
        if(elementName=="설치장소" || elementName=="설치위치" || elementName=="운영시간" || elementName=="위도")
        {
            if(elementName=="name"){
                passName=false;
            }
            passData=false;
        }
    }
    
    // 현재 태그에 담겨있는 string이 전달됩니다.
    func parser(_ parser: XMLParser, foundCharacters string: String) {
//        if(passName){
//            strXMLData=strXMLData+"\n\n"+string
//        }
//        if(passData)
//        {
//            print(string)
//        }
        
        switch currentElement {
        case "설치장소":
            location = string
        case "설치위치":
            place = string
        case "운영시간":
            operatingTime = string
        case "위도":
            latitude = string
        default:
            print("fail")
        }
    }
    
    //에러발생하면 무슨에러인지 알려주는?
    private func parser(parser: XMLParser, parseErrorOccurred parseError: NSError) {
        NSLog("failure error: %@", parseError)
    }
    
}



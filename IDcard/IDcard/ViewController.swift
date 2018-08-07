//
//  ViewController.swift
//  IDcard
//
//  Created by kimdaeman14 on 2018. 8. 8..
//  Copyright © 2018년 GoldenShoe. All rights reserved.
//
/*
<menu>
    <item>
        <id>1</id>
        <name>Margherita</name>
        <cost>155</cost>
        <description>Single cheese topping</description>
    </item>
    <item>
        <id>2</id>
        <name>Double Cheese Margherita</name>
        <cost>225</cost>
        <description>Loaded with Extra Cheese</description>
    </item>
    <item>
        <id>3</id>
        <name>Fresh Veggie</name>
        <cost>110</cost>
        <description>Oninon and Crisp capsicum</description>
    </item>
*/


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

class ViewController: UIViewController,XMLParserDelegate {
    
    var strXMLData:String = ""
    var currentElement:String = ""
    var passData:Bool=false
    var passName:Bool=false
    var parser = XMLParser()
    
    @IBOutlet weak var lblNameData:UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url:String="http://api.androidhive.info/pizza/?format=xml"
        let urlToSend = URL(string: url)!
        // Parse the XML
        parser = XMLParser(contentsOf: urlToSend)!
        parser.delegate = self
        
        let success:Bool = parser.parse()
        
        if success {
            print("parse success!")
            
            print(strXMLData)
            
            lblNameData.text=strXMLData
            
        } else {
            print("parse failure!")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElement=elementName;
        if(elementName=="id" || elementName=="name" || elementName=="cost" || elementName=="description")
        {
            if(elementName=="name"){
                passName=true;
            }
            passData=true;
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        currentElement="";
        if(elementName=="id" || elementName=="name" || elementName=="cost" || elementName=="description")
        {
            if(elementName=="name"){
                passName=false;
            }
            passData=false;
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if(passName){
            strXMLData=strXMLData+"\n\n"+string
        }
        
        if(passData)
        {
            print(string)
        }
    }
    
    private func parser(parser: XMLParser, parseErrorOccurred parseError: NSError) {
        NSLog("failure error: %@", parseError)
    }
}



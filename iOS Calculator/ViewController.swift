//
//  ViewController.swift
//  iOS Calculator
//
//  Created by Andrés Fonseca on 08/07/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var holder: UIView!
    
    var firstNumber = 0
    var resultNumber = 0
    var currentOperation: Operations?
    
    enum Operations {
        case add, subtract, multiply, divide
    }
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "arial", size: 80.2)
        label.textColor = .white
        label.backgroundColor = .black
        label.textAlignment = .right
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupNumberPad()
    }

        private func setupNumberPad() {
            let buttonSize: CGFloat = view.frame.size.width / 4
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-buttonSize, width: buttonSize*3, height: buttonSize))
            zeroButton.setTitleColor(.black, for: .normal)
            zeroButton.backgroundColor = .white
        zeroButton.setTitle("0", for: .normal)
            zeroButton.tag = 1
            zeroButton .addTarget(self, action: #selector(zeroPressed), for: .touchUpInside)
        holder.addSubview(zeroButton)

    
        for position in 0..<3 {
            let rowOneButton = UIButton(frame: CGRect(x: buttonSize * CGFloat(position), y: holder.frame.size.height-(buttonSize*2), width: buttonSize, height: buttonSize))
            rowOneButton.setTitleColor(.black, for: .normal)
            rowOneButton.backgroundColor = .white
            rowOneButton.setTitle("\(position+1)", for: .normal)
            rowOneButton.tag = position+2
            holder.addSubview(rowOneButton)
            rowOneButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
    }
            
            for position in 0..<3 {
                let rowTwoButton = UIButton(frame: CGRect(x: buttonSize * CGFloat(position), y: holder.frame.size.height-(buttonSize*3), width: buttonSize, height: buttonSize))
                rowTwoButton.setTitleColor(.black, for: .normal)
                rowTwoButton.backgroundColor = .white
                rowTwoButton.setTitle("\(position+4)", for: .normal)
                rowTwoButton.tag = position+5
                holder.addSubview(rowTwoButton)
                rowTwoButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }
            
            for position in 0..<3 {
                let rowThreeButton = UIButton(frame: CGRect(x: buttonSize * CGFloat(position), y: holder.frame.size.height-(buttonSize*4), width: buttonSize, height: buttonSize))
                rowThreeButton.setTitleColor(.black, for: .normal)
                rowThreeButton.backgroundColor = .white
                rowThreeButton.setTitle("\(position+7)", for: .normal)
                rowThreeButton.tag = position+8
                holder.addSubview(rowThreeButton)
                rowThreeButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }
            
            let clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-(buttonSize*5), width: buttonSize*3, height: buttonSize))
            clearButton.setTitleColor(.black, for: .normal)
            clearButton.backgroundColor = .orange
            clearButton.setTitle("CLEAR", for: .normal)
            holder.addSubview(clearButton)
            
            let operations = ["=", "+", "-", "*", "/"]
            
            for position in 0..<5 {
                let rowFourButton = UIButton(frame: CGRect(x: buttonSize * 3, y: holder.frame.size.height-(buttonSize * CGFloat(position+1)), width: buttonSize, height: buttonSize))
                rowFourButton.setTitleColor(.black, for: .normal)
                rowFourButton.backgroundColor = .orange
                rowFourButton.setTitle("\(operations[position])", for: .normal)
                holder.addSubview(rowFourButton)
                rowFourButton.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside  )
                rowFourButton.tag = position+1
        }
            
            resultLabel.frame = CGRect(x: 0, y: clearButton.frame.origin.y - buttonSize, width: holder.frame.size.width, height: buttonSize)
            holder.addSubview(resultLabel)
            
            
        // Action
            
            clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
            
        }
    
    @objc func zeroPressed() {
        if resultLabel.text != "0"{
            if let text = resultLabel.text {
            resultLabel.text = "\(text)\(0)"
         }
            
        }
    }
    
    @objc func clearResult(){
        resultLabel.text = "0"
        currentOperation = nil
        firstNumber = 0
    }
    
    @objc func numberPressed(_ sender: UIButton){
        let tag = sender.tag - 1
        
        if resultLabel.text == "0"{
            resultLabel.text = "\(tag)"
        } else if let text = resultLabel.text {
            resultLabel.text = "\(text)\(tag)"
        }
        
    }
    
    @objc func operationPressed(_ sender: UIButton){
        let tag = sender.tag
            
        if let text = resultLabel.text, let value = Int(text), firstNumber == 0 {
           firstNumber = value
            resultLabel.text = "0"
        }
        
        
        if tag == 1 {
            if let operation = currentOperation {
                 var secondNumber = 0
                if let text = resultLabel.text, let value = Int(text){
                    secondNumber = value
                }
                switch operation {
                case .add:
                    let resultNumber = firstNumber + secondNumber
                    resultLabel.text = "\(resultNumber)"
                    
                case .subtract:
                    let resultNumber = firstNumber - secondNumber
                    resultLabel.text = "\(resultNumber)"
                    
                case .multiply:
                    let resultNumber = firstNumber * secondNumber
                    resultLabel.text = "\(resultNumber)"
                    
                case .divide:
                    let resultNumber = firstNumber / secondNumber
                    resultLabel.text = "\(resultNumber)"
                    
                }
                
            }
        } else if tag == 2{
            currentOperation = .add
        } else if tag == 3{
            currentOperation = .subtract
        } else if tag == 4{
            currentOperation = .multiply
        } else if tag == 5 {
            currentOperation = .divide
    }
    
  }

}

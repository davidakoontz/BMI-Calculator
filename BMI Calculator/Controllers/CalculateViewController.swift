//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    var calculatorBrain = CalculatorBrain()
    // to handle Metric/Imperial unit changes
    var imperialLabel = "Units:  Imperial"
    var metricLabel = "Units:  Metric"
    var lengthUnit = "m"    // or inches (in)
    var weightUnit = "Kg"   // or pounds (lb)
    let maxLengthMetric: Float = 3.0
    let maxLengthImperial: Float = 96.0
    let maxWeightMetric: Float = 200.0
    let maxWeightImperial: Float = 440.0

    @IBOutlet var calculateBmiView: UIView!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func switchUnits(_ sender: UISwitch) {
        // On = Metric  while Off = Imperial
        if sender.isOn {
            unitsLabel.text = metricLabel
            lengthUnit = "m"
            weightUnit = "Kg"
            heightSlider.maximumValue = maxLengthMetric
            weightSlider.maximumValue = maxWeightMetric
            calculatorBrain.setFactor(value: 1.0)
            // how to redraw the Height label - to change to metric
            //heightLabel.setNeedsLayout()  does not work - the new values are not in label yet
        } else {
            unitsLabel.text = imperialLabel
            lengthUnit = "in"
            weightUnit = "lb"
            heightSlider.maximumValue = maxLengthImperial
            weightSlider.maximumValue = maxWeightImperial
            calculatorBrain.setFactor(value: 703.0)

        }
    }
    
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        let height = String(format: "%.2f", sender.value)
        heightLabel.text = "\(height) \(lengthUnit)"
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        let weight = String(format: "%.0f", sender.value)
        weightLabel.text = "\(weight) \(weightUnit)"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let height = heightSlider.value
        let weight = weightSlider.value

        calculatorBrain.calculateBMI(height: height, weight: weight)
        performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiValue = calculatorBrain.getBMIValue()
            destinationVC.advice = calculatorBrain.getAdvice()
            destinationVC.color = calculatorBrain.getColor()
        }
    }
}
























//
//  GridProvider.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-11-08.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//


import UIKit

struct GridProvider {
    
    typealias GridMatrix = (rows: Int, columns: Int)
    
    private let spacing: CGFloat = 8.0
    private let margin: CGFloat = 16.0
    private let frame: CGRect
    private let size: Int
        
    var grid: [CGRect] = []
    
    init(of size: Int, in frame: CGRect){
        self.size = size
        self.frame = frame
        getGrid()
    }

    mutating private func getGrid() {
        let rows = floor(sqrt(Double(size)))
        let columns = (Double(size)/rows)
        
        let gridMatrix = (rows: Int(rows), columns: Int(columns))
    
        let itemSize = getItemSize(for: gridMatrix)
        
        for r in 0 ..< gridMatrix.rows {
            for c in 0 ..< gridMatrix.columns {

                var x = margin
                if c > 0 {
                    x = (spacing + itemSize.width) * CGFloat(c) + margin
                }
                
                let minY = frame.minY + margin
                let y = minY + (spacing + itemSize.height) * CGFloat(r)

                let frame = CGRect(x: x, y: y, width: itemSize.width, height: itemSize.height)
                grid.append(frame)
            }
        }
    }
    
    private func getItemSize(for grid: GridMatrix)-> CGSize {
        let totalHorizontalSpacing = spacing * (CGFloat(grid.columns - 1))
        let sizeConstant = (frame.width - margin * 2 - totalHorizontalSpacing) / CGFloat(grid.columns)
        return CGSize(width: sizeConstant, height: sizeConstant)
    }
}

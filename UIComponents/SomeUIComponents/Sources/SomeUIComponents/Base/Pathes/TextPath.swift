//
//  TextPath.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 01.11.2024.
//

import SwiftUI
import CoreText

public func SomeTextPath(string: String, textStyle: Font) -> Path {
    // Convert SwiftUI Font to CTFont
        let uiFont: UIFont
        switch textStyle {
        case .largeTitle:
            uiFont = UIFont.preferredFont(forTextStyle: .largeTitle)
        case .title:
            uiFont = UIFont.preferredFont(forTextStyle: .title1)
        case .headline:
            uiFont = UIFont.preferredFont(forTextStyle: .headline)
        case .body:
            uiFont = UIFont.preferredFont(forTextStyle: .body)
        default:
            uiFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        }

        let ctFont = CTFontCreateWithName(uiFont.fontName as CFString, uiFont.pointSize, nil)

        // Create attributed string with CoreText font
        let attributes: [NSAttributedString.Key: Any] = [
            .font: ctFont
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)

        // Create a line of text
        let line = CTLineCreateWithAttributedString(attributedString)

        // Create a path to hold the glyphs
        var path = Path()

        // Get the glyph runs and add them to the path
        let runs = CTLineGetGlyphRuns(line) as! [CTRun]
        for run in runs {
            let glyphCount = CTRunGetGlyphCount(run)
            for glyphIndex in 0..<glyphCount {
                var glyph = CGGlyph()
                var position = CGPoint.zero
                CTRunGetGlyphs(run, CFRangeMake(glyphIndex, 1), &glyph)
                CTRunGetPositions(run, CFRangeMake(glyphIndex, 1), &position)
                
                if let glyphPath = CTFontCreatePathForGlyph(ctFont, glyph, nil) {
                    let transform = CGAffineTransform(translationX: position.x, y: position.y)
                        .scaledBy(x: 1, y: -1) // Flip vertically
                        .translatedBy(x: 0, y: -uiFont.pointSize) // Adjust the baseline
                    path.addPath(Path(glyphPath), transform: transform)
                }
            }
        }

        return path
}

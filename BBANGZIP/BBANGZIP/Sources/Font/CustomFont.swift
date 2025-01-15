//
//  CustomFont.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/8/25.
//
import SwiftUI

enum CustomFont: Sendable {
    case title1Small
    case title1Medium
    case title1Bold
    case title2Small
    case title2Medium
    case title2Bold
    case title3Small
    case title3Medium
    case title3Bold
    case heading1Small
    case heading1Medium
    case heading1Bold
    case heading2Small
    case heading2Medium
    case heading2Bold
    case headline1Small
    case headline1Medium
    case headline1Bold
    case headline2Small
    case headline2Medium
    case headline2Bold
    case body1Small
    case body1Medium
    case body1Bold
    case body2Small
    case body2Medium
    case body2Bold
    case label1Small
    case label1Medium
    case label1Bold
    case label2Small
    case label2Medium
    case label2Bold
    case caption1Small
    case caption1Medium
    case caption1Bold
    case caption2Small
    case caption2Medium
    case caption2Bold

    var size: CGFloat {
        switch self {
        case .title1Small, .title1Medium, .title1Bold:
            return 36
        case .title2Small, .title2Medium, .title2Bold:
            return 28
        case .title3Small, .title3Medium, .title3Bold:
            return 24
        case .heading1Small, .heading1Medium, .heading1Bold:
            return 22
        case .heading2Small, .heading2Medium, .heading2Bold:
            return 20
        case .headline1Small, .headline1Medium, .headline1Bold:
            return 18
        case .headline2Small, .headline2Medium, .headline2Bold:
            return 17
        case .body1Small, .body1Medium, .body1Bold:
            return 16
        case .body2Small, .body2Medium, .body2Bold:
            return 15
        case .label1Small, .label1Medium, .label1Bold:
            return 14
        case .label2Small, .label2Medium, .label2Bold:
            return 13
        case .caption1Small, .caption1Medium, .caption1Bold:
            return 12
        case .caption2Small, .caption2Medium, .caption2Bold:
            return 11
        }
    }

    var lineHeight: CGFloat {
        switch self {
        case .title1Small, .title1Medium, .title1Bold:
            return 48
        case .title2Small, .title2Medium, .title2Bold:
            return 38
        case .title3Small, .title3Medium, .title3Bold:
            return 32
        case .heading1Small, .heading1Medium, .heading1Bold:
            return 30
        case .heading2Small, .heading2Medium, .heading2Bold:
            return 28
        case .headline1Small, .headline1Medium, .headline1Bold:
            return 26
        case .headline2Small, .headline2Medium, .headline2Bold:
            return 24
        case .body1Small, .body1Medium, .body1Bold:
            return 24
        case .body2Small, .body2Medium, .body2Bold:
            return 22
        case .label1Small, .label1Medium, .label1Bold:
            return 20
        case .label2Small, .label2Medium, .label2Bold:
            return 18
        case .caption1Small, .caption1Medium, .caption1Bold:
            return 16
        case .caption2Small, .caption2Medium, .caption2Bold:
            return 14
        }
    }

    var letterSpacing: CGFloat {
        switch self {
        case .title1Small, .title1Medium, .title1Bold:
            return -0.027
        case .title2Small, .title2Medium, .title2Bold:
            return -0.0236
        case .title3Small, .title3Medium, .title3Bold:
            return -0.023
        case .heading1Small, .heading1Medium, .heading1Bold:
            return -0.0194
        case .heading2Small, .heading2Medium, .heading2Bold:
            return -0.012
        case .headline1Small, .headline1Medium, .headline1Bold:
            return -0.002
        case .headline2Small, .headline2Medium, .headline2Bold:
            return 0
        case .body1Small, .body1Medium, .body1Bold:
            return 0.0057
        case .body2Small, .body2Medium, .body2Bold:
            return 0.0096
        case .label1Small, .label1Medium, .label1Bold:
            return 0.0145
        case .label2Small, .label2Medium, .label2Bold:
            return 0.0194
        case .caption1Small, .caption1Medium, .caption1Bold:
            return 0.0252
        case .caption2Small, .caption2Medium, .caption2Bold:
            return 0.0311
        }
    }

    var swiftUIFont: Font {
        switch self {
        case .title1Small, .title2Small, .title3Small, .heading1Small, .heading2Small, .headline1Small, .headline2Small, .body1Small, .body2Small, .label1Small, .label2Small, .caption1Small, .caption2Small:
            return BBANGZIPFontFamily.Pretendard.regular.swiftUIFont(size: self.size)
        case .title1Medium, .title2Medium, .title3Medium, .heading1Medium, .heading2Medium, .headline1Medium, .headline2Medium, .body1Medium, .body2Medium, .label1Medium, .label2Medium, .caption1Medium, .caption2Medium:
            return BBANGZIPFontFamily.Pretendard.medium.swiftUIFont(size: self.size)
        case .title1Bold, .title2Bold, .title3Bold, .heading1Bold, .heading2Bold, .headline1Bold, .headline2Bold, .body1Bold, .body2Bold, .label1Bold, .label2Bold, .caption1Bold, .caption2Bold:
            return BBANGZIPFontFamily.Pretendard.bold.swiftUIFont(size: self.size)
        }
    }
}


struct FontModifier: ViewModifier {
    private let font: CustomFont
    
    nonisolated init(font: CustomFont) {
        self.font = font
    }
    
    func body(content: Content) -> some View {
        content
            .font(font.swiftUIFont)
            .lineSpacing(font.lineHeight - font.size)
            .kerning(font.letterSpacing)
    }
}

extension View {
    nonisolated func applyFont(font: CustomFont) -> some View {
        modifier(FontModifier(font: font))
    }
}

struct BbangText: View {
    private let title: String
    private let fontType: CustomFont
    private let color: Color?
    
    nonisolated init(
        _ title: String,
        fontType: CustomFont,
        color: Color? = BBANGZIPAsset.Assets.primaryHeavy.swiftUIColor
    ) {
        self.title = title
        self.fontType = fontType
        self.color = color
    }
    
    var body: some View {
        Text(title)
            .applyFont(font: fontType)
            .foregroundStyle(color ?? BBANGZIPAsset.Assets.primaryHeavy.swiftUIColor)
    }
}

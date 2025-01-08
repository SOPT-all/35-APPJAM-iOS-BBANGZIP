//
//  BbangzipFont.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/8/25.
//
import SwiftUI

public enum BbangFont {
    case title1
    case title2
    case title3
    case heading1
    case heading2
    case headline1
    case headline2
    case body1
    case body2
    case label1
    case label2
    case caption1
    case caption2
    
    public var size: CGFloat {
        switch self {
        case .title1: return 36
        case .title2: return 28
        case .title3: return 24
        case .heading1: return 22
        case .heading2: return 20
        case .headline1: return 18
        case .headline2: return 17
        case .body1: return 16
        case .body2: return 15
        case .label1: return 14
        case .label2: return 13
        case .caption1: return 12
        case .caption2: return 11
        }
    }
    
    public var lineHeight: CGFloat {
        switch self {
        case .title1: return 48
        case .title2: return 38
        case .title3: return 32
        case .heading1: return 30
        case .heading2: return 28
        case .headline1: return 26
        case .headline2: return 24
        case .body1: return 24
        case .body2: return 22
        case .label1: return 20
        case .label2: return 18
        case .caption1: return 16
        case .caption2: return 14
        }
    }
    
    public var letterSpacing: CGFloat {
        switch self {
        case .title1: return -0.027
        case .title2: return -0.0236
        case .title3: return -0.023
        case .heading1: return -0.0194
        case .heading2: return -0.012
        case .headline1: return -0.002
        case .headline2: return 0
        case .body1: return 0.0057
        case .body2: return 0.0096
        case .label1: return 0.0145
        case .label2: return 0.0194
        case .caption1: return 0.0252
        case .caption2: return 0.0311
        }
    }
    
    public var swiftUIFont: Font {
        switch self {
        case .title1: return BBANGZIPFontFamily.Pretendard.bold.swiftUIFont(size: self.size)
        case .title2: return BBANGZIPFontFamily.Pretendard.semiBold.swiftUIFont(size: self.size)
        case .title3: return BBANGZIPFontFamily.Pretendard.medium.swiftUIFont(size: self.size)
        case .heading1: return BBANGZIPFontFamily.Pretendard.medium.swiftUIFont(size: self.size)
        case .heading2: return BBANGZIPFontFamily.Pretendard.medium.swiftUIFont(size: self.size)
        case .headline1: return BBANGZIPFontFamily.Pretendard.regular.swiftUIFont(size: self.size)
        case .headline2: return BBANGZIPFontFamily.Pretendard.regular.swiftUIFont(size: self.size)
        case .body1: return BBANGZIPFontFamily.Pretendard.light.swiftUIFont(size: self.size)
        case .body2: return BBANGZIPFontFamily.Pretendard.light.swiftUIFont(size: self.size)
        case .label1: return BBANGZIPFontFamily.Pretendard.light.swiftUIFont(size: self.size)
        case .label2: return BBANGZIPFontFamily.Pretendard.light.swiftUIFont(size: self.size)
        case .caption1: return BBANGZIPFontFamily.Pretendard.extraLight.swiftUIFont(size: self.size)
        case .caption2: return BBANGZIPFontFamily.Pretendard.extraLight.swiftUIFont(size: self.size)
        }
    }
}

public struct FontModifier: ViewModifier {
    let font: BbangFont
    
    public func body(content: Content) -> some View {
        content
            .font(font.swiftUIFont)
            .lineSpacing(font.lineHeight - font.size)
            .kerning(font.letterSpacing)
    }
}

extension View {
    public func applyFont(font: BbangFont) -> some View {
        modifier(FontModifier(font: font))
    }
}

public struct BbangText: View {
    let title: String
    let fontType: BbangFont
    let color: Color?
    
    public init(
        _ title: String,
        fontType: BbangFont,
        color: Color? = BBANGZIPAsset.Assets.primaryHeavy.swiftUIColor
    ) {
        self.title = title
        self.fontType = fontType
        self.color = color
    }
    
    public var body: some View {
        Text(title)
            .applyFont(font: fontType)
            .foregroundStyle(color ?? BBANGZIPAsset.Assets.primaryHeavy.swiftUIColor)
    }
}

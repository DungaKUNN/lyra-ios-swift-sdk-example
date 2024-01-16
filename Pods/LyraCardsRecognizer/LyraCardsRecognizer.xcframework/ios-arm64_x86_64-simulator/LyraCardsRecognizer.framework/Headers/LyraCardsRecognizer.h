//
//  LyraCardsRecognizer.h
//  LyraCardsRecognizer
//
//  Created by Vitaliy Kuzmenko on 12/07/2017.
//  Copyright © 2017 Wallet One. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LyraCardsRecognizerResult.h"

extern NSString * _Nonnull const WOCardNumber;
extern NSString * _Nonnull const WOExpDate;
extern NSString * _Nonnull const WOHolderName;
extern NSString * _Nonnull const WOHolderNameRaw;
extern NSString * _Nonnull const WONumberConfidences;
extern NSString * _Nonnull const WOHolderNameConfidences;
extern NSString * _Nonnull const WOExpDateConfidences;
extern NSString * _Nonnull const WOCardImage;
extern NSString * _Nonnull const WOPanRect;
extern NSString * _Nonnull const WODateRect;
extern NSString * _Nonnull const WONumberSamples;
extern NSString * _Nonnull const WODateSamples;
extern NSString * _Nonnull const WOHolderSamples;

typedef NS_ENUM(NSUInteger, LyraCardsRecognizerResultMode) {
    LyraCardsRecognizerResultModeAsync, // Recognized data will be return separatley. First time returned number and exiration, after name
    LyraCardsRecognizerResultModeSync, // All recognized data will be return at one time.
};

typedef NS_OPTIONS(NSUInteger, LyraCardsRecognizerDataMode) {
    LyraCardsRecognizerDataModeNone = 0,
    LyraCardsRecognizerDataModeNumber = 1,
    LyraCardsRecognizerDataModeDate = 2,
    LyraCardsRecognizerDataModeName = 4,
    LyraCardsRecognizerDataModeGrabCardImage = 8
};

@protocol LyraCardsRecognizerPlatformDelegate;

@interface LyraCardsRecognizer : NSObject

- (instancetype _Nonnull)initWithDelegate:(id<LyraCardsRecognizerPlatformDelegate> _Nonnull)delegate resultMode:(LyraCardsRecognizerResultMode)resultMode container:(UIView * _Nonnull)container frameColor:(UIColor * _Nonnull)frameColor unavailableOrientationMsg:(NSString * _Nonnull)message bgColorForUnavailableMsg:(UIColor * _Nonnull)color;

- (instancetype _Nonnull)initWithDelegate:(id<LyraCardsRecognizerPlatformDelegate> _Nonnull)delegate recognizerMode:(LyraCardsRecognizerDataMode)recognizerMode resultMode:(LyraCardsRecognizerResultMode)resultMode container:(UIView * _Nonnull)container frameColor:(UIColor * _Nonnull)frameColor unavailableOrientationMsg:(NSString * _Nonnull)message bgColorForUnavailableMsg:(UIColor * _Nonnull)color;

@property (nonatomic, weak, nullable) id<LyraCardsRecognizerPlatformDelegate> delegate;

- (void)startCamera;

- (void)startCameraWithOrientation:(UIInterfaceOrientation)orientation;

- (void)stopCamera;

- (void)pauseRecognizer;

- (void)resumeRecognizer;

- (void)setOrientation:(UIInterfaceOrientation)orientation;

- (void)turnTorchOn:(BOOL)on withValue:(float)value;

@end

@protocol LyraCardsRecognizerPlatformDelegate

- (void)payCardsRecognizer:(LyraCardsRecognizer * _Nonnull)payCardsRecognizer didRecognize:(LyraCardsRecognizerResult * _Nonnull)result;

@end

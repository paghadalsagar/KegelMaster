//
//  myTargetSDK 5.6.0
//
// Created by Timur on 4/12/18.
// Copyright (c) 2018 Mail.Ru Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTRGAppwallAdView;
@class MTRGNativeAppwallBanner;
@class MTRGAppwallBannerAdView;
@protocol MTRGAppwallBannerAdViewDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface MTRGNativeAppwallViewsFactory : NSObject

+ (MTRGAppwallBannerAdView *)bannerViewWithBanner:(MTRGNativeAppwallBanner *)appwallBanner delegate:(id <MTRGAppwallBannerAdViewDelegate>)delegate;

+ (MTRGAppwallBannerAdView *)bannerViewWithDelegate:(id <MTRGAppwallBannerAdViewDelegate>)delegate;

+ (MTRGAppwallAdView *)appwallAdViewWithBanners:(NSArray <MTRGNativeAppwallBanner *> *)banners;

@end

NS_ASSUME_NONNULL_END

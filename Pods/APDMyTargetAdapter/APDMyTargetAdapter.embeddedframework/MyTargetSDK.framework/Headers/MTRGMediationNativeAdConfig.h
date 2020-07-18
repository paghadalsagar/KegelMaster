//
// Copyright (c) 2019 Mail.Ru Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTRGMediationAdConfig.h"
#import "MTRGNativeAd.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTRGMediationNativeAdConfig : MTRGMediationAdConfig

@property(nonatomic, readonly) BOOL autoLoadImages; // Deprecated
@property(nonatomic, readonly) BOOL autoLoadVideo; // Deprecated
@property(nonatomic, readonly) MTRGCachePolicy cachePolicy;
@property(nonatomic, readonly) MTRGAdChoicesPlacement adChoicesPlacement;

+ (instancetype)configWithPlacementId:(NSString *)placementId
							  payload:(nullable NSString *)payload
						 serverParams:(NSDictionary<NSString *, NSString *> *)serverParams
								  age:(nullable NSNumber *)age
							   gender:(MTRGGender)gender
				 userConsentSpecified:(BOOL)userConsentSpecified
						  userConsent:(BOOL)userConsent
					userAgeRestricted:(BOOL)userAgeRestricted
				 trackLocationEnabled:(BOOL)trackLocationEnabled
						  cachePolicy:(MTRGCachePolicy)cachePolicy
				   adChoicesPlacement:(MTRGAdChoicesPlacement)adChoicesPlacement;

@end

NS_ASSUME_NONNULL_END

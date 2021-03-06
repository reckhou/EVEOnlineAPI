//
//  EVEShareholders.h
//  EVEOnlineAPI
//
//  Created by Artem Shimanski on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EVERequest.h"

@interface EVEShareholdersCharactersItem : NSObject<NSCoding>
@property (nonatomic) int32_t shareholderID;
@property (nonatomic, copy) NSString *shareholderName;
@property (nonatomic) int32_t shareholderCorporationID;
@property (nonatomic, copy) NSString *shareholderCorporationName;
@property (nonatomic) int32_t shares;

+ (id) shareholdersCharactersItemWithXMLAttributes:(NSDictionary *)attributeDict;
- (id) initWithXMLAttributes:(NSDictionary *)attributeDict;

@end


@interface EVEShareholdersCorporationsItem : NSObject<NSCoding>
@property (nonatomic) int32_t shareholderID;
@property (nonatomic, copy) NSString *shareholderName;
@property (nonatomic) int32_t shares;

+ (id) shareholdersCorporationsItemWithXMLAttributes:(NSDictionary *)attributeDict;
- (id) initWithXMLAttributes:(NSDictionary *)attributeDict;

@end


@interface EVEShareholders : EVERequest
@property (nonatomic, strong) NSArray *characters;
@property (nonatomic, strong) NSArray *corporations;

+ (id) shareholdersWithKeyID: (int32_t) keyID vCode: (NSString*) vCode cachePolicy:(NSURLRequestCachePolicy) cachePolicy characterID: (int32_t) characterID error:(NSError **)errorPtr progressHandler:(void(^)(CGFloat progress, BOOL* stop)) progressHandler;
- (id) initWithKeyID: (int32_t) keyID vCode: (NSString*) vCode cachePolicy:(NSURLRequestCachePolicy) cachePolicy characterID: (int32_t) characterID error:(NSError **)errorPtr progressHandler:(void(^)(CGFloat progress, BOOL* stop)) progressHandler;

@end
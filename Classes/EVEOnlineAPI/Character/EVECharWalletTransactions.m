//
//  EVECharWalletTransactions.m
//  EVEOnlineAPI
//
//  Created by Artem Shimanski on 7/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EVECharWalletTransactions.h"


@implementation EVECharWalletTransactionsItem

+ (id) charWalletTransactionsItemWithXMLAttributes:(NSDictionary *)attributeDict {
	return [[EVECharWalletTransactionsItem alloc] initWithXMLAttributes:attributeDict];
}

- (id) initWithXMLAttributes:(NSDictionary *)attributeDict {
	if (self = [super init]) {
		self.transactionDateTime = [[NSDateFormatter eveDateFormatter] dateFromString:[attributeDict valueForKey:@"transactionDateTime"]];
		self.transactionID = [[attributeDict valueForKey:@"transactionID"] longLongValue];
		self.quantity = [[attributeDict valueForKey:@"quantity"] intValue];
		self.typeName = [attributeDict valueForKey:@"typeName"];
		self.typeID = [[attributeDict valueForKey:@"typeID"] intValue];
		self.price = [[attributeDict valueForKey:@"price"] floatValue];
		self.clientID = [[attributeDict valueForKey:@"clientID"] intValue];
		self.clientName = [attributeDict valueForKey:@"clientName"];
		self.stationID = [[attributeDict valueForKey:@"stationID"] intValue];
		self.stationName = [attributeDict valueForKey:@"stationName"];
		self.transactionType = [attributeDict valueForKey:@"transactionType"];
		self.transactionFor = [attributeDict valueForKey:@"transactionFor"];
	}
	return self;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.transactionDateTime forKey:@"transactionDateTime"];
	[aCoder encodeInt64:self.transactionID forKey:@"transactionID"];
	[aCoder encodeInt32:self.quantity forKey:@"quantity"];
	[aCoder encodeObject:self.typeName forKey:@"typeName"];
	[aCoder encodeInt32:self.typeID forKey:@"typeID"];
	[aCoder encodeFloat:self.price forKey:@"price"];
	[aCoder encodeInt32:self.clientID forKey:@"clientID"];
	[aCoder encodeObject:self.clientName forKey:@"clientName"];
	[aCoder encodeInt32:self.stationID forKey:@"stationID"];
	[aCoder encodeObject:self.stationName forKey:@"stationName"];
	[aCoder encodeObject:self.transactionType forKey:@"transactionType"];
	[aCoder encodeObject:self.transactionFor forKey:@"transactionFor"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super init]) {
		self.transactionDateTime = [aDecoder decodeObjectForKey:@"transactionDateTime"];
		self.transactionID = [aDecoder decodeInt64ForKey:@"transactionID"];
		self.quantity = [aDecoder decodeInt32ForKey:@"quantity"];
		self.typeName = [aDecoder decodeObjectForKey:@"typeName"];
		self.typeID = [aDecoder decodeInt32ForKey:@"typeID"];
		self.price = [aDecoder decodeFloatForKey:@"price"];
		self.clientID = [aDecoder decodeInt32ForKey:@"clientID"];
		self.clientName = [aDecoder decodeObjectForKey:@"clientName"];
		self.stationID = [aDecoder decodeInt32ForKey:@"stationID"];
		self.stationName = [aDecoder decodeObjectForKey:@"stationName"];
		self.transactionType = [aDecoder decodeObjectForKey:@"transactionType"];
		self.transactionFor = [aDecoder decodeObjectForKey:@"transactionFor"];
	}
	return self;
}

@end


@implementation EVECharWalletTransactions

+ (EVEApiKeyType) requiredApiKeyType {
	return EVEApiKeyTypeFull;
}

+ (id) charWalletTransactionsWithKeyID: (int32_t) keyID vCode: (NSString*) vCode cachePolicy:(NSURLRequestCachePolicy) cachePolicy characterID: (int32_t) characterID beforeTransID: (int64_t) beforeTransID error:(NSError **)errorPtr progressHandler:(void(^)(CGFloat progress, BOOL* stop)) progressHandler {
	return [[EVECharWalletTransactions alloc] initWithKeyID:keyID vCode:vCode cachePolicy:cachePolicy characterID:characterID beforeTransID:beforeTransID error:errorPtr progressHandler:progressHandler];
}

- (id) initWithKeyID: (int32_t) keyID vCode: (NSString*) vCode cachePolicy:(NSURLRequestCachePolicy) cachePolicy characterID: (int32_t) characterID beforeTransID: (int64_t) beforeTransID error:(NSError **)errorPtr progressHandler:(void(^)(CGFloat progress, BOOL* stop)) progressHandler {
	if (self = [super initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/char/WalletTransactions.xml.aspx?keyID=%d&vCode=%@&characterID=%d%@", EVEOnlineAPIHost, keyID, [vCode stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], characterID,
														(beforeTransID > 0 ? [NSString stringWithFormat:@"&beforeTransID=%qi", beforeTransID] : @"")]]
					   cachePolicy:cachePolicy
							error:errorPtr
				  progressHandler:progressHandler]) {
	}
	return self;
}

- (NSError*) parseData:(NSData *)data {
	NSError* error = [super parseData:data];
	self.cachedUntil = [self.currentTime dateByAddingTimeInterval:3600];
	self.cacheExpireDate = [self localTimeWithServerTime:self.cachedUntil];
	return error;
}

#pragma mark NSXMLParserDelegate

- (id) didStartRowset: (NSString*) rowset {
	if ([rowset isEqualToString:@"transactions"]) {
		self.transactions = [[NSMutableArray alloc] init];
		return self.transactions;
	}
	else
		return nil;
}

- (id) didStartRowWithAttributes:(NSDictionary *) attributeDict rowset:(NSString*) rowset rowsetObject:(id) object {
	if ([rowset isEqualToString:@"transactions"]) {
		EVECharWalletTransactionsItem *charWalletTransactionsItem = [EVECharWalletTransactionsItem charWalletTransactionsItemWithXMLAttributes:attributeDict];
		[(NSMutableArray*) self.transactions addObject:charWalletTransactionsItem];
		return charWalletTransactionsItem;
	}
	return nil;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.transactions forKey:@"transactions"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		self.transactions = [aDecoder decodeObjectForKey:@"transactions"];
	}
	return self;
}

@end
//
//  EVEMailBodies.m
//  EVEOnlineAPI
//
//  Created by Artem Shimanski on 1/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EVEMailBodies.h"


@implementation EVEMailBodiesItem

+ (id) mailBodiesItemWithXMLAttributes:(NSDictionary *)attributeDict {
	return [[EVEMailBodiesItem alloc] initWithXMLAttributes:attributeDict];
}

- (id) initWithXMLAttributes:(NSDictionary *)attributeDict {
	if (self = [super init]) {
		self.messageID = [[attributeDict valueForKey:@"messageID"] intValue];
	}
	return self;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt32:self.messageID forKey:@"messageID"];
	[aCoder encodeObject:self.text forKey:@"text"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super init]) {
		self.messageID = [aDecoder decodeInt32ForKey:@"messageID"];
		self.text = [aDecoder decodeObjectForKey:@"text"];
	}
	return self;
}

@end


@implementation EVEMailBodies

+ (EVEApiKeyType) requiredApiKeyType {
	return EVEApiKeyTypeFull;
}

+ (id) mailBodiesWithKeyID: (int32_t) keyID vCode: (NSString*) vCode cachePolicy:(NSURLRequestCachePolicy) cachePolicy characterID: (int32_t) characterID ids: (NSArray*) ids error:(NSError **)errorPtr progressHandler:(void(^)(CGFloat progress, BOOL* stop)) progressHandler {
	return [[EVEMailBodies alloc] initWithKeyID:keyID vCode:vCode cachePolicy:cachePolicy characterID:characterID ids:ids error:errorPtr progressHandler:progressHandler];
}

- (id) initWithKeyID: (int32_t) keyID vCode: (NSString*) vCode cachePolicy:(NSURLRequestCachePolicy) cachePolicy characterID: (int32_t) characterID ids: (NSArray*) ids error:(NSError **)errorPtr progressHandler:(void(^)(CGFloat progress, BOOL* stop)) progressHandler {
	if (self = [super initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/char/MailBodies.xml.aspx?keyID=%d&vCode=%@&characterID=%d&ids=%@", EVEOnlineAPIHost, keyID, [vCode stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], characterID, [ids componentsJoinedByString:@","]]]
					   cachePolicy:cachePolicy
							error:errorPtr
				  progressHandler:progressHandler]) {
	}
	return self;
}

#pragma mark NSXMLParserDelegate

- (id) didStartRowset: (NSString*) rowset {
	if ([rowset isEqualToString:@"messages"]) {
		self.messages = [[NSMutableArray alloc] init];
		return self.messages;
	}
	else
		return nil;
}

- (id) didStartRowWithAttributes:(NSDictionary *) attributeDict rowset:(NSString*) rowset rowsetObject:(id) object {
	if ([rowset isEqualToString:@"messages"]) {
		EVEMailBodiesItem *mailBodiesItem = [EVEMailBodiesItem mailBodiesItemWithXMLAttributes:attributeDict];
		[(NSMutableArray*) self.messages addObject:mailBodiesItem];
		return mailBodiesItem;
	}
	return nil;
}

- (void) didEndRow: (id) row rowset: (NSString*) rowset {
	[super didEndRow:row rowset:rowset];
	if ([rowset isEqualToString:@"messages"]) {
		[row setText:[self.text copy]];
	}
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.messages forKey:@"messages"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		self.messages = [aDecoder decodeObjectForKey:@"messages"];
	}
	return self;
}

@end

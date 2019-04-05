//
//  NSData.m
//  CoreFoundation
//
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <CoreFoundation/CFData.h>
//#import <Foundation/NSData.h>
#import "CFPriv.h"
#import <Foundation/NSObject.h>

@interface NSData : NSObject
@end

@interface NSMutableData : NSData
@end

@implementation NSData
@end

@implementation NSMutableData
@end

CF_PRIVATE
@interface __NSCFData : NSMutableData {
    unsigned char _cfinfo[4];
    CFIndex _length;
    CFIndex _capacity;
    CFAllocatorRef *_bytesDeallocator;
    char *_bytes;
}
@end

@implementation __NSCFData

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
    return NO;
}

- (void)setLength:(NSUInteger)length
{
    CFDataSetLength((CFMutableDataRef)self, length);
}

- (void *)mutableBytes
{
    return CFDataGetMutableBytePtr((CFMutableDataRef)self);
}

- (const void *)bytes
{
    return CFDataGetBytePtr((CFDataRef)self);
}

- (NSUInteger)length
{
    return CFDataGetLength((CFDataRef)self);
}

- (id)copyWithZone:(NSZone *)zone
{
    return (id)CFDataCreateCopy(kCFAllocatorDefault, (CFDataRef)self);
}

- (NSUInteger)retainCount
{
    return CFGetRetainCount((CFTypeRef)self);
}

- (BOOL)_isDeallocating
{
    return _CFIsDeallocating((CFTypeRef)self);
}

- (BOOL)_tryRetain
{
    return _CFTryRetain((CFTypeRef)self) != NULL;
}

- (oneway void)release
{
    CFRelease((CFTypeRef)self);
}

- (id)retain
{
    return (id)CFRetain((CFTypeRef)self);
}

- (NSUInteger)hash
{
    return CFHash((CFTypeRef)self);
}

- (BOOL)isEqual:(id)object
{
    if (object == nil)
    {
        return NO;
    }
    return CFEqual((CFTypeRef)self, (CFTypeRef)object);
}

@end

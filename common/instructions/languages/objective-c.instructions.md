`
---
applyTo: "objective-c, objc, cocoa, ios, macos, **/*.m, **/*.h, **/*.mm"
---

# Objective-C Programming Language Instructions

## Overview
- **Domain**: Apple Platform Development Language for iOS, macOS, watchOS, and tvOS
- **Purpose**: Native app development for Apple ecosystems with C-based object-oriented programming
- **Applicable To**: iOS applications, macOS applications, legacy codebases, bridging Swift and C
- **Integration Level**: Apple platform frameworks, Core Foundation, and system-level programming

## Core Principles

### Fundamental Concepts
1. **Message Passing**: Dynamic method dispatch through runtime messaging system
2. **Reference Counting**: Manual and automatic memory management with ARC
3. **Dynamic Runtime**: Runtime introspection and method resolution
4. **Categories and Extensions**: Extending existing classes without inheritance
5. **Protocols**: Interface definitions for implementing common behavior
6. **Foundation Framework**: Core classes for strings, collections, and system services

### Key Benefits
- Direct access to Apple platform APIs and frameworks
- Mature runtime with extensive debugging and profiling tools
- Seamless C and C++ interoperability
- Dynamic features enabling runtime flexibility
- Strong integration with Xcode development environment
- Extensive existing codebase and libraries

### Common Misconceptions
- **Myth**: Objective-C is obsolete and completely replaced by Swift
  **Reality**: Objective-C remains important for legacy code, C interop, and specific use cases
- **Myth**: Objective-C syntax is unnecessarily verbose
  **Reality**: Verbosity provides clarity and self-documenting code

## Implementation Framework

### Getting Started
#### Prerequisites
- macOS with Xcode installed
- Understanding of C programming fundamentals
- Familiarity with object-oriented programming concepts
- Knowledge of Apple platform development patterns

#### Initial Setup
```objc
// Basic Objective-C project structure
// AppDelegate.h
#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

// AppDelegate.m
#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

@end

// Example class definition
// Person.h
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, assign) NSInteger age;

- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName age:(NSInteger)age;
- (NSString *)fullName;
- (void)celebrateBirthday;

@end

NS_ASSUME_NONNULL_END

// Person.m
#import "Person.h"

@implementation Person

- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName age:(NSInteger)age {
    self = [super init];
    if (self) {
        _firstName = firstName;
        _lastName = lastName;
        _age = age;
    }
    return self;
}

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (void)celebrateBirthday {
    self.age++;
    NSLog(@"Happy Birthday %@! You are now %ld years old.", [self fullName], (long)self.age);
}

@end
```

### Core Methodologies
#### Memory Management and ARC Integration
- **Purpose**: Implement robust memory management patterns with Automatic Reference Counting
- **When to Use**: All Objective-C development to prevent memory leaks and crashes
- **Implementation Steps**:
  1. Use strong/weak property attributes appropriately
  2. Implement proper delegate patterns with weak references
  3. Handle retain cycles with weak or unowned references
  4. Use autorelease pools for performance optimization
  5. Bridge Core Foundation objects properly
- **Success Metrics**: Zero memory leaks and stable memory usage patterns

#### Protocol-Oriented Design Strategy
- **Purpose**: Design flexible and maintainable code using protocols and categories
- **When to Use**: Creating reusable components and implementing design patterns
- **Implementation Steps**:
  1. Define clear protocol interfaces for common behaviors
  2. Implement delegation patterns for loose coupling
  3. Use categories to extend existing classes
  4. Create protocol compositions for complex interfaces
  5. Implement optional protocol methods appropriately
- **Success Metrics**: Modular codebase with clear separation of concerns

### Process Integration
#### iOS Application Architecture Framework
```objc
// Model-View-Controller Architecture Implementation

// 1. Model Layer - Data Management
// DataManager.h
#import <Foundation/Foundation.h>

@class User;

typedef void(^DataManagerCompletion)(BOOL success, NSError * _Nullable error);
typedef void(^UserFetchCompletion)(NSArray<User *> * _Nullable users, NSError * _Nullable error);

@interface DataManager : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

+ (instancetype)sharedManager;

- (void)saveContextWithCompletion:(DataManagerCompletion)completion;
- (void)fetchUsersWithCompletion:(UserFetchCompletion)completion;
- (void)createUserWithName:(NSString *)name email:(NSString *)email completion:(DataManagerCompletion)completion;

@end

// DataManager.m
#import "DataManager.h"
#import "User.h"
#import <CoreData/CoreData.h>

@interface DataManager ()
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation DataManager

+ (instancetype)sharedManager {
    static DataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupCoreDataStack];
    }
    return self;
}

- (void)setupCoreDataStack {
    // Core Data setup
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DataModel" withExtension:@"momd"];
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] 
                                       initWithManagedObjectModel:self.managedObjectModel];
    
    NSURL *storeURL = [[[NSFileManager defaultManager] applicationDocumentsDirectory] 
                       URLByAppendingPathComponent:@"DataModel.sqlite"];
    
    NSError *error = nil;
    if (![self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                       configuration:nil
                                                                 URL:storeURL
                                                             options:nil
                                                               error:&error]) {
        NSLog(@"Core Data error: %@", error.localizedDescription);
    }
    
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
}

- (void)saveContextWithCompletion:(DataManagerCompletion)completion {
    if ([self.managedObjectContext hasChanges]) {
        NSError *error = nil;
        BOOL success = [self.managedObjectContext save:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(success, error);
            }
        });
    } else {
        if (completion) {
            completion(YES, nil);
        }
    }
}

- (void)fetchUsersWithCompletion:(UserFetchCompletion)completion {
    NSFetchRequest *fetchRequest = [User fetchRequest];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    NSError *error = nil;
    NSArray *users = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (completion) {
            completion(users, error);
        }
    });
}

@end

// 2. Network Layer - API Communication
// APIClient.h
#import <Foundation/Foundation.h>

typedef void(^APIClientCompletion)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error);
typedef void(^APIClientJSONCompletion)(id _Nullable jsonObject, NSError * _Nullable error);

@interface APIClient : NSObject

@property (nonatomic, strong, readonly) NSURLSession *session;
@property (nonatomic, strong) NSString *baseURL;

+ (instancetype)sharedClient;

- (NSURLSessionDataTask *)GET:(NSString *)endpoint 
                   parameters:(NSDictionary * _Nullable)parameters 
                   completion:(APIClientCompletion)completion;

- (NSURLSessionDataTask *)POST:(NSString *)endpoint 
                    parameters:(NSDictionary * _Nullable)parameters 
                    completion:(APIClientCompletion)completion;

- (NSURLSessionDataTask *)requestJSONWithURL:(NSURL *)URL 
                                      method:(NSString *)method 
                                  parameters:(NSDictionary * _Nullable)parameters 
                                  completion:(APIClientJSONCompletion)completion;

@end

// APIClient.m
#import "APIClient.h"

@interface APIClient ()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation APIClient

+ (instancetype)sharedClient {
    static APIClient *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[APIClient alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = 30.0;
        configuration.timeoutIntervalForResource = 60.0;
        
        self.session = [NSURLSession sessionWithConfiguration:configuration];
        self.baseURL = @"https://api.example.com";
    }
    return self;
}

- (NSURLSessionDataTask *)GET:(NSString *)endpoint 
                   parameters:(NSDictionary *)parameters 
                   completion:(APIClientCompletion)completion {
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", self.baseURL, endpoint]];
    
    if (parameters.count > 0) {
        NSURLComponents *components = [NSURLComponents componentsWithURL:URL resolvingAgainstBaseURL:NO];
        NSMutableArray *queryItems = [NSMutableArray array];
        
        [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {
            NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:key value:value];
            [queryItems addObject:queryItem];
        }];
        
        components.queryItems = queryItems;
        URL = components.URL;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:completion];
    [task resume];
    
    return task;
}

- (NSURLSessionDataTask *)POST:(NSString *)endpoint 
                    parameters:(NSDictionary *)parameters 
                    completion:(APIClientCompletion)completion {
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", self.baseURL, endpoint]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (parameters) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters 
                                                           options:0 
                                                             error:&error];
        if (error) {
            if (completion) {
                completion(nil, nil, error);
            }
            return nil;
        }
        request.HTTPBody = jsonData;
    }
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:completion];
    [task resume];
    
    return task;
}

- (NSURLSessionDataTask *)requestJSONWithURL:(NSURL *)URL 
                                      method:(NSString *)method 
                                  parameters:(NSDictionary *)parameters 
                                  completion:(APIClientJSONCompletion)completion {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = method;
    
    return [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }
        
        if (!data) {
            NSError *noDataError = [NSError errorWithDomain:@"APIClientErrorDomain" 
                                                       code:1001 
                                                   userInfo:@{NSLocalizedDescriptionKey: @"No data received"}];
            if (completion) {
                completion(nil, noDataError);
            }
            return;
        }
        
        NSError *jsonError = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (completion) {
            completion(jsonObject, jsonError);
        }
    }];
}

@end

// 3. View Layer - Custom UI Components
// CustomButton.h
#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CustomButton : UIButton

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *highlightedBackgroundColor;

@end

// CustomButton.m
#import "CustomButton.h"

@interface CustomButton ()
@property (nonatomic, strong) UIColor *originalBackgroundColor;
@end

@implementation CustomButton

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupButton];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupButton];
    }
    return self;
}

- (void)setupButton {
    self.originalBackgroundColor = self.backgroundColor;
    [self updateAppearance];
}

- (void)updateAppearance {
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.borderWidth = self.borderWidth;
    self.clipsToBounds = YES;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted && self.highlightedBackgroundColor) {
        self.backgroundColor = self.highlightedBackgroundColor;
    } else {
        self.backgroundColor = self.originalBackgroundColor;
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self updateAppearance];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    [self updateAppearance];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    [self updateAppearance];
}

@end

// 4. Controller Layer - View Controller Management
// BaseViewController.h
#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIActivityIndicatorView *loadingIndicator;

- (void)showLoadingIndicator;
- (void)hideLoadingIndicator;
- (void)showErrorAlert:(NSError *)error;
- (void)showMessageAlert:(NSString *)message title:(NSString *)title;

@end

// BaseViewController.m
#import "BaseViewController.h"

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLoadingIndicator];
}

- (void)setupLoadingIndicator {
    self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.loadingIndicator.center = self.view.center;
    self.loadingIndicator.hidesWhenStopped = YES;
    [self.view addSubview:self.loadingIndicator];
}

- (void)showLoadingIndicator {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.loadingIndicator startAnimating];
    });
}

- (void)hideLoadingIndicator {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.loadingIndicator stopAnimating];
    });
}

- (void)showErrorAlert:(NSError *)error {
    NSString *message = error.localizedDescription ?: @"An unknown error occurred.";
    [self showMessageAlert:message title:@"Error"];
}

- (void)showMessageAlert:(NSString *)message title:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title 
                                                                       message:message 
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" 
                                                           style:UIAlertActionStyleDefault 
                                                         handler:nil];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    });
}

@end
```

### Advanced Objective-C Patterns
```objc
// Advanced Pattern Implementations

// 1. Category for NSString Validation
// NSString+Validation.h
#import <Foundation/Foundation.h>

@interface NSString (Validation)

- (BOOL)isValidEmail;
- (BOOL)isValidPhoneNumber;
- (BOOL)isValidURL;
- (NSString *)trimmedString;
- (BOOL)containsOnlyNumbers;

@end

// NSString+Validation.m
#import "NSString+Validation.h"

@implementation NSString (Validation)

- (BOOL)isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidPhoneNumber {
    NSString *phoneRegex = @"^\\d{3}-\\d{3}-\\d{4}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)isValidURL {
    NSURL *url = [NSURL URLWithString:self];
    return url != nil && url.scheme != nil && url.host != nil;
}

- (NSString *)trimmedString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)containsOnlyNumbers {
    NSCharacterSet *nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange range = [self rangeOfCharacterFromSet:nonNumbers];
    return range.location == NSNotFound;
}

@end

// 2. Protocol-based Observer Pattern
// Observable.h
#import <Foundation/Foundation.h>

@protocol Observer <NSObject>
- (void)notifyWithObject:(id)object;
@end

@protocol Observable <NSObject>
- (void)addObserver:(id<Observer>)observer;
- (void)removeObserver:(id<Observer>)observer;
- (void)notifyObservers:(id)object;
@end

// ObservableObject.h
#import <Foundation/Foundation.h>
#import "Observable.h"

@interface ObservableObject : NSObject <Observable>

@property (nonatomic, strong, readonly) NSMutableSet<id<Observer>> *observers;

@end

// ObservableObject.m
#import "ObservableObject.h"

@interface ObservableObject ()
@property (nonatomic, strong) NSMutableSet<id<Observer>> *observers;
@end

@implementation ObservableObject

- (instancetype)init {
    self = [super init];
    if (self) {
        _observers = [NSMutableSet set];
    }
    return self;
}

- (void)addObserver:(id<Observer>)observer {
    [self.observers addObject:observer];
}

- (void)removeObserver:(id<Observer>)observer {
    [self.observers removeObject:observer];
}

- (void)notifyObservers:(id)object {
    for (id<Observer> observer in self.observers) {
        [observer notifyWithObject:object];
    }
}

@end

// 3. Singleton with Thread Safety
// ConfigurationManager.h
#import <Foundation/Foundation.h>

@interface ConfigurationManager : NSObject

@property (nonatomic, strong, readonly) NSDictionary *configuration;

+ (instancetype)sharedManager;
- (void)loadConfigurationFromFile:(NSString *)filePath;
- (id)valueForKey:(NSString *)key;
- (void)setValue:(id)value forKey:(NSString *)key;

@end

// ConfigurationManager.m
#import "ConfigurationManager.h"

@interface ConfigurationManager ()
@property (nonatomic, strong) NSMutableDictionary *mutableConfiguration;
@property (nonatomic, strong) dispatch_queue_t configurationQueue;
@end

@implementation ConfigurationManager

+ (instancetype)sharedManager {
    static ConfigurationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ConfigurationManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _mutableConfiguration = [NSMutableDictionary dictionary];
        _configurationQueue = dispatch_queue_create("com.app.configuration", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (NSDictionary *)configuration {
    __block NSDictionary *config = nil;
    dispatch_sync(self.configurationQueue, ^{
        config = [self.mutableConfiguration copy];
    });
    return config;
}

- (void)loadConfigurationFromFile:(NSString *)filePath {
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data) {
        NSError *error = nil;
        NSDictionary *config = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        if (!error && config) {
            dispatch_barrier_async(self.configurationQueue, ^{
                [self.mutableConfiguration setDictionary:config];
            });
        }
    }
}

- (id)valueForKey:(NSString *)key {
    __block id value = nil;
    dispatch_sync(self.configurationQueue, ^{
        value = self.mutableConfiguration[key];
    });
    return value;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    dispatch_barrier_async(self.configurationQueue, ^{
        if (value) {
            self.mutableConfiguration[key] = value;
        } else {
            [self.mutableConfiguration removeObjectForKey:key];
        }
    });
}

@end

// 4. Block-based Callback Pattern
// AsyncOperationManager.h
#import <Foundation/Foundation.h>

typedef void(^CompletionBlock)(BOOL success, NSError * _Nullable error);
typedef void(^ProgressBlock)(float progress);
typedef void(^DataCompletionBlock)(NSData * _Nullable data, NSError * _Nullable error);

@interface AsyncOperationManager : NSObject

+ (instancetype)sharedManager;

- (void)performAsyncOperationWithProgress:(ProgressBlock)progressBlock 
                               completion:(CompletionBlock)completionBlock;

- (void)downloadDataFromURL:(NSURL *)URL 
                   progress:(ProgressBlock)progressBlock 
                 completion:(DataCompletionBlock)completionBlock;

- (void)performBatchOperations:(NSArray *)operations 
                    completion:(CompletionBlock)completionBlock;

@end

// AsyncOperationManager.m
#import "AsyncOperationManager.h"

@implementation AsyncOperationManager

+ (instancetype)sharedManager {
    static AsyncOperationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AsyncOperationManager alloc] init];
    });
    return sharedInstance;
}

- (void)performAsyncOperationWithProgress:(ProgressBlock)progressBlock 
                               completion:(CompletionBlock)completionBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Simulate long-running operation
        for (int i = 0; i <= 100; i += 10) {
            usleep(100000); // Sleep for 0.1 seconds
            
            if (progressBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    progressBlock(i / 100.0f);
                });
            }
        }
        
        // Complete operation
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock(YES, nil);
            }
        });
    });
}

- (void)downloadDataFromURL:(NSURL *)URL 
                   progress:(ProgressBlock)progressBlock 
                 completion:(DataCompletionBlock)completionBlock {
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:URL 
                                                        completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (error) {
            if (completionBlock) {
                completionBlock(nil, error);
            }
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock(data, nil);
            }
        });
    }];
    
    [downloadTask resume];
}

- (void)performBatchOperations:(NSArray *)operations 
                    completion:(CompletionBlock)completionBlock {
    
    dispatch_group_t group = dispatch_group_create();
    __block BOOL allSuccessful = YES;
    __block NSError *firstError = nil;
    
    for (void (^operation)(CompletionBlock) in operations) {
        dispatch_group_enter(group);
        
        operation(^(BOOL success, NSError *error) {
            if (!success) {
                allSuccessful = NO;
                if (!firstError) {
                    firstError = error;
                }
            }
            dispatch_group_leave(group);
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (completionBlock) {
            completionBlock(allSuccessful, firstError);
        }
    });
}

@end
```

## Best Practices

### Memory Management and Performance
```objc
// Memory management best practices

// 1. Proper use of weak references to avoid retain cycles
@interface ViewControllerWithDelegate : UIViewController

@property (nonatomic, weak) id<SomeDelegate> delegate; // Use weak for delegates

@end

// 2. Autorelease pool optimization
- (void)processLargeDataSet:(NSArray *)dataSet {
    for (id item in dataSet) {
        @autoreleasepool {
            // Process item - autorelease pool will clean up temporary objects
            [self processItem:item];
        }
    }
}

// 3. Lazy loading properties
@interface DataProcessor : NSObject
@property (nonatomic, strong) NSMutableArray *cachedResults;
@end

@implementation DataProcessor

- (NSMutableArray *)cachedResults {
    if (!_cachedResults) {
        _cachedResults = [[NSMutableArray alloc] init];
    }
    return _cachedResults;
}

@end

// 4. Efficient string operations
- (NSString *)processStringsEfficiently:(NSArray<NSString *> *)strings {
    // Use NSMutableString for multiple concatenations
    NSMutableString *result = [NSMutableString string];
    
    for (NSString *string in strings) {
        [result appendString:string];
        [result appendString:@" "];
    }
    
    return [result copy]; // Return immutable copy
}

// 5. Background queue processing
- (void)performHeavyComputationWithCompletion:(void(^)(id result))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Heavy computation on background queue
        id result = [self performComplexCalculation];
        
        // Return to main queue for UI updates
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(result);
        });
    });
}

// 6. Core Foundation bridging
- (void)workWithCoreFoundationTypes {
    // Bridge from Core Foundation to Objective-C
    CFStringRef cfString = CFStringCreateWithCString(NULL, "Hello", kCFStringEncodingUTF8);
    NSString *nsString = (__bridge NSString *)cfString;
    
    // Use the string
    NSLog(@"%@", nsString);
    
    // Clean up Core Foundation object
    CFRelease(cfString);
}

// 7. KVO implementation
@interface ObservableModel : NSObject
@property (nonatomic, strong) NSString *observedProperty;
@end

@implementation ObservableModel

+ (NSSet<NSString *> *)keyPathsForValuesAffectingComputedProperty {
    return [NSSet setWithObjects:@"observedProperty", nil];
}

- (NSString *)computedProperty {
    return [self.observedProperty uppercaseString];
}

@end

// KVO Observer
@interface Observer : NSObject
@end

@implementation Observer

- (void)observeValueForKeyPath:(NSString *)keyPath 
                      ofObject:(id)object 
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change 
                       context:(void *)context {
    
    if ([keyPath isEqualToString:@"observedProperty"]) {
        NSLog(@"Property changed: %@", change[NSKeyValueChangeNewKey]);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
```

### Error Handling and Debugging
```objc
// Comprehensive error handling patterns

// 1. Custom error domain and codes
extern NSString * const MyAppErrorDomain;

typedef NS_ENUM(NSInteger, MyAppErrorCode) {
    MyAppErrorCodeNetworkFailure = 1000,
    MyAppErrorCodeDataParsingFailure = 1001,
    MyAppErrorCodeInvalidInput = 1002,
    MyAppErrorCodeUserCancelled = 1003
};

@implementation SomeClass

NSString * const MyAppErrorDomain = @"com.myapp.ErrorDomain";

- (BOOL)performOperationWithError:(NSError **)error {
    // Check for invalid input
    if (![self validateInput]) {
        if (error) {
            *error = [NSError errorWithDomain:MyAppErrorDomain
                                         code:MyAppErrorCodeInvalidInput
                                     userInfo:@{
                                         NSLocalizedDescriptionKey: @"Invalid input provided",
                                         NSLocalizedRecoverySuggestionErrorKey: @"Please check your input and try again"
                                     }];
        }
        return NO;
    }
    
    // Perform operation
    BOOL success = [self executeOperation];
    
    if (!success && error) {
        *error = [NSError errorWithDomain:MyAppErrorDomain
                                     code:MyAppErrorCodeNetworkFailure
                                 userInfo:@{
                                     NSLocalizedDescriptionKey: @"Network operation failed",
                                     NSLocalizedRecoverySuggestionErrorKey: @"Check your internet connection and try again"
                                 }];
    }
    
    return success;
}

// 2. Assertion and logging
- (void)debugMethod:(NSString *)input {
    NSParameterAssert(input != nil);
    NSAssert([input length] > 0, @"Input string must not be empty");
    
    NSLog(@"Processing input: %@", input);
    
    #ifdef DEBUG
    NSLog(@"Debug: Method called from %s:%d", __FUNCTION__, __LINE__);
    #endif
}

// 3. Exception handling for external libraries
- (id)parseJSONSafely:(NSData *)data {
    @try {
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        if (error) {
            NSLog(@"JSON parsing error: %@", error.localizedDescription);
            return nil;
        }
        
        return result;
    }
    @catch (NSException *exception) {
        NSLog(@"JSON parsing exception: %@", exception.reason);
        return nil;
    }
}

@end
```

## Common Patterns and Examples

### Pattern 1: Model-View-Controller Architecture
**Scenario**: Implement clean MVC architecture for iOS applications
**Implementation**:
```objc
// Complete MVC implementation example

// Model
@interface UserModel : NSObject

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSDate *createdDate;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)toDictionary;
- (BOOL)isValid;

@end

@implementation UserModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _userID = dictionary[@"id"];
        _username = dictionary[@"username"];
        _email = dictionary[@"email"];
        
        NSString *dateString = dictionary[@"created_date"];
        if (dateString) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
            _createdDate = [formatter dateFromString:dateString];
        }
    }
    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (self.userID) dict[@"id"] = self.userID;
    if (self.username) dict[@"username"] = self.username;
    if (self.email) dict[@"email"] = self.email;
    
    if (self.createdDate) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
        dict[@"created_date"] = [formatter stringFromDate:self.createdDate];
    }
    
    return [dict copy];
}

- (BOOL)isValid {
    return self.userID.length > 0 && 
           self.username.length > 0 && 
           [self.email isValidEmail];
}

@end

// View
@interface UserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

- (void)configureWithUser:(UserModel *)user;

@end

@implementation UserTableViewCell

- (void)configureWithUser:(UserModel *)user {
    self.usernameLabel.text = user.username;
    self.emailLabel.text = user.email;
    
    // Load avatar image asynchronously
    [self loadAvatarForUser:user];
}

- (void)loadAvatarForUser:(UserModel *)user {
    // Placeholder image
    self.avatarImageView.image = [UIImage imageNamed:@"placeholder_avatar"];
    
    // Load actual avatar in background
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *avatarURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.example.com/avatars/%@", user.userID]];
        NSData *imageData = [NSData dataWithContentsOfURL:avatarURL];
        
        if (imageData) {
            UIImage *avatarImage = [UIImage imageWithData:imageData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.avatarImageView.image = avatarImage;
            });
        }
    });
}

@end

// Controller
@interface UserListViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray<UserModel *> *users;
@property (nonatomic, strong) UIRefreshControl *refreshController;

- (void)loadUsers;
- (void)refreshUsers;

@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Users";
    self.users = [NSMutableArray array];
    
    [self setupRefreshControl];
    [self loadUsers];
}

- (void)setupRefreshControl {
    self.refreshController = [[UIRefreshControl alloc] init];
    [self.refreshController addTarget:self 
                               action:@selector(refreshUsers) 
                     forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = self.refreshController;
}

- (void)loadUsers {
    [self showLoadingIndicator];
    
    [[APIClient sharedClient] GET:@"/users" parameters:nil completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self hideLoadingIndicator];
        
        if (error) {
            [self showErrorAlert:error];
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            [self showErrorAlert:jsonError];
            return;
        }
        
        NSArray *userDictionaries = jsonResponse[@"users"];
        NSMutableArray *newUsers = [NSMutableArray array];
        
        for (NSDictionary *userDict in userDictionaries) {
            UserModel *user = [[UserModel alloc] initWithDictionary:userDict];
            if ([user isValid]) {
                [newUsers addObject:user];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.users = newUsers;
            [self.tableView reloadData];
        });
    }];
}

- (void)refreshUsers {
    [self loadUsers];
    [self.refreshController endRefreshing];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    
    UserModel *user = self.users[indexPath.row];
    [cell configureWithUser:user];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UserModel *selectedUser = self.users[indexPath.row];
    
    // Navigate to user detail
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserDetailViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"UserDetailViewController"];
    detailVC.user = selectedUser;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
```
**Expected Outcomes**: Clean separation of concerns with maintainable and testable code

### Pattern 2: Core Data Integration
**Scenario**: Implement comprehensive Core Data stack with modern practices
**Implementation**:
```objc
// Core Data implementation with NSPersistentContainer

// CoreDataManager.h
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (readonly, strong) NSManagedObjectContext *viewContext;

+ (instancetype)sharedManager;

- (void)saveContext;
- (void)saveContextWithCompletion:(void(^)(BOOL success, NSError *error))completion;

- (NSManagedObjectContext *)createBackgroundContext;
- (void)performBackgroundTask:(void(^)(NSManagedObjectContext *context))block;

@end

// CoreDataManager.m
#import "CoreDataManager.h"

@implementation CoreDataManager

+ (instancetype)sharedManager {
    static CoreDataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CoreDataManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupPersistentContainer];
    }
    return self;
}

- (void)setupPersistentContainer {
    _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"DataModel"];
    
    [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
        if (error != nil) {
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        } else {
            NSLog(@"Core Data stack initialized successfully");
        }
    }];
    
    // Configure automatic merging
    _persistentContainer.viewContext.automaticallyMergesChangesFromParent = YES;
}

- (NSManagedObjectContext *)viewContext {
    return self.persistentContainer.viewContext;
}

- (void)saveContext {
    [self saveContextWithCompletion:nil];
}

- (void)saveContextWithCompletion:(void(^)(BOOL success, NSError *error))completion {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    
    if ([context hasChanges]) {
        NSError *error = nil;
        BOOL success = [context save:&error];
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(success, error);
            });
        }
        
        if (!success) {
            NSLog(@"Failed to save context: %@", error.localizedDescription);
        }
    } else {
        if (completion) {
            completion(YES, nil);
        }
    }
}

- (NSManagedObjectContext *)createBackgroundContext {
    return [self.persistentContainer newBackgroundContext];
}

- (void)performBackgroundTask:(void(^)(NSManagedObjectContext *context))block {
    [self.persistentContainer performBackgroundTask:block];
}

@end

// User+CoreDataClass.h (Generated by Core Data)
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface User : NSManagedObject

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *userID;
@property (nullable, nonatomic, copy) NSString *username;
@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSDate *createdDate;

// Custom methods
+ (User *)createUserWithUserID:(NSString *)userID 
                      username:(NSString *)username 
                         email:(NSString *)email 
                     inContext:(NSManagedObjectContext *)context;

+ (NSArray<User *> *)fetchUsersWithPredicate:(NSPredicate *)predicate 
                                   inContext:(NSManagedObjectContext *)context;

- (BOOL)isValid;

@end

// User+CoreDataClass.m
#import "User+CoreDataClass.h"

@implementation User

+ (User *)createUserWithUserID:(NSString *)userID 
                      username:(NSString *)username 
                         email:(NSString *)email 
                     inContext:(NSManagedObjectContext *)context {
    
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" 
                                               inManagedObjectContext:context];
    user.userID = userID;
    user.username = username;
    user.email = email;
    user.createdDate = [NSDate date];
    
    return user;
}

+ (NSArray<User *> *)fetchUsersWithPredicate:(NSPredicate *)predicate 
                                   inContext:(NSManagedObjectContext *)context {
    
    NSFetchRequest<User *> *request = [User fetchRequest];
    request.predicate = predicate;
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"username" ascending:YES];
    request.sortDescriptors = @[sortDescriptor];
    
    NSError *error = nil;
    NSArray<User *> *users = [context executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"Fetch error: %@", error.localizedDescription);
        return @[];
    }
    
    return users ?: @[];
}

- (BOOL)isValid {
    return self.userID.length > 0 && 
           self.username.length > 0 && 
           self.email.length > 0;
}

@end
```
**Expected Outcomes**: Robust Core Data implementation with proper threading and error handling

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Strong Reference Cycles
- **Description**: Creating retain cycles between objects, especially with delegates and blocks
- **Why It's Problematic**: Causes memory leaks and prevents proper deallocation
- **Better Approach**: Use weak references for delegates and capture weak self in blocks

#### Anti-Pattern 2: Main Thread Blocking
- **Description**: Performing heavy operations on the main thread
- **Why It's Problematic**: Causes UI freezing and poor user experience
- **Better Approach**: Use background queues for heavy operations and return to main queue for UI updates

## Tools and Resources

### Development Tools and Frameworks
```objc
// Essential Objective-C development tools and frameworks

// 1. Foundation Framework - Core classes
#import <Foundation/Foundation.h>
// NSString, NSArray, NSDictionary, NSDate, etc.

// 2. UIKit Framework - iOS UI components
#import <UIKit/UIKit.h>
// UIViewController, UIView, UIButton, UITableView, etc.

// 3. Core Data - Object-relational mapping
#import <CoreData/CoreData.h>
// NSManagedObject, NSManagedObjectContext, NSFetchRequest, etc.

// 4. Network programming
#import <CFNetwork/CFNetwork.h>
// Low-level networking

// 5. Grand Central Dispatch - Concurrency
#import <dispatch/dispatch.h>
// dispatch_async, dispatch_sync, dispatch_queue_t, etc.

// 6. Core Foundation - C-based framework
#import <CoreFoundation/CoreFoundation.h>
// CFString, CFArray, CFDictionary, etc.

// 7. Core Animation - Animation framework
#import <QuartzCore/QuartzCore.h>
// CALayer, CAAnimation, etc.

// 8. Core Graphics - 2D graphics
#import <CoreGraphics/CoreGraphics.h>
// CGRect, CGPoint, CGPath, etc.
```

### Testing and Debugging Tools
```objc
// Unit testing with XCTest
#import <XCTest/XCTest.h>

@interface MyClassTests : XCTestCase
@property (nonatomic, strong) MyClass *testObject;
@end

@implementation MyClassTests

- (void)setUp {
    [super setUp];
    self.testObject = [[MyClass alloc] init];
}

- (void)tearDown {
    self.testObject = nil;
    [super tearDown];
}

- (void)testBasicFunctionality {
    // Arrange
    NSString *input = @"test input";
    NSString *expectedOutput = @"TEST INPUT";
    
    // Act
    NSString *actualOutput = [self.testObject processString:input];
    
    // Assert
    XCTAssertEqualObjects(actualOutput, expectedOutput, @"String processing should uppercase input");
}

- (void)testAsyncOperation {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Async operation completion"];
    
    [self.testObject performAsyncOperationWithCompletion:^(BOOL success, NSError *error) {
        XCTAssertTrue(success, @"Async operation should succeed");
        XCTAssertNil(error, @"Error should be nil on success");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end

// Performance testing
- (void)testPerformanceExample {
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        [self.testObject performExpensiveOperation];
    }];
}
```

### Development Environment Configuration
```objc
// Build settings and compiler directives

// Debug vs Release configurations
#ifdef DEBUG
    #define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
    #define DLog(...)
#endif

// Conditional compilation
#if TARGET_OS_IPHONE
    // iOS specific code
#elif TARGET_OS_MAC
    // macOS specific code
#endif

// Feature flags
#ifndef FEATURE_ADVANCED_ANALYTICS
    #define FEATURE_ADVANCED_ANALYTICS 0
#endif

#if FEATURE_ADVANCED_ANALYTICS
    // Advanced analytics code
#endif

// Static analyzer annotations
@interface MyClass : NSObject

- (NSString *)createString NS_RETURNS_RETAINED;
- (void)processString:(NSString *)string NS_REQUIRES_NIL_TERMINATION;

@end
```

### Learning Resources
- **Apple Developer Documentation**: https://developer.apple.com/documentation/
- **Objective-C Programming Guide**: https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/
- **iOS Human Interface Guidelines**: https://developer.apple.com/design/human-interface-guidelines/
- **WWDC Videos**: https://developer.apple.com/videos/
- **Ray Wenderlich Tutorials**: https://www.raywenderlich.com/
- **NSHipster**: https://nshipster.com/

## Quality and Compliance

### Quality Standards
- Follow Apple's coding conventions and style guidelines
- Use meaningful variable and method names with clear intent
- Implement comprehensive error handling and input validation
- Write unit tests for all business logic and critical functionality
- Use static analysis tools and address all warnings

### Security Standards
- Validate all user inputs and external data
- Use Keychain services for sensitive data storage
- Implement proper authentication and authorization
- Follow OWASP mobile security guidelines
- Regular security audits and vulnerability assessments

### Performance Standards
- Optimize memory usage and prevent retain cycles
- Use background queues for heavy operations
- Implement efficient algorithms and data structures
- Monitor and profile application performance
- Follow Apple's performance best practices

## AI Assistant Guidelines

When helping with Objective-C programming:

1. **Apple Platform Focus**: Prioritize Apple platform conventions and best practices
2. **Memory Management**: Emphasize proper ARC usage and retain cycle prevention
3. **Framework Integration**: Leverage Apple frameworks and avoid reinventing functionality
4. **Performance Optimization**: Consider performance implications of design decisions
5. **Legacy Support**: Support maintenance of existing Objective-C codebases
6. **Swift Interoperability**: Enable smooth interoperation with Swift code
7. **Testing Strategy**: Implement comprehensive testing for reliability
8. **Security Awareness**: Follow Apple's security guidelines and best practices

### Decision Making Framework
When helping teams with Objective-C:

1. **Platform Assessment**: Determine if Objective-C is the right choice vs Swift
2. **Architecture Planning**: Design appropriate patterns for the use case
3. **Performance Evaluation**: Assess performance requirements and constraints
4. **Legacy Integration**: Plan for existing codebase integration and migration
5. **Maintenance Strategy**: Consider long-term maintenance and team capabilities

### Code Generation Rules
- Generate Objective-C code following Apple's coding conventions
- Include proper memory management with ARC best practices
- Use Apple frameworks and APIs appropriately
- Implement comprehensive error handling and validation
- Generate thread-safe code with proper queue management
- Include unit tests for generated business logic
- Provide clear documentation and comments
- Support interoperability with Swift when applicable

### Quality Enforcement
- ✅ Enforce Apple coding conventions and style guidelines
- ✅ Require proper memory management and retain cycle prevention
- ✅ Block generation of code that violates Apple platform guidelines
- ✅ Require error handling for all potentially failing operations
- ✅ Enforce thread safety for concurrent operations
- ✅ Promote use of Apple frameworks over custom implementations
- ✅ Require unit tests for business logic and critical functionality
- ✅ Enforce security best practices for data handling and storage
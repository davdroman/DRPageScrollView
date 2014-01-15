DRPaginatedScrollView
=====================

Implement a paginated scroll view really easily using blocks.

<p align="center">
	<img src="https://raw.github.com/Dromaguirre/DRPaginatedScrollView/images/1.gif" alt="DRPaginatedScrollView GIF" title="DRPaginatedScrollView GIF" width="320px" />
</p>

<p align="center">
	<img src="https://raw.github.com/Dromaguirre/DRPaginatedScrollView/images/2.gif" alt="DRPaginatedScrollView GIF" title="DRPaginatedScrollView GIF" width="568px" />
</p>

## Features

- **Block-driven** pages setup.
- **Jump** between pages (with **bouncy effect**).
- Automatic **jump** to the next page **by tapping**.
- **Autolayout**-compatible.
- **Portrait** and **landscape** orientations support.

## CocoaPods

You can install DRPaginatedScrollView through CocoaPods adding the following to your Podfile:

	pod 'DRPaginatedScrollView'

## How to use

### Getting page-related information

```objective-c
- (NSInteger)currentPage
```

- Returns: index of the current page displaying (indexes start from 0).

```objective-c
- (NSInteger)nextPage
```

- Returns: index of the next page (indexes start from 0).

```objective-c
- (NSInteger)lastPage
```

- Returns: index of the last page (indexes start from 0).

```objective-c
- (NSInteger)numberOfPages
```

- Returns: the current number of pages of the paginated scroll view.

### Setting up pages

```objective-c
- (void)addPageWithHandler:(void (^)(UIView * pageView))handler
```

- `handler` is a block passing the view that will contain the subviews for the new page, so in that block you just need to add all the views to be displayed on that page to the `pageView`. It'll just work.

Applying autolayout on the subviews is not obligatory, but recommended.

Anyway, if you decide to use autolayout I suggest using a framework called [**Masonry**](https://github.com/cloudkite/Masonry). Pretty great stuff.

Here's an example without using autolayout, to simplify things. If you want to see an example of this implementation using autolayout, check out the demo app:

```objective-c
[paginatedScrollView addPageWithHandler:^(UIView * pageView) {
    UIView * square = [UIView new];
    [square setBackgroundColor:[UIColor redColor]];
    [square setFrame:CGRectMake(0, 0, 100, 100)];
    
    [pageView addSubview:square];
}];
```
### Jumping between pages

```objective-c
- (void)jumpToPage:(NSInteger)page bounce:(CGFloat)bounce completion:(void (^)(void))completion
```

- `page` specifies the index of the page to jump.
- `bounce` specifies the amount of bouncy effect the jump will be performed with. Recommended values are `0`-`40`, being 0 the total absence of bounce.
- `completion` is a block that will be executed after the jump is performed.

Here are some examples:

```objective-c
// Jumping to the 4th page with no bounce effect and completion

[paginatedScrollView jumpToPage:3 bounce:0 completion:^{
	NSLog(@"Jump finished!");
}];

// Jumping to the first page with a normal bounce effect and no completion

[paginatedScrollView jumpToPage:0 bounce:20 completion:nil];

// Jumping to the next page with a little bounce effect and no completion

[paginatedScrollView jumpToPage:[paginatedScrollView nextPage] bounce:10 completion:nil];

// Jumping to the last page with a high bounce effect and no completion

[paginatedScrollView jumpToPage:[paginatedScrollView lastPage] bounce:40 completion:nil];
```

### Controlling details of jumps between pages

```objective-c
BOOL isJumping
```

- Description: whether the paginated scroll view is currently jumping between pages or not.

```objective-c
NSTimeInterval jumpDurationPerPage
```

- Description: the duration each page will last jumping with when jumping through multiple pages.
- Default value: `0.1`
- Recommended value: `0.05`-`0.175`

### Handling taps on the view

```objective-c
void (^actionWhenTappedBlock)(DRPaginatedScrollView *)
```

- Description: action that executes when the paginated scroll view is tapped.
- Default value:

	```objective-c
	^(DRPaginatedScrollView * paginatedScrollView) {
		[paginatedScrollView jumpToPage:[paginatedScrollView nextPage] bounce:0 completion:nil];
	}
	```		
- Recommended value: any.

## Wish list

- **~~CocoaPods support.~~**
- Being able to add gaps between pages.
- Automatic block-customizable page indicator (`paginatedScrollView configurePageIndicatorWithHandler:`).
- Being able to clip any subview until a determined page (`pageView clipSubview:untilPage:`) and forever (`pageView clipSubviewForever:`).

## Requirements

- iOS 6 or higher.
- Automatic Reference Counting (ARC).

## License

DRPaginatedScrollView is available under the MIT license.

Also, I'd really love to know you're using it in any of your projects, so send me an [**email**](mailto:dromaguirre@gmail.com) or a [**tweet**](http://twitter.com/Dromaguirre) and make my day :)

DRPaginatedScrollView
=====================

Implement a paginated scroll view really easily using blocks.

## Features

- **Block-driven** pages setup.
- **Jump** between pages (with **bouncy effect**).
- Automatic **jump** to the next page **by tapping**.
- **Autolayout**-ready.

## How to use

### Getting page-related information

`- (NSInteger)currentPage`

- Description: index of the current page displaying (indexes start from 0).
- Default value: `0`

`- (NSInteger)nextPage`

- Description: index of the next page (indexes start from 0).

`- (NSInteger)lastPage`

- Description: index of the last page (indexes start from 0).

`- (NSInteger)numberOfPages`

- Description: the current number of pages of the paginated scroll view.

### Setting up pages

Pages are added through blocks, with the following method:

`- (void)addPageWithHandler:(void (^)(UIView * pageView))handler`

- `handler` is a block passing the view that will contain the subviews for the new page, so in that block you just need to add all the views to be displayed on that page to the `pageView`. It'll just work.

Applying autolayout on the subviews is not obligatory, but recommended.

Anyway, if you decide to use autolayout I suggest using a framework called [**Masonry**](https://github.com/cloudkite/Masonry). Pretty great stuff.

Here's an example without using autolayout, to simplify things. If you want to see an example of this implementation using autolayout, check out the demo app:

	[paginatedScrollView addPageWithHandler:^(UIView * pageView) {
        UIView * square = [UIView new];
        [square setBackgroundColor:[UIColor redColor]];
        [square setFrame:CGRectMake(0, 0, 100, 100)];
        
        [pageView addSubview:square];
    }];

### Jumping between pages

You can jump to the page you want with this method:

`- (void)jumpToPage:(NSInteger)page bounce:(CGFloat)bounce completion:(void (^)(void))completion`

- `page` specifies the index of the page to jump.
- `bounce` specifies the amount of bouncy effect the jump will be performed with. Recommended values are `0`-`40`, being 0 the total absence of bounce.
- `completion` is a block that will be executed after the jump is performed.

Here are some examples:
	
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

### Controlling details of jumps between pages

`BOOL isJumping`

- Description: whether the paginated scroll view is currently jumping between pages or not.

`NSTimeInterval jumpDurationPerPage`

- Description: the duration each page will last jumping with when jumping through multiple pages.
- Default value: `0.1`
- Recommended value: `0.05`-`0.4`

### Handling taps on the view

`void (^actionWhenTappedBlock)(DRPaginatedScrollView *)`

- Description: action that executes when the paginated scroll view is tapped.
- Default value:

		^(DRPaginatedScrollView * paginatedScrollView) {
			[paginatedScrollView jumpToPage:[paginatedScrollView nextPage] bounce:0 completion:nil];
		}
		
- Recommended value: any.

## Wish list

- Automatic block-customizable page indicator.

## Requirements

- iOS 6 or higher.
- Automatic Reference Counting (ARC).

## License

You can use it for whatever you want, however you want. I just **[would love to know](mailto:dromaguirre@gmail.com)** if you're using it in any project of yours.
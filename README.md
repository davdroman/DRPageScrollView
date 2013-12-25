DRPaginatedScrollView
=====================

Implement a paginated scroll view really easily using blocks.

## Features

- Block-driven pages setup.
- Jump between pages (with bouncy effect).
- Autolayout-ready.

## How to use

### Properties you can get & set

`NSTimeInterval jumpDurationPerPage`

- Description: the duration each page will last jumping with when jumping through multiple pages.
- Default value: `0.1`
- Recommended value: `0.05`-`0.4`

`void (^actionWhenTappedBlock)(DRPaginatedScrollView *)`

- Description: action that executes when the paginated scroll view is tapped.
- Default value:

		^(DRPaginatedScrollView * paginatedScrollView) {
			[paginatedScrollView jumpToPage:[paginatedScrollView currentPage]+1 bounce:0 completion:nil];
		}
		
- Recommended value: any.

### Properties you can get

`BOOL isJumping`

- Description: whether the paginated scroll view is currently jumping between pages or not.

### Methods returning values

`- (NSInteger)currentPage`

- Description: index of the current page displaying (indexes start from 0).
- Default value: `0`

`- (NSInteger)lastPage`

- Description: index of the last page (indexes start from 0).

`- (NSInteger)numberOfPages`

- Description: the current number of pages of the paginated scroll view.

### Setting up pages

In process...

## Wish list

- Automatic block-customizable page indicator.

## Requirements

- iOS 6 or higher.
- Automatic Reference Counting (ARC).

## License

You can use it for whatever you want, however you want. I just **[would love to know](mailto:dromaguirre@gmail.com)** if you're using it in any project of yours.
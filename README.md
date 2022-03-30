Application Overview
------

iOS application that will display latest World News and click on table cell, article details view will display. User can view also webview mode by clicking on "Open Web Link" option.

MVVM Overview
------

MVVM (Model View ViewModel) is an architectural pattern based on MVC and MVP, which attempts to more clearly separate the development of user-interfaces (UI) from that of the business logic and behaviour in an application. 

Requirements
-----

Swift 5.0 and  Xcode 13.1

    
Project Details
-----
* `APIService.swift` - Calling web API.
* `NewsResponse.swift,Article.swift,ImageInformation.swift` - Data model with the information to show in the table.
* `HomeViewModel.swift` - Manage and format the data to be displayed in the views.
* `NewsCell.swift` - The cell that contain the new view.
* `DetailsViewController.swift` - The view contain the details news.
* `WebLinkViewController.swift` - Load webview using specific news url.
* `Constants.swift, AsyncImageLoader.swift` - Utility classes for the project.



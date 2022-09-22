Unfortunately, this is not the entire code for the Walkee app. I lost most of the work that I did last minute for the ACM Hackathon Spring 2022 at UNR. But here's a brief on the app and what the demo did.

Walkee is an ios app built using Swift in Xcode. It is a productivity app that calculated daily steps and returns a virtual reward.
The steps are calculated using the Healthkit which can be seen in the Home View. The user is initially asked for permission to use data from the Healthkit to access the daily step count.

There is an Onboarding view that welcomes the user to the app and gives details about it.

When a particular number of steps are counted the user is rewarded with virtual trees which they can add to their virtual forest.
The virtual forest is implemented using the SceneKit feature. The trees are added to the user's inventory when they earn them. The trees can be dragged and dropped into the different cells in the forest.

This forest can be shared with your friends using iCloud it.
Statistics about daily and weekly steps are also calculated and displayed in the Statistics View.

Inspired by Sweatcoin and Forest apps.

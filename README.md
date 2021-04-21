# BUDGET BUDDY 

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)

## Overview
### Description
This application will help users budget depending on their individual hobbies and interests when they first create an account. Additionally, users will be able to identify their transactions over a certain period of time. The app will have a bot that users can interact with, which helps to navigate around the app.
### App Evaluation
- **Category:** Finance & ifestyle
- **Mobile:** Application is Interactive being able to be used on any iOS device
- **Story:** Allows users to view their daily/weekly/monthly expenses while breaking down their most costly expense
- **Market:** Anyone that has a need or curiousity to monitor their finances. 
- **Habit:** Users are using this app throughout the day or week to monitor their finances and weekly or monthly expenses
- **Scope:** V1 would allow users to see a feed or their daily/weekly/monthly spending and input new expense logs. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [X] User sees an app icon on the home screen and a styled launch screen.
- [X] User can create a new account
- [X] User can login
- [] User can input new expenses


**Optional Nice-to-have Stories**

- [] User can view the app on various device sizes and orientations.
- [] User can run Budget Buddy on a real device.
- [] User can have morning reports of their spendings yesterday.

### 2. Screen Archetypes

* Login Page
    * Login Button
    * Email
    * Password
* Sign Up
    * Sign Up Button
    * Email 
    * Password
* Analytics/ChatBot/Settings
    * Analytics/Feed
        * Summary of Spending Month by Month and Categories
    * Chat Bot
        * Simple Commands with Fixed Questions and Answers
    * Settings
        * Light or Dark Mode

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Analytics/Feed
* Chat Bot
* Settings

**Flow Navigation** (Screen to Screen)
* Login Screen
 => Home
* Registration Screen
 => Home




## Wireframes

<img src="https://i.imgur.com/ExyuTkF.jpg" width=600>



## Schema

**Models**

User
| Property | Type        | Description                                 |
| -------- | ----------- | ------------------------------------------- |
| objectID | String      | Unique ID for the User for the database     |
| username | String      | Nickname for the User                       |
| password | String      | Password used for authentication            |
| bank     | JSON Object | Bank connected to access data               |
| image    | File        | Profile Picture

Posts

| Property     | Type        | Description                                |
| -----------  | ----------- | ------------------------------------------ |
| purchaseDate | DateTime    | Date of items purchased                    |
| amountSpent | Number      | Amount Spent                               |
| amountSaved | Number      | Amount Saved                               |
| description  | String      | Description of the item that was bought    |


### 4. Parse Network Requests

**Analytics Screen** 
* (Read/GET) Query logged from Bank JSON Object
```
let query = PFQuery(className:"accounts")

query.whereKey("account_id", equalTo: currentUser)
query.findObjectsInBackground { (metadata: [PFObject]?, error: Error?) in
   if let error = error { 
      print(error.localizedDescription)
   } else onSuccess  {
       fetch('//yourserver.com/get_access_token', {
      method: 'POST',
      body: {
        public_token: public_token,
        accounts: metadata.accounts,
        institution: metadata.institution,
        link_session_id: metadata.link_session_id,
      },
    });
   }
}
```

**Feed Screen**
* (Read/GET) Create new transaction post
```
let query = PFQuery(className:"Post")
query.whereKey("author", equalTo: currentUser)
query.order(byDescending: "createdAt")
query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
   if let error = error { 
      print(error.localizedDescription)
   } else if let posts = posts {
      print("Successfully retrieved \(posts.count) posts.")
   }
}
```
* (Delete) Delete existing Transaction
* (Create/POST) Create a new post object

**Login Screen** 
* (Create/POST) Create a new session for the user after login

**Settings Screen** 
* (Read/GET) Query logged in user object 
* (Update/PUT) Update user profile image
* (Update/PUT) Update UI light and dark mode

## [OPTIONAL:] Existing API Endpoints

Plaid
* Base Url - https://plaid.com/docs/api/

| HTTP Verb | Endpoint  | Description |
| --------- | --------  | ----------- |
| GET       | /auth/get | Retrieve and verify bank account information |
| GET       | /transactions/get | Retreive 24 hours worht of transactions data |
| GET       | /accounts/get | Retreive Account Information |
| GET       | /item/get | Get user Data
| GET       | /institutions/get | Retrieve Supported Data by Institution |


Back4App
* Base Url - https://dashboard.back4app.com/apidocs


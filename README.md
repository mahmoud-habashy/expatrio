# coding_challenge
This is the expatrio home assignment for the mobile post.

## credentials for access 
- email : tito+bs792@expatrio.com
- password : nemampojma

## Getting Started
To check this app, first you have to clone it in your local machine.

### Prerequisites
> - flutter pub get => To get all the dependencies.
> - dart doc . => To generate the app documentations.
> - run the app.

## Folder structure

- Presentation:
This folder contains all the ui widgets.

- Data:
This folder has any external network communication http requests and the responses and its **models** also the it contains the secure storage keys.

- Repositories:
This folder contains the modeling layer between the **BusinessLogic** and the **Data**

- Logic:
This folder contains the business logic and the methods for getting the data.

- Shared:
This folder has all the shared data **Strings** , **Colors** , **Theme** , **Constants** to make a guideline for the app to prevent any hard coded values.

- Util:
This folder contains the app router and the validators.

## Screens
**- Splash**: When the user opens the app this is the initial page. We have three scenarios:

- First: User opens the app for first time or the user already opened the app and click on logout button.
 the app will not find any token data stored in the device, then the app will redirect the user to **Dashboard**
 the email and password fields both will be empty.

- Second: User opens the app and the app will get the token data from the device if the token is valid (check if DateTime.now() is before the token expire date) then the app will redirect the user to **Dashboard**

- Third: User opens the app and the app will get the token data from the device if the token is invalid
(check if DateTime.now() is after the token expire date) then the app will redirect the user to **Login**. the email filed only will be filled with the user email.

**- Login**:
Authentication with expatrio here we have three scenarios:
- Success: When user enter a valid credentials then the app will redirect user to **Dashboard** and save the token data in the device.

- Wrong credentials: App will show up a bottom modal sheet to ask user to check the credentials.

- Error: this would happen if no internet connection or any server error, app will show 
up a bottom modal sheet with error message.

Help button: this button when user clicks on it, the app open the expatrio website "https://help.expatrio.com/hc/en-us".
- Note: For **Testing** only i set the email controller value to tito+bs792@expatrio.com and the password controller to nemampojma

**- Dashboard**:
when user lands on this page, app will search for user's data which stored in the device.
Here we have two scenarios:
- First: User opens the app for first time then app will not find any data stored in the device then it sends a request to expatrio server to get the user data by user id.

- Second: App found user's data stored in the device then no need for sending a request to expatrio server.
This page has "Update Tax Data" button When the user clicks on it, a bottom sheet open prompting the user to input their tax data.


**- Tax Data**:
When user opens this widget, app will search for user's tax data stored in the device.
Here we have two scenarios:
- First: User opens the app for first time then app will not find any tax data stored in the device then it sends a request to expatrio server to get the tax data by user id.

- Second: App found tax data stored in the device. app will open the bottom sheet with the stored data and no need for sending a request to expatrio server.

user can edit his tax data, remove any additional **Tax entry** by clicking on the remove button,
or add new **Tax entry** by clicking ADD ANOTHER button.

- Tax entry: contains two fields first one is the country and second one is the tax number and both of them are required.
To save tax data user must check the checkbox verifying the accuracy of tax information.
after that when user clicks on save button, the app will send request to Expatrio server with new data and waits for response if success the app will show a success bottom modal with animation and store this new data in the device. if any error ocurred the app will show error state ask the user to try again.

- Country entry: The user can not choose a previously selected country.

**- Logout**
User can logout from the app by clicking on the red button in the **Dashboard** app bar.
after that the app will clear the data and push the user to **Login**.

## Implementation
To implement those features i used those packages:
- flutter_bloc, equatable: to manage the business login and manage the state.
- http: to communicant with expatrio server.
- flutter_secure_storage: to store data in the device.
- dropdown_search: for **Country entry** in the **Tax Data**.
- url_launcher: to open the expatrio website.
- lottie: for animation.
- flutter_svg: for svg assets.
- flutter_launcher_icons: for app launch icon.

## Improvements
- Use any other state management.
- Use dio package instance of http to create interceptor and manage error handling.
- Use connectivity_plus allows to discover network connectivity.
- write unit test , widget test and integration test.

Apk link -> [click ](https://drive.google.com/file/d/1WtTeuJH8OhJbOTtlfmReceea17bZV7c-/view?usp=sharing)

mr.habashy88@gmail.com
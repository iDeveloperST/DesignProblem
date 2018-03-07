# DesignProblem
Online Task

Expectation: Design is extensible and Thread safe.
1. An IOS application has two modules, User Interface and backend (for business logic). UI has a screen where user inputs an URL to download a file and clicks on the button to start. That URL should be passed on to backend module which initiates the file download and assume that this download takes around 4-5 minutes. During this time backend module should be updating UI about the progress for every minute. UI should be accessible to the user for interactions with any other controls like buttons or text fields.

2. An IOS application showing weather of a specific city in a custom Tableview. User can enter a city and accordingly the weather will be shown for that city. Use this https://openweathermap.org/api for retrieving the data. It is not required to show all the parameters in the UI just the basic data can be shown using the current weather api. Emphasis will be given on the design and how it can be scaled further if required.

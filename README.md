# Marvel App
This is a simple app that uses the Marvel API to display a list of characters and their comics, we ca, see the position of the different characters on a map with clustering.

## Prerequisites

To make google maps work, you need to add your own API key. To do so, follow the steps below:

- In android folder, create a file called local.properties in the root folder, and add the following line:

    ```
    GOOGLE_MAPS_API_KEY= YOUR_MAPS_API_KEY
    ```

- In ios folder, add a GoogleMapsAPIKeys.xcconfig in the root folder, with the following line:

    ```
    GOOGLE_MAPS_API_KEY = YOUR_MAPS_API_KEY
    ```


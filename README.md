
## Native UI component for PhoneGap apps that want a side navigation menu.


To run tests (iOS only for now) you'll need cordova-paramedic installed

    > npm install cordova-paramedic
    > cordova-paramedic --platform ios

To install in your project

    > cordova plugin add https://github.com/purplecabbage/phonegap-plugin-sidebar
    > // again, that was iOS only ...


## API

    pgsidebar.show(cbSuccess,cbError,items)

- `cbSuccess:` callback to be called when the sidebar control is shown
- `cbError:` callback to be called if there was an error showing the sidebar control
- `items:` an array of strings to display as a list in the sidebar control, when the user selects an item, the index in this array will be returned to the callback function


    pgsidebar.hide(cbSuccess,cbError)

- `cbSuccess:` callback to be called when the sidebar control is hidden
- `cbError:` callback to be called if there was an error hiding the sidebar control



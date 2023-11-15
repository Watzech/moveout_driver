[ services/dashboard_info ]

getCurrentRating -> current Rating

getMonthlyIncome -> Monthly Income

getTotalTransports -> Total transports maded

getCurrentSubscribe -> Current Subscribe

// ---------------------------------------------------------------------------------- //

[ services/device_info ]

getUserInfo -> Return current driver info

getVehicleInfo -> Get all Vehicle info

getTransportsInfo -> Get all his transports: scheduled, finished and in progress

removeUserInfo -> Need to be called on logoff

// ---------------------------------------------------------------------------------- //

[ services/requests ]

getRequests -> Get list of open requests

applyRequest -> Shoud be called on applying a request

// ---------------------------------------------------------------------------------- //

[ services/upload_file ]

uploadPdf -> Transform pdf file into base64 (string)

uploadPhoto -> Transform image file into base64 (string)

// ---------------------------------------------------------------------------------- //

[ services/vehicle ]

addVehicle -> Add new Vehicle
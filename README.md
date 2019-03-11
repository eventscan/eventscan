# README

## 1. User Stories (Required and Optional)

**Required Must-have Stories**

 * Display upcoming events    
 * Scan flyers
     * Be able to view the camera
     * Be able to use OCR
     * Take the picture first and then process the information 
 * Add the event to the user's calender app
 * Ask for alert preferences for the event
 * Be able to verify the event before adding it to the calender.

**Optional Nice-to-have Stories**

 * User Onboarding 
 * Ability to invite other users to the scanned event
 * Setup default alert times  i.e "At time of event" 
 * Be able to edit the newly scanned event in case the parsing algorithm failed
 * Detail Even View for upcoming events

## 2. Screen Archetypes

 * Camera View 
 	- The user can take a picture of a flyer to be parsed by the app.
 * Image Confirmation View
 	- The user is presented with the picture they captured using the camera view. If they feel that the image captured contains all the inofrmation that they wish to inlclude in their calendar event, else they may rescan it.
 * Upcoming Events Screen
 	- It shows the user the closet events in their calendar that have been created using the app.
 * Event details screen
     - Once the information that event has been parsed, it is displayed to the user so they make some modifcations to the event if they wish to do so.

## 3. Navigation

**Tab Navigation** (Tab to Screen)

 * Camera View 
 	- The user uses the camera view to take a picture and create an event.
 * Upcoming Events
 	- The upcoming events view is where the user would go to view their upcoming events.
 * Manually enter an event (optional)
 	-  This can be a view for the users to create events manually using the application via the event detail view.

**Flow Navigation** (Screen to Screen)

 * Camera View
     => Image Confirmation View
     => Events Detail View
 * Upcoming Events
     => Events Detail View

## Wireframe
<img src='prototype.jpeg' title='Wireframe'><br>
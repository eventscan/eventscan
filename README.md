# EventScan

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
1. [Schema](#Schema)


## Overview
### Description
Use the Captured Image and OCR library to Scan information, and create event on calender base on it.
   - **Category:** Photo & Calendar
   - **Mobile:** Uses camera, mobile only experience.
   - **Story:** Allows users to manage their schedule through pictures.
   - **Market:** Anyone use camera to store detailed information about the event. 
   - **Habit:** Users can create event throughout capturing the image or directly entering the information.
   - **Scope:** Capturing image, scanning the words from the image, manipulate the information, create the event. 
   
## Product-Spec
### 1. User Stories (Required and Optional)

**Required Must-have Stories**
#### Status

- [ ] Display upcoming events    
- [ ] Scan flyers
- [ ] Be able to view the camera
- [ ] Be able to use OCR
- [ ] Take the picture first and then process the information 
- [ ] Add the event to the user's calender app
- [ ] Ask for alert preferences for the event
- [ ] Be able to verify the event before adding it to the calender.

**Optional Nice-to-have Stories**

 * User Onboarding 
 * Ability to invite other users to the scanned event
 * Setup default alert times  i.e "At time of event" 
 * Be able to edit the newly scanned event in case the parsing algorithm failed
 * Detail Even View for upcoming events

### 2. Screen Archetypes

 * Camera View 
 	- The user can take a picture of a flyer to be parsed by the app.
 * Image Confirmation View
 	- The user is presented with the picture they captured using the camera view. If they feel that the image captured contains all the inofrmation that they wish to inlclude in their calendar event, else they may rescan it.
 * Upcoming Events Screen
 	- It shows the user the closet events in their calendar that have been created using the app.
 * Event details screen
     - Once the information that event has been parsed, it is displayed to the user so they make some modifcations to the event if they wish to do so.

### 3. Navigation

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


## Schema 
### Models
#### Event

   | Property          | Type          | Description                              |
   | ----------------- | ------------- | -----------------------------------------|
   | id                | String        | unique id for the image clicked          |
   | name              | String        | Event name                               |
   | date              | Date          | Event date                               |
   | location          | String        | Event location                           |
   | description       | String        | Event description                        |
   | alert preferences | Array of Time | alerts for upcoming events               |
   | invitees          | Array<String> | list of emails of the people the user wants to share the event with.|
   | image             | Image         | The image used to create the event       |

### Networking
#### List of network requests by screen

 * Camera View 
 	- No network calls made.
 * Image Confirmation View
 	- (Write/POST) to ABBY to process the image using submit image/processImage
 	- (READ/GET) download processed image from ABBY
 	- (Write/POST) end all tasks related to parsing the image on ABBY.
 * Upcoming Events Screen
 	- No network calls made.
 * Event details screen
    - No network calls made.

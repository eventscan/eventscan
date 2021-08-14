# EventScan

## Table of Contents
1. [Overview](#Overview)
1. [Event Scan Function Summarization](#Event-Scan-Function-Summarization)
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
   
## Event-Scan-Function-Summarization
### Camera View Controller:
1.	Importing AVFoundation for displaying live camera preview on the Safe Area
2.	When the middle button clicked 
      * 	current image of the preview captured for display on UIImageView 
      * 	starts parsing through Vision Helper struct
3.	When parsing is completed 
      * 	clear and confirm button appears
4.	When clear button clicked 
      * 	clear and confirm button become invisible 
      * 	image is removed form UIImageView
4.	When confirm button clicked
      * 	parsed data is transferred into the EventDataViewController
      * 	the new screen appears for selection
### Vision Helper struct:
1.	create textRecognizer through Firebase and FirebaseMLCommon
2.	fix the rotation of the image
3.	change the image to the VisionImage for calculation
4.	process the VisionImage through textRecognizer
5.	return the text part of the result
### Event Data View Controller:
#### All the data handling is done through Array of Array of EventData Object
1.	If Previous Bar Button clicked, it goes back to the previous selection or dismiss the screen if not possible
1.	If Next Bar Button clicked, it goes forward to the previous selection, or dismiss the screen if not possible
      * 	If dismiss the screen:
            * transfer the final data as an struct to the detail screen
            * activate the static data in DetailViewController for recognition of data source
### Detail View Controller:
1.	If data source is camera or list view:
      * 	it fills in the field according to the received data
2.	If cancel button is clicked:
      * 	it resets all the fields to its original state
      * 	returns to the data source if it exists.
2.	If confirm button is clicked:
      * 	it resets all the fields to its original state 
      * 	save the entered data into the CoreData
      * 	create event on calendar through EventKit or edits event if event already exist
      * 	transfers to the list view
3.	Resets all the data for data source
### List View Controller:
1.	Creates each cell for display based on data in CoreData
2.	If any cell selected transfers selected row to the Detail View for editing
3.	Transfers to the detail view   
   
## Product-Spec
### 1. User Stories (Required and Optional)

**Required Must-have Stories**
#### Status

- [X] Display upcoming events    
- [X] Scan flyers
- [X] Be able to view the camera
- [X] Be able to use OCR
- [X] Take the picture first and then process the information 
- [X] Add the event to the user's calender app
- [X] Ask for alert preferences for the event
- [X] Be able to verify the event before adding it to the calender.

**Optional Nice-to-have Stories**

- [ ] User Onboarding 
- [ ] Ability to invite other users to the scanned event
- [ ] Setup default alert times  i.e "At time of event" 
- [X] Be able to edit the newly scanned event in case the parsing algorithm failed
- [X] Detail Event View for upcoming events

### 2. Screen Archetypes

- [X] Camera View 
 	- The user can take a picture of a flyer to be parsed by the app.
- [X] Image Confirmation View
 	- The user is presented with the picture they captured using the camera view. If they feel that the image captured contains all the inofrmation that they wish to inlclude in their calendar event, else they may rescan it.
- [X] Upcoming Events Screen
 	- It shows the user the closet events in their calendar that have been created using the app.
- [X] Event details screen
     - Once the information that event has been parsed, it is displayed to the user so they make some modifcations to the event if they wish to do so.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

 - [X] Camera View 
 	- The user uses the camera view to take a picture and create an event.
 - [X] Upcoming Events
 	- The upcoming events view is where the user would go to view their upcoming events.
 - [X] Manually enter an event (optional)
 	-  This can be a view for the users to create events manually using the application via the event detail view.

**Flow Navigation** (Screen to Screen)

- [X] Camera View
     => Image Confirmation View
     => Events Detail View
- [X] Upcoming Events
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

    
## Video Walkthrough

Note, it may take a couple seconds for the gif to appear may take a couple seconds as the gif file is quite large.

#### Sprint 2

<img src='./gifs/Sprint2.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<a href="https://github.com/eventscan/eventscan/files/3052156/Camera.Feature.GIF.MP4.zip"> Link for Camera Feature </a>

<a href="https://github.com/eventscan/eventscan/blob/master/DetailViewFrontEnd.MP4"> Link for Detail View Feature </a>

#### Sprint 3

<a href="https://github.com/eventscan/eventscan/blob/master/RPReplay_Final1555278800.MP4.zip"> Link for Detail View Feature </a>

#### Final Sprint
<img src='./gifs/Final%20Recording.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<a href="https://github.com/eventscan/eventscan/blob/master/Final%20Recording.mp4"> Link for Final Replay Video </a>


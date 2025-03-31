![Loopliner introduction section picture, showing its app icon, tagline & sub-tagline. In the picture also shows several screens from the app as the previews, with the journey mode's map view is put inside an iPad screen.](https://github.com/lonard2/Loopliner/blob/main/README%20Assets/Loopliner%20intro.png)

#
Designed and created as a submission for the 2025 Swift Student Challenge, held by Apple for the WWDC25.\
An interactive experience game for guiding you become a smart commuter, available for the iPadOS & macOS platform.

Unfortunately, the game didn't selected for the award in the end, however I gotten many new skills & abilities when working on it.
Some includes:
- making use of CoreGraphics' framework Canvas for building interactive (and lively) commuter train system map according to a gameplay's condition,
- testing out apps/games for multiple Apple platforms with various sizes for visual and technical issues & bugs, especially iPad and macOS, and
- building accessiblity features for ensuring accessible design, particularly for apps that encountered public interest themes, and
- attempting to create interesting storytelling (for the essay).

I would like to carry many of those on my future projects.
Hope you will like this project!

![Loopliner first section: "About the game", with a background of a Jakarta commuter train station, Jatinegara station, at night.](https://github.com/lonard2/Loopliner/blob/main/README%20Assets/Section%201.png)
## Why I made the game
In these days, public transportation should be a necessity as a way to improve society in my opinion. It positively contributes to the improvement of environment, solidarity, financial, and more, compared with personal transport. However, with the advent of technology, some people are tend to have more individualistic (at least in my observation). I personally believe that all public transportation users (whether it's train, buses, boats, planes, etc.) should be equipped with "smart" attributes that leverage the benefits of those systems. "Smart" in this terms are mainly about being always empathic & mastery on using the systems, as those could support everyone for making public transport better in many terms (such as safety, comfort, and service quality).\
If I learned from my observation, people are tend to follow engaging and fun stuffs instead of the boring ones, thus I'm have an idea to make people learn about the great ways (or the smart ways) to use public transportation. Then, Loopliner is born.

## About Loopliner
Hello, Loopliner! It is an public transportation-themed interactive experience game (some of you could tend to call this an visual novel due to half of the gameplay are in ADV/visual novel mode) that is set in my hometown, Jakarta, Indonesia 🇮🇩.\
In this game, you will play as Robert, a new commuter whom lived in North Jakarta that is just first riding the city's commuter train. He's excited to do the journey, with the expectations of him being understandable towards other passengers & knowledgeable to use the train system. The main goal is to guide him to Cisauk station, where the campus is located the nearest, with those expectations are fulfilled for his future commuting.

![Loopliner second section: "Features", with a background of a Jakarta commuter train station, Rajawali station, at daytime.](https://github.com/lonard2/Loopliner/blob/main/README%20Assets/Section%202.png)
##
**- Simple, modern, and intuitive user experience design.** Not too complicated user experience, allowing for quick & easy usage experience.\
**- Review your commuting journey, before going into the real thing.** Via the interactive map which accessible from the main menu, you could check out the Jakarta's commuter train system in more detail. The feature is suitable for you whom wanted to learn about public transportation in a sense, even it could be possible to use as during travel to Jakarta.\
**- Accessible for many commuters.** I believe that public transportation should be universal & welcoming for everyone, thus I'm aiming to have Loopliner having many accessibility features. At first, it have colorblind mode (which takes effect on the map view & intermission view) and manual-crafted screen reader support.\
**- Act like a real commuter.** With some interactions & cues are mimicking the real-life commuting, you could learn or adapt how commuters doing. Activities you could do are payment (tap-in/tap-out), balance checking, select platforms & next trains, and deciding to stay/exit train.\
**- Decision is crucial.** Encounters or big events will occurs sometimes, and Robert should follow your choice. He will get successful, apathy, or bad outcomes, depending on how the choices done. Outside those, choices will appear too which mainly make the difference for Robert's journey.

![Loopliner third section: "Technicals & frameworks", with a background of a Jakarta commuter train.](https://github.com/lonard2/Loopliner/blob/main/README%20Assets/Section%203.png)
##
Loopliner is proud to be fully powered with technologies, all are Apple techs:\
- **SwiftUI** for the user interface & experience, in overall,\
- **SwiftData** & local data tech combination for the data handling, including CRUD and data persistance of the whole game,\
- **CoreText** for implementing custom text within the game,\
- **CoreGraphics** for building Canvas(es) of the interactive map (whether the journey or the menu one),\
- **Combine** for handling player journey data within view models,\
- **AVFoundation** for making the music and sound effect happens in the app,\
- **AppStorage** for the settings handling, and\
- **UniformTypeIdentifier** for making drag-and-drop items as Transferable representations.\
\
The game is built with Swift Playgrounds 4.6, and was tested without any issues in iPadOS 18.2 & 18.3 (all sizes) and macOS (both Designed for iPad and Mac Catalyst).

![Loopliner fourth section: "Design & audio-visual", with a background of a Jakarta commuter train station, Klender Baru station, at daytime.](https://github.com/lonard2/Loopliner/blob/main/README%20Assets/Section%204.png)

The design & art of the app is mainly designed by two values: **"infinite and dynamic movement of public transportation"** and **"the beauty of Jakarta's public transportation service"**. 
With intentional design selection like flat design, modern font, icons used as informative elements, and more, I hope that you could felt those values. Likewise with the audio design, which I intended to have "moving beats" style to capture those, too. The all-electronic audio design really captures that, do you think?

![Loopliner fifth section: "How to use & play", with a background of a running Jakarta commuter train, taken in Cisauk station at nighttime.](https://github.com/lonard2/Loopliner/blob/main/README%20Assets/Section%206.png)

Want to play or modify the project for improving its experience? It's easy in 4 steps!

1. Download the whole repository via selecting Code button > Download ZIP at the repository's homepage, or
2. Extract the ZIP file on a folder/intended location
3. Open the swiftpm on the Swift Playgrounds directly or Xcode (via File > Open/Open Existing Project modal menu)
4. Voila! You could check the code or experience the game via Preview (Swift Playgrounds) /Simulator (Xcode).

![Loopliner sixth section: "Credits & acknowledgments", with a background of an another Jakarta commuter train station, Rajawali station, at daytime.](https://github.com/lonard2/Loopliner/blob/main/README%20Assets/Section%205.png)

##
Thank you for being here (and contributing to it, if you do hehe)! Make the public transportation better, starting from you.
**Loopliner - Feel, hear, and learn your public transportation.**

## Pictures
All images shown in the journey are taken by myself,  during period of March - December 2024 in several Jakarta commuter line stations: Rajawali, Kampung Bandan, Tanah Abang, Manggarai, and Cisauk.\
Exceptions include: 2 Commuter Line train pictures, used in intermission view, which are explicitly declared as public domain via Creative Commons Zero 1.0 license by their owners:\
- https://commons.wikimedia.org/wiki/File:KRL_205JR.jpg
- https://commons.wikimedia.org/wiki/File:JR_205_Masuk_Jakarta_Kota.jpg
All icons used in this game are based on SF Symbols 6.0.

## Text/Typography
All fonts used are open-source fonts & licensed under SIL Open Font License 1.1 (https://openfontlicense.org/):\
- Space Grotesk (https://github.com/floriankarsten/space-grotesk)
- Unica One (https://github.com/etunni/unica)
- Space Mono (https://github.com/googlefonts/spacemono)

## Music & sound effects
All music are created by myself, using GarageBand for iOS.\
Sound effects are all made by freesound_community (https://pixabay.com/users/freesound_community-46691455/) from Pixabay:\
- button-pressed (https://pixabay.com/sound-effects/button-pressed-38129/)
- Electric train (https://pixabay.com/sound-effects/electric-train-27377/)
- Train entering & leaving station (https://pixabay.com/sound-effects/train-entering-and-leaving-station-23301/)
- correct (https://pixabay.com/sound-effects/correct-38597/) and
- Short beep tone (https://pixabay.com/sound-effects/short-beep-tone-47916/)

## Art & assets
All character portraits are made by me in Inkscape, an open-source vector graphics software.\
In addition to that, app logo & payment assets (card reader, smartphone, etc.) are all drawn in Figma by myself, too.

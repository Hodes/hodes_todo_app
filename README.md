# hodes_todo_app

The Hodes TODO app to learn flutter. This app is meant for leaning purposes. 

## Flutter/Dart Techniques learned in this project

* Intermediate Layout With Rows, Cols, Expansible
* Widget separation
* Creating custom widgets
* Using third part packages
* Integrating custom widgets with third part widgets
* Routing
* Dealing with State reactivity
* Integrate with GetX library
* Widget tree dynamic arrangement and loader state
* Future 
* Database storage (With NoSQL sembast)
* Model Serialization with Annotations third part library  
* Code generation with builders
* Dealing with nullsafe

## Prepare

First get the dependencies

`flutter pub get`

## Code Generation
### To generate code for models serialization this project use dart builders

This step is needed only if the models were modified. This will generate the implementation of the 
serialization and 'unserialization' methods.

`flutter packages pub run build_runner build`

## Build / Run

Then run on the already open emulator

`flutter run`

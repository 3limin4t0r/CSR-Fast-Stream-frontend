# Developer Pipeline

### Development (inc. automated testing)

**Key**
- Github: Code repository
- Slack: Team chat & Services integration (eg. builds, deployment etc)
- Travis CI: Continuous Integration / Build Server
- Hosting: Currently Heroku (PaaS)
- Static Code Analysis: Scrutinizer (inc. Cpd, Md, Cs, Coverage etc)

![Alt text](http://g.gravizo.com/g?
@startuml;
actor Developer;
participant "Feature/Bug/Tests" as DEVELOPER;
participant "Local Dev ENV" as LOCAL;
participant "Slack" as SLACK;
participant "Github" as GITHUB;
participant "Travis CI" as TRAVIS;
participant "Hosting" as HOSTING;
participant "Static Code Analysis" as ANALYSIS;
Developer -> DEVELOPER: Code;
activate DEVELOPER;
DEVELOPER -> LOCAL: Do Work;
activate LOCAL;
LOCAL -> GITHUB: Push;
activate GITHUB;
activate SLACK;
GITHUB -> SLACK: Notification;
GITHUB -> TRAVIS: Push Hook;
activate TRAVIS;
activate HOSTING;
TRAVIS -> HOSTING: If Successful;
TRAVIS --> GITHUB: If failure;
TRAVIS --> SLACK: Notification;
activate ANALYSIS;
TRAVIS --> ANALYSIS: Push;
ANALYSIS --> GITHUB: Notification;
deactivate ANALYSIS;
TRAVIS -> GITHUB: Notification;
HOSTING --> SLACK: Notification;
deactivate HOSTING;
TRAVIS --> GITHUB: Notification;
deactivate TRAVIS;
deactivate GITHUB;
SLACK --> DEVELOPER: Notification;
deactivate SLACK;
deactivate LOCAL;
DEVELOPER --> Developer: Done;
deactivate DEVELOPER;
@enduml
)

### Peer Review / Pull Request

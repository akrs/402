# $PROJECT_NAME
### Andrew Akers, 19 Jan 2016

## Description
- A simple, extensible backbone for an free/open source (GPLv3) smart-home
- IFTTT for Arduinos, with a Raspberry Pi providing the internet connection
- Unlike more complicated systems (i.e. OpenHab) focuses on cheap, off the shelf
  hardware, and a DIY attitude.

## Justification
- Limited scope, focusing on a single core experience
- Interesting intersection of hardware and software
  - Arduino, Raspberry Pi, and the wireless interface

## Users's POV
Core concepts:
- Triggers
- Action
- Sequence

Trigger:
- Some incoming action:
  - text message
  - Input change on remote Arduino
  - Timer
  - Web interface input


Action:
- Some outgoing action:
  - Output on Arduino
  - Tweet
  - Text message

Section:
- Some sequence of actions:

  Eg:
    - Start coffee maker
    - Turn on bedroom lights

See IFTTT.

## Operations/Technologies
Raspberry Pi base station
- Connected to local network, and internet
- Python/Flask web server
- Easy python plugin interface for new triggers/actions

Arduino
- programmed by Raspberry Pi with auto-generated code

Wireless link:
- nRF24L01+ modules
  - Raspberry Pi and Arduino libraries

## Preliminary development schedule
Week 2:
Wireless ping-pong between Arduino and Pi

Week 3:
Web skeleton

Week 4:
Web trigger light on Arduino

Other goals:
- Raspberry Pi autogenerate and program Arduino

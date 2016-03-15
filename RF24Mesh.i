%module RF24Mesh
%{
#include <stdio.h>
#include <stdlib.h>
#include <RF24/RF24.h>
#include <RF24Network/RF24Network.h>
#include <RF24Mesh/RF24Mesh.h>
%}

#include <stdio.h>
#include <stdlib.h>
#define MESH_ADDR_CONFIRM 129

#define MESH_ADDR_LOOKUP 196
#define MESH_ADDR_RELEASE 197
#define MESH_ID_LOOKUP 198

#define MESH_BLANK_ID 65535

#include "RF24Mesh_config.h"

#include <RF24/RF24.h>
#include <RF24Network/RF24Network.h>
#define RF24_LINUX

#include <stddef.h>
#include <stdint.h>

class RF24;
class RF24Network;

class RF24Mesh {
    public:
      RF24Mesh( RF24& _radio,RF24Network& _network );
      bool begin(uint8_t channel = MESH_DEFAULT_CHANNEL, rf24_datarate_e data_rate = RF24_1MBPS, uint32_t timeout=MESH_RENEWAL_TIMEOUT );

      uint8_t update();
      bool write(const void* data, uint8_t msg_type, size_t size, uint8_t nodeID=0);
      void setNodeID(uint8_t nodeID);

      void DHCP();
      int16_t getNodeID(uint16_t address=MESH_BLANK_ID);

      bool checkConnection();
      uint16_t renewAddress(uint32_t timeout=MESH_RENEWAL_TIMEOUT);

      bool releaseAddress();

      uint16_t mesh_address;
      int16_t getAddress(uint8_t nodeID);
      bool write(uint16_t to_node, const void* data, uint8_t msg_type, size_t size );

      void setChannel(uint8_t _channel);

      void setChild(bool allow);
      void setAddress(uint8_t nodeID, uint16_t address);

      void saveDHCP();
      void loadDHCP();
      uint8_t _nodeID;

      void setStaticAddress(uint8_t nodeID, uint16_t address);

  private:
      RF24& radio;
      RF24Network& network;
      bool findNodes(RF24NetworkHeader& header, uint8_t level, uint16_t *address);
      bool requestAddress(uint8_t level);
      bool waitForAvailable(uint32_t timeout);
      bool doDHCP;
      uint32_t lastSaveTime;
      uint32_t lastFileSave;
      uint8_t radio_channel;
};

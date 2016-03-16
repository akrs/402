RF23Mesh_wrap.cxx:
	swig -c++ -python RF24Mesh.i

RF24Mesh_wrap.o: RF23Mesh_wrap.cxx
	arm-linux-gnueabihf-gcc -pthread -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes -g -fstack-protector-strong -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -fPIC -I/usr/include/python3.4m -c RF24Mesh_wrap.cxx -o build/RF24Mesh_wrap.o

_RF24Mesh.so: RF24Mesh_wrap.o
	arm-linux-gnueabihf-g++ -pthread -shared -Wl,-O1 -Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,-z,relro -g -fstack-protector-strong -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 build/F24Mesh_wrap.o /usr/lib/arm-linux-gnueabihf/libpython3.4m.so -lrf24-bcm -lrf24network -lrf24mesh -o _RF24Mesh.so
# why the fuck do I have to manually link this with libpython3.4m.so??!!!?
# The world will probably never know. It does avoid nasty symbol not defined errors

CC ?= gcc
LIBMNL_DIR = $(realpath ./)/libmnl_build
LIBNFTNL_DIR = $(realpath ./)/libnftnl_build
KERNELCTF = kernelctf/exploit.c
UNIVERSAL = universal/exploit.c
CFLAGS = -w -static -Wall
LIBS = -L$(LIBMNL_DIR)/install/usr/local/lib -L$(LIBNFTNL_DIR)/install/usr/local/lib -lnftnl -lmnl -lpthread
INCLUDES = -I$(LIBMNL_DIR)/install/usr/local/include -I$(LIBNFTNL_DIR)/install/usr/local/include

all: kernelctf universal

kernelctf: $(KERNELCTF) $(LIBMNL_DIR) $(LIBNFTNL_DIR)
	$(CC) $(CFLAGS) $(KERNELCTF) -o kctf $(INCLUDES) $(LIBS) 

universal: $(UNIVERSAL) $(LIBMNL_DIR) $(LIBNFTNL_DIR)
	$(CC) $(CFLAGS) $(UNIVERSAL) -o otterroot $(INCLUDES) $(LIBS)

clean:
	rm -f otterroot kctf

.PHONY: all kernelctf universal clean

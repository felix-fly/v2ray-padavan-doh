THISDIR := $(shell pwd)
SMARTDNS_URL_BASE :=  https://raw.githubusercontent.com/felix-fly/v2ray-padavan-doh/master/bin

SMARTDNS_NAME := smartdns
SMARTDNS_URL := $(SMARTDNS_URL_BASE)/$(SMARTDNS_NAME)

CERT_FILE := https://curl.se/ca/cacert.pem

all: download_test
	@echo "$(SMARTDNS_NAME) build done!"

download_test:
	( if [ ! -f $(SMARTDNS_NAME) ]; then \
		wget -t5 --timeout=20 --no-check-certificate $(SMARTDNS_URL); \
		wget -t5 --timeout=20 --no-check-certificate $(CERT_FILE); \
	fi )

romfs:
ifeq ($(CONFIG_FIRMWARE_INCLUDE_SMARTDNS),y)
	$(ROMFSINST) -p +x $(THISDIR)/$(SMARTDNS_NAME) /usr/bin/$(SMARTDNS_NAME)
	$(ROMFSINST) -p -x $(THISDIR)/cacert.pem /usr/lib/cacert.pem
endif
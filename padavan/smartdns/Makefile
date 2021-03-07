THISDIR := $(shell pwd)
SMARTDNS_URL_BASE :=  https://raw.githubusercontent.com/felix-fly/v2ray-padavan-doh/master/smartdns

SMARTDNS_NAME := smartdns
SMARTDNS_URL := $(SMARTDNS_URL_BASE)/$(SMARTDNS_NAME)

all: download_test
	@echo "smartdns build done!"

download_test:
	( if [ ! -f $(SMARTDNS_NAME) ]; then \
		wget -t5 --timeout=20 --no-check-certificate $(SMARTDNS_URL); \
	fi )

romfs:
ifeq ($(CONFIG_FIRMWARE_INCLUDE_SMARTDNS),y)
	$(ROMFSINST) -p +x $(THISDIR)/$(SMARTDNS_NAME) /usr/bin/$(SMARTDNS_NAME)
endif
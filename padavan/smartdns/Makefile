THISDIR := $(shell pwd)
SMARTDNS_URL_BASE :=  https://raw.githubusercontent.com/felix-fly/v2ray-padavan-doh/master/padavan/smartdns

all: download_test extra_test
	@echo "smartdns done"

download_test:
	wget -t5 --timeout=20 --no-check-certificate $(SMARTDNS_URL_BASE)/smartdns

extra_test:
  @echo "download smartdns"

romfs:
ifeq ($(CONFIG_FIRMWARE_INCLUDE_SMARTDNS),y)
	$(ROMFSINST) -p +x $(THISDIR)/smartdns /usr/bin/smartdns
endif
THISDIR := $(shell pwd)
XRAY_URL_BASE := https://github.com/felix-fly/xray-openwrt/releases/latest/download/

XRAY_NAME := xray-linux-mipsle
XRAY_URL := $(XRAY_URL_BASE)/$(XRAY_NAME).tar.gz

CERT_FILE := https://curl.se/ca/cacert.pem

all: download_test extra_test
	@echo "xray build done!"

download_test:
	( if [ ! -f $(XRAY_NAME).tar.gz ]; then \
		wget -t5 --timeout=20 --no-check-certificate -O $(XRAY_NAME).tar.gz $(XRAY_URL); \
		wget -t5 --timeout=20 --no-check-certificate $(CERT_FILE); \
	fi )

extra_test:
	( if [ ! -d $(XRAY_NAME) ]; then \
		tar xf $(XRAY_NAME).tar.gz; \
		rm xray; \
		mv xray_softfloat xray; \
	fi )

clean:
	rm -rf $(XRAY_NAME).tar.gz

romfs:
ifeq ($(CONFIG_FIRMWARE_INCLUDE_XRAY),y)
	$(ROMFSINST) -p +x $(THISDIR)/xray /usr/bin/xray
	$(ROMFSINST) -p -x $(THISDIR)/cacert.pem /usr/lib/cacert.pem
endif
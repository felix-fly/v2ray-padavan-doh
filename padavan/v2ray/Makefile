THISDIR := $(shell pwd)
V2RAY_VER := 4.26.0
V2RAY_URL_BASE := https://github.com/felix-fly/v2ray-openwrt/releases/download

V2RAY_NAME := v2ray-linux-mipsle
V2RAY_URL := $(V2RAY_URL_BASE)/$(V2RAY_VER)/$(V2RAY_NAME).tar.gz

all: download_test extra_test
	@echo "v2ray build done!"

download_test:
	( if [ ! -f $(V2RAY_NAME).tar.gz ]; then \
		wget -t5 --timeout=20 --no-check-certificate -O $(V2RAY_NAME).tar.gz $(V2RAY_URL); \
	fi )

extra_test:
	( if [ ! -d $(V2RAY_NAME) ]; then \
		tar xf $(V2RAY_NAME).tar.gz; \
		rm v2ray; \
		mv v2ray_softfloat v2ray; \
	fi )

clean:
	rm -rf $(V2RAY_NAME).tar.gz

romfs:
ifeq ($(CONFIG_FIRMWARE_INCLUDE_V2RAY),y)
	$(ROMFSINST) -p +x $(THISDIR)/v2ray /usr/bin/v2ray
endif
#
# Copyright (C) 2016 killaWRT
#
# This is free software, licensed under OpenBSD
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=killawrt
PKG_VERSION:=git
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=http://github.com/laudarch/killaWRT.git
PKG_SOURCE_VERSION:=HEAD

include $(INCLUDE_DIR)/package.mk

define Package/killawrt
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+aircrack-ng +macchanger
  TITLE:=Automated wireless security audit and cracking tool
  URL:=http://killawrt.org/
  SUBMENU:=wireless
  PKGARCH:=all
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/killawrt/conffiles
/etc/killawrt.conf
endef

H_SRC_DIR:=$(PKG_BUILD_DIR)/killaWRT

define Package/killawrt/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(H_SRC_DIR)/killawrt.sh $(1)/usr/bin/killawrt
	$(INSTALL_DIR) $(1)/usr/lib/killawrt
	$(INSTALL_DATA) $(H_SRC_DIR)/killawrt.d/*.sh $(1)/usr/lib/killawrt/
	chmod 0755 $(1)/usr/lib/killawrt/udhcpc.sh
	$(INSTALL_DIR) $(1)/usr/lib/killawrt/dict
	$(INSTALL_DATA) $(H_SRC_DIR)/killawrt.d/dict/*.dict $(1)/usr/lib/killawrt/dict/
	$(INSTALL_DIR) $(1)/usr/lib/killawrt/ssid
	$(INSTALL_DATA) $(H_SRC_DIR)/killawrt.d/ssid/*.ssid $(1)/usr/lib/killawrt/ssid/
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DATA) $(H_SRC_DIR)/killawrt.conf $(1)/etc/
	$(SED) 's|^\(H_LIB_D\)=.*$$$$|\1=/usr/lib/killawrt|' \
	    -e 's|^\(H_LOG_F\)=.*$$$$|\1=/var/log/killawrt.log|' \
	    -e 's|^\(H_PID_F\)=.*$$$$|\1=/var/run/killawrt.pid|' \
	    -e 's|^\(H_RUN_D\)=.*$$$$|\1=/var/run/killawrt|' \
		$(1)/etc/killawrt.conf
	$(INSTALL_DIR) $(1)/etc/default
	$(INSTALL_DATA) ./files/killawrt.default $(1)/etc/default/killawrt
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/killawrt.init $(1)/etc/init.d/killawrt
endef

$(eval $(call BuildPackage,killawrt))

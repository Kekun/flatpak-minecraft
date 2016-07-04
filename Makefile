NULL=

ID=com.mojang.Minecraft
BUNDLE=minecraft.flatpak

RUNTIME=org.gnome.Platform
SDK=org.gnome.Sdk
VERSION=3.20

SDK_REPO=gnome
SDK_LOCATION=https://sdk.gnome.org/repo/
SDK_KEY=gnome-sdk.gpg
SDK_KEY_URL=https://sdk.gnome.org/keys/gnome-sdk.gpg

USER=--user
MANIFEST=$(ID).json
BUILD_DIR=tmp
REPO=repo
INSTALL_REPO=minecraft-repo

BUILD_DEPS= \
	$(MANIFEST) \
	jre-Makefile \
	minecraft-Makefile \
	$(NULL)

all: .gitignore $(BUNDLE)

.gitignore:
	echo ".gitignore" > $@
	echo "$(BUNDLE)" >> $@
	echo "$(SDK_KEY)" >> $@
	echo "$(BUILD_DIR)" >> $@
	echo "$(REPO)" >> $@
	echo ".flatpak-builder" >> $@

$(SDK_KEY):
	wget $(SDK_KEY_URL)

install-sdk-repo: $(SDK_KEY)
	flatpak $(USER) remote-add --gpg-import=$(SDK_KEY) $(SDK_REPO) $(SDK_LOCATION)

# Depends on 'install-sdk-repo'
install-runtime:
	flatpak $(USER) install $(SDK_REPO) $(RUNTIME) $(VERSION)

# Depends on 'install-sdk-repo'
install-sdk:
	flatpak $(USER) install $(SDK_REPO) $(SDK) $(VERSION)

# Depends on 'install-runtime' and 'install-sdk'
build: $(BUILD_DEPS) clean-build
	flatpak-builder --repo=$(REPO) $(BUILD_DIR) $(MANIFEST)

$(BUNDLE): build
	flatpak build-bundle $(REPO) $(BUNDLE) $(ID)

prepare-install:
	flatpak $(USER) remote-add --no-gpg-verify $(INSTALL_REPO) $(REPO)

install:
	flatpak $(USER) install $(INSTALL_REPO) $(ID)

uninstall:
	flatpak $(USER) uninstall $(ID)

run:
	flatpak run $(ID)

clean-build:
	rm -Rf $(BUILD_DIR)

clean:
	rm -Rf .gitignore $(BUNDLE) $(BUILD_DIR) $(REPO) $(SDK_KEY)

.PHONY: all install-sdk-repo install-runtime install-sdk build prepare-install install uninstall run clean-build clean .gitignore

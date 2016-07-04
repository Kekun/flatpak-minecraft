#flatpak-minecraft

A small tool to automatially bundle Minecraft as a flatpak.

## Usage

You will need the `gnome` repository, if you don't already have it you can install it with:
```
make install-sdk-repo
```

To build `minecraft.flatpak`:
```
make
```

To install it:
```
make install
```

To uninstall it:
```
make uninstall
```

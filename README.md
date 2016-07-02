#flatpak-minecraft

A small tool to automatially bundle Minecraft as a flatpak.

## Usage

You may need to prepare the build by running these commands, you have to run each of these only once:
```
make install-sdk-repo
```

```
make install-runtime
```

```
make install-sdk
```

To build the flatpak, simply run:
```
make
```

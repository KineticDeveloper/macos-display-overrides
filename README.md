# Display Overrides for macOS (Big Sur)

This repository is for display overrides to make (my) monitors work better on macOS.

For Catalina and older, see mafredis [catalina](https://github.com/mafredri/macos-display-overrides/tree/catalina)-branch.

<img src="./resources/Screen Shot 2021-04-10 at 14.47.09.png">

## Goals

- Force HiDPI modes for screens that are not supported (by macOS)
- Force picture modes on misbehaving screens
- Fix displays detected as TVs
- Make sure Night Shift works on external displays
- Allow picking HiDPI modes in Display preferences like for retina displays (less realiant on RDM)
- Custom icons for displays

## Usage

1. Create overrides (`DisplayVendorID-*/DisplayProductID-*.plist`) or use the existing ones
2. Open Terminal and run `sudo install.sh` from the project folder
3. Reboot

After rebooting, the "Display" system preferences should show an updated display name in the title bar and if scaled resolutions are shown (option-click on "Scaled"): additional resolutions are available. 

See screenshot below from my Dell U3818DW.

![Screenshot of "Display" settings preferences](Screenshot.png)

The highlighted resolutions correspond to a scaling of 80% respectively 75% of the native screens resolution.

## Notes

- Since macOS Mojave we no longer seem to need RGB edid overrides, they seem to be ineffective
  - We can use `DisplayIsTV` => `false` instead
- Tweak `target-default-ppmm` to enable selection of HiDPI modes in System Preferences -> Display
  - Also requires adding the appropriate HiDPI resolutions
  - How do we calculate optimal ppmm for display x resolution?
  - See [DELL U2715H](./DisplayVendorID-10ac/DisplayProductID-d066.plist) override for an example

## Dumping display EDID

Create a dump for each display connected to your Mac.

```bash
n=0; \
ioreg -lw0 | grep "IODisplayEDID" \
    | while read line; do \
        ((n++)); \
        name=display-${n}.edid; \
        sed "/[^<]*</s///" <<<"$line" | xxd -p -r >$name; \
        echo "Created $name"; \
    done
```

## Resources

- [Adding/Using HiDPI custom resolutions - tonymacx86.com](https://www.tonymacx86.com/threads/adding-using-hidpi-custom-resolutions.133254/)
- [Display Override PropertyList File Parser and Generator with HiDPI support](https://comsysto.github.io/Display-Override-PropertyList-File-Parser-and-Generator-with-HiDPI-Support-For-Scaled-Resolutions/)
- [edid-decode](https://git.linuxtv.org/edid-decode.git/)
- [avibrazil/RDM](https://github.com/avibrazil/RDM) - Easily set Mac Retina display to higher unsupported resolutions
- [usr-sse2/RDM](https://github.com/usr-sse2/RDM) - Fork, supports editing, icons, etc.
- [xzhih/one-key-hidpi](https://github.com/xzhih/one-key-hidpi)

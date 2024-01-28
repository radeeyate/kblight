# kblight

Control your Framework Laptop 13 keyboard backlight brightness and effects.

## Installation

Choose one of the following installation methods:

1. Automatic installation using wget:

   ```bash
   wget -qO- https://raw.githubusercontent.com/radeeyate/kblight/main/install.sh | sudo bash
   ```

2. Manual installation:

   1. Download kblight script:

      ```bash
      curl -LO https://raw.githubusercontent.com/radeeyate/kblight/main/kblight
      ```

   2. Make it executable:

      ```bash
      chmod +x kblight
      ```

   3. Move it to a directory in your PATH (optional):

      ```bash
      sudo mv kblight /usr/local/bin/
      ```

## Usage

```bash
kblight <command> <options>
```

Available commands:

* **set <brightness>:** Sets the keyboard backlight brightness.
  - **Available brightness levels:**
    - `max`: Sets brightness to maximum (100%)
    - `off`: Turns off the backlight
    - `mid`: Sets brightness to 50%
    - `low`: Sets brightness to 20%
    - `dim`: Sets brightness to 5%
    - `<number>`: Sets brightness to a specific percentage value (0-100)
* **effect <effect>:** Applies a keyboard lighting effect.
  - **Available effects:**
    - `strobe`
    - `breathe`
* **get:** Gets the current keyboard backlight brightness as a percentage.
* **help:** Displays this help message.
* **version:** Displays the version information of kblight.

**## Examples**

* Turn off the keyboard backlight:

   ```bash
   kblight set off
   ```

* Set the brightness to 75%:

   ```bash
   kblight set 75
   ```

* Apply the "breathe" effect:

   ```bash
   kblight effect breathe
   ```

## Notes

* This script requires root privileges to run.
* It relies on the `ectool` utility to interact with the Framework Laptop 13 embedded controlled. If `ectool` is not found, the binary will be downloaded automatically into `/usr/local/bin`.

## Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

## License

MIT

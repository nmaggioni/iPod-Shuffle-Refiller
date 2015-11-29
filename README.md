# iPod-Shuffler
A mix of Bash and Python scripts to correctly copy and format music into an iPod Shuffle - and potentially any non-iOS based iPod - without the need to use iTunes. *OverVoice* is handled as well.

To use these scripts you need to install the Debian package `libttspico-utils` (needed for `pico2wave`) or the AUR package `svox-pico-bin`, and the Python**2** module `mutagen`.

## Usage
Just run the Bash script with the quoted path to the iPod's folder - without the trailing slash - as the first parameter. Escaping spaces and other characters instead of quoting the whole string may result in endefined behavior!

``` bash
./iPod-Shuffler.sh "/path/to/your/iPod"
```

#### Credits
The Python script was found somewhere in the wild, unfortunately I can't recall the original author. Anyway, most of the merit should go to him/her.

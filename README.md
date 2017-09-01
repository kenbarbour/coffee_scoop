# Coffee Scoop

## About
`coffee_scoop.scad` is a SCAD script for generating a coffee scoop with the correct volume for scooping coffee grounds for a given volume of pre-brew water.

## How to generate a scoop

1. Determine the volume of water in milliliters (mL) you would like the scoop to measure coffee for.  Keep in mind that 1 cup as measured on your carafe likely represents a serving (180 mL) and NOT a US cup (240 mL).  Enter this value for `water_volume`.

2. Determine the bulk density of your coffee (in Kg/m^3).  Enter this value for `coffee_density`.
  * __Fine ground coffee__ - 400 Kg/m^3
  * __Coarse ground coffee__ - 300 Kg/m^3
  * __Medium ground coffee__ - 360 Kg/m^3
  * __Whole Bean Light Roast__ - 370 Kg/m^3
  * __Whole Bean Dark Roast__ - 290 Kg/m^3

3. **Optional**: Type a label for `text_content`.  By default, the label is the amount of water this scoop is for.

4. Generate your STL model by pressing F6 and export it.  (Or run `openscad coffee_scoop.scad`)

## About
Author: Kenneth Barbour; kenbarbour.com

## License
GNU GPLv3

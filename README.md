# LiPoCheck

Tiny standalone LED bargraph to indicate battery level.

This simple project recreates a feature often built-in to lithium battery packs: press a button, and a small LED bar graph displays the current charge level for a few seconds. It uses an ATtiny85 and its internal bandgap voltage reference to measure its own power supply and illuminate the correct number of LEDs. 

The voltage thresholds for each LED should be set depending on the battery you're using and the application. The discharge curve for LiPo batteries varies based on discharge current, so the safest thing to do is to measure a complete discharge, logging the voltage against the integrated capacity -- if you have a constant-current sink, this will directly be proportional to time. Once you know the voltages at 75% capacity, 50% capacity, etc you can drop these into the macros in the code to get an accurate reading on the bar graph.

More info: https://mitxela.com/projects/lipocheck

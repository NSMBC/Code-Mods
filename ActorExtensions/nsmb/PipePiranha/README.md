# Pipe Piranha Extension

**Adds:**
- Variable scale
- Variable health and invincibility
- The option to move regardless of the player's proximity
- Attack/wait length options
- Move speed options


To use the new settings within NSMBe, put the following in `[NSMBe root]/stageobjsettings_new.xml`
```xml
<class id="23">
  <name>Pipe Piranha Plant (facing up)</name>
  <flags known="1" complete="1" />
  <category id="13" />
  <notes></notes>
  <files>/enemy/v_pakkun.nsbmd</files>
  <field id="41-48" type="list" name="Number of fireballs" values="0=0,1=1,17=2,33=3,49=6" notes="" />
  <field id="37-40" type="value" name="Scale" values="" notes="" />
  <field id="33-36" type="value" name="Health" values="" notes="Number of fireball hits it takes to kill the piranha. 0 is the same as 1." />
  <field id="32" type="checkbox" name="Invincible" values="" notes="Makes piranha invincible to fireballs and shells." />
  <field id="31" type="checkbox" name="No player wait" values="" notes="Don't stop for a player near the pipe." />
  <field id="28-30" type="list" name="Attack/wait length multiplier" values="0=1x,1=4x,2=3x,3=2x,4=0.5x,5=0.375x,6=0.25x" notes="" />
  <field id="25-27" type="list" name="Move speed multiplier" values="0=1x,1=0.25x,2=0.375x,3=0.5x,4=2x,5=3x,6=4x" notes="" />
</class>

<class id="24">
  <name>Pipe Piranha Plant (facing down)</name>
  <flags known="1" complete="1" />
  <category id="13" />
  <notes></notes>
  <files>/enemy/v_pakkun.nsbmd</files>
  <field id="41-48" type="list" name="Number of fireballs" values="0=0,1=1,17=2,33=3,49=6" notes="" />
  <field id="37-40" type="value" name="Scale" values="" notes="" />
  <field id="33-36" type="value" name="Health" values="" notes="Number of fireball hits it takes to kill the piranha. 0 is the same as 1." />
  <field id="32" type="checkbox" name="Invincible" values="" notes="Makes piranha invincible to fireballs and shells." />
  <field id="31" type="checkbox" name="No player wait" values="" notes="Don't stop for a player near the pipe." />
  <field id="28-30" type="list" name="Attack/wait length multiplier" values="0=1x,1=4x,2=3x,3=2x,4=0.5x,5=0.375x,6=0.25x" notes="" />
  <field id="25-27" type="list" name="Move speed multiplier" values="0=1x,1=0.25x,2=0.375x,3=0.5x,4=2x,5=3x,6=4x" notes="" />
</class>

<class id="25">
  <name>Pipe Piranha Plant (facing right)</name>
  <flags known="1" complete="1" />
  <category id="13" />
  <notes></notes>
  <files>/enemy/v_pakkun.nsbmd</files>
  <field id="41-48" type="list" name="Number of fireballs" values="0=0,1=1,17=2,33=3,49=6" notes="" />
  <field id="37-40" type="value" name="Scale" values="" notes="" />
  <field id="33-36" type="value" name="Health" values="" notes="Number of fireball hits it takes to kill the piranha. 0 is the same as 1." />
  <field id="32" type="checkbox" name="Invincible" values="" notes="Makes piranha invincible to fireballs and shells." />
  <field id="31" type="checkbox" name="No player wait" values="" notes="Don't stop for a player near the pipe." />
  <field id="28-30" type="list" name="Attack/wait length multiplier" values="0=1x,1=4x,2=3x,3=2x,4=0.5x,5=0.375x,6=0.25x" notes="" />
  <field id="25-27" type="list" name="Move speed multiplier" values="0=1x,1=0.25x,2=0.375x,3=0.5x,4=2x,5=3x,6=4x" notes="" />
</class>

<class id="26">
  <name>Pipe Piranha Plant (facing left)</name>
  <flags known="1" complete="1" />
  <category id="13" />
  <notes></notes>
  <files>/enemy/v_pakkun.nsbmd</files>
  <field id="41-48" type="list" name="Number of fireballs" values="0=0,1=1,17=2,33=3,49=6" notes="" />
  <field id="37-40" type="value" name="Scale" values="" notes="" />
  <field id="33-36" type="value" name="Health" values="" notes="Number of fireball hits it takes to kill the piranha. 0 is the same as 1." />
  <field id="32" type="checkbox" name="Invincible" values="" notes="Makes piranha invincible to fireballs and shells." />
  <field id="31" type="checkbox" name="No player wait" values="" notes="Don't stop for a player near the pipe." />
  <field id="28-30" type="list" name="Attack/wait length multiplier" values="0=1x,1=4x,2=3x,3=2x,4=0.5x,5=0.375x,6=0.25x" notes="" />
  <field id="25-27" type="list" name="Move speed multiplier" values="0=1x,1=0.25x,2=0.375x,3=0.5x,4=2x,5=3x,6=4x" notes="" />
</class>
```

## Stats

- **Class size increased by**: 4 bytes

> [!NOTE]
> Code size was measured after compiling with `-Os` (optimized for size) enabled.

- **Size of code added:** 1332 bytes

- **With** `ALLOW_CODE_PACK`: 1204 bytes

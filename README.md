# Photo Caddy Game Organizers
A home for my photo caddy game oragnizer designs

I stumbled across this group of game organizers designed to fit inside the Photo and Craft Keeper 4x6 inch storage bins (made by Simply Tidy and others).  This has lead down a rat hole of inserts and sparking ideas inside my head.  This is a place for me to design additional inserts as well as provide tools for others to easily design inserts as well.

# Usage
1. Check out the repo
2. Create a new OpenSCAD file and `use` the `photo_base.scad` in your design
3. Use the `difference()` function to remove parts to fit the game

Feel free to fork this repo and add your own caddy inserts.  Or, create your own and file a PR and I'll add it to this one.

# Contributions
In order to contribute you will need the following files as part of your PR and follow the directory structure pattern laid out below.  Note: all file names should be lowercase with underscores seperating the words.

```
name_of_game/
├── insert.scad
├── additional_part_1.scad
├── additional_part_2.scad
├── REAMD.md
├── models/
│   ├── insert.stl
│   ├── additional_part_1.stl
│   └── additional_part_2.stl
└── assets/
    ├── box_inside_0.jpg
    ├── box_inside_1.jpg
    ├── box_inside_n.jpg
    ├── box_outside_0.jpg
    ├── box_outside_1.jpg
    └── box_outside_n.jpg
```

* The README.md should have the name of the game as well as the version (year / edition) of the game.  It should also include screenshots loaded from the `assets` folder.
* The scad files should be exported into stls and placed in the `models` directory with the same name as the scad file.
* The base insert should be named `insert.scad` and any additional models (trays, etc) can be named based on their part type.
* There should be at least one photo of the box insert but multiple photos are always welcome.
* Variants should be appened to the name such as `insert_expansions.scad` or `insert_sleeved.scad`.
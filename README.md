# Instructions

## Manifest File (Package.swift) and Structure

Apple's packages and HM are included; `import` accordingly as needed. 

Each day is a library. When you start working on a new day…

1. Create folders and files for the new day, in `Sources` and `Tests`, if someone else hasn't already.
2. Update "(year, days)" tuple at the top of the manifest to match.

There is also an `AOC` folder/library. Code that is useful for multiple puzzles (probably input parsing stuff) should go there. 

Push any changes that are not specific to your own solutions, to `main`, so that others can use them.

## Puzzles

Copy your daily "puzzle input" directly from Advent of Code.
Paste it into a file named `Input.md` in the same folder as your test file.

Just copy the smaller sample data that exists on each puzzles page into a multiline String literal, making sure to add an empty line at the end to replicate the format of `Input` files.

Push changes to your own branch.

## Tests

You'll want at least these imports in each test file, filling in the `?`s as appropriate.

```swift
import AOC
import AOC_20??_?
import XCTest
```

The test files should mostly provide parsed input data to code in the `Sources` folder, and check answers. 

For puzzle solutions…
1. Write a failing test with a random answer and get the right answer from the failure message instead. 
2. Copy that to the Advent of Code website and get a 🌟! 
3. Also, copy it into the test, so that it can pass in the future.  

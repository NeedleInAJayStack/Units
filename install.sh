#!/bin/sh
swift build -c release
cp .build/release/convertunit /usr/local/bin/
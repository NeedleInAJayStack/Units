#!/bin/sh
swift build -c release
cp .build/release/unit /usr/local/bin/
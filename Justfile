# Units Justfile
# Command line support


# About Units Commands
_default:
    @echo '{{ style("warning") }}Units Script Commands{{ NORMAL }}'
    @echo @{{source_file()}}
    @echo ""
    @just -f {{source_file()}} --list

# Install 'units' in /usr/local/bin
install:
    swift build -c release
    cp .build/release/unit /usr/local/bin/

# rm 'units' from /usr/local/bin
uninstall:
    rm /usr/local/bin/unit

# Add swiftformat to git/pre-commit
dev_setup:
    echo "./Scripts/git_commit_hook.sh" > .git/hooks/pre-commit

# Open Documentation
docs:
    open https://swiftpackageindex.com/NeedleInAJayStack/Units/v1.0.0/documentation/units

git_origin := `git remote get-url origin`

# repo/origin
repo:
    @echo {{git_origin}}

# open repo/origin
open-repo:
    open {{git_origin}}


#!/bin/bash

# Use this scipt to install swiftlint. It also installs homebrew if required

# Install homebrew
which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing Homebrew.."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "done"
else
    echo "Homebrew already installed:"
    echo " - $(brew --version)"
fi

# Install swiftlint
if [ -z $(brew list -1 | grep swiftlint) ]; then
    echo "Installing SwiftLint from homebrew.."
    echo " - Installing swiftlint.."
    brew install swiftlint
    echo "done"
else
    echo "Swiftlint already installed:"
    echo " - Version $(swiftlint version)"
fi

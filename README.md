## An installer script for CodeFormatter
Simply run `code-formatter-install.sh` with root privilages to pull the latest version of CodeFormatter and install it.

## What is CodeFormatter?
It's a command line tool designed to format your .NET code written in C# or Visual Basic.

Learn more at [dotnet/CodeFormatter](https://github.com/dotnet/codeformatter).

## After installing
The installer pulls the repo, builds the CodeFormatter and copies the binaries into `/opt/code-formatter`. Then it creates an exectuable in `/usr/bin`.

Use `code-formatter` to run it.

## Example usage

    code-formatter /nocopyright /nounicode /rule-:FieldNames MyProject.csproj

This will format all the files in the `MyProject.csproj` project, without adding any copyright notices, without escaping unicode characters, without the rule `FieldNames` which makes all private fields start with `_`.

## Adding a git hook
If you want to make sure you only commit formatted code you can create a git pre-commit hook.

Something like:

    echo "#!/bin/bash" > .git/hooks/pre-commit
    echo "code-formatter (...)" >> .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit

And replace `(...)` with your parameters.

Make sure you don't already have a pre-commit hook before you replace it. If it's a script and not a binary executable you can simply append your code-formatter line to it.

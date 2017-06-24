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

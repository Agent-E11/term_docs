# Documentation

This is my personal documentation file,
I will use it to write down any little things that I want to know quickly

## Shell commands

### `ln`

```sh
ln -s <target_file> <link_name>
```

### `awk`

Print certain fields:

```sh
echo "f1 f2 f3" | awk '{ print $3, $1 }'
```

### `sed`

Simple search and replace

```sh
# The trailing `/` is required
sed 's/<old>/<new>/' <file>
```

Change file inplace

```sh
sed -i 's/<old>/<new>/' <file>
```

### `uname`

Use uname to get the architecture and platform information:

```sh
uname -a
```

## `command`

Use `command` to check if a command exists:

```sh
command -v <command>
```

## `printenv`

Use `printenv` to print currently set environment variables

```sh
printenv
```

### `read`

To read user input, use `read`

```sh
# Read user input into the variable `my_var`
read my_var

# Read user input into variable `answer` with the prompt `What is your name?: `
# zsh
read "answer?What is your name?: "

# bash
read -p "What is your name?: " answer

# Read user input, but don't show characters (like if you were asking for a password)
read -s password
```

## Shell tips

### Variable expansion
Read more in `man bash` /parameter expansion

```sh
var="file.txt.bak"

# Remove suffix
echo ${var%.*} # `file.txt`
echo ${var%%.*} # `file`

# Remove prefix
echo ${var#*.} # `txt.bak`
echo ${var##*.} # `bak`

# Search and replace
echo ${var/file/test} # `test.txt.bak`
```

### Suspended jobs

If you get this error:

```
zsh: you have suspended jobs
```

You can list the suspended jobs with:

```sh
jobs
```

And foreground them so that you can stop them with this:

```sh
fg <job>
```

<!-- TODO: Check this -->
Where `<job>` is the command used to start the job, preceded by a `%`

You can also press tab to autocomplete jobs

## Powershell cmdlets

### link in powershell

```ps1
New-Item -ItemType SymbolicLink -Path <link_name> -Value <target_file>
```

## Git

### Line endings

[Pro Git Chapter](https://www.git-scm.com/book/en/v2/Customizing-Git-Git-Configuration#_formatting_and_whitespace)
[.gitattributes documentation](https://www.git-scm.com/book/en/v2/Customizing-Git-Git-Configuration#_formatting_and_whitespace)

When working on a Windows system, set `autocrlf` to `true`. This will
automatically convert `LF` endings to `CRLF` when you checkout code:

```sh
git config --global core.autocrlf true
```

When working on a Linux system, set `autocrlf` to `input`. This will
automatically convert `CRLF` endings to `LF` when commiting files, but not the
other way around.

```sh
git config --global core.autocrlf input
```


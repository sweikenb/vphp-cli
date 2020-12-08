# vphp-cli

License: MIT


## Installation & Update

To use this library you must first download the script and then add an alias to your bash environment.

This can be done very easy by following the next steps:


### Download

```bash
curl "https://raw.githubusercontent.com/sweikenb/vphp-cli/master/vphp.sh" --output /usr/local/bin/vphp-cli
chmod +x /usr/local/bin/vphp-cli
```


### Setup alias

Depending on your environment you have to edit different profile files such as:

- `nano ~/.profile` or
- `nano ~/.bash_profile` or 
- `nano ~/.zshrc` or 
- ...


When you opened the proper profile file, add the following line at the end of the file:

```bash
alias php="/usr/local/bin/vphp-cli"
```

Save and close the file and do not forget to **restart your terminal session**.


## Usage

Place a stopfile called `.vphp-cli` in your project root or somewhere in the direct parent-directory structure to specify the php binary that should be used for the current project / directory.

This can become handy in case you have multiple PHP-versions installed and do not want to switch the global PHP version everytime you swtich a project.

**Sample file content:**

```bash
/usr/local/opt/php@7.4/bin/php
```

Only add the raw binary path, do not add comments or any other content beside the actual path.


## Debug

In case you want to check which pathes where checked and which binary actually was used, you can set a debug flag for a dry-run:

```bash
VPHP_DEBUG=1 php
```

This will output information about the binary used and will **NOT** execute the actual command but display the PHP version information of the used PHP binary _(equal to `php -v`)_.
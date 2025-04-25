Onbbu Laravel

Esta imagen contiene las dependencias base para trabajar con laravel 12, se recomienda el uso del siguiente devcontainer.json

```json
{
	"name": "PHP",
	"dockerFile": "Dockerfile",
	"context": "..",
	"runArgs": [
		"--network",
		"host",
		"--env-file",
		".env"
	],
	"postCreateCommand": "composer install && echo 'Welcome!! Ya puedes trabajar'",
	"customizations": {
		"vscode": {
			"settings": {
				"terminal.integrated.defaultProfile.linux": "bash",
				"php-cs-fixer.executablePath": "php-cs-fixer",
				"php-cs-fixer.executablePathWindows": "",   //eg: php-cs-fixer.bat
				"php-cs-fixer.onsave": false,
				"php-cs-fixer.rules": "@PSR12",
				"php-cs-fixer.config": ".php-cs-fixer.php;.php-cs-fixer.dist.php;.php_cs;.php_cs.dist",
				"php-cs-fixer.allowRisky": false,
				"php-cs-fixer.pathMode": "override",
				"php-cs-fixer.ignorePHPVersion": false,
				"php-cs-fixer.exclude": [],
				"php-cs-fixer.autoFixByBracket": false,
				"php-cs-fixer.autoFixBySemicolon": false,
				"php-cs-fixer.formatHtml": false,
				"php-cs-fixer.documentFormattingProvider": true,		
				"git.enabled": true,
				"git.autofetch": true,
				"git.confirmSync": false
			},
			"extensions": [
				"felixfbecker.php-intellisense",
				"bmewburn.vscode-intelephense-client",
				"neilbrayfield.php-docblocker",
				"junstyle.php-cs-fixer",
				"esbenp.prettier-vscode"
			]
		}
	},
	"remoteUser": "vscode"
}
```

Docker file

```Dockerfile
FROM onbbu/laravel:dev

CMD ["/bin/bash"]
```



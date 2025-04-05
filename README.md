Onbbu Python

Esta imagen contiene las dependencias base para trabajar con python, se recomienda el uso del siguiente devcontainer.json

```json
{
	"name": "<yOUR PROJECT>",
	"dockerFile": "Dockerfile",
	"context": "..",
	"runArgs": [
		"--network",
		"host",
		"--env-file",
		".devcontainer/.env"
	],
	"postCreateCommand": "make install && echo 'Welcome!! Ya puedes trabajar'",
	"customizations": {
		"vscode": {
			"settings": {
				"python.languageServer": "Pylance",
				"terminal.integrated.shell.linux": "/bin/bash",
				"python.defaultInterpreterPath": "/home/vscode/venv/bin/python",
				"python.analysis.nodeExecutable": "/usr/bin/node",
				"python.analysis.autoSearchPaths": true,
				"python.analysis.typeCheckingMode": "strict",
				"python.analysis.autoImportCompletions": true,
				"python.analysis.languageServerMode": "full",
				"python.linting.enabled": true,
				"python.linting.mypyEnabled": true,
				"python.linting.pylintEnabled": false,
				"python.linting.flake8Enabled": false,
				"git.enabled": true,
				"git.autofetch": true,
				"git.confirmSync": false
			},
			"extensions": [
				"ms-python.autopep8",
				"ms-python.black-formatter",
				"ms-python.debugpy",
				"ms-python.isort",
				"ms-python.python",
				"ms-python.vscode-pylance",
				"streetsidesoftware.code-spell-checker"
			]
		}
	},
	"remoteUser": "vscode"
}
```

Docker file

```Dockerfile
FROM onbbu/python:dev

CMD ["/bin/bash"]
```



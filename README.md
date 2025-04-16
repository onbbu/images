Onbbu Python

Esta imagen contiene las dependencias base para trabajar con python, se recomienda el uso del siguiente devcontainer.json

```json
{
  "name": "React DevContainer",
  "context": "..",
  "dockerFile": "Dockerfile",
  "runArgs": [
    "--network",
    "host",
    "--env-file",
    ".env"
  ],
  "postCreateCommand": "make install && make ssh",
  "postAttachCommand": "npm run dev",
  "customizations": {
    "vscode": {
      "settings": {
        "terminal.integrated.shell.linux": "/bin/bash",
				"codetime.getToken": "${env:CODETIME_TOKEN}",
				"codetime.statusBarInfo": "24h",
				"git.enabled": true,
				"git.autofetch": true,
				"git.confirmSync": false,
        "npm.packageManager": "npm"
      },
      "extensions": [
        "jannchie.codetime",
        "styled-components.vscode-styled-components",
        "streetsidesoftware.code-spell-checker"
      ]
    }
  },
  "remoteUser": "node"
}
```

Docker file

```Dockerfile
FROM onbbu/vite:dev

CMD ["/bin/bash"]
```



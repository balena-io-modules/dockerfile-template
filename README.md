# dockerfile-template

**DEPRECATED -- This module has been deprecated; please use [balena-compose](https://github.com/balena-io-modules/balena-compose) instead.**

Process dockerfile templates, a format that allows replacing variables in dockerfiles.

### Installation

```bash
npm install dockerfile-template
```

### Format

The format of a dockerfile template is the same as a Dockerfile, but augmented with variables.

Variables have the format %%VARIABLE_NAME%%, where variable name starts with an uppercase letter,
and can contain uppercase letters and underscores.

Variables in comments (lines that start with #) are not processed.

### Library

This module exposes a single `process` method.

It receives a dockerfile template body and key-value pairs and replaces variables in the template.

If the template has variables that cannot be found, it throws an error.

Example:

```javascript
dockerfileTemplate = require("dockerfile-template");
  
variables = {
    BASE: "debian",
    TAG: "latest"
};
res = dockerfileTemplate.process("FROM %%BASE%%:%%TAG%%", variables);
console.log(res)
```

Output:

```FROM debian:latest```

You can read the tests in `test` folder for more examples.

### Command line usage

The module also exposes a script for command line usage, to test templates.

After installing the module locally, the script should be in `./node_modules/.bin/dockerfile-template`.

```
  Usage: dockerfile-template [options]

  Options:

    -h, --help                     output usage information
    -V, --version                  output the version number
    -f, --filename <templatefile>  template file to process (default: Dockerfile.template)
    -d, --define [VARIABLE=value]  replace variable with value (repeatable option)
```

### Tests

Run the test suite by executing:

```sh
$ npm install
$ npm test
```

### Contribute

- Issue Tracker: [github.com/resin-io/dockerfile-template/issues](https://github.com/resin-io/dockerfile-template/issues)
- Source Code: [github.com/resin-io/dockerfile-template](https://github.com/resin-io/dockerfile-template)

Before submitting a PR, please make sure that you include tests, and that [coffeelint](http://www.coffeelint.org/) runs without any warning.

### License

The project is licensed under the Apache-2.0 License.

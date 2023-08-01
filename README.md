# Building C4 Models using Structurizr

https://structurizr.com/ and https://github.com/structurizr/dsl

## Previewing Images

https://dev.to/simonbrown/getting-started-with-structurizr-lite-27d0

### Docker

Install Docker image:

```
docker pull structurizr/lite
```

Preview workspace diagrams:

```
docker run -it --rm -p 8080:8080 -v $PWD/diagrams:/usr/local/structurizr structurizr/lite
```

Navigate to http://localhost:8080 to view the workspace.

## Export DSL to different format

https://github.com/structurizr/cli

### Docker

Install Docker image:

```
docker pull structurizr/cli
```

Export DSL:

```
docker run -it --rm -v $PWD/:/usr/local/structurizr structurizr/cli export -workspace diagrams/workspace.dsl -format {format} -output docs
```

[Formats](https://github.com/structurizr/cli/blob/master/docs/export.md#options):

* `json` - structurizr JSON
* `plantuml`
* `plantuml/c4plantuml`

## Building Images

### Structurizr Lite

Export diagrams in PNG/SVG format [manually](https://structurizr.com/help/exporting-diagrams) or via CLI with [puppeteer](https://github.com/structurizr/puppeteer).

_Note: Must have Structurizr Lite running locally._

### Docker

Install Docker image:

```
docker pull extenda/structurizr-to-png
```

Generate diagram image(s):

```
docker run --rm -it -v $PWD/:/docs extenda/structurizr-to-png --path diagrams/workspace.dsl --render-with structurizr --output ../docs
```

See [/docs](./docs/diagrams.md) for generated images.
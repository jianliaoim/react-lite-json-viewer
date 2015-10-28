
React Lite JSON Viewer
----

Demo http://ui.talk.ai/react-lite-json-viewer/

Component for exploring Store in JSON.

### Usage

```bash
npm i --save react-lite-json-viewer
```

```coffee
LiteJSONViewer = require 'react-lite-json-viewer'

LiteJSONViewer
  height: 500
  data: Immutable.fromJS(jianliaoData)
  path: @state.path # Immutable.List()
  onChange: @onPathChange
```

Read more in `src/`.

### Develop

https://github.com/teambition/coffee-webpack-starter

### Background

http://fotonin.com/data_images/out/15/892020-space-wallpaper-hd.jpg

### License

MIT
